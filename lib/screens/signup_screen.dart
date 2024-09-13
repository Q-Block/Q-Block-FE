import 'package:flutter/material.dart';
import '../dialog/signup_dialog.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  void _onSignupPressed() {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nicknameController.text.isEmpty) {
      SignupDialogs.showValidationDialog(context);
    } else {
      SignupDialogs.showSignupSuccessDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 8.0, top: 0.0),
          child: Text('회원가입'),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(0.0), // Height of the bottom border
          child: Container(
            color: Colors.black.withOpacity(0.3), // Color of the bottom border
            height: 0.5, // Height of the bottom border
          ),
        ),
        toolbarHeight:
            90, // Adjust toolbarHeight to reduce space above the bottom border
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
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
                    vertical: 10.0,
                    horizontal: 12.0), // Adjust vertical padding
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
            const SizedBox(height: 20), // Space between TextField and next text
            const Text("비밀번호*"),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 12.0), // Adjust vertical padding
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
            const SizedBox(height: 20), // Space between TextField and next text
            const Text("닉네임*"),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 12.0), // Adjust vertical padding
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 202,
                height: 45,
                child: FilledButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF54715B), //const Color(0xFF364B3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onPressed: _onSignupPressed, // Call the new method
                  child: const Text(
                    "가입하기",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70), // Space below the button
          ],
        ),
      ),
    );
  }
}
