import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class AndroidVersionHelper {
  static Future<int?> getAndroidVersion() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }
    return null;
  }
}
