import 'package:flutter/material.dart';
import 'package:test_flutter/Core/theme/colors.dart';

import '../../Components/Buttons/ElevationButton/ElevationButton.dart';
import '../../Components/Buttons/TextButton/TextButton.dart';
import '../../Components/InputField/InputField.dart';
import '../../Components/TitleText/TitleText.dart';
import 'Login.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller_num = TextEditingController();
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
              hintText: 'E-mail을 입력하세요.',
              labelText: 'E-MAIL',
              controller: controller_num,
              suffix: TextBtn(
                text: '인증요청',
                textcolor: Color(0xFF000000),
                fontSize: 13,
                fontWeight: FontWeight.w300,
                borderColor: AppColors.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 42),
              child: ElevationBtn(
                text: '인증 완료',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
