import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color pressedBackgroundColor;
  final Color textColor;
  final Color pressedTextColor;
  final double fontSize;

  const CustomTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.pressedBackgroundColor = const Color(0x3AB458),
    this.textColor = Colors.black,
    this.pressedTextColor = Colors.white,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return pressedBackgroundColor; // 버튼이 눌렸을 때 배경색
            }
            return backgroundColor; // 기본 배경색
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return pressedTextColor; // 버튼이 눌렸을 때 글자색
            }
            return textColor; // 기본 글자색
          },
        ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // 버튼 테두리 둥글게
        )),
        shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.8)), // 그림자 색상
        elevation: MaterialStateProperty.all(2), // 그림자 높이
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8)), // 버튼 안의 텍스트와 가장자리 사이의 여백
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w200
        ),
      ),
    );
  }
}
