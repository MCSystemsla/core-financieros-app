import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/endpoint/responses_endpoint.dart';
import 'package:logger/logger.dart';

abstract class ResponsesRepository {
  Future<void> mejoraViviendaAnswer({
    required MejoraViviendaAnswer mejoraVivienda,
  });
  Future<void> mejoraViviendaRecurrenteAnswer({
    required MejoraViviendaRecurrente mejoraViviendaRecurrente,
  });
  Future<void> energiaLimpia({
    required EnergiaLimpiaModel energiaLimpiaModel,
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

  @override
  Future<void> mejoraViviendaRecurrenteAnswer({
    required MejoraViviendaRecurrente mejoraViviendaRecurrente,
  }) async {
    try {
      final endpoint = RecurrenteMejoraViviendaEndpoint(
        mejoraViviendaAnswer: mejoraViviendaRecurrente,
      );
      final resp = await _api.request(endpoint: endpoint);
      _logger.i(resp);
    } catch (e) {
      throw AppException.toAppException(e);
    }
  }

  @override
  Future<void> energiaLimpia({
    required EnergiaLimpiaModel energiaLimpiaModel,
  }) async {
    final endpoint = EnergiaLimpiaEndpoint(
      energiaLimpiaModel: energiaLimpiaModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
      throw AppException.toAppException(e);
    }
  }
}
