import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

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

  static String? validateNotZero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'input.input_validator'.tr();
    }

    final cleanedValue = toNumericString(value, allowPeriod: true);
    final numValue = num.tryParse(cleanedValue);

    if (numValue == null || numValue <= 0) {
      return 'Ingresa un valor mayor que 0';
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

  static String? validateMaxIntValueAndMinValueHN(
    String? value,
    int length, {
    bool isRequired = true,
  }) {
    if (isRequired && value == null && value!.isEmpty) {
      return 'input.input_validator'.tr();
    }
    if (isRequired && value!.length < length ||
        isRequired && value!.length > length) {
      return 'Este campo debe tener como maximo $length caracteres';
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

  static String? hondurasDocumentValidator(
    String? value,
    String tipoDocumento,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }

    final input = value.trim();
    final tipo = tipoDocumento;

    final cedulaRegex = RegExp(r'^[0-9]{13}$');
    final rtnRegex = RegExp(r'^[0-9]{14}$');
    final pasaporteRegex = RegExp(r'^[A-Z][0-9]{7,8}$');
    final carnetRegex = RegExp(r'^[A-Za-z0-9\-]{6,15}$');

    switch (tipo) {
      case 'CEDULAIDENTIDAD':
        if (!cedulaRegex.hasMatch(input)) {
          return 'La cédula debe tener exactamente 13 dígitos numéricos';
        }
        break;

      case 'RTN':
        if (!rtnRegex.hasMatch(input)) {
          return 'El RTN debe tener exactamente 14 dígitos numéricos';
        }
        break;

      case 'PASAPORTE':
        if (!pasaporteRegex.hasMatch(input)) {
          return 'El pasaporte debe tener entre 6 y 9 caracteres alfanuméricos';
        }
        break;

      case 'CARNETRESIDENCIA':
        if (!carnetRegex.hasMatch(input)) {
          return 'El carnét de residencia debe tener entre 6 y 15 caracteres alfanuméricos';
        }
        break;

      default:
        return 'Tipo de documento no reconocido $tipo';
    }

    return null;
  }

  static String? validateRTN(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final rtn = value.trim();

    if (!RegExp(r'^[0-9]+$').hasMatch(rtn)) {
      return 'El RTN solo debe contener números';
    }

    if (rtn.length != 14) {
      return 'El RTN debe tener 14 dígitos';
    }

    // No todos los dígitos iguales
    if (RegExp(r'^(\d)\1+$').hasMatch(rtn)) {
      return 'RTN inválido';
    }

    // final departamento = int.parse(rtn.substring(0, 2));
    final year = int.parse(rtn.substring(4, 8));
    final correlativo = rtn.substring(8, 14);

    // if (departamento < 1 || departamento > 18) {
    //   return 'Código de departamento inválido';
    // }

    final currentYear = DateTime.now().year;
    if (year < 1900 || year > currentYear) {
      return 'Año inválido en el RTN';
    }

    if (correlativo == '000000') {
      return 'Correlativo inválido';
    }

    return null;
  }
}
