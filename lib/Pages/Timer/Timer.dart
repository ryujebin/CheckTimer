import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                  Text_Distance(settingData.distance, settingData.distanceUnit),
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
                        final parts = _checkList[index].split(',');
                        final time = parts.length > 0 ? parts[0].trim() : '';
                        final speed = parts.length > 1 ? parts[1].trim() : '';
                        final distance =
                            parts.length > 2 ? parts[2].trim() : '';

                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text.rich(
                              TextSpan(
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${index + 1}. ',
                                    style: TextStyle(
                                        color: AppColors.secondary,
                                        fontSize: 20),
                                  ),
                                  TextSpan(
                                    text: time,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  const TextSpan(
                                    text: ', ',
                                    style:
                                        TextStyle(color: AppColors.secondary),
                                  ),
                                  TextSpan(
                                    text: '$speed',
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  const TextSpan(
                                    text: ', ',
                                    style:
                                        TextStyle(color: AppColors.secondary),
                                  ),
                                  TextSpan(
                                    text: '$distance',
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ],
                              ),
                            ));
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
    final settingData =
        Provider.of<TimerSettingDataProvider>(context).settingData;

    final isRunning = _isRunning;
    final hasTimePassed = _seconds > 0;

    if (!isRunning && !hasTimePassed) {
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
          String speed = settingData?.speed ?? '';
          String distance = settingData?.distance ?? '';
          String speedUnit =
              (settingData?.speedUnit == '선택' || settingData?.speedUnit == null)
                  ? 'KM/H'
                  : settingData!.speedUnit!;
          String distanceUnit = (settingData?.distanceUnit == '선택' ||
                  settingData?.distanceUnit == null)
              ? 'M'
              : settingData!.distanceUnit!;

          // 단위별 거리 값을 미터 단위로 변환하는 함수 (내부에 넣거나 외부에 따로 만들어도 됨)
          double distanceToMeters(String dist, String unit) {
            double val = double.tryParse(dist) ?? 0.0;
            if (unit.toLowerCase() == 'km') {
              return val * 1000;
            }
            return val; // m 단위면 그대로 리턴
          }

          // 단위별 속도 값을 km/h 단위로 변환하는 함수
          double speedToKmPerHour(String spd, String unit) {
            double val = double.tryParse(spd) ?? 0.0;
            if (unit.toLowerCase() == 'm/s') {
              return val * 3.6; // m/s -> km/h 변환
            }
            return val; // km/h면 그대로 리턴
          }

          double? speedDouble = double.tryParse(speed);
          double? distanceDouble = double.tryParse(distance);

          // 거리 단위를 미터 단위로 변환
          double distanceInMeters = distanceToMeters(distance, distanceUnit);
          // 속도를 km/h 단위로 변환
          double speedInKmh = speedToKmPerHour(speed, speedUnit);

          // 거리 계산 (속도는 있는데 거리 없음)
          if ((distance.isEmpty || distanceDouble == null) &&
              speedDouble != null &&
              _seconds > 0) {
            double dist = (speedInKmh * _seconds) / 3.6; // km/h -> m/s 계산식
            distance = (distanceUnit.toLowerCase() == 'km')
                ? (dist / 1000).toStringAsFixed(2)
                : dist.toStringAsFixed(1);
          }

          // 속도 계산 (거리 있는데 속도 없음)
          if ((speed.isEmpty || speedDouble == null) &&
              distanceDouble != null &&
              _seconds > 0) {
            double distMeters = distanceToMeters(distance, distanceUnit);
            double spd = (distMeters / _seconds) * 3.6; // m/s -> km/h 계산
            speed = (speedUnit.toLowerCase() == 'm/s')
                ? (spd / 3.6).toStringAsFixed(2)
                : spd.toStringAsFixed(1);
          }

          final speedValue = speed.isEmpty ? '입력값 없음' : '$speed $speedUnit';
          final distanceValue =
              distance.isEmpty ? '입력값 없음' : '$distance $distanceUnit';

          setState(() {
            _checkList
                .add('${_formatTime(_seconds)}, $speedValue, $distanceValue');
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
    } else if (!isRunning && hasTimePassed) {
      return ElevationBtn(
        text: '저장 및 초기화',
        width: 150,
        height: 50,
        onPressed: () async {
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            // 🔐 로그인된 상태
            try {
              // Firestore에 저장 (예시로 현재 시간 저장)
              await FirebaseFirestore.instance
                  .collection('timerData')
                  .doc(user.uid)
                  .set({
                'title': settingData!.title,
                'speed': settingData.speed,
                'speedUnit' : settingData.speedUnit,
                'distance' : settingData.distance,
                'distanceUnit' : settingData.distanceUnit,
                // 필요한 데이터 추가
                // 예: 'distance': totalDistance, 'speed': averageSpeed, ...
              });

              await FirebaseFirestore.instance
                  .collection('checkData')
                  .doc(user.uid)
                  .set({
                'checkList': _checkList, // List 또는 Map 형태 모두 가능
              });

              // 타이머 초기화
              _resetTimer();
            } catch (e) {
              // 에러 처리
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('오류'),
                  content: Text('데이터 저장 중 오류가 발생했습니다: $e'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
            }
          } else {
            // ❌ 로그인되지 않은 상태 → 알림창
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('알림'),
                content: const Text('저장 기능은 로그인 후 사용 가능합니다.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('확인'),
                  ),
                  TextButton(
                    onPressed: () {
                      _resetTimer(); // 타이머 초기화
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                    },
                    child: const Text('초기화'),
                  ),
                ],
              ),
            );
          }
        },
      );
    } else {
      return const SizedBox.shrink();
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
