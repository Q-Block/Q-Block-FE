import 'package:flutter/material.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../home/presentation/home_screen.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '오늘의 탐지',
        onIconPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), // 상단 여백 설정
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero, // ListView의 기본 패딩 제거
                children: [
                  _buildRecordItem(
                    dateTime: '2024.09.02 18:04:39',
                    urlAssessment: '0',  // QR 이미지 표시
                    url: 'http://babo.com',
                    accessStatus: 'X',
                  ),
                  _buildRecordItem(
                    dateTime: '2024.09.02 18:05:00',
                    urlAssessment: '1',  // URL 이미지 표시
                    url: 'http://malicious.com',
                    accessStatus: 'O',
                  ),
                  // 추가 기록 항목들을 여기에 정의할 수 있습니다.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordItem({
    required String dateTime,
    required String urlAssessment,
    required String url,
    required String accessStatus,
  }) {
    // URL 평가 결과에 따라 표시할 이미지 선택
    String displayImagePath = (urlAssessment == '0')
        ? 'assets/images/record_qr.png' // QR 이미지 경로
        : 'assets/images/record_url.png'; // URL 이미지 경로

    return Container(
      color: Colors.white, // 카드 배경색을 흰색으로 설정
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0), // 카드 간의 간격 줄이기
      child: Padding(
        padding: const EdgeInsets.all(12.0), // 카드 내 여백 조정
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 8.0), // 이미지 위에 여백 추가
                Image.asset(
                  displayImagePath,
                  width: 65, // 이미지 크기를 키움
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(width: 16.0), // 이미지와 텍스트 간격 조정
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateTime,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), // 텍스트 크기 줄이기
                  ),
                  SizedBox(height: 2.0), // 텍스트 간격 조정
                  Text(
                    '악성 URL 판단 결과 : ${urlAssessment == '0' ? 'O' : 'X'}',
                    style: TextStyle(fontSize: 12), // 텍스트 크기 줄이기
                  ),
                  Text(
                    'URL : $url',
                    style: TextStyle(fontSize: 12), // 텍스트 크기 줄이기
                  ),
                  Text(
                    '접속 여부 : $accessStatus',
                    style: TextStyle(fontSize: 12), // 텍스트 크기 줄이기
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RecordScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
