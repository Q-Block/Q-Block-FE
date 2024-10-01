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

  @override
  void initState() {
    super.initState();
    _initializeNaverMap();
  }

  Future<void> _initializeNaverMap() async {
    WidgetsFlutterBinding.ensureInitialized(); // Flutter의 엔진 초기화
    String clientId = 'ub6c5z1yy9'; // Naver Map 클라이언트 ID 설정
    await NaverMapSdk.instance.initialize(clientId: clientId); // NaverMap SDK 초기화
    print("Naver Map SDK 초기화 완료");
  }

  @override
  Widget build(BuildContext context) {
    // 화면의 높이를 가져옵니다.
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = screenHeight * 0.1;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight, // 계산된 높이 설정
        title: Container(
          padding: EdgeInsets.only(top: 20), // 위쪽 간격 추가
          child: Text(
            '큐블럭님 안녕하세요!', // 나중에 API 호출로 변경될 예정
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 제거
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // 양옆 패딩 추가
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          // NaverMap을 크기가 설정된 SizedBox로 감싸기
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 300.0, // 여기를 조정하여 지도 크기를 설정합니다.
              child: Container(
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
          ),

          // 스크롤 가능한 영역으로 텍스트와 카드들 감싸기
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0), // 전체 요소에 상하좌우 16 패딩 추가
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0), // 아래쪽 간격 추가
                      child: Text(
                        '큐싱 다발 지역 Top 3 🔥',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // 카드들을 세로로 나열하기 위해 Column 사용
                    Column(
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // 클릭 시 호출될 메서드
      ),
    );
  }

  // BottomNavigationBar의 항목이 클릭될 때 호출되는 메서드
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // 클릭된 인덱스에 따라 화면 전환 등을 추가할 수 있습니다.
    });
  }

  Widget _buildCard({required Color iconColor, required String number, required String address, required String name}) {
    return SizedBox(
      height: 100.0, // 카드 높이 설정
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.0), // 카드 내 요소에 패딩 추가
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
                      fontSize: 18, // 숫자 크기 조절
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
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 13,
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

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}