import 'package:flutter/material.dart';
import '../../../widgets/toolbar.dart'; // CustomBottomBar를 임포트
import 'package:flutter_naver_map/flutter_naver_map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // 기본 선택된 인덱스 설정
  NaverMapController? _mapController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // 네비게이션 바 클릭 시의 동작을 추가할 수 있습니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // 양옆 마진 설정
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0), // 위아래 간격 설정
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '큐블럭님 안녕하세요!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ],
                ),
              ),
            ),
            // NaverMap을 크기가 설정된 SizedBox로 감싸기
            SizedBox(
              height: 300.0, // 여기를 조정하여 지도 크기를 설정합니다.
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: NaverMap(
                  options: NaverMapViewOptions(
                    // 현위치 버튼 활성화
                  ),
                  onMapReady: (controller) {
                    _mapController = controller;
                    print("네이버 맵 로딩됨!");
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0), // 맵과 텍스트 사이에 여백 추가
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // 양옆 마진 설정
              child: Text(
                '큐싱 다발 지역 Top 3 🔥',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.0), // 텍스트와 카드 사이에 여백 추가
            // 카드들을 세로로 나열하기 위해 Column 사용
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // 양옆 마진 설정
              child: Column(
                children: <Widget>[
                  _buildCard(
                    number: '100',
                    iconColor: Colors.red,
                    address: '서울 강남구 역삼로3길 20-3',
                    name: '기린하우스',
                  ),
                  SizedBox(height: 10.0), // 카드 간의 간격
                  _buildCard(
                    number: '80',
                    iconColor: Colors.orange,
                    address: '서울 강남구 역삼로3길 20-3',
                    name: '기린하우스',
                  ),
                  SizedBox(height: 10.0), // 카드 간의 간격
                  _buildCard(
                    number: '50',
                    iconColor: Colors.yellow,
                    address: '서울 강남구 역삼로3길 20-3',
                    name: '기린하우스',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildCard({required Color iconColor, required String number, required String address, required String name}) {
    return SizedBox(
      height: 100.0, // 카드 높이 설정
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: iconColor, width: 2.0),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      fontSize: 20, // 숫자 크기 조절
                      color: iconColor,
                      fontWeight: FontWeight.bold, // 숫자를 굵게
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

