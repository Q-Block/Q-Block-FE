import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qblock_fe/features/detect/domain/url_processing_sevice.dart';
/*
Future<Map<String, dynamic>> fetchUrlData(String url) async {
  await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

  // Simulate a response
  bool isMalicious = url.contains("malicious");

  return {
    'url': url,
    'isMalicious': true, // Update to use the simulated value
  };
}
*/

class DetectionDialogs {
  static void showDetectionDialog(
      BuildContext context, String url, VoidCallback onScanAgain) async {
    try {
      UrlProcessingService urlProcessingService = UrlProcessingService();
      Map<String, dynamic>? urlData =
          await urlProcessingService.processUrl(url, true);

      if (urlData == null) {
        // Handle the case when URL data is null (e.g., no token or an error occurred)
        print('URL data is null.');
        return;
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          bool isMalicious = urlData['malicious_status'] == '악성';
          String message = isMalicious ? "악성 URL로 의심됩니다" : "정상 URL입니다.";

          return AlertDialog(
            title: Text(
              '큐싱 탐지 결과',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              mainAxisSize: MainAxisSize.min, // Column의 크기를 최소로 설정
              children: [
                const SizedBox(height: 10),
                Text(
                  'URL: ${urlData['url']}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16), // 버튼 위쪽 간격 추가
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (isMalicious) {
                            // Show the connection warning dialog if the URL is malicious
                            Navigator.pop(context); // Close the current dialog
                            showConnectionWarningDialog(
                                context, isMalicious, url);
                          } else {
                            // Launch the URL directly if it is not malicious
                            launchUrlIfPossible(url);
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // 둥글기 조정
                          ),
                        ),
                        child: Text('접속하기'),
                      ),
                    ),
                    SizedBox(height: 8), // 버튼 간격
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onScanAgain(); // Call the scan again function here
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // 둥글기 조정
                          ),
                        ),
                        child: Text('재탐지하기'),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // 둥글기 조정
                          ),
                        ),
                        child: Text('닫기'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle the error here (e.g., show an error dialog)
      print('Error: $e');
    }
  }

  static Future<void> launchUrlIfPossible(String url) async {
    Uri uri = Uri.parse(url); // Convert the URL string to a Uri

    // Attempt to launch the URL
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Launch the URL in the browser
    } else {
      // Handle the error if the URL can't be launched
      print('Could not launch $url');
    }
  }

  static void showConnectionWarningDialog(
      BuildContext context, bool isMalicious, String url) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '정말 접속하시겠습니까?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              mainAxisSize: MainAxisSize.min, // Column의 크기를 최소로 설정
              children: [
                const SizedBox(height: 10),
                if (isMalicious)
                  Text(
                    '$url 은\n악성 URL로 의심됩니다.',
                    style: const TextStyle(fontSize: 16),
                  ),
                const SizedBox(height: 10),
              ],
            ),
            actions: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16), // 버튼 위쪽 간격 추가
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          Uri uri = Uri.parse(url);
                          // Attempt to launch the URL
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                                uri); // Launch the URL in the browser
                          } else {
                            // Handle the error if the URL can't be launched
                            print('Could not launch $url');
                          }
                          Navigator.pop(context); // Close the dialog
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // 둥글기 조정
                          ),
                        ),
                        child: Text('접속하기'),
                      ),
                    ),
                    SizedBox(height: 8), // 버튼 간격
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // 둥글기 조정
                          ),
                        ),
                        child: Text('재탐지하기'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // 오류 처리
      print('Error: $e');
    }
  }
}
