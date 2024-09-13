import 'package:flutter/material.dart';
import 'package:qblock_fe/features/auth/presentation/login_screen.dart';

Future<Map<String, dynamic>> fetchUrlData(String url) async {
  await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

  // Simulate a response
  bool isMalicious = url.contains("malicious");

  return {
    'url': url,
    'isMalicious': true,
  };
}

class DetectionDialogs {
  static void showDetectionDialog(BuildContext context, String url) async {
    try {
      Map<String, dynamic> urlData = await fetchUrlData(url);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          bool isMalicious = urlData['isMalicious'] ?? false;
          String message = isMalicious ? "악성 URL로 의심됩니다" : "악성 URL이 아닙니다";

          return Dialog(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'URL탐지 결과',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'URL: $url',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      //color: isMalicious ? Colors.red : Colors.green,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120,
                        child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF54715B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          child: const Text(
                            '접속하기',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            showConnectionWarningDialog(
                                context, isMalicious, url);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          child: const Text(
                            '돌아가기',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Handle the error here (e.g., show an error dialog)
      print('Error: $e');
    }
  }

  static void showConnectionWarningDialog(
      BuildContext context, bool isMalicious, String url) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '정말 접속하시겠습니까?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  if (isMalicious)
                    Text(
                      '$url 은 악성 URL로 의심 됩니다. 접속 기록은 접속 기록 조회하기 -> 접속한 악성 URL에서 확인하실 수 있습니다.',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120,
                        child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF54715B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          child: const Text(
                            '접속하기',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            // Implement the logic to connect to the URL
                          },
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          child: const Text(
                            '돌아가기',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Handle the error here (e.g., show an error dialog)
      print('Error: $e');
    }
  }
}
