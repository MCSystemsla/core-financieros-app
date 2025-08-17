import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';

class AppException implements Exception {
  AppException({
    this.optionalMsg = 'Error en proceso de App',
    this.status = ErrorNetworkCode.unknownError,
  });

  String? get routeMsg => null;
  final String optionalMsg;
  final ErrorNetworkCode status;

  @override
  String toString() {
    return routeMsg.toString();
    // return routeMsg?.tr(optional: optionalMsg) ?? optionalMsg;
  }

  static AppException toAppException(dynamic error) {
    if (error is AppException) {
      return error;
    }
    return AppException(
      optionalMsg: 'Error controlado: ${error.toString()}',
      status: ErrorNetworkCode.unknownError,
    );
  }
}
