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

/// Resultado del Kiva de una solicitud creada offline al sincronizarla.
enum KivaSyncResultado {
  /// Formulario e imágenes enviados.
  enviado,

  /// Formulario enviado; las imágenes quedaron pendientes en el historial.
  enviadoSinImagenes,

  /// La solicitud es Kiva pero no hay formulario local: nada que enviar.
  sinFormulario,

  /// El formulario no llegó al backend. Queda en el historial y se reintenta
  /// en la próxima sincronización.
  fallido,
}

Future<KivaSyncResultado> processSolicitud({
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
  if (solicitud == null) return KivaSyncResultado.sinFormulario;

  final fila = SolicitudesPendientes()
    ..solicitudId = solicitudId
    ..numero = numeroSolicitud
    ..producto = tipoProducto
    ..cedula = cedula
    ..nombreFormulario = nombreFomularioKiva
    ..tipoSolicitud = tipoSolicitudId.toTypeFormId()
    ..tipoSolicitudId = tipoSolicitudId
    ..solicitudCreditoUuid = uuid
    ..isSended = true
    ..dateSended = DateTime.now()
    ..nombre = nombreCliente
    ..fecha = DateTime.now();

  return _enviarKivaYGuardar(
    solicitud: solicitud,
    fila: fila,
    kivaRepository: kivaRepository,
    kivaProvider: kivaProvider,
  );
}

/// Reenvía los Kivas de la sincronización cuyo formulario no llegó al backend
/// (filas con `formSended == false` y uuid). Devuelve un mensaje por cada uno
/// que sigue pendiente.
Future<List<String>> reintentarKivasSyncPendientes({
  required ResponsesRepository kivaRepository,
  required SolicitudesPendientesLocalDbCubit kivaProvider,
}) async {
  final pendientes = await kivaProvider.getKivasSyncPendientes();
  final errores = <String>[];
  for (final fila in pendientes) {
    final numero = fila.numero ?? '';
    try {
      final solicitud = await kivaProvider.getKivaByNumeroSolicitud(
        uuid: fila.solicitudCreditoUuid ?? '',
        tipoProducto: fila.producto ?? '',
        solicitudId: fila.solicitudId ?? '',
      );
      if (solicitud == null) {
        // El formulario ya no está en el teléfono: no hay nada que reenviar.
        log('Kiva pendiente $numero sin formulario local; se descarta.');
        fila.formSended = null;
        await kivaProvider.guardarResultadoKivaSync(solicitud: fila);
        continue;
      }
      final resultado = await _enviarKivaYGuardar(
        solicitud: solicitud,
        fila: fila,
        kivaRepository: kivaRepository,
        kivaProvider: kivaProvider,
      );
      if (resultado == KivaSyncResultado.fallido) {
        errores.add(
          'El formulario Kiva de la solicitud No. $numero sigue sin enviarse. '
          'Se reintentará en la próxima sincronización o desde Historial Kiva.',
        );
      }
    } catch (e) {
      log('Error reintentando Kiva $numero: $e');
      errores.add(
        'El formulario Kiva de la solicitud No. $numero sigue sin enviarse.',
      );
    }
  }
  return errores;
}

/// Envía el formulario y, si sale bien, las imágenes. Siempre deja la fila
/// del historial con el estado real (`formSended`, `imagesSended`).
Future<KivaSyncResultado> _enviarKivaYGuardar({
  required dynamic solicitud,
  required SolicitudesPendientes fila,
  required ResponsesRepository kivaRepository,
  required SolicitudesPendientesLocalDbCubit kivaProvider,
}) async {
  final solicitudId = fila.solicitudId ?? '';
  final tipoSolicitudId = fila.tipoSolicitudId ?? 0;

  bool formOk = false;
  try {
    final (isOk, msg) = await sendSolicitudKiva(
      solicitud: solicitud,
      kivaRepository: kivaRepository,
      tipoSolicitudId: tipoSolicitudId,
    );
    formOk = isOk;
    if (!isOk) log('Error al enviar formulario Kiva de $solicitudId: $msg');
  } catch (e) {
    log('Error al enviar formulario Kiva de $solicitudId: $e');
  }

  fila.formSended = formOk;
  if (formOk) fila.formSendedAt = DateTime.now();

  // Las imágenes solo se suben con el formulario ya aceptado. Si no hay
  // imágenes locales o la subida falla, queda imagesSended = false para que
  // aparezca en "Kivas fallidos" y no se purgue.
  if (formOk && !fila.imagesSended) {
    final imagesModel =
        await kivaProvider.getImageModelSolicitudCredito(solicitudId);
    if (imagesModel != null) {
      fila.imagesSended = await proccessImagesSolicitud(
        imageModel: imagesModel,
        kivaRepository: kivaRepository,
        solicitudId: solicitudId,
        nombreFomularioKiva: fila.nombreFormulario ?? '',
        numeroSolicitud: fila.numero ?? '',
        cedula: fila.cedula ?? '',
        tipoSolicitudId: tipoSolicitudId,
      );
    }
  }

  try {
    await kivaProvider.guardarResultadoKivaSync(solicitud: fila);
  } catch (e) {
    log('Error al guardar la solicitud pendiente localmente: $e');
  }

  if (!formOk) return KivaSyncResultado.fallido;
  return fila.imagesSended
      ? KivaSyncResultado.enviado
      : KivaSyncResultado.enviadoSinImagenes;
}

/// Devuelve `true` solo si el servidor confirmó la subida de las imágenes.
Future<bool> proccessImagesSolicitud({
  required ImageModel imageModel,
  required ResponsesRepository kivaRepository,
  required String solicitudId,
  required String nombreFomularioKiva,
  required String numeroSolicitud,
  required String cedula,
  required int tipoSolicitudId,
}) async {
  try {
    final (isOk, msg) = await kivaRepository.uploadUserFiles(
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
    if (!isOk) log('Error al subir imágenes Kiva de $solicitudId: $msg');
    return isOk;
  } catch (e) {
    log('Error al subir imágenes Kiva de $solicitudId: $e');
    return false;
  }
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
