import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import '../../../widgets/toolbar.dart';
import '../../user/domain/userInfo_service.dart';
import '../map/map_widget.dart';
import '../map/mark_locations.dart';
import 'dart:convert'; // JSON 변환을 위한 import
import 'package:http/http.dart' as http; // HTTP 요청을 위한 import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // 기본 선택된 인덱스 설정
  NaverMapController? _mapController;
  List<NMarker> _markers = []; // Markers stored for later access
  String? _nickname; // 사용자 nickname을 저장할 변수

  @override
  void initState() {
    super.initState();
    _fetchUserInfo(); // 사용자 정보를 가져옵니다.
  }

  Future<void> _fetchUserInfo() async {
    UserInfoService userInfoService = UserInfoService();
    final userInfo = await userInfoService.fetchUserInfo();
    setState(() {
      if (userInfo != null) {
        _nickname = userInfo['nickname']; // nickname 가져오기
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = screenHeight * 0.1;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            _nickname != null ? '$_nickname님 안녕하세요!' : '로딩 중...', // nickname 표시
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.grey, thickness: 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: SizedBox(
              height: 290.0,
              child: NaverMapWidget(
                onMapReady: (controller) {
                  setState(() {
                    _mapController = controller;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6, left: 16.0, right: 16.0, bottom: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        '큐싱 다발 지역 Top 3 🔥',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
        onItemTapped: _onItemTapped,
      ),
    );
  }

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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
