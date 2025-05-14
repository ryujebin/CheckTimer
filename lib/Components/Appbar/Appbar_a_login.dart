import 'package:flutter/material.dart';

import '../../Core/theme/colors.dart';

class AfterAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double fontSize;
  final double leftPadding;

  const AfterAppbar({
    super.key,
    this.title = 'CheckTimer',
    this.fontSize = 20,
    this.leftPadding = 16,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}