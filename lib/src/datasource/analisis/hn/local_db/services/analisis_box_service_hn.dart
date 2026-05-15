import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_list_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/asalariado/analisis_asalariado_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/grupal/analisis_grupal_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/imagenes_negocio/imagenes_negocio_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/nueva_menor_mil/nueva_menor_mil_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/represtamo/analisis_represtamo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_activo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ciclo_compras_semanales_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ciclo_venta_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_compras_proveedor_articulo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_costo_de_personal_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_cuentas_por_cobrar_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ingresos_familiares_fuera_negocio_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_inventario_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_nivel_produccion_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/nueva_mayor_mil/analisis_nueva_mayor_a_mil_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_otros_credito_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_pasivo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/ubicacion_cliente/ubicacion_cliente_hn_local_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AnalisisBoxServiceHn {
  late final Store _store;
  late final Box<AnalisisNuevaMayorAMilHnLocalDb>
      analisisNuevaMayorAMilHnLocalDb;
  late final Box<AnalisisCicloVentaHnLocalDb> analisisCicloVentasMensualesHnBox;
  late final Box<AnalisisCicloVentaHnLocalDb> cicloVentaDiariasHNBox;
  late final Box<AnalisisCicloComprasSemanalesHnLocalDb>
      cicloComprasSemanalesHnBox;
  late final Box<AnalisisNivelProduccionLocalDb> nivelProduccionHnBox;
  late final Box<AnalisisCuentasPorCobrarHn> cuentasPorCobrarHnBox;
  late final Box<AnalisisComprasProveedorArticuloHnLocalDb>
      analisisComprasProveedorArticuloHnLocalDb;
  late final Box<AnalisisCostoDePersonalHnLocalDb>
      analisisCostoDePersonalHnLocalDb;
  late final Box<AnalisisIngresosFamiliaresFueraNegocioHnLocalDb>
      analisisIngresosFamiliaresFueraNegocioHnLocalDb;
  late final Box<AnalisisOtrosCreditoHnLocalDb> analisisOtrosCreditoHnLocalDb;
  late final Box<AnalisisPasivoHnLocalDb> analisisPasivoHnLocalDb;
  late final Box<AnalisisActivoHnLocalDb> analisisActivoHnLocalDb;
  late final Box<AnalisisInventarioHnLocalDb> analisisInventarioHnLocalDb;
  late final Box<AnalisisAsalariadoHnLocalDb> analisisAsalariadoHnLocalDb;
  late final Box<AnalisisReprestamoHnLocalDb> analisisReprestamoHnLocalDb;
  late final Box<NuevaMenorMilLocalDb> analisisNuevaMenorMilHnLocalDb;
  late final Box<AnalisisListDataHn> analisisListDataHnBox;
  late final Box<AnalisisGrupalHnLocalDb> analisisGrupalHnLocalDb;
  late final Box<ImagenesNegocioHnLocalDb> imagenesNegocioHnLocalDb;
  late final Box<UbicacionClienteHnLocalDb> ubicacionClienteHnLocalDb;

  AnalisisBoxServiceHn._create(this._store) {
    analisisNuevaMayorAMilHnLocalDb =
        _store.box<AnalisisNuevaMayorAMilHnLocalDb>();
    analisisCicloVentasMensualesHnBox =
        _store.box<AnalisisCicloVentaHnLocalDb>();
    cicloVentaDiariasHNBox = _store.box<AnalisisCicloVentaHnLocalDb>();
    nivelProduccionHnBox = _store.box<AnalisisNivelProduccionLocalDb>();
    cuentasPorCobrarHnBox = _store.box<AnalisisCuentasPorCobrarHn>();
    analisisComprasProveedorArticuloHnLocalDb =
        _store.box<AnalisisComprasProveedorArticuloHnLocalDb>();
    analisisCostoDePersonalHnLocalDb =
        _store.box<AnalisisCostoDePersonalHnLocalDb>();
    analisisIngresosFamiliaresFueraNegocioHnLocalDb =
        _store.box<AnalisisIngresosFamiliaresFueraNegocioHnLocalDb>();
    analisisOtrosCreditoHnLocalDb = _store.box<AnalisisOtrosCreditoHnLocalDb>();
    analisisPasivoHnLocalDb = _store.box<AnalisisPasivoHnLocalDb>();
    analisisActivoHnLocalDb = _store.box<AnalisisActivoHnLocalDb>();
    cicloComprasSemanalesHnBox =
        _store.box<AnalisisCicloComprasSemanalesHnLocalDb>();
    analisisInventarioHnLocalDb = _store.box<AnalisisInventarioHnLocalDb>();
    analisisAsalariadoHnLocalDb = _store.box<AnalisisAsalariadoHnLocalDb>();
    analisisReprestamoHnLocalDb = _store.box<AnalisisReprestamoHnLocalDb>();
    analisisNuevaMenorMilHnLocalDb = _store.box<NuevaMenorMilLocalDb>();
    analisisListDataHnBox = _store.box<AnalisisListDataHn>();
    analisisGrupalHnLocalDb = _store.box<AnalisisGrupalHnLocalDb>();
    imagenesNegocioHnLocalDb = _store.box<ImagenesNegocioHnLocalDb>();
    ubicacionClienteHnLocalDb = _store.box<UbicacionClienteHnLocalDb>();
  }

  static Future<AnalisisBoxServiceHn> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dbDir = Directory('${dir.path}/database_hn');
      if (!dbDir.existsSync()) {
        dbDir.createSync(recursive: true);
      }

      final store = await openStore(
        directory: '${dbDir.path}/analisis_db',
      );

      return AnalisisBoxServiceHn._create(store);
    } on ObjectBoxException catch (e) {
      final isModelError = e.message.contains("DB's last entity ID") ||
          e.message.contains('Model') ||
          e.message.contains('Entity');

      if (isModelError) {
        log('⚠️ Error de modelo detectado. Borrando base de datos local...');

        final dir = await getApplicationDocumentsDirectory();
        final dbDir = Directory('${dir.path}/database_hn');

        if (await dbDir.exists()) {
          await dbDir.delete(recursive: true);
          log('⚠️ Base de datos local borrada.');
        }

        final store = await openStore();
        return AnalisisBoxServiceHn._create(store);
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

  AnalisisNuevaMayorAMilHnLocalDb? getAnalisisNuevaMayorMilByNumeroSolicitud({
    required int numeroSolicitud,
  }) {
    final query = analisisNuevaMayorAMilHnLocalDb
        .query(AnalisisNuevaMayorAMilHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build();

    final results = query.findFirst();
    query.close();

    return results;
  }

  AnalisisAsalariadoHnLocalDb? getAnalisisAsalariadoByNumeroSolicitud({
    required int numeroSolicitud,
  }) {
    final query = analisisAsalariadoHnLocalDb
        .query(AnalisisAsalariadoHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build();

    final results = query.findFirst();
    query.close();

    return results;
  }

  AnalisisReprestamoHnLocalDb? getAnalisisReprestamoByNumeroSolicitud({
    required int numeroSolicitud,
  }) {
    final query = analisisReprestamoHnLocalDb
        .query(AnalisisReprestamoHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build();

    final results = query.findFirst();
    query.close();

    return results;
  }

  NuevaMenorMilLocalDb? getAnalisisMenorMilByNumeroSolicitud({
    required int numeroSolicitud,
  }) {
    final query = analisisNuevaMenorMilHnLocalDb
        .query(NuevaMenorMilLocalDb_.numeroSolicitud.equals(numeroSolicitud))
        .build();

    final results = query.findFirst();
    query.close();

    return results;
  }

  AnalisisGrupalHnLocalDb? getAnalisisGrupalByNumeroSolicitud({
    required int numeroSolicitud,
  }) {
    final query = analisisGrupalHnLocalDb
        .query(AnalisisGrupalHnLocalDb_.numeroSolicitud.equals(numeroSolicitud))
        .build();

    final results = query.findFirst();
    query.close();

    return results;
  }

  int createAnalisisCicloVentaHnLocalDb({
    required AnalisisCicloVentaHnLocalDb analisisCicloVentaHnLocalDb,
  }) {
    return analisisCicloVentasMensualesHnBox.put(analisisCicloVentaHnLocalDb);
  }

  void createCicloVentasModelEntities(
      List<AnalisisCicloVentaHnLocalDb> cicloVentas, int numeroSolicitud) {
    final entities = cicloVentas.map((mes) {
      return AnalisisCicloVentaHnLocalDb(
        mes: mes.mes,
        typeFormAnalisis: 'VENTAS_MESES',
        valorizacion: mes.valorizacion,
        venta: mes.venta,
        numeroSolicitud: numeroSolicitud,
        dia: mes.dia,
        uuid: const Uuid().v4(),
      );
    }).toList();

    analisisCicloVentasMensualesHnBox.putMany(entities);
  }

  void saveAnalisisListDataHn({
    required List<AnalisisListDataHn> analisisListDataHn,
  }) {
    analisisListDataHnBox.removeAll();
    analisisListDataHnBox.putMany(analisisListDataHn);
  }

  void saveImagenesNegocioOnLocalDb({
    required ImagenesNegocioHnLocalDb imagenNegocioSchema,
  }) {
    imagenesNegocioHnLocalDb.put(imagenNegocioSchema);
  }

  ImagenesNegocioHnLocalDb? getImagenesNegocioFromLocalDb({
    required String numeroSolicitud,
  }) {
    try {
      final query = imagenesNegocioHnLocalDb
          .query(
              ImagenesNegocioHnLocalDb_.numeroSolicitud.equals(numeroSolicitud))
          .build();

      final result = query.findFirst();

      query.close();

      return result;
    } catch (e) {
      log('Error al consultar LocalDB: $e');
      return null;
    }
  }

  bool saveUbicacionCliente({
    required UbicacionClienteHnLocalDb ubicacionCliente,
  }) {
    try {
      ubicacionClienteHnLocalDb.put(ubicacionCliente);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<UbicacionClienteHnLocalDb> getAllClientesUbicacionesByNumeroSolicitud(
    String numeroSolicitud,
  ) {
    return ubicacionClienteHnLocalDb
        .query(
          UbicacionClienteHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        )
        .build()
        .find();
  }

  void deleteRowByNumeroSolicitud(String numeroSolicitud) {
    final query = ubicacionClienteHnLocalDb
        .query(
          UbicacionClienteHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        )
        .build();

    final item = query.findFirst();

    if (item != null) {
      ubicacionClienteHnLocalDb.remove(item.id);
    }

    query.close();
  }
}
