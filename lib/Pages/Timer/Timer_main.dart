import 'package:flutter/material.dart';
import 'package:test_flutter/Components/Appbar/Appbar_b_login.dart';
import 'package:test_flutter/Components/Buttons/ElevationButton/ElevationButton.dart';
import 'package:test_flutter/Components/InputField/InputField.dart';
import 'package:test_flutter/Components/TitleText/TitleText.dart';
import 'package:test_flutter/Core/theme/colors.dart';

import '../../Components/Buttons/DropdownButton/DropdownButton.dart';

class TimerMain extends StatefulWidget {
  const TimerMain({super.key});

  @override
  State<TimerMain> createState() => _TimerMainState();
}

class _TimerMainState extends State<TimerMain> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
        appBar: BeforeAppbar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(
                text: '초기 설정',
                color: AppColors.secondary,
              ),
              InputField(
                hintText: '주제를 입력하세요.',
                labelText: 'TITLE',
                controller: controller,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 47), // 양 옆 여백 조정
                child: Row(
                  children: [
                    Expanded(
                      flex: 1, // 가중치
                      child: InputField(
                        hintText: '입력하세요.',
                        labelText: '속력',
                        controller: controller,
                      ),
                    ),
                    const SizedBox(width: 12), // 사이 간격
                    Expanded(
                      flex: 1, // 드롭다운은 조금 좁게
                      child: Dropdown<String>(
                        labelText: '단위',
                        hintText: '선택',
                        items: ['선택', 'M/S', 'KM/H'],
                        value: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 47), // 양 옆 여백 조정
                child: Row(
                  children: [
                    Expanded(
                      flex: 1, // 가중치
                      child: InputField(
                        hintText: '입력하세요.',
                        labelText: '거리',
                        controller: controller,
                      ),
                    ),
                    const SizedBox(width: 12), // 사이 간격
                    Expanded(
                      flex: 1, // 드롭다운은 조금 좁게
                      child: Dropdown<String>(
                        labelText: '단위',
                        hintText: '선택',
                        items: ['선택', 'M', 'KM'],
                        value: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevationBtn(
                  text: '설정 완료',
                  onPressed: () {

                  },
                ),
              )
            ],
          ),
        ));
  }
}
