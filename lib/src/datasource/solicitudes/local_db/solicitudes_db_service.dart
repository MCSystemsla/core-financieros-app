import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_dep.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_mun.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_pais_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/departments_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:logger/logger.dart';

class ObjectBoxService {
  late final Store _store;
  late final Box<CatalogoLocalDb> catalogoBox;
  late final Box<CatalogoNacionalidadPaisDb> catalogoNacionalidadPaisBox;
  late final Box<CatalogoNacionalidadDepDb> catalogoNacionalidadDepBox;
  late final Box<CatalogoNacionalidadMunDb> catalogoNacionalidadMunBox;
  late final Box<DepartmentsLocalDb> departmentsBox;
  late final Box<ResponseLocalDb> solicitudesResponsesBox;
  late final Box<ReprestamoResponsesLocalDb> solicitudesReprestamoResponsesBox;
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
    // solicitudesResponsesBox.removeAll();
  }

  static Future<ObjectBoxService> init() async {
    final store = await openStore(); // .
    return ObjectBoxService._create(store);
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

  List<ResponseLocalDb> sendSolicitudWhenIsDone() {
    try {
      final solicitudes = solicitudesResponsesBox
          .query(ResponseLocalDb_.isDone
              .equals(true)
              .and(ResponseLocalDb_.hasVerified.equals(false)))
          .build()
          .find();
      return solicitudes;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  List<CatalogoLocalDb> findParentescosByNombre({required String type}) {
    final query = catalogoBox.query(CatalogoLocalDb_.type.equals(type)).build();

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

  void removeSolicitudWhenisUploaded({required int solicitudId}) {
    try {
      solicitudesResponsesBox.remove(solicitudId);
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  void updateWhenSolicitdIsFailed(
      {required int solicitudId, String? errorMsg}) {
    try {
      final solicitud = solicitudesResponsesBox.get(solicitudId);
      if (solicitud != null) {
        solicitud.hasVerified = true;
        solicitud.errorMsg = errorMsg;
        solicitudesResponsesBox.put(solicitud, mode: PutMode.update);
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }
}
