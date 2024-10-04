import 'package:flutter/material.dart';
import 'package:qblock_fe/features/report/presentation/guide_screen2.dart';
import 'package:qblock_fe/features/user/presentation/profile_edit_screen.dart';
import '../../../widgets/common_content.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../../widgets/textbutton.dart';
import '../../home/presentation/home_screen.dart';
import '../../auth/presentation/login_screen.dart'; // LogInScreen 임포트
import '../domain/userInfo_service.dart';
import '../domain/logout_service.dart'; // LogoutService 임포트 추가

class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  _MypageScreenState createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  String nickname = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserInfo(); // 사용자 정보 가져오기
  }

  Future<void> _getUserInfo() async {
    UserInfoService userInfoService = UserInfoService();
    final userInfo = await userInfoService.fetchUserInfo();

    if (userInfo != null) {
      setState(() {
        nickname = userInfo['nickname']; // 닉네임 설정
        isLoading = false; // 로딩 완료
      });
    } else {
      setState(() {
        isLoading = false; // 로딩 완료 (실패 시)
      });
      print('UserInfo is null.'); // 추가된 에러 로그
    }
  }

  Future<void> _logout() async {
    LogoutService logoutService = LogoutService();
    try {
      final response = await logoutService.logout();
      if (response['isSuccess']) {
        // 로그아웃 성공 시
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LogInScreen(), // 로그아웃 후 LogInScreen으로 이동
          ),
        );
      }
    } catch (error) {
      print('Logout error: $error');
      // 여기서 에러 처리 로직 추가 가능
    }
  }

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
                        _logout(); // 로그아웃 호출
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
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
        child: isLoading // 로딩 상태에 따른 UI 변경
            ? Center(child: CircularProgressIndicator())
            : Column(
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
                    nickname.isNotEmpty ? '$nickname 님' : '사용자 님',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileEditScreen(), // 닉네임 변경 화면으로 이동
                        ),
                      );
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
