import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;            // 표시할 문구
  final double fontSize;        // 글자 크기
  final Color color;            // 글자 색상
  final String fontFamily;      // 폰트명
  final FontWeight fontWeight;  // 굵기

  const TitleText({
    super.key,
    required this.text,
    this.fontSize = 40,
    this.color = Colors.black,
    this.fontFamily = 'Pretendard',
    this.fontWeight = FontWeight.w800,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}