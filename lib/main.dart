import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:test_flutter/Pages/Homescreen/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_flutter/Pages/MyRecord/Myrecord_detail.dart';
import 'package:test_flutter/Pages/MyRecord/Myrecord_main.dart';
import 'package:test_flutter/Providers/Timer_setting_data_provider.dart';
import 'Pages/SplashScreen/SplashScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerSettingDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: const HomeScreen(),
    );
  }
}