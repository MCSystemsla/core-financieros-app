import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/endpoint/responses_endpoint.dart';
import 'package:logger/logger.dart';

abstract class ResponsesRepository {
  Future<void> mejoraViviendaAnswer({
    required MejoraViviendaAnswer mejoraVivienda,
  });
}

class ResponsesRepositoryImpl extends ResponsesRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();

  @override
  Future<void> mejoraViviendaAnswer({
    required MejoraViviendaAnswer mejoraVivienda,
  }) async {
    final endpoint = MejoraViviendaKivaResponsesEndpoind(
      mejoraViviendaAnswer: mejoraVivienda,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      _logger.i(resp);
    } catch (e) {
      throw AppException.toAppException(e.toString());
    }
  }
}
