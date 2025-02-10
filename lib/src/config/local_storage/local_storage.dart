import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  String get currentLanguage {
    return prefs.getString('lang') ?? 'es';
  }

  List<String> get currentActions {
    return prefs.getStringList('actions') ?? [];
  }

  String get jwt {
    return prefs.getString('jwt') ?? '';
  }

  String get database {
    return prefs.getString('database') ?? '';
  }

  String get userId {
    return prefs.getString('userId') ?? '';
  }

  String get fcmToken {
    return prefs.getString('token') ?? '';
  }

  int get lastUpdate {
    return prefs.getInt('lastUpdate') ?? 0;
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

  Future<void> setDatabase(String value) async {
    await prefs.setString('database', value);
  }

  Future<void> setUserId(String value) async {
    await prefs.setString('userId', value);
  }

  Future<void> setActions(List<String> actions) async {
    await prefs.setStringList('actions', actions);
  }

  Future<void> setLastUpdate(int lastUpdate) async {
    await prefs.setInt('lastUpdate', lastUpdate);
  }
}
