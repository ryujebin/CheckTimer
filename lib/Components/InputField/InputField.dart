import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Core/theme/colors.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final double? width;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.width,
    this.suffix,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    // 화면 전체 너비
    final screenWidth = MediaQuery.of(context).size.width;

    // width가 없으면 좌우 47 여백을 뺀 값 사용
    final fieldWidth = width ?? (screenWidth - 94).clamp(0, screenWidth);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText.trim().isNotEmpty)
            Text(
              labelText,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          if (labelText.trim().isNotEmpty) const SizedBox(height: 4),
          Container(
            width: fieldWidth,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.primary,
                width: 1.0,
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold,
                decorationThickness: 0,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                isDense: true,
                suffixIcon: suffix != null
                    ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: suffix,
                )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                hintStyle: const TextStyle(
                  color: Color(0xFFA6A6A6),
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
