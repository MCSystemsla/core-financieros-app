import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  String get currentLanguage {
    return prefs.getString('lang') ?? 'es';
  }

  String get jwt {
    return prefs.getString('jwt') ?? '';
  }

  String get fcmToken {
    return prefs.getString('token') ?? '';
  }

  Future<void> setLanguage(String value) async {
    await prefs.setString('lang', value);
  }

  Future<void> setFcmToken(String value) async {
    await prefs.setString('token', value);
  }

  Future<void> setJWT(String value) async {
    await prefs.setString('jwt', value);
  }
}
