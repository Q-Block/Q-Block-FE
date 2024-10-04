import 'package:flutter/material.dart';
import 'package:qblock_fe/features/user/presentation/mypage_main_screen.dart';
import '../../../widgets/navigationbar.dart';
import '../domain/nicknameChange_service.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isButtonEnabled = false;
  final NicknameChangeService _nicknameChangeService = NicknameChangeService();

  void _onNicknameChanged(String value) {
    setState(() {
      _isButtonEnabled = value.isNotEmpty;
    });
  }

  void _handleNicknameChange() async {
    final newNickname = _nicknameController.text;

    try {
      final response = await _nicknameChangeService.changeNickname(newNickname);

      // 응답 내용 확인
      print('Response: $response');

      if (response['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('닉네임이 성공적으로 변경되었습니다!')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MypageScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('닉네임 변경에 실패했습니다. 다시 시도해주세요.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('에러가 발생했습니다: $e')),
      );
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                hintText: '큐블럭',
                border: OutlineInputBorder(),
              ),
              onChanged: _onNicknameChanged,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? _handleNicknameChange
                    : null, // 수정 완료 버튼 클릭 시 닉네임 변경 처리
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled ? Colors.green : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  '수정 완료',
                  style: TextStyle(color: Colors.white),
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
