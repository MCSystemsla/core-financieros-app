import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';

class ClassValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return null;
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
    final trimmedValue = value?.trim();
    if (trimmedValue == null ||
        trimmedValue.isEmpty ||
        trimmedValue == 'input.select_option'.tr()) {
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

  static String? validateMaxIntValueAndMinValue(
    String? value,
    int length, {
    bool isRequired = true,
    bool isNicaraguaCedula = false,
  }) {
    if (isRequired && value == null && value!.isEmpty) {
      return 'input.input_validator'.tr();
    }
    if (isRequired && value!.length < length ||
        isRequired && value!.length > length) {
      return 'Este campo debe tener como maximo $length caracteres';
    }
    if (isNicaraguaCedula) {
      final endsWithLetter = RegExp(r'[A-Za-z]$');
      if (!endsWithLetter.hasMatch(value!)) {
        return 'La cédula nicaragüense debe terminar con una letra';
      }
    }
    return null;
  }

  static String? validateIntValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    final numValue = num.tryParse(value.trim());
    if (numValue == null || numValue <= 0) {
      return 'Ingresa un número mayor que 0';
    }

    return null;
  }

  static String? validateCantidadHijos(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final numValue = num.tryParse(value.trim());
    if (numValue == null || numValue <= 0) {
      return 'Ingresa un número mayor que 0';
    }

    return null;
  }
}
