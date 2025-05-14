import 'package:flutter/material.dart';
import '../../../Core/theme/colors.dart';

class ElevationBtn extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final VoidCallback onPressed;

  const ElevationBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 50, // 기본 높이 50
    this.width, // 기본 width는 null, 양쪽 여백 56씩 남기게 처리
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = width ?? (screenWidth - 56 * 2); // 기본 width 계산

    return SizedBox(
      height: height, // 기본 높이
      width: buttonWidth, // 계산된 가로 길이
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.background,
          backgroundColor: AppColors.primary, // 글자색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius 10
          ),
          elevation: 0, // 그림자 없음
          padding: EdgeInsets.zero, // padding 없애기
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.bold,
              fontSize: 16, // 텍스트 크기
            ),
          ),
        ),
      ),
    );
  }
}
