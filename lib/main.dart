import 'package:flutter/material.dart';
import 'package:test_flutter/Components/SplashScreen/SplashScreen.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:test_flutter/Pages/Homescreen/HomeScreen.dart';

import 'Pages/SplashScreen/SplashScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckTimer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // 필요에 따라 변경
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Pretendard', // 원하는 폰트 지정
      ),
      home: const SplashScreen(), // 시작화면을 TimerMain으로 설정
    );
  }
}