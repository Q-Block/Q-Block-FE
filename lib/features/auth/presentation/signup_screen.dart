import 'package:flutter/material.dart';
import 'package:qblock_fe/features/auth/domain/auth_service.dart';
import '../../../widgets/auth_dialog.dart';
import '../../../widgets/navigationbar.dart';
import '../../home/presentation/home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _onSignupPressed() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nicknameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AuthDialog(
            title: '유효성 검사',
            content: '모든 필드를 입력해주세요.',
            onConfirm: () {},
          );
        },
      );
    } else {
      try {
        print(
            'Signup details: ${_emailController.text}, ${_passwordController.text}, ${_nicknameController.text}');

        await _authService.signUp(
          _emailController.text,
          _passwordController.text,
          _nicknameController.text,
        );

        showDialog(
          context: context,
          builder: (context) {
            return AuthDialog(
              title: '회원가입 성공',
              content: '회원가입이 완료되었습니다.',
              onConfirm: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LogInScreen()),
                );
              },
            );
          },
        );
      } catch (error) {
        print('Signup failed with error: $error');
        showDialog(
          context: context,
          builder: (context) {
            return AuthDialog(
              title: '회원가입 실패',
              content: '회원가입에 실패했습니다.',
              onConfirm: () {},
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '회원가입',
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30), // Space above the first TextField
              const Text("아이디(이메일)*"),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  labelText: "예: qblock@example.com",
                  filled: true,
                  fillColor:
                      const Color.fromRGBO(250, 250, 250, 0.7).withOpacity(0.2),
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.redAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              const SizedBox(
                  height: 20), // Space between TextField and next text
              const Text("비밀번호*"),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  labelText: "비밀번호를 입력해주세요",
                  filled: true,
                  fillColor:
                      const Color.fromRGBO(250, 250, 250, 0.7).withOpacity(0.2),
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.redAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              const SizedBox(
                  height: 20), // Space between TextField and next text
              const Text("닉네임*"),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  labelText: "닉네임을 입력해주세요",
                  filled: true,
                  fillColor:
                      const Color.fromRGBO(250, 250, 250, 0.7).withOpacity(0.2),
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.redAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              const SizedBox(
                  height:
                      100), // Space between TextField and button (버튼을 더 아래로 이동시킴)
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    onPressed: _onSignupPressed,
                    child: const Text(
                      "가입하기",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80), // Space below the button
            ],
          ),
        ),
      ),
    );
  }
}
