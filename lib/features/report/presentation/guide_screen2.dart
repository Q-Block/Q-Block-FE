import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen3.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart';
import '../../../widgets/textbutton.dart';
import 'guide_screen.dart';

class GuideScreen2 extends StatelessWidget {
  const GuideScreen2({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    double paddingVertical = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: CustomAppBar(
        title: '피해 신고 가이드',
        onIconPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GuideScreen()),
          );
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
                  onPressed: () => launchUrl(Uri.parse('https://www.fss.or.kr')),
                  backgroundColor: Colors.green,
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,

                ),
                SizedBox(height: 3),
                CustomTextButton(
                  label: '금융 결제원으로 문의하기',
                  onPressed: () => launchUrl(Uri.parse('https://www.kftc.or.kr')),
                  backgroundColor: Colors.green,
                  pressedBackgroundColor: Colors.white,
                  textColor: Colors.white,
                  pressedTextColor: Colors.black,
                ),
                SizedBox(height: 3),
                CustomTextButton(
                  label: '다음',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => GuideScreen3()),
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
    );
  }
}
