import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart';
import '../../../widgets/textbutton.dart';

class GuideScreen5 extends StatelessWidget {
  const GuideScreen5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double paddingVertical = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: CustomAppBar(
        title: '피해 신고 가이드',
        onIconPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // 전체 패딩 추가
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            SizedBox(height: 16), // 위쪽 간격 추가
            CommonContent(
              stepNumber: 5,
              title: '피해 상담 및 신고가 필요하다면?',
            ),
            Spacer(), // 버튼 위치를 그대로 유지하기 위해 Spacer 추가
            Padding(
              padding: EdgeInsets.symmetric(vertical: paddingVertical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextButton(
                    label: '118 상담 전화',
                    onPressed: () => launchUrl(Uri(scheme: 'tel', path: '118')), // 118 번호로 전화걸기
                    backgroundColor: Colors.green,
                    pressedBackgroundColor: Colors.white,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                  ),
                  SizedBox(height: 3),
                  CustomTextButton(
                    label: '112 신고 접수',
                    onPressed: () => launchUrl(Uri(scheme: 'tel', path: '112')), // 112 번호로 전화걸기
                    backgroundColor: Colors.green,
                    pressedBackgroundColor: Colors.white,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                  ),
                  SizedBox(height: 3),
                  CustomTextButton(
                    label: '처음으로 돌아가기',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => GuideScreen()),
                      );
                    },
                    backgroundColor: Colors.white,
                    pressedBackgroundColor: Colors.white,
                    textColor: Colors.black,
                    pressedTextColor: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
