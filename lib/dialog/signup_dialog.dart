import 'package:flutter/material.dart';
import 'package:qblock_fe/screens/login_screen.dart';

class SignupDialogs {
  static void showSignupSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '회원가입 완료',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  '이제 Q-BLOCK 에서 악성 URL을 탐지할 수 있어요!',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF364B3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showValidationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '회원가입 하려면 모든 정보를 입력해주세요.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF364B3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      child: const Text('확인', style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
