import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qblock_fe/features/detect/presentation/qr_detection_screen.dart';
import 'package:qblock_fe/features/detect/presentation/url_detection_screen.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../../widgets/textbutton.dart';
import '../../home/presentation/home_screen.dart';

class DetectInitialScreen extends StatelessWidget {
  const DetectInitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 높이의 10%를 패딩으로 사용하기 위해 계산
    double paddingVertical = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: CustomAppBar(
        title: '탐지하기',
        onIconPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
      ),
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: Column(
        children: [
          // 상단 중앙에 텍스트 위치
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0), // 상하 패딩
            child: Center(
              child: Text(
                '어떤 방식으로 탐지하시겠습니까?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // 버튼들을 하단에 위치시키기 위해 Spacer를 사용
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: paddingVertical), // 버튼 주변 패딩을 화면 높이의 10%로 설정
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // 버튼이 화면 가로폭에 맞게 확장
              children: [
                CustomTextButton(
                  label: '큐싱 탐지',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            QrDetectionScreen(), // QR 코드 스캔 화면으로 이동
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                ),
                SizedBox(height: 3), // 버튼 간의 간격
                CustomTextButton(
                  label: 'URL 탐지',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UrlDetectionScreen(),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetectInitialScreen(),
    debugShowCheckedModeBanner: false, // 디버그 배너를 숨깁니다.
  ));
}
