import 'package:flutter/material.dart';
import 'package:test_flutter/Components/Buttons/ElevationButton/ElevationButton.dart';
import 'package:test_flutter/Components/Buttons/TextButton/TextButton.dart';

import '../../Components/InputField/InputField.dart';
import '../../Components/TitleText/TitleText.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
            Padding(
              padding: const EdgeInsets.only(top: 42),
              child: ElevationBtn(
                text: '시작하기',
                onPressed: () {},
              ),
            ),
            TextBtn(
              text: '회원가입',
              fontSize: 15,
              fontWeight: FontWeight.w300,
              underline: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
