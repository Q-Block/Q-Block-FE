import 'package:flutter/material.dart';
import '../features/detect/presentation/detection_initial _screen.dart';
import '../features/home/presentation/home_screen.dart';

const Color activeColor = Color(0xFF54715B);
const Color bottomAppBarColor = Colors.white; // 흰색 배경

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bottomAppBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: Offset(0, -0.5),
          ),
        ],
      ),
      child: BottomAppBar(
        color: bottomAppBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildIconButton(Icons.folder, '조회', 0, context),
            _buildIconButton(Icons.search, '탐지', 1, context),
            _buildIconButton(Icons.home, '홈', 2, context),
            _buildIconButton(Icons.error, '가이드', 3, context),
            _buildIconButton(Icons.person, '마이', 4, context),
          ],
        ),
      ),
    );
  }

// 아이콘 버튼 빌드
  Widget _buildIconButton(IconData icon, String label, int index,
      BuildContext context) {
    return InkWell(
      onTap: () {
        onItemTapped(index); // 선택된 아이템에 대한 처리

        if (index == 1) { // 홈 아이콘의 인덱스가 1일 때
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                DetectInitialScreen()), // DetectInitialScreen으로 이동
          );
        } else if (index == 2) { // 홈 아이콘의 인덱스가 2일 때
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen()), // HomeScreen으로 이동
          );
        }
      },
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selectedIndex == index ? activeColor : Colors.grey,
              size: 30,
            ),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == index ? activeColor : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
