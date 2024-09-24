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
      body: Column(
        children: [
          CommonContent(
            stepNumber: 5,
            title: '피해 상담 및 신고가 필요하다면?',
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: paddingVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                CustomTextButton(
                  label: '118 상담 전화',
                  onPressed: () => launchUrl(Uri( scheme: 'tel', path: '118',)), // 118 번호로 전화걸기
                  backgroundColor: Color(0xFF364B3B),
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                  fontSize: 20,
                ),
                SizedBox(height: 10),
                CustomTextButton(
                  label: '112 신고 접수',
                  onPressed: () => launchUrl(Uri( scheme: 'tel', path: '112',)), // 112 번호로 전화걸기
                  backgroundColor: Color(0xFF364B3B),
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                  fontSize: 20,
                ),
                SizedBox(height: 10),
                CustomTextButton(
                  label: '처음으로 돌아가기',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GuideScreen()),
                    );
                  },
                  backgroundColor: Colors.white,
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.black,
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
