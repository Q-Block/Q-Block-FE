import 'package:flutter/material.dart';

// 색상 정의
const Color activeColor = Color(0xFF54715B);
const Color bottomAppBarColor = Colors.white; // 흰색 배경

// CustomBottomBar 위젯 정의
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
            color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도 조절
            spreadRadius: 0.5, // 그림자의 퍼짐 정도
            blurRadius: 3, // 그림자의 흐림 정도
            offset: Offset(0, -0.5), // 그림자의 위치 (위쪽으로 이동)
          ),
        ],
      ),
      child: BottomAppBar(
        color: bottomAppBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildIconButton(Icons.folder, '조회', 0),
            _buildIconButton(Icons.search, '탐지', 1),
            _buildIconButton(Icons.home, '홈', 2),
            _buildIconButton(Icons.error, '가이드', 3),
            _buildIconButton(Icons.person, '마이', 4),
          ],
        ),
      ),
    );
  }

  // 아이콘 버튼 빌드
  Widget _buildIconButton(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        onItemTapped(index); // 클릭 시 선택된 인덱스 업데이트
      },
      child: SizedBox(
        width: 60, // 버튼의 넓이 조정
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selectedIndex == index ? activeColor : Colors.grey,
              size: 30, // 아이콘 크기 조정
            ),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == index ? activeColor : Colors.grey,
                fontSize: 12, // 텍스트 크기 조정
              ),
            ),
          ],
        ),
      ),
    );
  }
}


