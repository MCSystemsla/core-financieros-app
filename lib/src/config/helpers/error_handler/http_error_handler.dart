enum ErrorNetworkCode {
  noConnection,
  serverError,
  timeOutError,
  unknownError,
  unauthorized,
  noError,
}

(String, ErrorNetworkCode) getErrorMessage(
  dynamic resp, {
  String errorMsg = 'La solicitud se guardó localmente.',
}) {
  final msg = resp['message']?.toString().toLowerCase() ??
      resp.toString().toLowerCase();

  if (msg.contains('clientexception') ||
      msg.contains('socketexception') ||
      msg.contains('failed host lookup') ||
      msg.contains('no address associated with hostname')) {
    return (
      'Sin conexión a internet, $errorMsg',
      ErrorNetworkCode.noConnection
    );
  }

  if (msg.contains('timeout')) {
    return (
      'La solicitud tardó demasiado en enviarse, Por favor intente de nuevo.',
      ErrorNetworkCode.timeOutError,
    );
  }
  if (resp['statusCode'] == 401) {
    return (
      'Acceso Denegado, ${resp['message']}',
      ErrorNetworkCode.unauthorized,
    );
  }

  if (msg.contains('validation failed')) {
    final errorMsg = resp['message']['errors'][0]['message'];
    final pathField = resp['message']['errors'][0]['path'].toString();
    return (
      'Advertencia antes de continuar verifica: $errorMsg $pathField',
      ErrorNetworkCode.unauthorized
    );
  }

  return (
    resp['message']?.toString() ?? resp.toString(),
    ErrorNetworkCode.unknownError
  );
}
