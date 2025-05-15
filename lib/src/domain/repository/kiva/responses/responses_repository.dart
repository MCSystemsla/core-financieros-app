import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/recurrente_agua_y_saneamiento.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/recurrente_micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/migrantes_ecomicos.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/recurrente_migrante_economico.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/recurrente_mujer_emprende.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/endpoint/responses_endpoint.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

enum TypeSigner { asesor, cliente, ambos, ninguno }

abstract class ResponsesRepository {
  Future<(bool, String)> mejoraViviendaAnswer({
    required MejoraViviendaAnswer mejoraVivienda,
  });
  Future<(bool, String)> mejoraViviendaRecurrenteAnswer({
    required MejoraViviendaRecurrente mejoraViviendaRecurrente,
  });
  Future<(bool, String)> energiaLimpia({
    required EnergiaLimpiaModel energiaLimpiaModel,
  });
  Future<(bool, String)> recurrenteREnergiaLimpiaAnswer({
    required RecurrenteEnergiaLimpiaModel energiaLimpiaModel,
  });
  Future<(bool, String)> aguaYSaneamientoAnswer({
    required AguaSaneamientoModel aguaSaneamientoModel,
  });
  Future<(bool, String)> recurrenteAguaYSaneamientoAnswer({
    required RecurrenteAguaSaneamientoModel recurrenteAguaSaneamientoModel,
  });
  Future<(bool, String)> mujerEmprendeAnswer({
    required MujerEmprendeModel mujerEmprendeModel,
  });
  Future<(bool, String)> recurrenteMujerEmprendeAnswer({
    required RecurrenteMujerEmprendeModel recurrenteMujerEmprendeModel,
  });
  Future<(bool, String)> miCrediEstudioAnswer({
    required MiCrediEstudioModel miCrediEstudioModel,
  });
  Future<(bool, String)> recurrenteMiCrediEstudioAnswer({
    required RecurrenteMiCrediEstudioModel recurrenteMiCrediEstudioModel,
  });
  Future<String> motivoPrestamo({
    required int numero,
  });
  Future<(bool, String)> estandar({
    required EstandarModel estandarModel,
  });
  Future<(bool, String)> recurrenteEstandar({
    required RecurrenteEstandarModel recurrenteEstandarModel,
  });
  Future<(bool, String)> uploadUserFiles({
    required String imagen1,
    required String imagen2,
    required String imagen3,
    required String fotoFirma,
    required int solicitudId,
    required String formularioKiva,
    required String database,
    required String tipoSolicitud,
    required String numero,
    required String cedula,
    required TypeSigner typeSigner,
  });
  Future<(bool, String)> uploadUserFilesOffline({
    required String imagen1,
    required String imagen2,
    required String imagen3,
    required String fotoFirma,
    required int solicitudId,
    required String formularioKiva,
    required String database,
    required String tipoSolicitud,
    required String numero,
    required String cedula,
    required TypeSigner typeSigner,
  });
  Future<(bool, String)> migrantesEconomicos({
    required MigrantesEconomicos migrantesEconmicos,
  });
  Future<(bool, String)> migrantesEconomicosRecurrente({
    required MigrantesEconomicosRecurrente migrantesEconmicos,
  });
}

class ResponsesRepositoryImpl extends ResponsesRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();

  @override
  Future<(bool, String)> mejoraViviendaAnswer({
    required MejoraViviendaAnswer mejoraVivienda,
  }) async {
    final endpoint = MejoraViviendaKivaResponsesEndpoind(
      mejoraViviendaAnswer: mejoraVivienda,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> mejoraViviendaRecurrenteAnswer({
    required MejoraViviendaRecurrente mejoraViviendaRecurrente,
  }) async {
    try {
      final endpoint = RecurrenteMejoraViviendaEndpoint(
        mejoraViviendaAnswer: mejoraViviendaRecurrente,
      );
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> energiaLimpia({
    required EnergiaLimpiaModel energiaLimpiaModel,
  }) async {
    final endpoint = EnergiaLimpiaEndpoint(
      energiaLimpiaModel: energiaLimpiaModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> recurrenteREnergiaLimpiaAnswer({
    required RecurrenteEnergiaLimpiaModel energiaLimpiaModel,
  }) async {
    final endpoint = RecurrenteEnergiaLimpiaEndpoint(
      recurrenteEnergiaLimpiaModel: energiaLimpiaModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> aguaYSaneamientoAnswer({
    required AguaSaneamientoModel aguaSaneamientoModel,
  }) async {
    final endpoint = AguaSaneamientoEndpoint(
      aguaSaneamientoModel: aguaSaneamientoModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> recurrenteAguaYSaneamientoAnswer({
    required RecurrenteAguaSaneamientoModel recurrenteAguaSaneamientoModel,
  }) async {
    final endpoint = RecurrenteAguaSaneamientoEndpoint(
      recurrenteAguaSaneamientoModel: recurrenteAguaSaneamientoModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> mujerEmprendeAnswer({
    required MujerEmprendeModel mujerEmprendeModel,
  }) async {
    final endpoint = MujerEmprendeEndpoint(
      mujerEmprendeModel: mujerEmprendeModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> recurrenteMujerEmprendeAnswer({
    required RecurrenteMujerEmprendeModel recurrenteMujerEmprendeModel,
  }) async {
    final endpoint = RecurrenteMujerEmprendeEndpoint(
      recurrenteMujerEmprendeModel: recurrenteMujerEmprendeModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> miCrediEstudioAnswer({
    required MiCrediEstudioModel miCrediEstudioModel,
  }) async {
    final endpoint = MiCrediEstudioEndpoint(
      miCrediEstudioModel: miCrediEstudioModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> recurrenteMiCrediEstudioAnswer({
    required RecurrenteMiCrediEstudioModel recurrenteMiCrediEstudioModel,
  }) async {
    final endpoint = RecurrenteMiCrediEstudioEndpoint(
      recurrenteMiCrediEstudioModel: recurrenteMiCrediEstudioModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<String> motivoPrestamo({
    required int numero,
  }) async {
    try {
      final endpoint = KivaMotivoAnteriorEndpoint(numero: numero);
      final resp = await _api.request(endpoint: endpoint);
      if (resp['MotivoAnterior'] == null) {
        return 'Este Usuario no tiene un prestamo anterior.';
      }
      return resp['MotivoAnterior'];
    } catch (e) {
      _logger.e(e);
      return e.toString();
    }
  }

  @override
  Future<(bool, String)> uploadUserFiles({
    required String imagen1,
    required String imagen2,
    required String imagen3,
    required String fotoFirma,
    required int solicitudId,
    required String formularioKiva,
    required String database,
    required String tipoSolicitud,
    required String numero,
    required String cedula,
    required TypeSigner typeSigner,
  }) async {
    const apiUrl = String.fromEnvironment('apiUrl');
    const protocol = String.fromEnvironment('protocol');

    const url = '$protocol://$apiUrl/kiva/subir-imagenes';

    final currentProduct = setCurrentProdut(product: formularioKiva);
    final typeSignerString = setFirmaByTypeSigner(typeSigner: typeSigner);
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['solicitudId'] = solicitudId.toString();
      request.fields['formularioKiva'] = currentProduct;
      request.fields['database'] = LocalStorage().database;
      request.fields['tipoSolicitud'] = tipoSolicitud;
      request.fields['numeroSolicitud'] = numero;
      request.fields['cedula'] = cedula;

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente1',
        imagen1,
        filename: imagen1,
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente2',
        imagen2,
        filename: imagen2,
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente3',
        imagen3,
        filename: imagen3,
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        typeSignerString,
        fotoFirma,
        filename: fotoFirma,
        contentType: MediaType('image', 'png'),
      ));

      request.headers.addAll(
        {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage().jwt}',
          'CF-Access-Client-Id':
              const String.fromEnvironment('CFAccessClientId'),
          'CF-Access-Client-Secret':
              const String.fromEnvironment('CFAccessClientSecret'),
        },
      );
      var response = await request.send();

      var responseBody = await http.Response.fromStream(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('Imagen enviada exitosamente: ${responseBody.body}');
      } else {
        _logger.e(
            'Error del servidor: ${response.statusCode}, ${responseBody.body}, ${responseBody.reasonPhrase}, ${responseBody.request}');
      }
      _logger.i(response.reasonPhrase);
      return (true, response.reasonPhrase ?? 'Imagenes Enviadas exitosamente!');
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  String setFirmaByTypeSigner({
    required TypeSigner typeSigner,
  }) {
    return switch (typeSigner) {
      TypeSigner.asesor => 'fotoFirmaDigitalAsesor',
      TypeSigner.cliente => 'fotoFirmaDigital',
      _ => 'N/A',
    };
  }

  String setCurrentProdut({required String product}) {
    return switch (product) {
      'VIVIENDA NUEVA' => 'ScrKivaMejoraVivienda',
      'VIVIENDA REPRESTAMO' => 'ScrKivaMejoraViviendaRecurrente',
      'ESTANDAR NUEVO' => 'ScrKivaCreditoEstandar',
      'ESTANDAR RECURRENTE' => 'ScrKivaCreditoEstandarRecurrente',
      'MICREDIESTUDIO NUEVO' => 'ScrKivaMiCrediEstudio',
      'MICREDIESTUDIO RECURRENTE' => 'ScrKivaMiCrediEstudioRecurrente',
      'MUJER EMPRENDE NUEVO' => 'ScrKivaMujerEmprende',
      'MUJER EMPRENDE RECURRENTE' => 'ScrKivaMujerEmprendeRecurrente',
      'AGUA Y SANEAMIENTO NUEVO' => 'ScrKivaAguaSaneamiento',
      'AGUA Y SANEAMIENTO RECURRENTE' => 'ScrKivaAguaSaneamientoRecurrente',
      'ASER NUEVO' => 'ScrKivaEnergiaLimpia',
      'ASER RECURRENTE' => 'ScrKivaEnergiaLimpiaRecurrente',
      'ESTANDAR COLONES NUEVO MAYOR A MIL' => 'ScrKivaMigrantesEconomicos',
      'ESTANDAR COLONES NUEVO MENOR A MIL' => 'ScrKivaMigrantesEconomicos',
      'ESTANDAR COLONES RECURRENTE MAYOR A MIL' =>
        'ScrKivaMigrantesEconomicosRecurrentes',
      'ESTANDAR COLONES RECURRENTE MENOR A MIL' =>
        'ScrKivaMigrantesEconomicosRecurrentes',
      _ => 'NO PRODUCT',
    };
  }

  @override
  Future<(bool, String)> estandar(
      {required EstandarModel estandarModel}) async {
    final endpoint = EstandarEndpoint(estandarModel: estandarModel);

    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      _logger.i(resp);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> recurrenteEstandar({
    required RecurrenteEstandarModel recurrenteEstandarModel,
  }) async {
    final endpoint = RecurrenteEstandarEndpoint(
      recurrenteEstandarModel: recurrenteEstandarModel,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (
        true,
        resp.toString(),
      );
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> uploadUserFilesOffline({
    required String imagen1,
    required String imagen2,
    required String imagen3,
    required String fotoFirma,
    required int solicitudId,
    required String formularioKiva,
    required String database,
    required String tipoSolicitud,
    required String numero,
    required String cedula,
    required TypeSigner typeSigner,
  }) async {
    final currentProduct = setCurrentProdut(product: formularioKiva);
    final typeSignerString = setFirmaByTypeSigner(typeSigner: typeSigner);
    const apiUrl = String.fromEnvironment('apiUrl');
    const protocol = String.fromEnvironment('protocol');

    const url = '$protocol://$apiUrl/kiva/subir-imagenes';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['solicitudId'] = solicitudId.toString();
      request.fields['formularioKiva'] = currentProduct;
      request.fields['database'] = LocalStorage().database;
      request.fields['tipoSolicitud'] = tipoSolicitud;
      request.fields['numeroSolicitud'] = numero;
      request.fields['cedula'] = cedula;

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente1',
        imagen1,
        filename: imagen1,
        contentType: MediaType('image', 'jpg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente2',
        imagen2,
        filename: imagen2,
        contentType: MediaType('image', 'jpg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente3',
        imagen3,
        filename: imagen3,
        contentType: MediaType('image', 'jpg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        typeSignerString,
        fotoFirma,
        filename: fotoFirma,
        contentType: MediaType('image', 'png'),
      ));

      // request.files.add(await http.MultipartFile.fromPath(
      //   'fotoCedula',
      //   fotoCedula,
      //   filename: fotoCedula,
      //   contentType: MediaType('image', 'jpg'),
      // ));
      // request.files.add(await http.MultipartFile.fromPath(
      //   'fotoFirmaDigitalAsesor',
      //   imagenAsesor,
      //   filename: imagenAsesor,
      //   contentType: MediaType('image', 'png'),
      // ));
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
        _logger.i('Imagen enviada exitosamente: ${responseBody.body}');
      } else {
        _logger.e(
            'Error del servidor: ${response.statusCode}, ${responseBody.body}, ${responseBody.reasonPhrase}, ${responseBody.request}');
      }

      _logger.i(response.reasonPhrase);
      return (true, response.reasonPhrase ?? 'Imagenes Enviadas exitosamente!');
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> migrantesEconomicos({
    required MigrantesEconomicos migrantesEconmicos,
  }) async {
    final endpoint = MigrantesEconomicosEndpoint(
      migrantesEconomicos: migrantesEconmicos,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> migrantesEconomicosRecurrente({
    required MigrantesEconomicosRecurrente migrantesEconmicos,
  }) async {
    final endpoint = MigrantesEconomicosEndpointRecurrente(
      migrantesEconomicosRecurrente: migrantesEconmicos,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }
}
