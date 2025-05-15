import 'package:flutter/material.dart';
import 'package:test_flutter/Core/theme/colors.dart';

import '../MyRecode/Myrecode_main.dart';
import '../Timer/Timer_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TimerMain(),
    MyRecord(), // 기록화면 추가
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