import 'package:flutter/material.dart';
import 'package:test_flutter/Components/Buttons/ElevationButton/ElevationButton.dart';
import 'package:test_flutter/Components/Buttons/TextButton/TextButton.dart';
import 'package:test_flutter/Pages/Login/Sign_up.dart';

import '../../Components/InputField/InputField.dart';
import '../../Components/TitleText/TitleText.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller_email = TextEditingController();
    TextEditingController controller_pw = TextEditingController();
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
              controller: controller_email,
            ),
            InputField(
              hintText: '비밀번호를 입력하세요.',
              labelText: 'PASSWORD',
              controller: controller_pw,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 42),
              child: ElevationBtn(
                text: '시작 하기',
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
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
