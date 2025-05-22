import 'package:flutter/material.dart';
import 'package:test_flutter/Core/theme/colors.dart';

import '../../Components/Buttons/ElevationButton/ElevationButton.dart';
import '../../Components/Buttons/TextButton/TextButton.dart';
import '../../Components/InputField/InputField.dart';
import '../../Components/TitleText/TitleText.dart';
import 'Login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: TitleText(
                text: 'Check Timer',
              ),
            ),
            InputField(
              hintText: '이름을 입력하세요.',
              labelText: 'NAME',
              controller: controller,
            ),
            InputField(
              hintText: '비밀번호를 입력하세요.',
              labelText: 'PASSWORD',
              controller: controller,
            ),
            InputField(
              hintText: '전화번호를 입력하세요.',
              labelText: 'PHONE NUMBER',
              controller: controller,
              suffix: TextBtn(
                text: '인증번호 발송',
                textcolor: Color(0xFF000000),
                fontSize: 13,
                fontWeight: FontWeight.w300,
                borderColor: AppColors.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 47),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InputField(
                  width: 100,
                  hintText: '인증번호',
                  labelText: ' ',
                  controller: controller,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 42),
              child: ElevationBtn(
                text: '가입하기',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
