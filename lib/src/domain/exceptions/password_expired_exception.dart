import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';

/// El backend rechazó el login porque la contraseña del usuario ya expiró.
class PasswordExpiredException extends AppException {
  PasswordExpiredException({super.optionalMsg});
}
