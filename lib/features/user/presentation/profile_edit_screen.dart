import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen2.dart';
import 'package:qblock_fe/features/user/presentation/mypage_main_screen.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../../widgets/textbutton.dart';
import '../../home/presentation/home_screen.dart';
import '../../auth/presentation/login_screen.dart'; // LogInScreen 임포트

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isButtonEnabled = false;

  void _onNicknameChanged(String value) {
    setState(() {
      _isButtonEnabled = value.isNotEmpty; // 입력값이 있을 때 버튼 활성화
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose(); // 리소스 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '닉네임 변경',
        onIconPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MypageScreen(),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 78.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 텍스트 필드를 상단에 배치
          children: [
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                hintText: '큐블럭',
                border: OutlineInputBorder(),
              ),
              onChanged: _onNicknameChanged, // 입력이 변경될 때 호출
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  // 수정 완료 버튼 클릭 시 처리
                  // 닉네임 변경 처리 로직 추가
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MypageScreen(), // 또는 다른 화면으로 이동
                    ),
                  );
                }
                    : null, // 비활성화 상태일 때 클릭 불가
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled ? Colors.green : Colors.grey, // 활성화 상태에 따른 색상 변경
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // 모서리를 덜 둥글게 설정
                  ),
                ),
                child: Text(
                  '수정 완료',
                  style: TextStyle(color: Colors.white), // 글씨 색상 흰색으로 변경
                ),
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
    home: ProfileEditScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

