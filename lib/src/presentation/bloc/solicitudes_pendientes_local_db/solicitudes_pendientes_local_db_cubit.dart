import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/actions/actions_model_db.dart';
import 'package:core_financiero_app/src/datasource/local_db/comunidades/comunidades_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/departamentos/departamentos_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/energia_limpia_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/estandar_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/recurrente_estandar_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/mejora_vivienda_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/recurrente_mejora_vivienda_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/micredi_estudio_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/recurrente_micredi_estudio_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/recurrente_migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/recurrente_mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/recurrente_energia_limpia_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/recurrente_saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
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
      // Obtén el directorio para almacenar la base de datos
      final dir = await getApplicationDocumentsDirectory();

      // Intenta abrir la base de datos Isar
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
          ComunidadesLocalDbSchema,
          ImageModelSchema,
          MigranteEconomicoDbLocalSchema,
          RecurrenteMigranteEconomicoDbLocalSchema,
          ActionsModelDbSchema,
        ],
        directory: dir.path,
      );

      emit(state.copyWith(isar: isar));
      _logger.i('La base de datos Isar está activa.');
    } catch (e) {
      _logger.e('Error al inicializar la base de datos Isar: $e');
      await ErrorReporter.registerError(
        errorMessage: 'Error Inesperado BD Local: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
      throw Exception('Error Inesperado BD Local: $e');
    }
  }

  Future<void> saveSolicitudesPendientes(
      {required List<SolicitudesPendientes> solicitudes}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await state.isar!.writeTxn(() {
        return state.isar!.solicitudesPendientes
            .filter()
            .isSendedEqualTo(false)
            .deleteAll();
      });

      await state.isar?.writeTxn(() {
        return state.isar!.solicitudesPendientes.putAll(solicitudes);
      });
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> updateIsSendedOnSolicitud({required String solicitudId}) async {
    try {
      // Actualiza el campo isSended en true solo para la solicitud con el id dado
      await state.isar?.writeTxn(() async {
        final existing = await state.isar?.solicitudesPendientes
            .filter()
            .solicitudIdEqualTo(solicitudId)
            .findFirst();
        if (existing != null) {
          existing.isSended = true;
          existing.dateSended = DateTime.now();
          // Guarda el objeto actualizado en la base de datos
          await state.isar?.solicitudesPendientes.put(existing);
        }
      });
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> updateIsImagesSendedOnSolicitud({
    required String solicitudId,
  }) async {
    try {
      // Actualiza el campo isSended en true solo para la solicitud con el id dado
      await state.isar?.writeTxn(() async {
        final existing = await state.isar?.solicitudesPendientes
            .filter()
            .solicitudIdEqualTo(solicitudId)
            .findFirst();
        if (existing != null) {
          existing.imagesSended = true;
          // Guarda el objeto actualizado en la base de datos
          await state.isar?.solicitudesPendientes.put(existing);
        }
      });
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> removeSolicitudWhenDateSendedIsMoreThanDateCreated() async {
    try {
      await state.isar?.writeTxn(() async {
        final solicitudes = await _getSolicitudesEnviadas();

        for (final solicitud in solicitudes) {
          if (_shouldDeleteSolicitud(solicitud)) {
            await _deleteSolicitudYAsociada(solicitud);
          }
        }
      });
    } catch (e) {
      _logger.e('Error eliminando solicitudes vencidas: $e');
    }
  }

  Future<List<SolicitudesPendientes>> _getSolicitudesEnviadas() {
    return state.isar!.solicitudesPendientes
        .filter()
        .isSendedEqualTo(true)
        .findAll();
  }

  bool _shouldDeleteSolicitud(SolicitudesPendientes solicitud) {
    if (solicitud.dateSended == null) return false;
    final daysPassed = DateTime.now().difference(solicitud.dateSended!).inDays;
    return daysPassed >= 12;
  }

  Future<void> _deleteSolicitudYAsociada(
    SolicitudesPendientes solicitud,
  ) async {
    final solicitudId = int.tryParse(solicitud.solicitudId ?? '0') ?? 0;

    final image = await state.isar?.imageModels
        .filter()
        .solicitudIdEqualTo(solicitudId)
        .findFirst();

    final solicitudDb = await state.isar?.solicitudesPendientes
        .filter()
        .solicitudIdEqualTo(solicitud.solicitudId)
        .findFirst();

    if (image != null) {
      await state.isar?.imageModels.delete(image.id);
    }

    if (solicitudDb != null) {
      await state.isar?.solicitudesPendientes.delete(solicitudDb.id);
    }

    log('Solicitud eliminada: ${solicitud.solicitudId}');
  }

  Future<void> getSolicitudes() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final solicitudes = await state.isar!.solicitudesPendientes
          .filter()
          .isSendedEqualTo(false)
          .findAll();
      // final solicitudes =
      //     await state.isar!.solicitudesPendientes.where().findAll();
      emit(state.copyWith(status: Status.done, solicitudes: solicitudes));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> getSolicitudesUploaded() async {
    emit(state.copyWith(status: Status.inProgress));
    await removeSolicitudWhenDateSendedIsMoreThanDateCreated();
    await Future.delayed(const Duration(seconds: 2));
    try {
      final solicitudes = await state.isar?.solicitudesPendientes
          .filter()
          .isSendedEqualTo(true)
          .findAll();

      emit(state.copyWith(
        solicitudes: solicitudes,
        status: Status.done,
      ));
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> getSolicitudesFailed() async {
    emit(state.copyWith(status: Status.inProgress));
    await Future.delayed(const Duration(seconds: 2));
    try {
      final solicitudes = await state.isar?.solicitudesPendientes
          .filter()
          .imagesSendedEqualTo(false)
          .and()
          .isSendedEqualTo(true)
          .findAll();

      emit(state.copyWith(
        solicitudes: solicitudes,
        status: Status.done,
      ));
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> getDepartamentos() async {
    // emit(state.copyWith(status: Status.inProgress));
    try {
      final departamentos =
          await state.isar!.departamentosDbLocals.where().findAll();
      emit(state.copyWith(departamentos: departamentos));
    } catch (e) {
      _logger.e(e);
      // emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> getComunidades() async {
    // emit(state.copyWith(status: Status.inProgress));
    try {
      final comunidades =
          await state.isar!.comunidadesLocalDbs.where().findAll();
      emit(state.copyWith(comunidades: comunidades));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<RecurrenteEstandarDbLocal?> getRecurrentEstandar(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
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

  Future<RecurrenteMigranteEconomicoDbLocal?> getRecurrentMigranteEconomico(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final migranteEconomico = await state
          .isar!.recurrenteMigranteEconomicoDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteMigranteEconomicoDbLocal: migranteEconomico,
      ));
      return migranteEconomico;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<MigranteEconomicoDbLocal?> getMigranteEconomico(
      int solicitudId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudId.toString()}');
      final migranteEconomico = await state.isar!.migranteEconomicoDbLocals
          .filter()
          .objSolicitudNuevamenorIdEqualTo(solicitudId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        migranteEconomicoDbLocal: migranteEconomico,
      ));
      return migranteEconomico;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<ImageModel?> getImagesModel(int solicitudRecurrenteId) async {
    // emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar?.imageModels
          .filter()
          .solicitudIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        // status: Status.done,
        imageModel: solicitud,
      ));
      log('Imagen 1: ${solicitud?.imagen1 ?? 'NO PATH'} ');
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<RecurrenteMiCrediEstudioDbLocal?> getRecurrentMiCrediEstudio(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.recurrenteMiCrediEstudioDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteMiCrediEstudioDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<RecurrenteMujerEmprendeDbLocal?> getRecurrentMujerEmprende(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.recurrenteMujerEmprendeDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteMujerEmprende: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<MejoraViviendaDbLocal?> getViviendaNueva(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.mejoraViviendaDbLocals
          .filter()
          .solicitudNuevamenorIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        mejoraViviendaDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<RecurrenteMejoraViviendaDbLocal?> getRecurrenteViviendaNueva(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.recurrenteMejoraViviendaDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteMejoraViviendaDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<SaneamientoDbLocal?> getSaneamientoNueva(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.saneamientoDbLocals
          .filter()
          .objSolicitudNuevamenorIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        saneamientoDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<RecurrenteSaneamientoDbLocal?> getSaneamientoRecurrente(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.recurrenteSaneamientoDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteSaneamientoDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<EnergiaLimpiaDbLocal?> getEnergiaLimpia(
      int solicitudRecurrenteId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.energiaLimpiaDbLocals
          .filter()
          .solicitudNuevamenorIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        energiaLimpiaDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<RecurrenteEnergiaLimpiaDbLocal?> getEnergiaLimpiaRecurrente(
    int solicitudRecurrenteId,
  ) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.recurrenteEnergiaLimpiaDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteEnergiaLimpiaDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<MujerEmprendeDbLocal?> getMujerEmprende(
    int solicitudRecurrenteId,
  ) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      log('Solicitud id: ${solicitudRecurrenteId.toString()}');
      final solicitud = await state.isar!.mujerEmprendeDbLocals
          .filter()
          .objSolicitudNuevamenorIdEqualTo(solicitudRecurrenteId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        mujerEmprendeDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<EstandarDbLocal?> getEstandar(int solicitudId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final estandar = await state.isar!.estandarDbLocals
          .filter()
          .objSolicitudNuevamenorIdEqualTo(solicitudId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        estandarDbLocal: estandar,
      ));
      log(estandar.toString());
      return estandar;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<MiCrediEstudioDbLocal?> getMiCrediEstudio(int solicitudId) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final solicitud = await state.isar!.miCrediEstudioDbLocals
          .filter()
          .objSolicitudNuevamenorIdEqualTo(solicitudId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        miCrediEstudioDbLocal: solicitud,
      ));
      return solicitud;
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }

  Future<List<int?>> getItemsRecurrents({required String typeProduct}) async {
    try {
      switch (typeProduct) {
        case 'ScrKivaMiCrediEstudioRecurrente':
          return await state.isar!.recurrenteMiCrediEstudioDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ScrKivaMiCrediEstudio':
          return await state.isar!.miCrediEstudioDbLocals
              .where()
              .objSolicitudNuevamenorIdProperty()
              .findAll();
        case 'ScrKivaCreditoEstandarRecurrente':
          return await state.isar!.recurrenteEstandarDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();

        case 'ScrKivaCreditoEstandar':
          return await state.isar!.estandarDbLocals
              .where()
              .objSolicitudNuevamenorIdProperty()
              .findAll();
        case 'ScrKivaMejoraViviendaRecurrente':
          return await state.isar!.recurrenteMejoraViviendaDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ScrKivaMejoraVivienda':
          return await state.isar!.mejoraViviendaDbLocals
              .where()
              .solicitudNuevamenorIdProperty()
              .findAll();
        case 'ScrKivaAguaSaneamientoRecurrente':
          return await state.isar!.recurrenteSaneamientoDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ScrKivaAguaSaneamiento':
          return await state.isar!.saneamientoDbLocals
              .where()
              .objSolicitudNuevamenorIdProperty()
              .findAll();
        case 'ScrKivaEnergiaLimpiaRecurrente':
          return await state.isar!.recurrenteEnergiaLimpiaDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ScrKivaEnergiaLimpia':
          return await state.isar!.energiaLimpiaDbLocals
              .where()
              .solicitudNuevamenorIdProperty()
              .findAll();
        case 'ScrKivaMujerEmprendeRecurrente':
          return await state.isar!.recurrenteMujerEmprendeDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ScrKivaMujerEmprende':
          return await state.isar!.mujerEmprendeDbLocals
              .where()
              .objSolicitudNuevamenorIdProperty()
              .findAll();
        case 'ScrKivaMigrantesEconomicos':
          return await state.isar!.migranteEconomicoDbLocals
              .where()
              .objSolicitudNuevamenorIdProperty()
              .findAll();
        case 'ESTANDAR COLONES NUEVO MENOR A MIL':
          return await state.isar!.migranteEconomicoDbLocals
              .where()
              .objSolicitudNuevamenorIdProperty()
              .findAll();
        case 'ScrKivaMigrantesEconomicosRecurrentes':
          return await state.isar!.recurrenteMigranteEconomicoDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
        case 'ESTANDAR COLONES RECURRENTE MENOR A MIL':
          return await state.isar!.recurrenteMigranteEconomicoDbLocals
              .where()
              .objSolicitudRecurrenteIdProperty()
              .findAll();
      }
      // emit(state.copyWith(status: Status.done));

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

  Future<void> saveImagesLocal({
    required ImageModel imageModel,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.imageModels.put(imageModel);
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

  Future<void> saveMigranteEconomicoForm({
    required MigranteEconomicoDbLocal migranteEconomicoDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.migranteEconomicoDbLocals
              .put(migranteEconomicoDbLocal);
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

  Future<void> saveRecurrentMigranteEconomico({
    required RecurrenteMigranteEconomicoDbLocal
        recurrenteMigranteEconomicoDbLocal,
  }) async {
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.recurrenteMigranteEconomicoDbLocals
              .put(recurrenteMigranteEconomicoDbLocal);
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
    // emit(state.copyWith(status: Status.inProgress));
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
      // emit(state.copyWith(status: Status.done));
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
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
    } catch (e) {
      _logger.e(e);
    }
    try {
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

  Future<void> saveActions({
    required List<ActionsModelDb> actions,
  }) async {
    try {
      await state.isar!.writeTxn(
        () {
          return state.isar!.actionsModelDbs.clear();
        },
      );
    } catch (e) {
      _logger.e(e);
    }
    try {
      final resp = await state.isar!.writeTxn(
        () {
          return state.isar!.actionsModelDbs.putAll(actions);
        },
      );
      _logger.i(resp);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> getActionsAsList() async {
    final actions = await state.isar!.actionsModelDbs.where().findAll();
    // if (state.isar != null) {
    // return;
    // if (actions!.isEmpty) return;

    final List<String> actionStrings =
        actions.map((e) => e.action ?? 'N/A').toList();
    emit(state.copyWith(actions: actionStrings));
    _logger.i(actionStrings.toString());
    // }
  }

  Future<void> removeWhenFormIsUpload(
      int solicitudId, String tipoProducto) async {
    try {
      switch (tipoProducto) {
        case 'ESTANDAR NUEVO':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.estandarDbLocals
                  .filter()
                  .objSolicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'ESTANDAR RECURRENTE':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteEstandarDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'MICREDIESTUDIO NUEVO':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.miCrediEstudioDbLocals
                  .filter()
                  .objSolicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'MICREDIESTUDIO RECURRENTE':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteMiCrediEstudioDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'VIVIENDA NUEVA':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.mejoraViviendaDbLocals
                  .filter()
                  .solicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'VIVIENDA REPRESTAMO':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteMejoraViviendaDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'AGUA Y SANEAMIENTO NUEVO':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.saneamientoDbLocals
                  .filter()
                  .objSolicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'AGUA Y SANEAMIENTO RECURRENTE':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteSaneamientoDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'ASER NUEVO':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.energiaLimpiaDbLocals
                  .filter()
                  .solicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'ASER RECURRENTE':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteEnergiaLimpiaDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'MUJER EMPRENDE NUEVO':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.mujerEmprendeDbLocals
                  .filter()
                  .objSolicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'MUJER EMPRENDE RECURRENTE':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteMujerEmprendeDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'ESTANDAR COLONES NUEVO MAYOR A MIL':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.migranteEconomicoDbLocals
                  .filter()
                  .objSolicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'ESTANDAR COLONES NUEVO MENOR A MIL':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.migranteEconomicoDbLocals
                  .filter()
                  .objSolicitudNuevamenorIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'ESTANDAR COLONES RECURRENTE MAYOR A MIL':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteMigranteEconomicoDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        case 'ESTANDAR COLONES RECURRENTE MENOR A MIL':
          await state.isar!.writeTxn(
            () async {
              return state.isar!.recurrenteMigranteEconomicoDbLocals
                  .filter()
                  .objSolicitudRecurrenteIdEqualTo(solicitudId)
                  .deleteAll();
            },
          );
          break;
        default:
      }
    } catch (e) {
      _logger.e(e);
    }
  }
}
