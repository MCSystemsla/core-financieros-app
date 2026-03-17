import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/actividades_economicas_alias_filtered_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_actividad_cnbs_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_aldea_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_barrio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_caserio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/local_db/solicitud_represtamo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_frecuencia_pago_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_dep.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_mun.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_pais_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/cedula/cedula_client_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/signature_client/signature_client_db.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:path_provider/path_provider.dart';

class SolicitudesHnBoxService {
  late final Store _store;
  late final Box<SolicitudAsalariadoHnDbLocal> solicitudesAsalariadoBox;
  late final Box<SolicitudNuevaMenorHnLocalDb> solicitudesNuevaMenorBox;
  late final Box<SolicitudReprestamoHnLocalDb> solicitudesReprestamoBox;
  late final Box<CatalogoLocalDb> catalogoLocalBox;
  late final Box<CedulaClientDb> cedulaClientBox;
  late final Box<CatalogoNacionalidadPaisDb> catalogoNacionalidadPaisBox;
  late final Box<CatalogoNacionalidadDepDb> catalogoNacionalidadDepBox;
  late final Box<CatalogoNacionalidadMunDb> catalogoNacionalidadMunBox;
  late final Box<CatalogoBarrioLocalDb> catalogoBarrioBox;
  late final Box<CatalogoAldeaLocalDb> catalogoAldeaBox;
  late final Box<CatalogoCaserioLocalDb> catalogoCaserioBox;
  late final Box<CatalogoFrecuenciaPagoDb> catalogoFrecuenciaPagoBox;
  late final Box<CatalogoActividadCnbsLocalDb> catalogoActividadCnbsBox;
  late final Box<HistorialCrediticioLocalDb> historialCrediticioBox;
  late final Box<ActividadesEconomicasAliasFilteredLocalDb>
      actividadesEconomicasAliasFilteredBox;
  late final Box<SignatureClientDb> signatureClientBox;

  SolicitudesHnBoxService._create(this._store) {
    solicitudesAsalariadoBox = _store.box<SolicitudAsalariadoHnDbLocal>();
    solicitudesNuevaMenorBox = _store.box<SolicitudNuevaMenorHnLocalDb>();
    solicitudesReprestamoBox = _store.box<SolicitudReprestamoHnLocalDb>();
    catalogoLocalBox = _store.box<CatalogoLocalDb>();
    cedulaClientBox = _store.box<CedulaClientDb>();
    catalogoNacionalidadPaisBox = _store.box<CatalogoNacionalidadPaisDb>();
    catalogoNacionalidadDepBox = _store.box<CatalogoNacionalidadDepDb>();
    catalogoNacionalidadMunBox = _store.box<CatalogoNacionalidadMunDb>();
    catalogoBarrioBox = _store.box<CatalogoBarrioLocalDb>();
    catalogoAldeaBox = _store.box<CatalogoAldeaLocalDb>();
    catalogoCaserioBox = _store.box<CatalogoCaserioLocalDb>();
    catalogoFrecuenciaPagoBox = _store.box<CatalogoFrecuenciaPagoDb>();
    catalogoActividadCnbsBox = _store.box<CatalogoActividadCnbsLocalDb>();
    actividadesEconomicasAliasFilteredBox =
        _store.box<ActividadesEconomicasAliasFilteredLocalDb>();
    historialCrediticioBox = _store.box<HistorialCrediticioLocalDb>();
    signatureClientBox = _store.box<SignatureClientDb>();
  }

  static Future<SolicitudesHnBoxService> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dbDir = Directory('${dir.path}/database_hn');
      if (!dbDir.existsSync()) {
        dbDir.createSync(recursive: true);
      }

      final store = await openStore(
        directory: '${dbDir.path}/solicitudes_db',
      );

      return SolicitudesHnBoxService._create(store);
    } on ObjectBoxException catch (e) {
      final isModelError = e.message.contains("DB's last entity ID") ||
          e.message.contains('Model') ||
          e.message.contains('Entity');

      if (isModelError) {
        log('⚠️ Error de modelo detectado. Borrando base de datos local...');

        final dir = await getApplicationDocumentsDirectory();
        final dbDir = Directory('${dir.path}/database');

        if (await dbDir.exists()) {
          await dbDir.delete(recursive: true);
          log('⚠️ Base de datos local borrada.');
        }

        final store = await openStore();
        return SolicitudesHnBoxService._create(store);
      }

      rethrow;
    } catch (e) {
      await ErrorReporter.registerError(
        errorMessage: 'Error inesperado BD Local: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
      throw Exception('Error inesperado BD Local: $e');
    }
  }

  void close() {
    _store.close(); // Cierra la conexión con la base de datos.
  }

  CedulaClientDb saveCedulaClient({required CedulaClientDb cedulaClient}) {
    try {
      cedulaClient.id = 0;
      cedulaClientBox.put(cedulaClient);
      return cedulaClient;
    } catch (e) {
      rethrow;
    }
  }

  List<CatalogoLocalDb> findCatalogoByCodigo({required String codigo}) {
    final query =
        catalogoLocalBox.query(CatalogoLocalDb_.type.equals(codigo)).build();

    final results = query.find();
    query.close();

    return results;
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
      case 'BR':
        if (whereClause.isEmpty) {
          final query = catalogoBarrioBox.query().build();

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
          final query = catalogoBarrioBox
              .query(CatalogoBarrioLocalDb_.relacion.equals(whereClause))
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
      case 'ALD':
        if (whereClause.isEmpty) {
          final query = catalogoAldeaBox.query().build();

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
          final query = catalogoAldeaBox
              .query(CatalogoAldeaLocalDb_.relacion.equals(whereClause))
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
      case 'CAS':
        if (whereClause.isEmpty) {
          final query = catalogoCaserioBox.query().build();

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
          final query = catalogoCaserioBox
              .query(CatalogoCaserioLocalDb_.relacion.equals(whereClause))
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

  List<CatalogoFrecuenciaPagoDb> getCatalogoFrecuenciaPago() {
    final query = catalogoFrecuenciaPagoBox.query().build();

    final results = query.find();
    query.close();

    return results;
  }

  CatalogoLocalDb? getParametroByName({required String nombre}) {
    try {
      final result = catalogoLocalBox
          .query(CatalogoLocalDb_.type.equals(nombre, caseSensitive: false))
          .build()
          .findFirst();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  List<SolicitudNuevaMenorHnLocalDb> getSolicitudesNueva() {
    final resp = solicitudesNuevaMenorBox.getAll();
    return resp.reversed.toList();
  }

  List<SolicitudAsalariadoHnDbLocal> getSolicitudesAsalariado() {
    final resp = solicitudesAsalariadoBox.getAll();
    log('Asalariado solicitudes: ${resp.reversed.toList().length}');
    return resp.reversed.toList();
  }

  List<SolicitudReprestamoHnLocalDb> getSolicitudesReprestamo() {
    final resp = solicitudesReprestamoBox.getAll();
    return resp.reversed.toList();
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

      return result;
    } catch (e) {
      rethrow;
    }
  }

  List<dynamic> sendSolicitudesWhenIsDone() {
    try {
      final nuevas = solicitudesNuevaMenorBox
          .query(SolicitudNuevaMenorHnLocalDb_.isDone
              .equals(true)
              .and(SolicitudNuevaMenorHnLocalDb_.hasVerified.equals(false)))
          .build()
          .find();

      final represtamos = sendSolicitudReprestamoWhenIsDone();
      final asalariados = sendSolicitudAsalariadoWhenIsDone();

      return [...nuevas, ...represtamos, ...asalariados];
    } catch (e) {
      rethrow;
    }
  }

  List<dynamic> sendSolicitudReprestamoWhenIsDone() {
    try {
      final represtamo = solicitudesReprestamoBox
          .query(SolicitudReprestamoHnLocalDb_.isDone
              .equals(true)
              .and(SolicitudReprestamoHnLocalDb_.hasVerified.equals(false)))
          .build()
          .find();

      return represtamo;
    } catch (e) {
      // _logger.e(e.toString());
      rethrow;
    }
  }

  List<dynamic> sendSolicitudAsalariadoWhenIsDone() {
    try {
      final asalariado = solicitudesAsalariadoBox
          .query(SolicitudAsalariadoHnDbLocal_.isDone
              .equals(true)
              .and(SolicitudAsalariadoHnDbLocal_.hasVerified.equals(false)))
          .build()
          .find();

      return asalariado;
    } catch (e) {
      // _logger.e(e.toString());
      rethrow;
    }
  }

  List<HistorialCrediticioLocalDb> getHistorialCredito({required String uuid}) {
    final query = historialCrediticioBox
        .query(HistorialCrediticioLocalDb_.uuid.equals(uuid))
        .build();

    final results = query.find();
    query.close();

    return results;
  }

  void saveHistorialCredito({
    required HistorialCrediticioLocalDb historialCreditoLocalDb,
  }) {
    try {
      historialCrediticioBox.put(historialCreditoLocalDb);
    } catch (e) {
      rethrow;
    }
  }

  void deleteHistorialByUuid(String uuid) {
    final query = historialCrediticioBox
        .query(HistorialCrediticioLocalDb_.uuid.equals(uuid))
        .build();

    final item = query.findFirst();
    query.close();

    // Si se encontró, eliminarlo
    if (item == null) {
      log('No se encontró registro con ese UUID');
      return;
    }

    historialCrediticioBox.remove(item.id);
  }

  void deleteRowsByDeterminateTime({
    Duration duration = const Duration(days: 30),
  }) {
    final now = DateTime.now().subtract(duration);
    solicitudesNuevaMenorBox
        .query(SolicitudNuevaMenorHnLocalDb_.createdAt
            .lessThan(now.millisecondsSinceEpoch))
        .build()
        .remove();
    solicitudesReprestamoBox
        .query(SolicitudReprestamoHnLocalDb_.createdAt
            .lessThan(now.millisecondsSinceEpoch))
        .build()
        .remove();
    solicitudesAsalariadoBox
        .query(SolicitudAsalariadoHnDbLocal_.createdAt
            .lessThan(now.millisecondsSinceEpoch))
        .build()
        .remove();
  }

  void saveClientSignature(SignatureClientDb clientSignature) {
    try {
      signatureClientBox.put(clientSignature);
    } catch (e) {
      rethrow;
    }
  }

  SignatureClientDb? getSignatureByCedula(String cedula, TypeForm typeForm) {
    final query = signatureClientBox
        .query(
          SignatureClientDb_.cedula
              .equals(cedula)
              .and(SignatureClientDb_.typeSolicitud.equals(typeForm.codigo)),
        )
        .build();

    final result = query.findFirst();
    query.close();

    return result;
  }
}
