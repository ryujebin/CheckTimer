import 'package:flutter/material.dart';
import 'package:test_flutter/Components/Buttons/ElevationButton/ElevationButton.dart';
import 'package:test_flutter/Components/TitleText/TitleText.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:test_flutter/Pages/MyRecord/Myrecord_detail.dart';

import '../../Components/Appbar/Appbar.dart';
import '../../Components/Buttons/TextButton/TextButton.dart';

class MyRecord extends StatelessWidget {
  const MyRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: SizedBox.expand(
        child: Stack(
          children: [
            /// 1. 스크롤 가능한 콘텐츠 영역
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // 버튼 가려지지 않게 아래 여백
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 82),
                    child: const TitleText(text: '000님의 기록'),
                  ),
        
                  const SizedBox(height: 55),
        
                  // 여기에 GridView 등 넣기
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // 내부 Grid만 스크롤 안 하게
                    itemCount: 8,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (context, index) {
                      return TextBtn(
                        text: '기록 ${index + 1}',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyRecordDetail()),
                          );
                        },
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 48,
                        borderColor: AppColors.secondary,
                      );
                    },
                  ),
                ],
              ),
            ),
        
            /// 2. 하단 고정 버튼
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(child: DeleteBtn()),
            ),
          ],
        ),
      ),
    );
  }

  Widget DeleteBtn() {
    return ElevationBtn(
      onPressed: () {},
      width: 80,
      height: 50,
      text: '',
      child: Image.asset(
        'assets/images/trashimg.png',
        height: 30,
        width: 30,
      ),
    );
  }
}
