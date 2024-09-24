import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onIconPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = screenHeight * 0.1;

    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0), // 상하 패딩 추가
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: onIconPressed ?? () => Navigator.of(context).pop(),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 32.0), // 제목 위쪽 패딩
        child: Text(
          title,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
        ),
      ),
      toolbarHeight: appBarHeight + 32.0, // 전체 높이 증가
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.1 + 32.0); // 높이 증가
}

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Test Title',
        onIconPressed: () {
          // 예를 들어 다른 화면으로 이동하는 경우
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AnotherScreen(),
            ),
          );
        },
      ),
      body: Center(
        child: Text('This is a test screen.'),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Another Screen',
      ),
      body: Center(
        child: Text('This is another screen.'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TestScreen(),
  ));
}
