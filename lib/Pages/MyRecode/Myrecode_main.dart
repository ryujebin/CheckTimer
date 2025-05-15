import 'package:flutter/material.dart';
import 'package:test_flutter/Components/Appbar/Appbar_a_login.dart';

class MyRecord extends StatelessWidget {
  const MyRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AfterAppbar(),
      body: const Center(
        child: Text('여기에 기록 내용을 표시할 수 있습니다.'),
      ),
    );
  }
}
