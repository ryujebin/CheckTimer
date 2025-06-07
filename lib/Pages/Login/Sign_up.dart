import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:test_flutter/Pages/Login/Authentication.dart';

import '../../Components/Buttons/ElevationButton/ElevationButton.dart';
import '../../Components/Buttons/TextButton/TextButton.dart';
import '../../Components/InputField/InputField.dart';
import '../../Components/TitleText/TitleText.dart';
import 'Login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller_email = TextEditingController();
    TextEditingController controller_pw = TextEditingController();
    TextEditingController controller_name = TextEditingController();
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
                controller: controller_email,
              ),
              InputField(
                hintText: '비밀번호를 입력하세요.',
                labelText: 'PASSWORD',
                controller: controller_pw,
              ),
              InputField(
                hintText: '이름을 입력하세요.',
                labelText: 'NAME',
                controller: controller_name,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 42),
                child: ElevationBtn(
                    text: '가입 하기',
                    onPressed: () async {
                      final email = controller_email.text.trim();
                      final password = controller_pw.text.trim();
                      final name = controller_name.text.trim();

                      try {
                        // 회원가입 시도
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        final user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          // 2. Firestore에 사용자 정보 저장
                          try {
                            await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                              'name': name,
                              'email': email,
                            });
                            print('Firestore 저장 성공');
                          } catch (e) {
                            print('Firestore 저장 실패: $e');
                          }
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Authentication()),
                        );
                      } on FirebaseAuthException catch (e) {
                        // 이메일 중복 에러 처리
                        if (e.code == 'email-already-in-use') {
                          try {
                            // 기존 계정으로 로그인 시도
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            final user = userCredential.user;

                            if (user != null && user.emailVerified) {
                              // 이메일 인증 완료된 계정
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('알림'),
                                  content: const Text('이미 존재하는 계정입니다.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('확인'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // 이메일 인증 안된 계정
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('이메일 인증 필요'),
                                  content: const Text('이메일 인증을 먼저 진행해주세요.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('확인'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } catch (e) {
                            // 로그인 자체가 실패한 경우
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('로그인 실패'),
                                content: Text(
                                    '이미 존재하는 계정이지만 로그인에 실패했습니다.\n${e.toString()}'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('확인'),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          // 다른 FirebaseAuth 오류
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("회원가입 실패: ${e.message}")),
                          );
                        }
                      } catch (e) {
                        // 알 수 없는 오류
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("오류 발생: ${e.toString()}")),
                        );
                      }
                    }),
              ),
              TextBtn(
                text: '이메일 인증하러 가기',
                fontSize: 15,
                fontWeight: FontWeight.w300,
                underline: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Authentication()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
