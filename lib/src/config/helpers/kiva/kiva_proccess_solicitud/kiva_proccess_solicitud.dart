import 'dart:developer';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
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
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/kiva/kiva_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';

import '../../../../datasource/local_db/solicitudes_pendientes.dart';

Future<bool> processSolicitud({
  required String uuid,
  required String numeroSolicitud,
  required String solicitudId,
  required String tipoProducto,
  required int tipoSolicitudId,
  required String nombreFomularioKiva,
  required String cedula,
  required ResponsesRepository kivaRepository,
  required SolicitudesPendientesLocalDbCubit kivaProvider,
  required String nombreCliente,
}) async {
  await kivaProvider.setNumeroSolicitudAndSolicitudIdWhenSolicitudCreditoIsKiva(
    uuid,
    numeroSolicitud,
    solicitudId,
    tipoProducto,
    tipoSolicitudId,
  );

  final solicitud = await kivaProvider.getKivaByNumeroSolicitud(
    uuid: uuid,
    tipoProducto: tipoProducto,
    solicitudId: solicitudId,
  );
  if (solicitud == null) {
    return true;
  }

  final (isOk, msg) = await sendSolicitudKiva(
    solicitud: solicitud,
    kivaRepository: kivaRepository,
    tipoSolicitudId: tipoSolicitudId,
  );

  if (isOk) {
    final imagesModel =
        await kivaProvider.getImageModelSolicitudCredito(solicitudId);
    if (imagesModel != null) {
      await proccessImagesSolicitud(
        imageModel: imagesModel,
        kivaRepository: kivaRepository,
        solicitudId: solicitudId,
        nombreFomularioKiva: nombreFomularioKiva,
        numeroSolicitud: numeroSolicitud,
        cedula: cedula,
        tipoSolicitudId: tipoSolicitudId,
      );
    }
    try {
      final nuevaSolicitudPendente = SolicitudesPendientes()
        ..solicitudId = solicitudId
        ..numero = numeroSolicitud
        ..producto = tipoProducto
        ..cedula = cedula
        ..nombreFormulario = nombreFomularioKiva
        ..tipoSolicitud = tipoSolicitudId.toTypeFormId()
        ..isSended = true
        ..dateSended = DateTime.now()
        ..nombre = nombreCliente
        ..imagesSended = true
        ..fecha = DateTime.now();

      await kivaProvider.saveSolicitudPendente(
        solicitud: nuevaSolicitudPendente,
      );
    } catch (e) {
      log('Error al guardar la solicitud pendiente localmente: $e');
    }
  }
  return isOk;
}

Future<void> proccessImagesSolicitud({
  required ImageModel imageModel,
  required ResponsesRepository kivaRepository,
  required String solicitudId,
  required String nombreFomularioKiva,
  required String numeroSolicitud,
  required String cedula,
  required int tipoSolicitudId,
}) async {
  await kivaRepository.uploadUserFiles(
    imagen1: imageModel.imagen1 ?? 'No path',
    imagen2: imageModel.imagen2 ?? 'No path',
    imagen3: imageModel.imagen3 ?? 'No path',
    fotoFirma: imageModel.imagenFirma ?? 'No path',
    solicitudId: int.tryParse(solicitudId) ?? 0,
    formularioKiva: nombreFomularioKiva,
    database: LocalStorage().database,
    tipoSolicitud: tipoSolicitudId.toTypeFormId(),
    numero: numeroSolicitud,
    cedula: cedula,
    typeSigner: (imageModel.typeSigner ?? '') == 'cliente'
        ? TypeSigner.cliente
        : TypeSigner.asesor,
  );
}

Future<(bool isOk, String msg)> sendSolicitudKiva({
  required dynamic solicitud,
  required ResponsesRepository kivaRepository,
  required int tipoSolicitudId,
}) async {
  return switch (solicitud) {
    EstandarDbLocal() => await kivaRepository.estandar(
        estandarModel:
            solicitud.toEstandarModel(tipoSolicitudId: tipoSolicitudId),
      ),
    RecurrenteEstandarDbLocal() => await kivaRepository.recurrenteEstandar(
        recurrenteEstandarModel: solicitud.toRecurrenteEstandarModel(
            tipoSolicitudId: tipoSolicitudId),
      ),
    MejoraViviendaDbLocal() => await kivaRepository.mejoraViviendaAnswer(
        mejoraVivienda: solicitud.toMejoraViviendaModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    RecurrenteMejoraViviendaDbLocal() =>
      await kivaRepository.mejoraViviendaRecurrenteAnswer(
        mejoraViviendaRecurrente: solicitud.toRecurrenteMejoraViviendaModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    MiCrediEstudioDbLocal() => await kivaRepository.miCrediEstudioAnswer(
        miCrediEstudioModel: solicitud.toMicrediEstudioModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    RecurrenteMiCrediEstudioDbLocal() =>
      await kivaRepository.recurrenteMiCrediEstudioAnswer(
        recurrenteMiCrediEstudioModel:
            solicitud.toRecurrenteMicrediEstudioModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    MujerEmprendeDbLocal() => await kivaRepository.mujerEmprendeAnswer(
        mujerEmprendeModel: solicitud.toMujerEmprendeModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    RecurrenteMujerEmprendeDbLocal() =>
      await kivaRepository.recurrenteMujerEmprendeAnswer(
        recurrenteMujerEmprendeModel: solicitud.toRecurrenteMujerEmprendeModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    SaneamientoDbLocal() => await kivaRepository.aguaYSaneamientoAnswer(
        aguaSaneamientoModel: solicitud.toAguaSaneamientoModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    RecurrenteSaneamientoDbLocal() =>
      await kivaRepository.recurrenteAguaYSaneamientoAnswer(
        recurrenteAguaSaneamientoModel:
            solicitud.toAguaSaneamientoRecurrenteModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    EnergiaLimpiaDbLocal() => await kivaRepository.energiaLimpia(
        energiaLimpiaModel: solicitud.toEnergiaLimpiaModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    RecurrenteEnergiaLimpiaDbLocal() =>
      await kivaRepository.recurrenteREnergiaLimpiaAnswer(
        energiaLimpiaModel: solicitud.toRecurrenteEnergiaLimpiaModel(
          tipoSolicitudId: tipoSolicitudId,
        ),
      ),
    _ => throw UnsupportedError(
        'Solicitud de tipo ${solicitud.runtimeType} no soportado en el envío automático.',
      ),
  };
}
