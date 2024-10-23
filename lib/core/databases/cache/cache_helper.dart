import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveString({required String key, required dynamic value}) async {
    return await sharedPreferences.setString(key, value);
  }

  Future<bool> saveList({required String key, required dynamic value}) async {
    return await sharedPreferences.setStringList(key, value);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  List<String>? getList(String key) {
    return sharedPreferences.getStringList(key);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
