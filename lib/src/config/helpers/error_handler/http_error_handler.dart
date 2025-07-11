enum ErrorNetworkCode {
  noConnection,
  serverError,
  timeOutError,
  unknownError,
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

  return (resp['message'] ?? resp.toString(), ErrorNetworkCode.unknownError);
}
