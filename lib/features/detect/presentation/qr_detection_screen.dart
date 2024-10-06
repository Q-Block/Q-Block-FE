import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qblock_fe/widgets/detection_dialog_qr.dart';
import 'package:qblock_fe/widgets/navigationbar.dart';
import 'package:qblock_fe/widgets/textbutton.dart';
import 'package:qblock_fe/features/detect/domain/url_processing_sevice.dart';

class QrDetectionScreen extends StatefulWidget {
  const QrDetectionScreen({super.key});

  @override
  State<QrDetectionScreen> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<QrDetectionScreen> {
  String qrResult = 'Scanned Data will appear here';
  final TextEditingController urlController = TextEditingController();

  Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      // Request permission if not already granted
      status = await Permission.camera.request();
    }
    return status.isGranted; // Return whether permission is granted or not
  }

  Future<void> scanQR() async {
    bool hasPermission = await checkCameraPermission();

    if (!hasPermission) {
      setState(() {
        qrResult = 'Camera permission not granted';
      });
      return; // Exit if permission is not granted
    }
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        if (qrCode == '-1') {
          qrResult = 'Scan cancelled';
          urlController.text = ''; // Clear the TextField if scan is cancelled
        } else {
          qrResult = qrCode;
          urlController.text =
              qrCode; // Update the TextEditingController to show the scanned result
        }
      });
      final response = await UrlProcessingService().processUrl(qrCode, true);
      if (response != null) {
        print('$response');
      } else {
        print("Error Processing URL");
      }
    } on PlatformException catch (e) {
      setState(() {
        qrResult = 'Failed to scan QR Code: ${e.message}';
        urlController.text = ''; // Clear the TextField on error
      });
    } catch (e) {
      setState(() {
        qrResult = 'An error occurred: $e';
        urlController.text = ''; // Clear the TextField on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '큐싱 탐지하기',
        onIconPressed: () {
          Navigator.of(context).pop(); // Go back to the previous screen
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wrap the TextField in a Container with specified width

              Container(
                width: double.infinity, // Set the desired width
                child: TextField(
                  controller: urlController,
                  readOnly: true, // Make the TextField read-only
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Detected URL',
                      hintText: 'URL will appear here'),
                ),
              ),

              SizedBox(height: 8),

              SizedBox(
                width: double.infinity, // Set the desired width
                child: CustomTextButton(
                  label: ' qr코드 탐지하기  ',
                  onPressed: scanQR,
                  backgroundColor: Colors.green,
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                ),
              ),
              if (qrResult.startsWith('http') ||
                  qrResult.startsWith('www') ||
                  qrResult.startsWith('https'))
                Padding(
                  padding:
                      const EdgeInsets.only(left: 0.0, right: 0.0, top: 8.0),
                  child: SizedBox(
                    width: double.infinity, // Set the desired width
                    child: CustomTextButton(
                      label: '  접속하기  ',
                      onPressed: () {
                        DetectionDialogs.showDetectionDialog(
                            context, qrResult, scanQR);
                      },
                      backgroundColor: Colors.green,
                      pressedBackgroundColor: Colors.white,
                      textColor: Colors.white,
                      pressedTextColor: Colors.black,
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
