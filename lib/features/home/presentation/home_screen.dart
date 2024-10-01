import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import '../../../widgets/toolbar.dart';
import '../map/map_widget.dart';
import '../map/mark_locations.dart'; // Import mark_location.dart

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // 기본 선택된 인덱스 설정
  NaverMapController? _mapController;
  List<NMarker> _markers = []; // Markers stored for later access
  NMarker? _highlightedMarker; // Store highlighted marker

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = screenHeight * 0.1;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight, // 계산된 높이 설정
        title: Container(
          padding: const EdgeInsets.only(top: 20), // 위쪽 간격 추가
          child: const Text(
            '큐블럭님 안녕하세요!',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 제거
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.grey, thickness: 1),
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
              child: NaverMapWidget(
                onMapReady: (controller) {
                  setState(() {
                    _mapController = controller;
                  });
                },
              ),
            ),
          ),
          // 스크롤 가능한 영역으로 텍스트와 카드들 감싸기
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // 전체 요소에 상하좌우 16 패딩 추가
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0), // 아래쪽 간격 추가
                      child: Text(
                        '큐싱 다발 지역 Top 3 🔥',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // 카드들을 세로로 나열하기 위해 Column 사용
                    Column(
                      children: markLocations.map((location) {
                        return Column(
                          children: [
                            _buildCard(
                              number: location.number,
                              iconColor: location.color,
                              address: location.address,
                              name: location.name,
                              onTap: () => _onCardTap(location),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        );
                      }).toList(),
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

  // 카드 클릭 시 호출되는 메서드
  void _onCardTap(MarkLocation location) {
    if (_mapController != null) {
      _mapController?.updateCamera(NCameraUpdate.scrollAndZoomTo(
        target: location.position,
        zoom: 17,
      ));
    }
  }

  Widget _buildCard({
    required String number,
    required Color iconColor,
    required String address,
    required String name,
    required VoidCallback onTap, // 카드 클릭 시 호출되는 콜백
  }) {
    return GestureDetector(
      onTap: onTap, // 카드 클릭 시 동작
      child: SizedBox(
        height: 100.0,
        child: Card(
          elevation: 4.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                        fontSize: 20,
                        color: iconColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        address,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
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
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
