import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:test_flutter/Pages/Homescreen/HomeScreen.dart';

import '../../Components/Buttons/ElevationButton/ElevationButton.dart';
import '../../Components/Buttons/TextButton/TextButton.dart';
import '../../Components/InputField/InputField.dart';
import '../../Components/TitleText/TitleText.dart';
import '../Timer/Timer_main.dart';
import 'Login.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller_num = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
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
                  textcolor: Color(0xFFA6A6A6),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  borderColor: AppColors.primary,
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null && !user.emailVerified) {
                      FirebaseAuth.instance.setLanguageCode('ko');
                      await user.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("이메일 인증 메일이 전송되었습니다.")),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 42),
                child: ElevationBtn(
                  text: '인증 완료',
                    onPressed: () async {
                      await FirebaseAuth.instance.currentUser?.reload();
                      final user = FirebaseAuth.instance.currentUser;

                      if (user != null && user.emailVerified) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                        // 다음 페이지로 이동
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("아직 이메일 인증이 완료되지 않았습니다.")),
                        );
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
