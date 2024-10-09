import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/navigationbar.dart'; // CustomAppBar의 경로를 확인하고 수정
import '../../home/presentation/home_screen.dart';
import '../domain/record_service.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<Map<String, dynamic>> records = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    RecordsService recordsService = RecordsService();
    try {
      List<Map<String, dynamic>> fetchedRecords =
          await recordsService.getRecords();
      // Use a Set to filter unique records based on url and created_at
      Set<String> uniqueRecordKeys = {};
      List<Map<String, dynamic>> uniqueRecords = [];

      for (var record in fetchedRecords) {
        String url = record['url'];
        DateTime createdAt =
            DateTime.parse(record['created_at']); // Parse the timestamp

        bool isUnique = true; // Assume the record is unique

        for (var uniqueRecord in uniqueRecords) {
          String uniqueUrl = uniqueRecord['url'];
          DateTime uniqueCreatedAt = DateTime.parse(uniqueRecord['created_at']);

          // Check if the URLs are the same and the time difference is less than 1 second
          if (url == uniqueUrl &&
              createdAt.difference(uniqueCreatedAt).inMilliseconds.abs() <=
                  2000) {
            isUnique = false; // Mark as not unique
            break; // No need to check further
          }
        }

        // If the record is unique, add it to the list
        if (isUnique) {
          uniqueRecords.add(record);
        }
      }

      setState(() {
        records = uniqueRecords; // Update the records state with unique records
        isLoading = false; // Set loading to false after fetching
      });
    } catch (e) {
      print('Error fetching records: $e');
      setState(() {
        isLoading = false; // Ensure loading is false even if there's an error
      });
    }
  }

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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator()) // Show loading indicator
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return _buildRecordItem(
                      dateTime: record['created_at'],
                      type: record['qr_status'].toString(),
                      url: record['url'],
                      urlAssessment: record['malicious_status'].toString());
                },
              ),
      ),
    );
  }
}

Widget _buildRecordItem(
    {required String dateTime,
    required String urlAssessment,
    required String url,
    required String type}) {
  // qr_status 에 따라 표시할 이미지 선택
  String displayImagePath = (type == '1')
      ? 'assets/images/record_qr.png' // QR 이미지 경로
      : 'assets/images/record_url.png'; // URL 이미지 경로

// Parse the dateTime string into DateTime object
  DateTime parsedDateTime =
      DateTime.parse(dateTime); // Adjust this if your date format is different

  // Format DateTime to 'YYYY-MM-DD HH:MM:SS'
  String formattedDateTime =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDateTime);

  return Container(
    color: Colors.white, // 카드 배경색을 흰색으로 설정
    margin: const EdgeInsets.symmetric(
        vertical: 2.0, horizontal: 16.0), // 카드 간의 간격 줄이기
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
                  formattedDateTime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14), // 텍스트 크기 줄이기
                ),
                SizedBox(height: 2.0), // 텍스트 간격 조정
                Text(
                  '악성 URL 판단 결과 : ${urlAssessment == '1' ? 'O' : 'X'}',
                  style: TextStyle(fontSize: 12), // 텍스트 크기 줄이기
                ),
                Text(
                  'URL : $url',
                  style: TextStyle(fontSize: 12), // 텍스트 크기 줄이기
                ),
                /*
                  Text(
                    '접속 여부 : $accessStatus',
                    style: TextStyle(fontSize: 12), // 텍스트 크기 줄이기
                  ),
                  */
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void main() {
  runApp(MaterialApp(
    home: RecordScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
