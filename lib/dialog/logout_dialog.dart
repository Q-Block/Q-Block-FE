import 'package:flutter/material.dart';

class LoginDialogs {
  static void showConnectionWarningDialog(
      BuildContext context, bool isMalicious, String url) async {
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
                  '로그아웃',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                if (isMalicious)
                  Text(
                    '정말 로그아웃 할까요?',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 120,
                      child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF54715B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: const Text(
                          '로그아웃',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // 로그아웃
                        },
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: const Text(
                          '닫기',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
