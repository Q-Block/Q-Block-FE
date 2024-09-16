import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen2.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../../widgets/textbutton.dart';
import '../../home/presentation/home_screen.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 높이의 10%를 패딩으로 사용하기 위해 계산
    double paddingVertical = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: CustomAppBar(
        title: '피해 신고 가이드',
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
          // CommonContent 위젯 사용
          CommonContent(
            stepNumber: 1, // 숫자만 입력
            title: '모바일 백신으로 치료하고 악성 애플리케이션 설치 파일(APK)를 삭제하세요.',
            subTitle: ' APK 파일은 스마트폰에 기본적으로 설치되어 있는 ‘파일관리자’, ‘내파일’ 등 파일관리 애플리케이션에서 ‘Download 폴더’를 확인하여 삭제가 가능합니다.',
          ),

          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: paddingVertical), // 버튼 주변 패딩을 화면 높이의 10%로 설정
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // 버튼이 화면 가로폭에 맞게 확장
              children: [
                CustomTextButton(
                  label: '다음',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => GuideScreen2()
                      ),
                    );
                  },
                  backgroundColor: Color(0xFF364B3B),
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                  fontSize: 20,
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
    home: GuideScreen(),
    debugShowCheckedModeBanner: false, // 디버그 배너를 숨깁니다.
  ));
}
