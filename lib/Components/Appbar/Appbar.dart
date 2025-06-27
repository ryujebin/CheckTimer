import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/Pages/Homescreen/HomeScreen.dart';

import '../../Core/theme/colors.dart';
import '../../Pages/Login/Login.dart';
import '../../Pages/Timer/Timer_setting.dart';

class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double fontSize;
  final double leftPadding;
  final VoidCallback? onLoginPressed;

  const MainAppbar({
    super.key,
    this.title = 'CheckTimer',
    this.fontSize = 20,
    this.leftPadding = 22,
    this.onLoginPressed,
  });

  @override
  State<MainAppbar> createState() => _MainAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppbarState extends State<MainAppbar> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  void _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃 확인'),
        content: const Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // 네
            child: const Text('네'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // 아니요
            child: const Text('아니요'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();
      setState(() {
        _user = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("로그아웃 되었습니다.")),
      );
      // ✅ TimerSetting 페이지로 이동
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(left: widget.leftPadding),
        child: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 23),
          child: ElevatedButton(
            onPressed: _user == null
                ? widget.onLoginPressed ??
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }
                : _handleLogout,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              textStyle: const TextStyle(fontSize: 14),
            ),
            child: Text(
              _user == null ? '로그인' : '로그아웃',
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      shape: Border(
        bottom: BorderSide(color: AppColors.primary, width: 1),
      ),
    );
  }
}