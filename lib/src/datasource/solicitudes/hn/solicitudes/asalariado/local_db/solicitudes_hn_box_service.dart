import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_actividad_cnbs_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_aldea_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_barrio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_caserio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/local_db/solicitud_represtamo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_frecuencia_pago_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_dep.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_mun.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_pais_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/cedula/cedula_client_db.dart';
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

  SolicitudesHnBoxService._create(this._store) {
    solicitudesAsalariadoBox = _store.box<SolicitudAsalariadoHnDbLocal>();
    solicitudesNuevaMenorBox = _store.box<SolicitudNuevaMenorHnLocalDb>();
    catalogoLocalBox = _store.box<CatalogoLocalDb>();
    cedulaClientBox = _store.box<CedulaClientDb>();
    catalogoNacionalidadPaisBox = _store.box<CatalogoNacionalidadPaisDb>();
    catalogoNacionalidadDepBox = _store.box<CatalogoNacionalidadDepDb>();
    catalogoNacionalidadMunBox = _store.box<CatalogoNacionalidadMunDb>();
    catalogoBarrioBox = _store.box<CatalogoBarrioLocalDb>();
    catalogoAldeaBox = _store.box<CatalogoAldeaLocalDb>();
    catalogoCaserioBox = _store.box<CatalogoCaserioLocalDb>();
    catalogoFrecuenciaPagoBox = _store.box<CatalogoFrecuenciaPagoDb>();
    solicitudesReprestamoBox = _store.box<SolicitudReprestamoHnLocalDb>();
    catalogoActividadCnbsBox = _store.box<CatalogoActividadCnbsLocalDb>();
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
}
