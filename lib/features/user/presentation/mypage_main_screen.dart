import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen2.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../../widgets/textbutton.dart';
import '../../home/presentation/home_screen.dart';
import '../../auth/presentation/login_screen.dart'; // LogInScreen 임포트

class MypageScreen extends StatelessWidget {
  const MypageScreen({Key? key}) : super(key: key);

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '로그아웃',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text('정말 로그아웃할까요?'),
          actions: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16), // 버튼 위쪽 간격 추가
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LogInScreen(), // 로그아웃 후 LogInScreen으로 이동
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF364B3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 둥글기 조정
                        ),
                      ),
                      child: Text('로그아웃'),
                    ),
                  ),
                  SizedBox(height: 8), // 버튼 간격
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 둥글기 조정
                        ),
                      ),
                      child: Text('닫기'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '마이 페이지',
        onIconPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    '안녕하세요!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '큐블럭 님',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '계정',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: Text('로그아웃'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                  ListTile(
                    title: Text('탈퇴하기'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    onTap: () {
                      // 탈퇴 처리
                    },
                  ),
                  ListTile(
                    title: Text('닉네임 변경'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    onTap: () {
                      // 닉네임 변경 처리
                    },
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

void main() {
  runApp(MaterialApp(
    home: MypageScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
