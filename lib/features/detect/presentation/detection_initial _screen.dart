import 'package:flutter/material.dart';
import 'package:qblock_fe/features/detect/presentation/url_detection_screen.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../home/presentation/home_screen.dart';

class DetectInitialScreen extends StatelessWidget {
  const DetectInitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // 버튼들을 하단에 위치시키기 위해 Spacer를 사용
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0), // 버튼 주변 패딩
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // 버튼이 화면 가로폭에 맞게 확장
              children: [
                _buildTextButton('큐싱 탐지', () {}),
                SizedBox(height: 10), // 버튼 간의 간격
                _buildTextButton('URL 탐지', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UrlDetectionScreen(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 재사용 가능한 TextButton 위젯을 반환
  Widget _buildTextButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Color(0xFF54715B); // 버튼이 눌렸을 때 배경색
            }
            return Colors.white; // 기본 배경색
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white; // 버튼이 눌렸을 때 글자색
            }
            return Colors.black; // 기본 글자색
          },
        ),
        side: MaterialStateProperty.all(BorderSide(color: Colors.grey, width: 0.2)), // 버튼 테두리
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 버튼 테두리 둥글게
        )),
        shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.8)), // 그림자 색상
        elevation: MaterialStateProperty.all(2), // 그림자 높이
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)), // 버튼 안의 텍스트와 가장자리 사이의 여백
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600, // Semibold (600)
        ),
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
