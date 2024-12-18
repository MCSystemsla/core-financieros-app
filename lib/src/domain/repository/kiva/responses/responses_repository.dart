import 'dart:io';

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
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/recurrente_mujer_emprende.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/endpoint/responses_endpoint.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

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
    required File imagen1,
    required File imagen2,
    required File imagen3,
    required File fotoFirma,
    required File fotoCedula,
    required int solicitudId,
    required String formularioKiva,
    required String database,
  });
  Future<(bool, String)> uploadUserFilesOffline({
    required String imagen1,
    required String imagen2,
    required String imagen3,
    required String fotoFirma,
    required String fotoCedula,
    required int solicitudId,
    required String formularioKiva,
    required String database,
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
      _logger.i(resp);
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
    required File imagen1,
    required File imagen2,
    required File imagen3,
    required File fotoFirma,
    required File fotoCedula,
    required int solicitudId,
    required String formularioKiva,
    required String database,
  }) async {
    // try {
    // final dio = Dio();

    const url = 'https://vps-4267502-x.dattaweb.com/kiva/subir-imagenes';
    // Crea la solicitud Multipart
    //   final formData = FormData.fromMap({
    //     'solicitudId': '3925',
    //     'formularioKiva': 'ScrKivaCreditoEstandarRecurrente',
    //     'database': 'MC_CH',
    //     'fotoCliente1': await MultipartFile.fromFile(
    //       imagen1.path,
    //       filename: 'fotoCliente1.jpg',
    //     ),
    //     'fotoCliente2': await MultipartFile.fromFile(
    //       imagen2.path,
    //       filename: 'fotoCliente2.jpg',
    //     ),
    //     'fotoCliente3': await MultipartFile.fromFile(
    //       fotoCedula.path,
    //       filename: 'fotoCliente3.jpg',
    //     ),
    //     'fotoFirmaDigital': await MultipartFile.fromFile(
    //       fotoFirma.path,
    //       filename: 'fotoFirmaDigital.jpg',
    //     ),
    //     'fotoCedula': await MultipartFile.fromFile(
    //       fotoCedula.path,
    //       filename: 'fotoCedula.jpg',
    //     ),
    //   });
    //   final resp = await dio.post(
    //     url,
    //     data: formData,
    //     options: Options(contentType: 'multipart/form-data', headers: {
    //       'Authorization':
    //           'Bearer ${LocalStorage().jwt}', // Reemplaza con el token real
    //     }),
    //   );
    //   _logger.i(formData);
    //   _logger.i(resp);
    //   return true;
    // } on DioException catch (e) {
    //   // Imprimir más detalles en caso de error
    //   _logger.e('Código de error: ${e.response?.statusCode}');
    //   _logger.e('Datos del error: ${e.response?.data}');
    //   _logger.e('Detalles adicionales: ${e.error}');
    //   return false;
    // } catch (e) {
    //   _logger.e(e);
    //   return false;
    final currentProduct = setCurrentProdut(product: formularioKiva);
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['solicitudId'] = solicitudId.toString();
      request.fields['formularioKiva'] = currentProduct;
      request.fields['database'] = LocalStorage().database;

      // Agregar imágenes
      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente1',
        imagen1.path,
        filename:
            imagen1.path, // Asegúrate de que el nombre del archivo sea correcto
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente2',
        imagen2.path,
        filename: imagen2.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente3',
        imagen3.path,
        filename: imagen3.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoFirmaDigital',
        fotoFirma.path,
        filename: fotoFirma.path,
        contentType: MediaType('image', 'png'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCedula',
        fotoCedula.path,
        filename: fotoCedula.path,
        contentType: MediaType('image', 'jpeg'),
      ));
      // Agregar encabezados (si es necesario)
      request.headers.addAll({
        'Accept': 'application/json', // Indica que se espera una respuesta JSON
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      });
      // Enviar la solicitud
      var response = await request.send();

      var responseBody = await http.Response.fromStream(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('Imagen enviada exitosamente: ${responseBody.body}');
      } else {
        _logger.e(
            'Error del servidor: ${response.statusCode}, ${responseBody.body}');
      }
      _logger.i(response.reasonPhrase);
      return (true, response.reasonPhrase ?? 'Imagenes Enviadas exitosamente!');
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
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
    required String fotoCedula,
    required int solicitudId,
    required String formularioKiva,
    required String database,
  }) async {
    final currentProduct = setCurrentProdut(product: formularioKiva);

    const url = 'https://vps-4267502-x.dattaweb.com/kiva/subir-imagenes';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['solicitudId'] = solicitudId.toString();
      request.fields['formularioKiva'] = currentProduct;
      request.fields['database'] = LocalStorage().database;

      // Agregar imágenes
      request.files.add(await http.MultipartFile.fromPath(
        'fotoCliente1',
        imagen1,
        filename:
            imagen1, // Asegúrate de que el nombre del archivo sea correcto
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
        'fotoFirmaDigital',
        fotoFirma,
        filename: fotoFirma,
        contentType: MediaType('image', 'png'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'fotoCedula',
        fotoCedula,
        filename: fotoCedula,
        contentType: MediaType('image', 'jpg'),
      ));
      // Agregar encabezados (si es necesario)
      request.headers.addAll({
        'Accept': 'application/json', // Indica que se espera una respuesta JSON
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      });
      // Enviar la solicitud
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('Imagen enviada exitosamente: ${responseBody.body}');
      } else {
        _logger.e(
            'Error del servidor: ${response.statusCode}, ${responseBody.body}');
      }
      // if (response.statusCode == 201) {
      //   print(
      //       '¡Éxito! Respuesta del servidor: ${await http.Response.fromStream(response)}');
      //   return true;
      // }
      _logger.i(response.reasonPhrase);
      return (true, response.reasonPhrase ?? 'Imagenes Enviadas exitosamente!');
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }
}
