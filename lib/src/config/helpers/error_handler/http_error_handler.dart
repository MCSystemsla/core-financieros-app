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
      'Sin conexión a internet, Revisa tu conexion a internet, $errorMsg',
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
  if (msg.contains('unauthorized')) {
    return (
      'Su sesión ha expirado. Por favor, vuelva a iniciar sesión, ${resp['message']}',
      ErrorNetworkCode.unauthorized
    );
  }
  if (msg.contains('<!DOCTYPE html>')) {
    return (
      'El servidor se encuentra fuera de servicio, por favor intente nuevamente. ${resp['message']}',
      ErrorNetworkCode.serverError,
    );
  }
  if (msg.contains('handshakeexception') || msg.contains('handshake')) {
    return (
      'La red actual ha bloqueado la conexión, Cambia a una conexión más estable para continuar',
      ErrorNetworkCode.unknownError,
    );
  }
  return (
    '${resp['message'] ?? resp.toString()}',
    ErrorNetworkCode.unknownError
  );
}
