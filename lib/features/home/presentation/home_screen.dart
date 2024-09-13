import 'package:flutter/material.dart';
import '../../../widgets/toolbar.dart'; // CustomBottomBar를 임포트
import 'package:flutter_naver_map/flutter_naver_map.dart';

// 애플리케이션의 메인 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

// 메인 화면 정의
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // 양옆 마진 설정
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0), // 위아래 간격 설정
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
          // NaverMap을 Column의 나머지 부분에 배치
          Expanded(
            child: NaverMap(
              options: const NaverMapViewOptions(),
              onMapReady: (controller) {
                print("네이버 맵 로딩됨!");
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

