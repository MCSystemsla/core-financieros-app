import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';

class ClassValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es obligatorio';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Ingresa un correo válido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty || value == 'input.select_option'.tr()) {
      return 'input.input_validator'.tr();
    }
    return null;
  }

  static String? validateMinLength(
    String? value,
    int length, {
    bool isRequired = true,
  }) {
    if (isRequired && value == null && value!.isEmpty) {
      return 'input.input_validator'.tr();
    }
    if (isRequired && value!.length < length) {
      return 'Este campo debe tener al menos $length caracteres';
    }
    return null;
  }

  static String? validateMaxIntValue(String? value, int length) {
    final numero = int.tryParse(value ?? '');
    if (numero == null || numero < 0 || numero > length) {
      return 'El valor no puede ser mayor a $length o menor a 0'.tr();
    }
    return null;
  }
}
