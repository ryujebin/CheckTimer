import 'package:flutter/material.dart';

import '../../Core/theme/colors.dart';
import '../../Pages/Login/Login.dart';

class BeforeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double fontSize;
  final double leftPadding;
  final VoidCallback? onLoginPressed; // 로그인 버튼 클릭 시 실행할 함수

  const BeforeAppbar({
    super.key,
    this.title = 'CheckTimer',
    this.fontSize = 20,
    this.leftPadding = 22,
    this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(left: leftPadding),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 23),
          child: ElevatedButton(
            onPressed: onLoginPressed ?? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //fixedSize: const Size(61, 28),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              textStyle: const TextStyle(fontSize: 14),
            ),
            child: const Text(
                '로그인',
              style: TextStyle(
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

