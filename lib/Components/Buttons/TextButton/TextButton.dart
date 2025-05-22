import 'package:flutter/material.dart';

import '../../../Core/theme/colors.dart';

class TextBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? borderColor;
  final double borderWidth;
  final bool underline;
  final double? height; // ← 추가됨
  final Color textcolor;

  const TextBtn({
    super.key,
    required this.text,
    this.onPressed,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.borderColor,
    this.borderWidth = 1.0,
    this.underline = false,
    this.height, // ← 추가됨
    this.textcolor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: borderColor != null
            ? BorderSide(color: borderColor!, width: borderWidth)
            : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: Size(0, height ?? 0), // ← height 지정
        textStyle: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Pretendard',
          fontWeight: fontWeight,
          decoration:
          underline ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
      child: Text(text,
      style: TextStyle(
        color: textcolor,
      ),),
    );
  }
}