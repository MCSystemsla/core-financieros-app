class AppException implements Exception {
  AppException({this.optionalMsg = 'Error en proceso de App'});

  String? get routeMsg => null;
  final String optionalMsg;

  @override
  String toString() {
    return routeMsg.toString();
    // return routeMsg?.tr(optional: optionalMsg) ?? optionalMsg;
  }

  static AppException toAppException(dynamic error) {
    if (error is AppException) {
      return error;
    }
    return AppException(optionalMsg: 'Error controlado: ${error.toString()}');
  }
}
