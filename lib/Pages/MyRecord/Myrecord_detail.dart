import 'package:flutter/material.dart';
import 'package:test_flutter/Components/Buttons/ElevationButton/ElevationButton.dart';

import '../../Components/Appbar/Appbar.dart';
import '../../Core/theme/colors.dart';

class MyRecordDetail extends StatefulWidget {
  const MyRecordDetail({super.key});

  @override
  State<MyRecordDetail> createState() => _MyRecordDetailState();
}

class _MyRecordDetailState extends State<MyRecordDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: SizedBox.expand(
        child: Stack(
          children: [
            /// 콘텐츠 영역
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // 버튼 안 가리도록 여유
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text_Title('터널'),
                    ),
                    Text_speed('속도'),
                    Text_distance('거리'),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppColors.primary, width: 1),
                          bottom: BorderSide(color: AppColors.primary, width: 3),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Check List',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1, // 임시 데이터 개수
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.check_circle_outline, color: AppColors.primary),
                          title: Text('체크리스트 아이템 $index',
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// 하단 고정 버튼
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Center(child: BackBtn()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Text_Title(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: AppColors.primary,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget Text_speed(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.primary,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget Text_distance(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.primary,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget BackBtn() {
    return ElevationBtn(
      onPressed: () {
        Navigator.pop(context);
      },
      width: 150,
      height: 50,
      text: '',
      child: Text(
        '돌아가기',
        style: TextStyle(
          color: AppColors.background,
          fontSize: 20,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }
}
