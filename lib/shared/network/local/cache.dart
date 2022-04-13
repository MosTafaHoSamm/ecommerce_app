import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
   static late  SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveBool(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }
   static Future<bool> saveString(
       {required String key, required String value}) async {
     return await sharedPreferences.setString(key, value);
   }

  static dynamic getSavedData({required String key})  {
    return   sharedPreferences.get(key);
  }
  static Future <bool> removeData({required String key}){
    return sharedPreferences.remove(key);
  }
}
