import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen4.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen5.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart';
import '../../../widgets/textbutton.dart';

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
      body: Column(
        children: [
          CommonContent(
            stepNumber: 4,
            title: '공동인증서 삭제 및 재발급하세요.',
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: paddingVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                SizedBox(height: 10),
                CustomTextButton(
                  label: '다음',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => GuideScreen5()
                      ),
                    );
                  },
                  backgroundColor: Color(0xFF364B3B),
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                  fontSize: 20,
                ),
                SizedBox(height: 10),
                CustomTextButton(
                  label: '이전',
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to the previous screen
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
