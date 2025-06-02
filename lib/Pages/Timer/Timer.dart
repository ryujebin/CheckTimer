import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Components/Appbar/Appbar.dart';
import 'package:test_flutter/Core/theme/colors.dart';

import '../../Components/Buttons/ElevationButton/ElevationButton.dart';
import '../../Providers/Timer_setting_data_provider.dart';

import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  List<String> _checkList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
    setState(() {});
  }

  void _stopTimer() {
    _isRunning = false;
    _timer?.cancel();
    setState(() {});
  }

  void _resetTimer() {
    _stopTimer();
    _seconds = 0;
    _checkList.clear();
    setState(() {});
  }

  String _formatTime(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);
    return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(secs)}';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  Widget build(BuildContext context) {
    final settingData =
        Provider.of<TimerSettingDataProvider>(context).settingData;

    return Scaffold(
      appBar: MainAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: settingData == null
            ? const Center(child: Text('설정 데이터가 없습니다.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text_Title(settingData.title),
                  ),
                  Text_Speed(settingData.speed, settingData.speedUnit),
                  Text_Distance(
                      settingData.distance, settingData.distanceUnit),

                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        _formatTime(_seconds),
                        style: const TextStyle(
                          fontSize: 50,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StartStopButton(),
                      const SizedBox(width: 20),
                      CheckResetButton(),
                    ],
                  ),
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
                    child: Center(
                      child: const Text(
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: _checkList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text(
                            '${index + 1}. ${_checkList[index]}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget StartStopButton() {
    return ElevationBtn(
      onPressed: _toggleTimer,
      width: 150,
      height: 50,
      text: '',
      child: Image.asset(
        _isRunning ? 'assets/images/stopimg.png' : 'assets/images/startimg.png',
        height: 30,
        width: 30,
      ),
    );
  }

  Widget CheckResetButton() {
    final settingData = Provider.of<TimerSettingDataProvider>(context).settingData;
    final isInitial = _seconds == 0;
    final isRunning = _isRunning;

    if (isInitial) {
      return ElevationBtn(
        text: '재설정',
        width: 150,
        height: 50,
        onPressed: () {
      Navigator.pop(context);
      },
      );
    } else if (isRunning) {
      return ElevationBtn(
        onPressed: () {
          final speed = settingData?.speed.isNotEmpty == true ? settingData!.speed : '입력값 없음';
          final distance = settingData?.distance.isNotEmpty == true ? settingData!.distance : '입력값 없음';

          setState(() {
            _checkList.add(
                '${_formatTime(_seconds)}, 속도: $speed ${settingData!.speedUnit}, 거리: $distance ${settingData.distanceUnit}'
            );
            _scrollToBottom();
          });
        },
        width: 150,
        height: 50,
        text: '',
        child: Image.asset(
          'assets/images/checkimg.png',
          height: 30,
          width: 30,
        ),
      );
    } else {
      return ElevationBtn(
        text: '저장 및 초기화',
        width: 150,
        height: 50,
        onPressed: _resetTimer,
      );
    }
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

  Widget Text_Speed(String speed, String unit) {
    final isSpeedEmpty = speed.isEmpty;
    final hasUnit = unit != '선택' && unit.isNotEmpty;

    return Text(
      '속도: ${isSpeedEmpty ? '입력값 없음' : speed}${hasUnit ? ' $unit' : ''}',
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.primary,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget Text_Distance(String distance, String unit) {
    final isDistanceEmpty = distance.isEmpty;
    final hasUnit = unit != '선택' && unit.isNotEmpty;

    return Text(
      '거리: ${isDistanceEmpty ? '입력값 없음' : distance}${hasUnit ? ' $unit' : ''}',
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.primary,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
