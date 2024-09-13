import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../image_picker.dart';
import '../dialog/detection_dialog.dart';

class UrlDetectionScreen extends StatefulWidget {
  const UrlDetectionScreen({super.key});

  @override
  State<UrlDetectionScreen> createState() => _UrlDetectionScreenState();
}

class _UrlDetectionScreenState extends State<UrlDetectionScreen> {
  File? _image;
  final TextEditingController _textController = TextEditingController();
  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();

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
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 8.0, top: 0.0),
          child: Text(
            '악성 URL 탐지하기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(0.0), // Height of the bottom border
          child: Container(
            color: Colors.black.withOpacity(0.3), // Color of the bottom border
            height: 0.5, // Height of the bottom border
          ),
        ),
        toolbarHeight:
            90, // Adjust toolbarHeight to reduce space above the bottom border
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
                    backgroundColor: const Color(0xFF364B3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: () {
                    // Show detection dialog when "탐지하기" button is pressed
                    DetectionDialogs.showDetectionDialog(
                      context,
                      _textController.text,
                    );
                  },
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
