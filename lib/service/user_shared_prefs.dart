import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  void setFirstLaunch(bool? isAppLaunch) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool('isLaunch', isAppLaunch ?? true);
    } catch (err) {
      log('Erorr while saving in shared prefs: $err');
    }
  }

  Future<bool?> isLaunch() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    // bool isAlreadyLaunch = await _sharedPreferences.getBool('isLaunch');
    final result = _sharedPreferences.getBool('isLaunch');
    return result;
  }
}
