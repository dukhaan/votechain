
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:votechain/data/models/user/user_model.dart';


class SharedPreferencesService {
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs ?? await SharedPreferences.getInstance();
  }

  static String? getPrivateKey() {
    return prefs?.getString('privateKey');
  }

  static Future<void> setPrivateKey({required String value}) async {
    await prefs?.setString('privateKey', value);
  }

  static String? getAddress() {
    return prefs?.getString('address');
  }

  static Future<void> setAddress({required String value}) async {
    await prefs?.setString('address', value);
  }

  static UserModel? getUser() {
    final data = prefs?.getString('user');
    return data == null ? null : UserModel.fromJson(jsonDecode(data));
  }

  static Future<void> setUser({required UserModel value}) async {
    await prefs?.setString('user', jsonEncode(value.toJson()));
  }


  static Future<void> clearAllPrefs() async {
    await prefs?.clear();
  }
}
