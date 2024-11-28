import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/local_db/comunidades/comunidades_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/departamentos/departamentos_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/energia_limpia_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/estandar_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/recurrente_estandar_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/mejora_vivienda_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/recurrente_mejora_vivienda_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/micredi_estudio_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/recurrente_micredi_estudio_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/recurrente_mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/recurrente_energia_limpia_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/recurrente_saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

part 'solicitudes_pendientes_local_db_state.dart';

class SolicitudesPendientesLocalDbCubit
    extends Cubit<SolicitudesPendientesLocalDbState> {
  SolicitudesPendientesLocalDbCubit()
      : super(SolicitudesPendientesLocalDbInitial());
  final _logger = Logger();
  Future<void> initDB() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        inspector: true,
        [
          SolicitudesPendientesSchema,
          EnergiaLimpiaDbLocalSchema,
          RecurrenteEnergiaLimpiaDbLocalSchema,
          MiCrediEstudioDbLocalSchema,
          RecurrenteMiCrediEstudioDbLocalSchema,
          MejoraViviendaDbLocalSchema,
          RecurrenteMejoraViviendaDbLocalSchema,
          MujerEmprendeDbLocalSchema,
          RecurrenteMujerEmprendeDbLocalSchema,
          SaneamientoDbLocalSchema,
          RecurrenteSaneamientoDbLocalSchema,
          EstandarDbLocalSchema,
          RecurrenteEstandarDbLocalSchema,
          DepartamentosDbLocalSchema,
          ComunidadesLocalDbSchema
        ],
        directory: dir.path,
      );
      if (isar.isOpen) {
        emit(state.copyWith(isar: isar));
        _logger.i('La base de datos Isar está activa.');
      }
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveSolicitudesPendientes(
      {required List<SolicitudesPendientes> solicitudes}) async {
    emit(state.copyWith(status: Status.inProgress));
    await Future.delayed(const Duration(seconds: 3));
    try {
      await state.isar!.writeTxn(() {
        return state.isar!.solicitudesPendientes.clear();
      });
      for (var solicitud in solicitudes) {
        //   final existingIds = await state.isar!.solicitudesPendientes
        //       .filter()
        //       .solicitudIdEqualTo(solicitud.solicitudId)
        //       .findFirst();
        //   final isnumerosIdExists = await state.isar!.solicitudesPendientes
        //       .filter()
        //       .numeroEqualTo(solicitud.numero)
        //       .findFirst();
        //   final issucursalExists = await state.isar!.solicitudesPendientes
        //       .filter()
        //       .sucursalEqualTo(solicitud.sucursal)
        //       .findFirst();
        // if (existingIds != null &&
        //     isnumerosIdExists != null &&
        //     issucursalExists != null) {
        //   _logger
        //       .i('Ya existe esta solicitud con el ID ${solicitud.solicitudId}');
        // } else {
        await state.isar!.writeTxn(() {
          return state.isar!.solicitudesPendientes.put(solicitud);
        });
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> getSolicitudes() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final solicitudes =
          await state.isar!.solicitudesPendientes.where().findAll();
      emit(state.copyWith(status: Status.done, solicitudes: solicitudes));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> getDepartamentos() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final departamentos =
          await state.isar!.departamentosDbLocals.where().findAll();
      emit(state.copyWith(status: Status.done, departamentos: departamentos));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> getComunidades() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final comunidades =
          await state.isar!.comunidadesLocalDbs.where().findAll();
      emit(state.copyWith(status: Status.done, comunidades: comunidades));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<RecurrenteEstandarDbLocal?> getRecurrentEstandar(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final estandar = await state.isar!.recurrenteEstandarDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteEstandarDbLocal: estandar,
      ));
      return estandar;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<List<int?>> getItemsRecurrents({required String typeProduct}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      switch (typeProduct) {
        case 'MICREDIESTUDIO RECURRENTE':
          return await state.isar!.recurrenteMiCrediEstudioDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ESTANDAR RECURRENTE':
          return await state.isar!.recurrenteEstandarDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'VIVIENDA REPRESTAMO':
          return await state.isar!.recurrenteMejoraViviendaDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'AGUA Y SANEAMIENTO RECURRENTE':
          return await state.isar!.recurrenteSaneamientoDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ASER RECURRENTE':
          return await state.isar!.recurrenteEnergiaLimpiaDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'MUJER EMPRENDE RECURRENTE':
          return await state.isar!.recurrenteMujerEmprendeDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
      }
      return [];
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return [];
    }
  }

  Future<void> checkMatching(String typeProduct, String solicitudId) async {
    final Map<String, bool> isMatchingMap = {};

    final numSolicitud = await getItemsRecurrents(typeProduct: typeProduct);
    // ignore: unrelated_type_equality_checks
    final isMatching = numSolicitud == int.tryParse(solicitudId);

    isMatchingMap[typeProduct] = isMatching;
    emit(state.copyWith(isMatchingMap: Map.from(isMatchingMap)));
  }

  Future<void> saveEnergiaLimpia({
    required EnergiaLimpiaDbLocal energiaLimpiaDBLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.energiaLimpiaDbLocals.put(energiaLimpiaDBLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveRecurrenteEnergiaLimpia({
    required RecurrenteEnergiaLimpiaDbLocal recurrenteEnergiaLimpiaDBLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.recurrenteEnergiaLimpiaDbLocals
              .put(recurrenteEnergiaLimpiaDBLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveEstandarForm(
      {required EstandarDbLocal estandarDBLocal}) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.estandarDbLocals.put(estandarDBLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveRecurrentEstandarForm(
      {required RecurrenteEstandarDbLocal recurrenteEstandarModel}) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.recurrenteEstandarDbLocals
              .put(recurrenteEstandarModel);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveMejoraViviendaForm(
      {required MejoraViviendaDbLocal mejoraViviendaDBLocal}) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.mejoraViviendaDbLocals.put(mejoraViviendaDBLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveRecurrenteMejoraViviendaForm({
    required RecurrenteMejoraViviendaDbLocal recurrenteMejoraViviendaDBLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.recurrenteMejoraViviendaDbLocals
              .put(recurrenteMejoraViviendaDBLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveMiCrediEstudioForm({
    required MiCrediEstudioDbLocal miCrediEstudioModelDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.miCrediEstudioDbLocals
              .put(miCrediEstudioModelDbLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveRecurrentMiCrediEstudioForm({
    required RecurrenteMiCrediEstudioDbLocal
        recurrenteMiCrediEstudioModelDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.recurrenteMiCrediEstudioDbLocals
              .put(recurrenteMiCrediEstudioModelDbLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveMujerEmprendeForm({
    required MujerEmprendeDbLocal mujerEmprendeDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.mujerEmprendeDbLocals.put(mujerEmprendeDbLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveRecurrenteMujerEmprendeForm({
    required RecurrenteMujerEmprendeDbLocal recurrenteMujerEmprendeDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.recurrenteMujerEmprendeDbLocals
              .put(recurrenteMujerEmprendeDbLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveSaneamientoForm({
    required SaneamientoDbLocal saneamientoDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.saneamientoDbLocals.put(saneamientoDbLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveRecurrentSaneamientoForm({
    required RecurrenteSaneamientoDbLocal recurrenteSaneamientoDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.recurrenteSaneamientoDbLocals
              .put(recurrenteSaneamientoDbLocal);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveDepartaments({
    required List<DepartamentosDbLocal> departaments,
  }) async {
    try {
      await state.isar!.writeTxn(
        () {
          return state.isar!.departamentosDbLocals.clear();
        },
      );

      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.departamentosDbLocals.putAll(departaments);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveComunidades({
    required List<ComunidadesLocalDb> comunidades,
  }) async {
    try {
      await state.isar!.writeTxn(
        () {
          return state.isar!.comunidadesLocalDbs.clear();
        },
      );

      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.comunidadesLocalDbs.putAll(comunidades);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }
}
