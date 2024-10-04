import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen4.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart';
import '../../../widgets/textbutton.dart';
import 'guide_screen2.dart';

class GuideScreen3 extends StatelessWidget {
  const GuideScreen3({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double paddingVertical = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: CustomAppBar(
        title: '피해 신고 가이드',
        onIconPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GuideScreen2()),
          );
        },
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CommonContent(
            stepNumber: 3,
            title: 'KT, SK telecom, LG U+ 통신사를 통해 모바일 결제 확인 및 취소하고 번호도용 차단서비스 신청하세요',
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: paddingVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                SizedBox(height: 3),
                CustomTextButton(
                  label: '다음',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => GuideScreen4()
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
                      MaterialPageRoute(builder: (context) => GuideScreen2()),
                    ); // Go back to the previous screen
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
    );
  }
}
