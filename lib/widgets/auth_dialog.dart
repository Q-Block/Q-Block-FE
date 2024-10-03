import 'package:flutter/material.dart';

class AuthDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm; // 확인 버튼을 눌렀을 때 호출할 콜백

  const AuthDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm, // 매개변수로 콜백을 받음
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 16.0), // 버튼과 텍스트 사이 간격 조정
        child: Text(content),
      ),
      actions: [
        Center(
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                onConfirm(); // 확인 버튼 눌렀을 때 동작
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // 둥글기 조정
                ),
              ),
              child: const Text('확인'),
            ),
          ),
        ),
      ],
    );
  }
}
