import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/recurrente_agua_y_saneamiento.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
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
  Future<void> recurrenteREnergiaLimpiaAnswer({
    required RecurrenteEnergiaLimpiaModel energiaLimpiaModel,
  });
  Future<void> aguaYSaneamientoAnswer({
    required AguaSaneamientoModel aguaSaneamientoModel,
  });
  Future<void> recurrenteAguaYSaneamientoAnswer({
    required RecurrenteAguaSaneamientoModel recurrenteAguaSaneamientoModel,
  });
  Future<void> mujerEmprendeAnswer({
    required MujerEmprendeModel mujerEmprendeModel,
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

  @override
  Future<void> recurrenteREnergiaLimpiaAnswer({
    required RecurrenteEnergiaLimpiaModel energiaLimpiaModel,
  }) async {
    final endpoint = RecurrenteEnergiaLimpiaEndpoint(
      recurrenteEnergiaLimpiaModel: energiaLimpiaModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
      throw AppException.toAppException(e);
    }
  }

  @override
  Future<void> aguaYSaneamientoAnswer({
    required AguaSaneamientoModel aguaSaneamientoModel,
  }) async {
    final endpoint = AguaSaneamientoEndpoint(
      aguaSaneamientoModel: aguaSaneamientoModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
      throw AppException.toAppException(e);
    }
  }

  @override
  Future<void> recurrenteAguaYSaneamientoAnswer({
    required RecurrenteAguaSaneamientoModel recurrenteAguaSaneamientoModel,
  }) async {
    final endpoint = RecurrenteAguaSaneamientoEndpoint(
      recurrenteAguaSaneamientoModel: recurrenteAguaSaneamientoModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      _logger.i(resp);
    } catch (e) {
      throw AppException.toAppException(e);
    }
  }

  @override
  Future<void> mujerEmprendeAnswer({
    required MujerEmprendeModel mujerEmprendeModel,
  }) async {
    final endpoint = MujerEmprendeEndpoint(
      mujerEmprendeModel: mujerEmprendeModel,
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
