import 'package:flutter/material.dart';
import 'package:qblock_fe/features/detect/presentation/url_detection_screen.dart';
import 'package:qblock_fe/features/home/presentation/home_screen.dart';
import '../../../widgets/auth_dialog.dart';
import 'signup_screen.dart';
import '../domain/auth_service.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Placeholder method to simulate login
  bool _login(String email, String password) {
    // Replace this logic with your server request when ready
    const hardcodedEmail = '123';
    const hardcodedPassword = 'test';

    return email == hardcodedEmail && password == hardcodedPassword;
  }

  void _onLoginPressed() async {
    print('Login button pressed'); // Add this

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final isSuccess = await AuthService().login(email, password);
      print('Login response: $isSuccess'); // Add this

      if (isSuccess) {
        // Login successful, navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Show AuthDialog for login error
        print('Showing login error dialog'); // Add this
        showDialog(
          context: context,
          builder: (context) {
            return AuthDialog(
              title: '로그인 오류',
              content: '아이디 또는 비밀번호가 올바르지 않습니다.',
              onConfirm: () {},
            );
          },
        );
      }
    } catch (error) {
      print('Login error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Transform.translate(
                  offset: const Offset(0, -30), // Adjust this value as needed
                  child: Image.asset(
                    'assets/images/logo_plain.png',
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "이메일",
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
                    backgroundColor: Colors.green,
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
                    const SizedBox(width: 60),
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
