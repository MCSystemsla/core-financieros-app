import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/borrador_sin_numero/local_db/analisis_borrador_sin_numero_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/borrador_sin_numero/modulo_borrador_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/local_db/analisis_fiador_hn_local_db.dart';
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
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/local_db/analisis_plan_inversion_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/local_db/analisis_fiador_ni_local_db.dart';
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
  late final Box<AnalisisFiadorNiLocalDb> analisisFiadorNiLocalDbBox;
  late final Box<AnalisisPlanInversionHnLocalDb>
      analisisPlanInversionHnLocalDbBox;
  late final Box<AnalisisFiadorHnLocalDb> analisisFiadorHnLocalDbBox;
  late final Box<AnalisisBorradorSinNumeroHnLocalDb>
      analisisBorradorSinNumeroHnBox;

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
    analisisFiadorNiLocalDbBox = _store.box<AnalisisFiadorNiLocalDb>();
    analisisPlanInversionHnLocalDbBox =
        _store.box<AnalisisPlanInversionHnLocalDb>();
    analisisFiadorHnLocalDbBox = _store.box<AnalisisFiadorHnLocalDb>();
    analisisBorradorSinNumeroHnBox =
        _store.box<AnalisisBorradorSinNumeroHnLocalDb>();
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

  bool deleteUbicacionClienteById(int id) {
    return ubicacionClienteHnLocalDb.remove(id);
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

  void saveFiadorNiPendiente(AnalisisFiadorNiLocalDb fiador) {
    analisisFiadorNiLocalDbBox.put(fiador);
  }

  List<AnalisisFiadorNiLocalDb> getFiadoresNiPendientes({
    required int numeroSolicitud,
    required String userId,
  }) {
    final query = analisisFiadorNiLocalDbBox
        .query(AnalisisFiadorNiLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisFiadorNiLocalDb_.userId.equals(userId)))
        .order(AnalisisFiadorNiLocalDb_.fechaGuardado)
        .build();

    final results = query.find();
    query.close();

    return results;
  }

  bool existsFiadorNiPendiente({
    required int numeroSolicitud,
    required String cedula,
    required String userId,
  }) {
    final query = analisisFiadorNiLocalDbBox
        .query(AnalisisFiadorNiLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisFiadorNiLocalDb_.cedula.equals(cedula))
            .and(AnalisisFiadorNiLocalDb_.userId.equals(userId)))
        .build();

    final exists = query.count() > 0;
    query.close();

    return exists;
  }

  void removeFiadorNiPendiente(int id) {
    analisisFiadorNiLocalDbBox.remove(id);
  }

  void saveFiadorHnPendiente(AnalisisFiadorHnLocalDb fiador) {
    analisisFiadorHnLocalDbBox.put(fiador);
  }

  List<AnalisisFiadorHnLocalDb> getFiadoresHnPendientes({
    required int numeroSolicitud,
    required String userId,
  }) {
    final query = analisisFiadorHnLocalDbBox
        .query(AnalisisFiadorHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisFiadorHnLocalDb_.userId.equals(userId)))
        .order(AnalisisFiadorHnLocalDb_.fechaGuardado)
        .build();

    final results = query.find();
    query.close();

    return results;
  }

  bool existsFiadorHnPendiente({
    required int numeroSolicitud,
    required String cedula,
    required String userId,
  }) {
    final query = analisisFiadorHnLocalDbBox
        .query(AnalisisFiadorHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisFiadorHnLocalDb_.cedula.equals(cedula))
            .and(AnalisisFiadorHnLocalDb_.userId.equals(userId)))
        .build();

    final exists = query.count() > 0;
    query.close();

    return exists;
  }

  /// `TFD2` es el código de fiador cónyuge (`FiadoresHnFormType.conyugue`).
  bool existsConyugeHnPendiente({
    required int numeroSolicitud,
    required String userId,
  }) {
    final query = analisisFiadorHnLocalDbBox
        .query(AnalisisFiadorHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisFiadorHnLocalDb_.userId.equals(userId))
            .and(AnalisisFiadorHnLocalDb_.tipoFiadorCodigo.equals('TFD2')))
        .build();

    final exists = query.count() > 0;
    query.close();

    return exists;
  }

  void updateFiadorHnPendienteFiadorId({
    required int id,
    required String fiadorId,
  }) {
    final fiador = analisisFiadorHnLocalDbBox.get(id);
    if (fiador == null) return;
    analisisFiadorHnLocalDbBox.put(fiador..fiadorId = fiadorId);
  }

  /// Borra la carpeta `fiadores_hn/<uuid>/` con las fotos de la cédula y la
  /// firma, y después la fila.
  Future<void> removeFiadorHnPendiente(AnalisisFiadorHnLocalDb fiador) async {
    final dir = await getApplicationDocumentsDirectory();
    final filesDir = Directory('${dir.path}/fiadores_hn/${fiador.uuid}');
    if (await filesDir.exists()) {
      await filesDir.delete(recursive: true);
    }
    analisisFiadorHnLocalDbBox.remove(fiador.id);
  }

  AnalisisPlanInversionHnLocalDb? getPlanInversionBorrador({
    required int numeroSolicitud,
    required String userId,
  }) {
    final query = analisisPlanInversionHnLocalDbBox
        .query(AnalisisPlanInversionHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisPlanInversionHnLocalDb_.userId.equals(userId)))
        .build();

    final borrador = query.findFirst();
    query.close();

    return borrador;
  }

  /// Crea o actualiza el borrador de la solicitud. Con [items] vacío lo borra.
  void savePlanInversionBorrador({
    required int numeroSolicitud,
    required String userId,
    required List<PlanInversion> items,
  }) {
    if (items.isEmpty) {
      removePlanInversionBorrador(
        numeroSolicitud: numeroSolicitud,
        userId: userId,
      );
      return;
    }

    final borrador = getPlanInversionBorrador(
          numeroSolicitud: numeroSolicitud,
          userId: userId,
        ) ??
        AnalisisPlanInversionHnLocalDb(
          numeroSolicitud: numeroSolicitud,
          userId: userId,
          fechaActualizacion: DateTime.now(),
          itemsJson: '[]',
        );

    borrador
      ..fechaActualizacion = DateTime.now()
      ..itemsJson = json.encode(items.map((e) => e.toLocalJson()).toList());

    analisisPlanInversionHnLocalDbBox.put(borrador);
  }

  void removePlanInversionBorrador({
    required int numeroSolicitud,
    required String userId,
  }) {
    final borrador = getPlanInversionBorrador(
      numeroSolicitud: numeroSolicitud,
      userId: userId,
    );
    if (borrador != null) {
      analisisPlanInversionHnLocalDbBox.remove(borrador.id);
    }
  }

  void removeAnalisisFormsByDate() {}

  /// Cédula sin guiones ni espacios, para comparar la solicitud local con la AUT.
  static String normalizarCedula(String cedula) =>
      cedula.replaceAll(RegExp(r'[\s-]'), '');

  /// Busca el borrador de la solicitud local por [solicitudLocalUuid] y, si no
  /// está, por usuario + cédula + tipo. Si no existe, lo crea.
  AnalisisBorradorSinNumeroHnLocalDb getOrCreateBorradorSinNumero({
    required String solicitudLocalUuid,
    required String userId,
    required String cedula,
    required String tipoSolicitud,
    required double monto,
    required String nombreCompleto,
  }) {
    AnalisisBorradorSinNumeroHnLocalDb? borrador;

    if (solicitudLocalUuid.isNotEmpty) {
      final query = analisisBorradorSinNumeroHnBox
          .query(AnalisisBorradorSinNumeroHnLocalDb_.solicitudLocalUuid
              .equals(solicitudLocalUuid)
              .and(AnalisisBorradorSinNumeroHnLocalDb_.userId.equals(userId)))
          .build();
      borrador = query.findFirst();
      query.close();
    }

    borrador ??= findBorradorSinNumero(
      userId: userId,
      cedula: cedula,
      tipoSolicitud: tipoSolicitud,
    );

    if (borrador != null) {
      if (borrador.solicitudLocalUuid.isEmpty &&
          solicitudLocalUuid.isNotEmpty) {
        borrador.solicitudLocalUuid = solicitudLocalUuid;
        analisisBorradorSinNumeroHnBox.put(borrador);
      }
      return borrador;
    }

    final nuevo = AnalisisBorradorSinNumeroHnLocalDb(
      solicitudLocalUuid: solicitudLocalUuid,
      userId: userId,
      cedula: normalizarCedula(cedula),
      tipoSolicitud: tipoSolicitud,
      monto: monto,
      nombreCompleto: nombreCompleto,
      fechaCreacion: DateTime.now(),
    );
    analisisBorradorSinNumeroHnBox.put(nuevo);

    return nuevo;
  }

  List<AnalisisBorradorSinNumeroHnLocalDb> getBorradoresSinNumero({
    required String userId,
  }) {
    final query = analisisBorradorSinNumeroHnBox
        .query(AnalisisBorradorSinNumeroHnLocalDb_.userId.equals(userId))
        .order(AnalisisBorradorSinNumeroHnLocalDb_.fechaCreacion)
        .build();

    final results = query.find();
    query.close();

    return results;
  }

  AnalisisBorradorSinNumeroHnLocalDb? findBorradorSinNumero({
    required String userId,
    required String cedula,
    required String tipoSolicitud,
  }) {
    final query = analisisBorradorSinNumeroHnBox
        .query(AnalisisBorradorSinNumeroHnLocalDb_.userId
            .equals(userId)
            .and(AnalisisBorradorSinNumeroHnLocalDb_.cedula
                .equals(normalizarCedula(cedula)))
            .and(AnalisisBorradorSinNumeroHnLocalDb_.tipoSolicitud
                .equals(tipoSolicitud)))
        .build();

    final borrador = query.findFirst();
    query.close();

    return borrador;
  }

  /// Módulos que tienen datos locales guardados con [numeroSolicitud].
  Set<ModuloBorradorHn> modulosConDatos({required int numeroSolicitud}) {
    final numero = numeroSolicitud.toString();
    final hayAnalisis = _hayDatos(
          analisisNuevaMenorMilHnLocalDb,
          NuevaMenorMilLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisNuevaMayorAMilHnLocalDb,
          AnalisisNuevaMayorAMilHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisAsalariadoHnLocalDb,
          AnalisisAsalariadoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisReprestamoHnLocalDb,
          AnalisisReprestamoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisCicloVentasMensualesHnBox,
          AnalisisCicloVentaHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        ) ||
        _hayDatos(
          cicloComprasSemanalesHnBox,
          AnalisisCicloComprasSemanalesHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        ) ||
        _hayDatos(
          nivelProduccionHnBox,
          AnalisisNivelProduccionLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        ) ||
        _hayDatos(
          cuentasPorCobrarHnBox,
          AnalisisCuentasPorCobrarHn_.numeroSolicitud.equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisComprasProveedorArticuloHnLocalDb,
          AnalisisComprasProveedorArticuloHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisCostoDePersonalHnLocalDb,
          AnalisisCostoDePersonalHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisIngresosFamiliaresFueraNegocioHnLocalDb,
          AnalisisIngresosFamiliaresFueraNegocioHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisOtrosCreditoHnLocalDb,
          AnalisisOtrosCreditoHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisPasivoHnLocalDb,
          AnalisisPasivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisActivoHnLocalDb,
          AnalisisActivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        ) ||
        _hayDatos(
          analisisInventarioHnLocalDb,
          AnalisisInventarioHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );

    return {
      if (hayAnalisis) ModuloBorradorHn.analisis,
      if (_hayDatos(
        analisisPlanInversionHnLocalDbBox,
        AnalisisPlanInversionHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
      ))
        ModuloBorradorHn.planInversion,
      if (_hayDatos(
        analisisFiadorHnLocalDbBox,
        AnalisisFiadorHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
      ))
        ModuloBorradorHn.fiadores,
      if (_hayDatos(
        imagenesNegocioHnLocalDb,
        ImagenesNegocioHnLocalDb_.numeroSolicitud.equals(numero),
      ))
        ModuloBorradorHn.imagenes,
      if (_hayDatos(
        ubicacionClienteHnLocalDb,
        UbicacionClienteHnLocalDb_.numeroSolicitud.equals(numero),
      ))
        ModuloBorradorHn.ubicacion,
    };
  }

  /// Borra todos los datos del borrador (incluidas las carpetas de sus
  /// fiadores) y la fila del borrador.
  Future<void> descartarBorradorSinNumero(
    AnalisisBorradorSinNumeroHnLocalDb borrador,
  ) async {
    final numero = borrador.numeroProvisional;
    for (final modulo in ModuloBorradorHn.values) {
      if (modulo != ModuloBorradorHn.fiadores) {
        _borrarModulo(modulo, numero);
      }
    }
    for (final fiador in _getFiadoresHn(numero)) {
      await removeFiadorHnPendiente(fiador);
    }
    analisisBorradorSinNumeroHnBox.remove(borrador.id);
  }

  List<AnalisisFiadorHnLocalDb> _getFiadoresHn(int numeroSolicitud) {
    final query = analisisFiadorHnLocalDbBox
        .query(AnalisisFiadorHnLocalDb_.numeroSolicitud.equals(numeroSolicitud))
        .build();
    final results = query.find();
    query.close();

    return results;
  }

  /// Borra las filas de [modulo] con [numeroSolicitud]. Los fiadores solo
  /// pierden la fila: sus carpetas se borran con [removeFiadorHnPendiente].
  void _borrarModulo(ModuloBorradorHn modulo, int numeroSolicitud) {
    final numero = numeroSolicitud.toString();
    switch (modulo) {
      case ModuloBorradorHn.analisis:
        _borrar(
          analisisNuevaMenorMilHnLocalDb,
          NuevaMenorMilLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
        _borrar(
          analisisNuevaMayorAMilHnLocalDb,
          AnalisisNuevaMayorAMilHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
        _borrar(
          analisisAsalariadoHnLocalDb,
          AnalisisAsalariadoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
        _borrar(
          analisisReprestamoHnLocalDb,
          AnalisisReprestamoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
        _borrar(
          analisisCicloVentasMensualesHnBox,
          AnalisisCicloVentaHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
        _borrar(
          cicloComprasSemanalesHnBox,
          AnalisisCicloComprasSemanalesHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
        _borrar(
          nivelProduccionHnBox,
          AnalisisNivelProduccionLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
        _borrar(
          cuentasPorCobrarHnBox,
          AnalisisCuentasPorCobrarHn_.numeroSolicitud.equals(numeroSolicitud),
        );
        _borrar(
          analisisComprasProveedorArticuloHnLocalDb,
          AnalisisComprasProveedorArticuloHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
        _borrar(
          analisisCostoDePersonalHnLocalDb,
          AnalisisCostoDePersonalHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
        _borrar(
          analisisIngresosFamiliaresFueraNegocioHnLocalDb,
          AnalisisIngresosFamiliaresFueraNegocioHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
        _borrar(
          analisisOtrosCreditoHnLocalDb,
          AnalisisOtrosCreditoHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
        _borrar(
          analisisPasivoHnLocalDb,
          AnalisisPasivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
        _borrar(
          analisisActivoHnLocalDb,
          AnalisisActivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
        _borrar(
          analisisInventarioHnLocalDb,
          AnalisisInventarioHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
      case ModuloBorradorHn.planInversion:
        _borrar(
          analisisPlanInversionHnLocalDbBox,
          AnalisisPlanInversionHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud),
        );
      case ModuloBorradorHn.fiadores:
        _borrar(
          analisisFiadorHnLocalDbBox,
          AnalisisFiadorHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        );
      case ModuloBorradorHn.imagenes:
        _borrar(
          imagenesNegocioHnLocalDb,
          ImagenesNegocioHnLocalDb_.numeroSolicitud.equals(numero),
        );
      case ModuloBorradorHn.ubicacion:
        _borrar(
          ubicacionClienteHnLocalDb,
          UbicacionClienteHnLocalDb_.numeroSolicitud.equals(numero),
        );
    }
  }

  void _borrar<T>(Box<T> box, Condition<T> condition) {
    final query = box.query(condition).build();
    query.remove();
    query.close();
  }

  bool _hayDatos<T>(Box<T> box, Condition<T> condition) {
    final query = box.query(condition).build();
    final count = query.count();
    query.close();

    return count > 0;
  }
}
