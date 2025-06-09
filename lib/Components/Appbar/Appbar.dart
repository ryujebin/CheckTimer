import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Core/theme/colors.dart';
import '../../Pages/Login/Login.dart';

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
    await FirebaseAuth.instance.signOut();
    setState(() {
      _user = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("로그아웃 되었습니다.")),
    );
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