import 'package:flutter/material.dart';

class LoginDialogs {
  static void showLoginErrorDialog(BuildContext context) {
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
                  '로그인 실패',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  '입력하신 아이디 또는 비밀번호 정보가 틀립니다.',
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
                        Navigator.pop(context);
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
