import 'package:flutter/material.dart';

class CommonContent extends StatelessWidget {
  final int stepNumber; // 숫자만 입력받음
  final String title;
  final String? subTitle; // 서브 타이틀을 선택적으로 입력받음

  const CommonContent({
    Key? key,
    required this.stepNumber,
    required this.title,
    this.subTitle, // 서브 타이틀은 선택적
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step 정보
          Text(
            'Step $stepNumber', // 숫자를 "Step {숫자}" 형태로 변환
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8), // 간격 추가
          // Title 정보
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // 서브 타이틀 정보 (선택적)
          if (subTitle != null && subTitle!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                subTitle!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
