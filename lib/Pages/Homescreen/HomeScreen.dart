import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:provider/provider.dart';
import '../MyRecord/Myrecord_main.dart';
import '../Timer/Timer_setting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TimerSetting(),
    MyRecord(), // 기록화면 추가
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // 로그인 안 되어있을 경우 알림창 띄우기
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('알림'),
            content: const Text('로그인 후 사용 가능합니다.'),
            actions: [
              TextButton(
                child: const Text('확인'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        return;
      }
    }

    // 로그인되어 있거나 타이머 페이지일 경우 페이지 변경
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,       // 터치 ripple 제거
          highlightColor: Colors.transparent,    // 강조 효과 제거
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.background,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.secondary.withOpacity(0.5),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: '타이머',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '기록',
            ),
          ],
        ),
      ),
    );
  }
}