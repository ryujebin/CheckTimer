import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:test_flutter/Pages/Homescreen/HomeScreen.dart';

import '../../Components/TitleText/TitleText.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoAnimation;

  late AnimationController _textController;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _logoController, curve: Curves.bounceOut));

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _logoController.forward().whenComplete(() {
      _textController.forward();

      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _logoAnimation,
              child: Image.asset(
                'assets/images/AppLogo.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _textFadeAnimation,
              child: TitleText(text: 'CheckTimer'),
            ),
          ],
        ),
      ),
    );
  }
}