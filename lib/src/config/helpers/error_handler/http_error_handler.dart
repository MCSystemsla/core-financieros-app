enum ErrorNetworkCode {
  noConnection,
  serverError,
  timeOutError,
  unknownError,
  unauthorized,
  noError,
}

const _defaultValidationMsg = 'Revisa los datos ingresados.';

(String, ErrorNetworkCode) getErrorMessage(
  dynamic resp, {
  String errorMsg = 'La solicitud se guardó localmente.',
}) {
  try {
    return _getErrorMessage(resp, errorMsg: errorMsg);
  } catch (_) {
    // Never let an unexpected response shape leak a Dart type error to the user.
    return (
      'Ocurrió un error inesperado, por favor intente nuevamente.',
      ErrorNetworkCode.unknownError
    );
  }
}

(String, ErrorNetworkCode) _getErrorMessage(
  dynamic resp, {
  required String errorMsg,
}) {
  final rawMessage = _field(resp, 'message');
  final readableMessage = _readable(rawMessage) ?? _readable(resp) ?? '';
  final msg = (rawMessage ?? resp).toString().toLowerCase();

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
  if (_statusCode(resp) == 401) {
    return (
      'Acceso Denegado, $readableMessage',
      ErrorNetworkCode.unauthorized,
    );
  }

  if (msg.contains('validation failed') || _validationErrors(resp) != null) {
    return (
      'Advertencia antes de continuar verifica: ${_getValidationErrors(resp)}',
      ErrorNetworkCode.unauthorized
    );
  }
  if (msg.contains('unauthorized')) {
    return (
      'Su sesión ha expirado. Por favor, vuelva a iniciar sesión, $readableMessage',
      ErrorNetworkCode.unauthorized
    );
  }
  if (msg.contains('<!doctype html>')) {
    // Do not dump the HTML page into the message.
    return (
      'El servidor se encuentra fuera de servicio, por favor intente nuevamente.',
      ErrorNetworkCode.serverError,
    );
  }
  if (msg.contains('failed to connect')) {
    return (
      'El servidor se encuentra fuera de servicio, por favor intente nuevamente. $readableMessage',
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
    readableMessage.isEmpty
        ? 'Ocurrió un error inesperado, por favor intente nuevamente.'
        : readableMessage,
    ErrorNetworkCode.unknownError
  );
}

/// Reads [key] only when [source] is a Map; Strings, Lists, exceptions
/// or null return null instead of throwing.
dynamic _field(dynamic source, String key) =>
    source is Map ? source[key] : null;

int? _statusCode(dynamic resp) {
  final code = _field(resp, 'statusCode');
  if (code is int) return code;
  return int.tryParse(code?.toString() ?? '');
}

/// Turns a message that may be a String, a List of Strings or a nested
/// `{message: ...}` Map into readable text.
String? _readable(dynamic value) {
  if (value == null) return null;
  if (value is String) return value.trim().isEmpty ? null : value;
  if (value is List) {
    final parts = value.map(_readable).whereType<String>().toList();
    return parts.isEmpty ? null : parts.join('\n');
  }
  if (value is Map) return _readable(value['message']);
  return value.toString();
}

/// Zod validation errors come in two shapes:
/// - `{message: {message: 'Validation failed', errors: [...]}}`
/// - `{message: 'Validation failed', errors: [...]}`
/// Each error is `{path: [field, ...], code, message}`.
List? _validationErrors(dynamic resp) {
  final nested = _field(_field(resp, 'message'), 'errors');
  if (nested is List && nested.isNotEmpty) return nested;
  final topLevel = _field(resp, 'errors');
  if (topLevel is List && topLevel.isNotEmpty) return topLevel;
  return null;
}

String _getValidationErrors(dynamic resp) {
  final errors = _validationErrors(resp);
  if (errors == null) return _defaultValidationMsg;

  final lines = errors
      .map((error) {
        if (error is String) return error;
        final message = _readable(_field(error, 'message'));
        if (message == null) return null;
        final path = _field(error, 'path');
        final field = path is List
            ? path.map((p) => p.toString()).join('.')
            : path?.toString() ?? '';
        return field.isEmpty ? message : '$message ($field)';
      })
      .whereType<String>()
      .toList();

  return lines.isEmpty ? _defaultValidationMsg : lines.join('\n');
}
