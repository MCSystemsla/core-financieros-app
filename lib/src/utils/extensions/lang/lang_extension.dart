import 'package:flutter_translate/flutter_translate.dart';

extension LangExtension on String {
  ///translate using the flutter translate package
  String tr({String? optional, Map<String, String>? args}) {
    final msg = translate(this, args: args);
    if (msg == this && optional != null) {
      return optional;
    }
    return msg;
  }
}
