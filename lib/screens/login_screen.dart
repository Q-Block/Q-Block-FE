import 'package:flutter/material.dart';
import 'package:qblock_fe/dialog/login_dialog.dart';
import 'package:qblock_fe/screens/url_detection_screen.dart';
import 'signup_screen.dart';
import '../auth_service.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Placeholder method to simulate login
  bool _login(String email, String password) {
    // Replace this logic with your server request when ready
    const hardcodedEmail = '123@test.com';
    const hardcodedPassword = 'test';

    if (email == hardcodedEmail && password == hardcodedPassword) {
      return true; // Simulate successful login
    } else {
      return false; // Simulate login failure
    }
  }

  void _onLoginPressed() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_login(email, password)) {
      // login successful
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (context) => const HomeScreen()),
        MaterialPageRoute(builder: (context) => const UrlDetectionScreen()),
      );
    } else {
      LoginDialogs.showLoginErrorDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/logo_plain.png',
                    height: 200, fit: BoxFit.contain),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "아이디",
                    filled: true,
                    fillColor: const Color.fromRGBO(250, 250, 250, 0.7)
                        .withOpacity(0.2),
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    filled: true,
                    fillColor: const Color.fromRGBO(250, 250, 250, 0.7)
                        .withOpacity(0.2),
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                const SizedBox(height: 15),
                FilledButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF54715B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onPressed: _onLoginPressed,
                  child: const Text(
                    "로그인",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 회원가입 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        "회원가입",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 60), // 텍스트 사이의 간격
                    GestureDetector(
                      onTap: () {
                        // 아이디/비밀번호 찾기 페이지로 이동
                      },
                      child: Text(
                        "아이디/비밀번호 찾기",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
