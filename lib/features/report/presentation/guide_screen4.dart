import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen4.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen5.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart';
import '../../../widgets/textbutton.dart';
import 'guide_screen3.dart';

class GuideScreen4 extends StatelessWidget {
  const GuideScreen4({Key? key}) : super(key: key);

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
              stepNumber: 4,
              title: '공동인증서 삭제 및 재발급하세요.',
            ),
            Spacer(), // 버튼 위치를 그대로 유지하기 위해 Spacer 추가
            Padding(
              padding: EdgeInsets.symmetric(vertical: paddingVertical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextButton(
                    label: '다음',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => GuideScreen5(),
                        ),
                      );
                    },
                    backgroundColor: Colors.green,
                    pressedBackgroundColor: Colors.white,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                  ),
                  SizedBox(height: 3),
                  CustomTextButton(
                    label: '이전',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => GuideScreen3()),
                      );// Go back to the previous screen
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
