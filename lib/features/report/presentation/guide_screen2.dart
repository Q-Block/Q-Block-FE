import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen3.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart';
import '../../../widgets/textbutton.dart';

class GuideScreen2 extends StatelessWidget {
  const GuideScreen2({Key? key}) : super(key: key);


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
            stepNumber: 2,
            title: '금융 피해 시 금융감독원, 금융결제원, 은행, 카드사 피해사실 등록 및 지급정지 방법을 문의하세요.',
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: paddingVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextButton(
                  label: '금융 감독원으로 문의하기',
                  onPressed: () {},
                  backgroundColor: Color(0xFF364B3B),
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                  fontSize: 20,
                ),
                SizedBox(height: 10),
                CustomTextButton(
                  label: '금융 결제원으로 문의하기',
                  onPressed: () {},
                  backgroundColor: Color(0xFF364B3B),
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                  fontSize: 20,
                ),
                SizedBox(height: 10),
                CustomTextButton(
                  label: '다음',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => GuideScreen3()
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
                    Navigator.of(context).pop();
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
