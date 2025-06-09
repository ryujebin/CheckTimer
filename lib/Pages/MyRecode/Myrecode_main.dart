import 'package:flutter/material.dart';

import '../../Components/Appbar/Appbar.dart';


class MyRecord extends StatelessWidget {
  const MyRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: const Center(
        child: Text('여기에 기록 내용을 표시할 수 있습니다.'),
      ),
    );
  }
}
