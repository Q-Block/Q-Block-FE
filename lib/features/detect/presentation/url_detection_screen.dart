import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:qblock_fe/features/detect/domain/url_processing_sevice.dart';
import '../../../widgets/detection_dialog.dart';
import '../../../widgets/image_picker.dart';
import '../../../widgets/navigationbar.dart';

class UrlDetectionScreen extends StatefulWidget {
  const UrlDetectionScreen({super.key});

  @override
  State<UrlDetectionScreen> createState() => _UrlDetectionScreenState();
}

class _UrlDetectionScreenState extends State<UrlDetectionScreen> {
  File? _image;
  final TextEditingController _textController = TextEditingController();
  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();
  final TextRecognizer _textRecognizer = TextRecognizer(); // 텍스트 인식기

  // URL 추출을 위한 정규식 패턴
  final String urlPattern = r'((https?:\/\/[^\s]+)|(www\.[^\s]+))';

  // 이미지를 선택한 후 텍스트 인식 (OCR) 실행 및 URL만 추출
  Future<void> _processImageForTextRecognition(File image) async {
    try {
      final inputImage = InputImage.fromFile(image);
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);

      // 인식된 텍스트가 존재하는지 확인
      if (recognizedText.text.isNotEmpty) {
        print("인식된 텍스트: ${recognizedText.text}"); // 콘솔에 출력

        // URL을 추출하는 기존 코드
        final RegExp regExp = RegExp(urlPattern);
        final Iterable<RegExpMatch> matches =
            regExp.allMatches(recognizedText.text);

        final response =
            await UrlProcessingService().processUrl(recognizedText.text, false);

        if (matches.isNotEmpty) {
          final List<String> urls =
              matches.map((match) => match.group(0) ?? '').toList();
          setState(() {
            _textController.text = urls.isNotEmpty ? urls.first : '';
          });
        } else {
          if (mounted) {
            // mounted 체크 추가
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("URL을 인식하지 못했습니다.")),
            );
          }
        }
      } else {
        if (mounted) {
          // mounted 체크 추가
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("텍스트를 인식하지 못했습니다.")),
          );
        }
      }
    } catch (e) {
      print("텍스트 인식 오류: $e");
      if (mounted) {
        // mounted 체크 추가
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("텍스트 인식 중 오류가 발생했습니다.")),
        );
      }
    }
  }

  Future<void> showImagePickerOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery',
                style: TextStyle(color: Color(0xFF364B3B))),
            onPressed: () async {
              Navigator.of(context).pop();
              File? image = await _imagePickerUtil.getImageFromGallery();
              if (image != null) {
                setState(() {
                  _image = image;
                  _textController.text = _image!.path.split('/').last;
                });
                await _processImageForTextRecognition(image); // 이미지 처리 및 URL 인식
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Camera',
              style: TextStyle(color: Color(0xFF54715B)),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              File? image = await _imagePickerUtil.getImageFromCamera();
              if (image != null) {
                setState(() {
                  _image = image;
                  _textController.text = _image!.path.split('/').last;
                });
                await _processImageForTextRecognition(image); // 이미지 처리 및 URL 인식
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _detectUrl() async {
    String enteredUrl = _textController.text;
    if (!enteredUrl.startsWith('http://') &&
        !enteredUrl.startsWith('https://')) {
      enteredUrl = 'https://$enteredUrl'; // Prepend 'https://'
    }
    if (enteredUrl.isNotEmpty) {
      // Process the URL entered manually
      final response =
          await UrlProcessingService().processUrl(enteredUrl, false);

      // Show detection dialog with the entered URL
      DetectionDialogs.showDetectionDialog(context, enteredUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("URL을 입력해주세요.")),
      );
    }
  }

  @override
  void dispose() {
    _textRecognizer.close(); // 텍스트 인식기 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'URL 탐지하기',
        onIconPressed: () {
          Navigator.of(context).pop(); // Go back to the previous screen
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 150.0), // Position 1/3 from the top
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'URL을 입력해주세요',
                        filled: true,
                        fillColor: const Color.fromRGBO(250, 250, 250, 0.7)
                            .withOpacity(0.2),
                        labelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.6)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: showImagePickerOptions,
                    child: const Icon(
                      Icons.file_upload_outlined,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: _detectUrl,
                  child: const Text(
                    "탐지하기",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
