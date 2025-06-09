import 'package:flutter/material.dart';
import '../const/Models/Timer_setting_data.dart';

class TimerSettingDataProvider with ChangeNotifier {
  TimerSettingData? _settingData;

  TimerSettingData? get settingData => _settingData;

  void setTimerSetting({
    required String title,
    required String speed,
    required String speedUnit,
    required String distance,
    required String distanceUnit,
  }) {
    _settingData = TimerSettingData(
      title: title,
      speed: speed,
      speedUnit: speedUnit,
      distance: distance,
      distanceUnit: distanceUnit,
    );
    notifyListeners();
  }

  void clearSetting() {
    _settingData = null;
    notifyListeners();
  }
}
