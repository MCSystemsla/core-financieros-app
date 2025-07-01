import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_frecuencia_pago_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_dep.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_mun.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_pais_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/departments_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/cedula/cedula_client_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxService {
  late final Store _store;
  late final Box<CatalogoLocalDb> catalogoBox;
  late final Box<CatalogoNacionalidadPaisDb> catalogoNacionalidadPaisBox;
  late final Box<CatalogoNacionalidadDepDb> catalogoNacionalidadDepBox;
  late final Box<CatalogoNacionalidadMunDb> catalogoNacionalidadMunBox;
  late final Box<DepartmentsLocalDb> departmentsBox;
  late final Box<ResponseLocalDb> solicitudesResponsesBox;
  late final Box<ReprestamoResponsesLocalDb> solicitudesReprestamoResponsesBox;
  late final Box<AsalariadoResponsesLocalDb> solicitudesAsalariadoResponsesBox;
  late final Box<CedulaClientDb> cedulaClientBox;
  late final Box<CatalogoFrecuenciaPagoDb> catalogoFrecuenciaPagoBox;
  final _logger = Logger();

  ObjectBoxService._create(this._store) {
    catalogoBox = _store.box<CatalogoLocalDb>();
    catalogoNacionalidadPaisBox = _store.box<CatalogoNacionalidadPaisDb>();
    catalogoNacionalidadDepBox = _store.box<CatalogoNacionalidadDepDb>();
    catalogoNacionalidadMunBox = _store.box<CatalogoNacionalidadMunDb>();
    departmentsBox = _store.box<DepartmentsLocalDb>();
    solicitudesResponsesBox = _store.box<ResponseLocalDb>();
    solicitudesReprestamoResponsesBox =
        _store.box<ReprestamoResponsesLocalDb>();
    solicitudesAsalariadoResponsesBox =
        _store.box<AsalariadoResponsesLocalDb>();
    cedulaClientBox = _store.box<CedulaClientDb>();
    catalogoFrecuenciaPagoBox = _store.box<CatalogoFrecuenciaPagoDb>();
    // cedulaClientBox.removeAll();
    // solicitudesAsalariadoResponsesBox.removeAll();
    // solicitudesResponsesBox.removeAll();
    // catalogoParametroBox.removeAll();
  }

  static Future<ObjectBoxService> init() async {
    try {
      final store = await openStore();

      return ObjectBoxService._create(store);
    } on ObjectBoxException catch (e) {
      final isEntityIdError = e.message.contains("DB's last entity ID");

      if (isEntityIdError) {
        log('⚠️ Error de modelo detectado. Borrando base de datos...');

        final dir = await getApplicationDocumentsDirectory();
        final dbDir = Directory('${dir.path}/objectbox');

        if (await dbDir.exists()) {
          await dbDir.delete(recursive: true);
          log('⚠️ Base de datos borrada.');
        }
      }
      final store = await openStore();
      return ObjectBoxService._create(store);
    } catch (e) {
      await ErrorReporter.registerError(
        errorMessage: 'Error Inesperado BD Local: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
      throw Exception('Error Inesperado BD Local: $e');
    }
  }

  void close() {
    _store.close(); // Cierra la conexión con la base de datos.
  }

  void deleteRowsByDeterminateTime() {
    final now = DateTime.now().subtract(const Duration(hours: 3));
    solicitudesResponsesBox
        .query(ResponseLocalDb_.createdAt.lessThan(now.millisecondsSinceEpoch))
        .build()
        .remove();
  }

  List<dynamic> sendSolicitudesWhenIsDone() {
    try {
      final nuevas = solicitudesResponsesBox
          .query(ResponseLocalDb_.isDone
              .equals(true)
              .and(ResponseLocalDb_.hasVerified.equals(false)))
          .build()
          .find();

      final represtamos = sendSolicitudReprestamoWhenIsDone();
      final asalariados = sendSolicitudAsalariadoWhenIsDone();

      return [...nuevas, ...represtamos, ...asalariados];
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  List<ReprestamoResponsesLocalDb> sendSolicitudReprestamoWhenIsDone() {
    try {
      final solicitudes = solicitudesReprestamoResponsesBox
          .query(ReprestamoResponsesLocalDb_.isDone
              .equals(true)
              .and(ReprestamoResponsesLocalDb_.hasVerified.equals(false)))
          .build()
          .find();
      return solicitudes;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  List<AsalariadoResponsesLocalDb> sendSolicitudAsalariadoWhenIsDone() {
    try {
      final solicitudes = solicitudesAsalariadoResponsesBox
          .query(AsalariadoResponsesLocalDb_.isDone
              .equals(true)
              .and(AsalariadoResponsesLocalDb_.hasVerified.equals(false)))
          .build()
          .find();
      return solicitudes;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  // * Catalgos
  List<CatalogoLocalDb> findParentescosByNombre({required String type}) {
    final query = catalogoBox.query(CatalogoLocalDb_.type.equals(type)).build();

    final results = query.find();
    query.close();

    return results;
  }

  List<CatalogoFrecuenciaPagoDb> getCatalogoFrecuenciaPago() {
    final query = catalogoFrecuenciaPagoBox.query().build();

    final results = query.find();
    query.close();

    return results;
  }

  List<ItemNacionalidad> getNacionalidadesDep({required String valor}) {
    final query = catalogoNacionalidadDepBox
        .query(CatalogoNacionalidadDepDb_.relacion.equals(valor))
        .build();

    final results = query.find();
    query.close();
    return results
        .map((e) => ItemNacionalidad(
              id: e.id,
              valor: e.valor,
              nombre: e.nombre,
              relacion: e.relacion ?? 'No data',
            ))
        .toSet()
        .toList();
  }

  List<ItemNacionalidad> getNacionalidadPaises({
    required String codigo,
    String whereClause = '',
  }) {
    switch (codigo) {
      case 'PAIS':
        final query = catalogoNacionalidadPaisBox.query().build();

        final results = query.find();
        query.close();
        return results
            .map((e) => ItemNacionalidad(
                  id: e.id,
                  valor: e.valor,
                  nombre: e.nombre,
                  relacion: e.relacion ?? 'No data',
                ))
            .toList();

      case 'DEP':
        if (whereClause.isEmpty) {
          final query = catalogoNacionalidadDepBox.query().build();
          final results = query.find();
          query.close();
          return results
              .map((e) => ItemNacionalidad(
                    id: e.id,
                    valor: e.valor,
                    nombre: e.nombre,
                    relacion: e.relacion ?? 'No data',
                  ))
              .toList();
        } else {
          final query = catalogoNacionalidadDepBox
              .query(CatalogoNacionalidadDepDb_.relacion.equals(whereClause))
              .build();
          final results = query.find();
          query.close();
          return results
              .map((e) => ItemNacionalidad(
                    id: e.id,
                    valor: e.valor,
                    nombre: e.nombre,
                    relacion: e.relacion ?? 'No data',
                  ))
              .toList();
        }
      case 'MUN':
        if (whereClause.isEmpty) {
          final query = catalogoNacionalidadMunBox.query().build();

          final results = query.find();
          query.close();
          return results
              .map((e) => ItemNacionalidad(
                    id: e.id,
                    valor: e.valor,
                    nombre: e.nombre,
                    relacion: e.relacion ?? 'No data',
                  ))
              .toList();
        } else {
          final query = catalogoNacionalidadMunBox
              .query(CatalogoNacionalidadMunDb_.relacion.equals(whereClause))
              .build();
          final results = query.find();
          query.close();
          return results
              .map((e) => ItemNacionalidad(
                    id: e.id,
                    valor: e.valor,
                    nombre: e.nombre,
                    relacion: e.relacion ?? 'No data',
                  ))
              .toList();
        }
    }
    return [];
  }

  CedulaClientDb saveCedulaClient({required CedulaClientDb cedulaClient}) {
    try {
      cedulaClient.id = 0;
      cedulaClientBox.put(cedulaClient);
      _logger.i('Creando nueva cedula');
      return cedulaClient;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  CedulaClientDb? getCedula(
      {required String cedula, required String tipoSolicitud}) {
    try {
      final query = cedulaClientBox
          .query(CedulaClientDb_.cedula
              .equals(cedula)
              .and(CedulaClientDb_.typeSolicitud.equals(tipoSolicitud)))
          .build();

      final result = query.findFirst();
      query.close();

      if (result != null) {
        _logger.i('Cedula encontrada: ${result.cedula}');
      } else {
        _logger.i('Cedula no encontrada');
      }

      return result;
    } catch (e) {
      _logger.e('Error al obtener la cédula: $e');
      rethrow;
    }
  }

  ResponseLocalDb saveSolicitudesNuevaMenorResponses({
    required ResponseLocalDb responseLocalDb,
  }) {
    try {
      responseLocalDb.id = 0;
      solicitudesResponsesBox.put(responseLocalDb);
      _logger.i('Creado');
      return responseLocalDb;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  ReprestamoResponsesLocalDb saveSolicitudesReprestamoResponses({
    required ReprestamoResponsesLocalDb responseReprestamoLocalDb,
  }) {
    try {
      responseReprestamoLocalDb.id = 0;
      solicitudesReprestamoResponsesBox.put(responseReprestamoLocalDb);
      _logger.i('Creado');
      return responseReprestamoLocalDb;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  AsalariadoResponsesLocalDb saveSolicitudesAsalariadoResponses({
    required AsalariadoResponsesLocalDb responseAsalariadoLocalDb,
  }) {
    try {
      responseAsalariadoLocalDb.id = 0;
      solicitudesAsalariadoResponsesBox.put(responseAsalariadoLocalDb);
      _logger.i('Creado');
      return responseAsalariadoLocalDb;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  void updateSolicitudNuevaMenorById({
    required int id,
    required ResponseLocalDb responseLocalDb,
  }) {
    try {
      responseLocalDb.id = id;
      final solicitud = solicitudesResponsesBox.get(responseLocalDb.id);
      if (solicitud != null) {
        solicitudesResponsesBox.put(responseLocalDb, mode: PutMode.update);
      }
      _logger.i('Actualizando');
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  void updateSolicitudReprestamoById({
    required int id,
    required ReprestamoResponsesLocalDb responseReprestamoLocalDb,
  }) {
    try {
      responseReprestamoLocalDb.id = id;
      final solicitud =
          solicitudesReprestamoResponsesBox.get(responseReprestamoLocalDb.id);
      if (solicitud != null) {
        solicitudesReprestamoResponsesBox.put(responseReprestamoLocalDb,
            mode: PutMode.update);
      }
      _logger.i('Actualizando');
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  void updateSolicitudAsalariadoById({
    required int id,
    required AsalariadoResponsesLocalDb asalariadoResponsesLocalDb,
  }) {
    try {
      asalariadoResponsesLocalDb.id = id;
      final solicitud =
          solicitudesAsalariadoResponsesBox.get(asalariadoResponsesLocalDb.id);
      if (solicitud != null) {
        solicitudesAsalariadoResponsesBox.put(asalariadoResponsesLocalDb,
            mode: PutMode.update);
      }
      _logger.i('Actualizando');
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  List<ResponseLocalDb> getSolicitudesResponse() {
    try {
      final resp = solicitudesResponsesBox.getAll();
      return resp;
    } catch (e) {
      _logger.e(e.toString());
      throw AppException.toAppException(e);
    }
  }

  List<ReprestamoResponsesLocalDb> getSolicitudesReprestamoResponse() {
    try {
      final resp = solicitudesReprestamoResponsesBox.getAll();
      return resp;
    } catch (e) {
      _logger.e(e.toString());
      throw AppException.toAppException(e);
    }
  }

  List<AsalariadoResponsesLocalDb> getSolicitudesAsalariadoResponse() {
    try {
      final resp = solicitudesAsalariadoResponsesBox.getAll();
      return resp;
    } catch (e) {
      _logger.e(e.toString());
      throw AppException.toAppException(e);
    }
  }

  void removeSolicitudWhenisUploaded({required int solicitudId}) {
    try {
      solicitudesResponsesBox.remove(solicitudId);
      // solicitudesReprestamoResponsesBox.remove(solicitudId);
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  void removeSolicitudReprestamoWhenisUploaded({required int solicitudId}) {
    try {
      solicitudesReprestamoResponsesBox.remove(solicitudId);
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  void removeSolicitudAsalariadoWhenisUploaded({required int solicitudId}) {
    try {
      solicitudesAsalariadoResponsesBox.remove(solicitudId);
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  void updateWhenSolicitdIsFailed(
      {required int solicitudId, String? errorMsg}) {
    try {
      final solicitud = solicitudesResponsesBox.get(solicitudId);
      final solicitudReprestamo =
          solicitudesReprestamoResponsesBox.get(solicitudId);
      final solicitudAsalariado =
          solicitudesAsalariadoResponsesBox.get(solicitudId);
      if (solicitud != null) {
        solicitud.hasVerified = true;
        solicitud.errorMsg = errorMsg;
        solicitudesResponsesBox.put(solicitud, mode: PutMode.update);
        solicitudesReprestamoResponsesBox.put(solicitudReprestamo!,
            mode: PutMode.update);
      }
      if (solicitudReprestamo != null) {
        solicitudReprestamo.hasVerified = true;
        solicitudReprestamo.errorMsg = errorMsg;
        solicitudesReprestamoResponsesBox.put(solicitudReprestamo,
            mode: PutMode.update);
      }
      if (solicitudAsalariado != null) {
        solicitudAsalariado.hasVerified = true;
        solicitudAsalariado.errorMsg = errorMsg;
        solicitudesAsalariadoResponsesBox.put(
          solicitudAsalariado,
          mode: PutMode.update,
        );
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  CatalogoLocalDb? getParametroByName({required String nombre}) {
    try {
      final result = catalogoBox
          .query(CatalogoLocalDb_.type.equals(nombre, caseSensitive: false))
          .build()
          .findFirst();

      return result;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }
}
