import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Components/Appbar/Appbar.dart';
import 'package:test_flutter/Components/Buttons/ElevationButton/ElevationButton.dart';
import 'package:test_flutter/Components/InputField/InputField.dart';
import 'package:test_flutter/Components/TitleText/TitleText.dart';
import 'package:test_flutter/Core/theme/colors.dart';

import '../../Components/Buttons/DropdownButton/DropdownButton.dart';
import '../../Providers/Timer_setting_data_provider.dart';
import 'Timer.dart';

class TimerSetting extends StatefulWidget {
  const TimerSetting({super.key});

  @override
  State<TimerSetting> createState() => _TimerSettingState();
}

class _TimerSettingState extends State<TimerSetting> {
  String? selectedSpeedUnit;
  String? selectedDistanceUnit;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController speedController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    speedController.dispose();
    distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: MainAppbar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(
                  text: '초기 설정',
                ),
                InputField(
                  hintText: '주제를 입력하세요.',
                  labelText: 'TITLE',
                  controller: titleController,
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
                          labelText: '속도',
                          controller: speedController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      const SizedBox(width: 12), // 사이 간격
                      Expanded(
                        flex: 1, // 드롭다운은 조금 좁게
                        child: Dropdown<String>(
                          labelText: '단위',
                          hintText: '선택',
                          items: ['선택', 'M/S', 'KM/H'],
                          value: selectedSpeedUnit,
                          onChanged: (value) {
                            setState(() {
                              selectedSpeedUnit = value;
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
                          controller: distanceController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      const SizedBox(width: 12), // 사이 간격
                      Expanded(
                        flex: 1, // 드롭다운은 조금 좁게
                        child: Dropdown<String>(
                          labelText: '단위',
                          hintText: '선택',
                          items: ['선택', 'M', 'KM'],
                          value: selectedDistanceUnit,
                          onChanged: (value) {
                            setState(() {
                              selectedDistanceUnit = value;
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
                      // 조건 검사
                      if (titleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('제목은 필수 입력입니다.')),
                        );
                        return;
                      }
                      if ((selectedSpeedUnit == null || selectedSpeedUnit == '선택') &&
                          (selectedDistanceUnit == null || selectedDistanceUnit == '선택')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('속력 또는 거리 단위 중 하나는 선택해야 합니다.')),
                        );
                        return;
                      }
                      if (speedController.text.isEmpty && distanceController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('속력 또는 거리 값 중 하나는 입력해야 합니다.')),
                        );
                        return;
                      }

                      // Provider에 저장
                      Provider.of<TimerSettingDataProvider>(context, listen: false)
                          .setTimerSetting(
                        title: titleController.text,
                        speed: speedController.text,
                        speedUnit: selectedSpeedUnit ?? '',
                        distance: distanceController.text,
                        distanceUnit: selectedDistanceUnit ?? '',
                      );

                      // 저장된 값 콘솔에 출력
                      final settingData = Provider.of<TimerSettingDataProvider>(context, listen: false).settingData;
                      print("제목: ${settingData?.title}");
                      print("속도: ${settingData?.speed} ${settingData?.speedUnit}");
                      print("거리: ${settingData?.distance} ${settingData?.distanceUnit}");

                      // 화면 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TimerPage()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
