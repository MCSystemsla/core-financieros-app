import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

/// Etapa de la solicitud a la que pertenece el archivo del expediente.
enum DigitalFileTipo {
  analisis('ANALISIS');

  final String codigo;

  const DigitalFileTipo(this.codigo);
}

/// Nombres de archivo del expediente digital. Todo PDF que se sube al
/// expediente debe tener su nombre aquí.
enum DigitalFilename {
  cedulaFiador('CEDULA_FIADOR'),
  rucClienteNegocio('RUC_CLIENTE_NEGOCIO');

  final String codigo;

  const DigitalFilename(this.codigo);

  /// Nombre con el que se sube al expediente (ej. `CEDULA_FIADOR.pdf`).
  String get pdfName => '$codigo.pdf';
}

/// Sube PDFs al expediente digital. Compartido por todos los países.
abstract class ExpedienteDigitalRepository {
  /// Sube el PDF en [pdfPath] como [filename] al expediente de
  /// [numeroSolicitud].
  Future<(bool, String)> uploadDigitalFile({
    required DigitalFileTipo tipo,
    required String cedula,
    required int numeroSolicitud,
    required DigitalFilename filename,
    required String pdfPath,
  });
}

class ExpedienteDigitalRepositoryImpl implements ExpedienteDigitalRepository {
  final _logger = Logger();

  @override
  Future<(bool, String)> uploadDigitalFile({
    required DigitalFileTipo tipo,
    required String cedula,
    required int numeroSolicitud,
    required DigitalFilename filename,
    required String pdfPath,
  }) async {
    final pdfName = filename.pdfName;
    const apiUrl = String.fromEnvironment('apiUrl');
    const protocol = String.fromEnvironment('protocol');
    const url = '$protocol://$apiUrl/cartera/digital-files/upload';

    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['tipo'] = tipo.codigo;
      request.fields['cedula'] = cedula;
      request.fields['filename'] = pdfName;
      request.fields['numeroSolicitud'] = numeroSolicitud.toString();
      request.fields['database'] = LocalStorage().database;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        pdfPath,
        filename: pdfName,
        contentType: MediaType('application', 'pdf'),
      ));
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${LocalStorage().jwt}',
        'CF-Access-Client-Id': const String.fromEnvironment('CFAccessClientId'),
        'CF-Access-Client-Secret':
            const String.fromEnvironment('CFAccessClientSecret'),
      });
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('$pdfName enviado al expediente: ${responseBody.body}');
        return (true, '$pdfName enviado al expediente');
      }

      final message = _messageFrom(responseBody.body) ??
          'Error ${response.statusCode} enviando $pdfName';
      await ErrorReporter.registerError(
        errorMessage: 'Error enviando $pdfName al expediente: $message',
        statusCode: response.statusCode.toString(),
        username: LocalStorage().currentUserName,
      );
      _logger.e(
          'Error del servidor: ${response.statusCode}, ${responseBody.body}');
      return (false, message);
    } catch (e) {
      await ErrorReporter.registerError(
        errorMessage: 'Error enviando $pdfName al expediente: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
      _logger.e(e);
      return (false, e.toString());
    }
  }

  String? _messageFrom(String body) {
    try {
      final decoded = json.decode(body);
      if (decoded is Map<String, dynamic> && decoded['message'] != null) {
        return decoded['message'].toString();
      }
    } catch (_) {}
    return null;
  }
}
