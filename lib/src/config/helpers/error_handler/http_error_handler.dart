String getErrorMessage(dynamic resp) {
  final msg = resp['message']?.toString().toLowerCase() ??
      resp.toString().toLowerCase();

  if (msg.contains('clientexception') ||
      msg.contains('socketexception') ||
      msg.contains('failed host lookup') ||
      msg.contains('no address associated with hostname')) {
    return 'Sin conexión a internet, la solicitud se guardó localmente.';
  }

  if (msg.contains('timeout')) {
    return 'La solicitud tardó demasiado en enviarse, Por favor intente de nuevo.';
  }

  return 'Error inesperado: ${resp.toString()}';
}
