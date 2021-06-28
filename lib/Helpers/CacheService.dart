import 'package:shared_preferences/shared_preferences.dart';

class CacheService{



  static setTheme(String themeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("theme", themeName);
  }

  static Future<String> getTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("theme");
  }

}