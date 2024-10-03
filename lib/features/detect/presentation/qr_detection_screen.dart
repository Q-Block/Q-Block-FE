import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qblock_fe/widgets/textbutton.dart';

class QrDetectionScreen extends StatefulWidget {
  const QrDetectionScreen({super.key});

  @override
  State<QrDetectionScreen> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<QrDetectionScreen> {
  String qrResult = 'Scanned Data will appear here';

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
        } else {
          qrResult = qrCode;
        }
      });
    } on PlatformException catch (e) {
      setState(() {
        qrResult = 'Failed to scan QR Code: ${e.message}';
      });
    } catch (e) {
      setState(() {
        qrResult = 'An error occurred: $e';
      });
    }
  }

  void openLink(String url) {
    // Implement the logic to open the URL
    // For example, using url_launcher:
    // launch(url);
    print('Opening URL: $url'); // Placeholder for URL opening logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              '$qrResult',
              style: const TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            CustomTextButton(
              label: ' 탐지하기  ',
              onPressed: scanQR,
              backgroundColor: Colors.green,
              pressedBackgroundColor: Colors.white,
              textColor: Colors.white,
              pressedTextColor: Colors.black,
            ),
            if (qrResult.startsWith('http') ||
                qrResult.startsWith('www') ||
                qrResult.startsWith('https'))
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextButton(
                  label: '  접속하기  ',
                  onPressed: () => openLink(qrResult),
                  backgroundColor: Colors.green,
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
