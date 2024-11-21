import 'package:bloc/bloc.dart';
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
      for (var solicitud in solicitudes) {
        final existingIds = await state.isar!.solicitudesPendientes
            .filter()
            .solicitudIdEqualTo(solicitud.solicitudId)
            .findFirst();
        final isnumerosIdExists = await state.isar!.solicitudesPendientes
            .filter()
            .numeroEqualTo(solicitud.numero)
            .findFirst();
        final issucursalExists = await state.isar!.solicitudesPendientes
            .filter()
            .sucursalEqualTo(solicitud.sucursal)
            .findFirst();
        if (existingIds != null &&
            isnumerosIdExists != null &&
            issucursalExists != null) {
          _logger
              .i('Ya existe esta solicitud con el ID ${solicitud.solicitudId}');
        } else {
          await state.isar!.writeTxn(() {
            return state.isar!.solicitudesPendientes.put(solicitud);
          });
        }
        emit(state.copyWith(status: Status.done));
      }
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
}
