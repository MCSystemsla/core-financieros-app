import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/recurrente_agua_y_saneamiento.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/recurrente_micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/recurrente_mujer_emprende.dart';
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
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';

extension EstandarDbLocalMapper on EstandarDbLocal {
  EstandarModel toEstandarModel({required int tipoSolicitudId}) {
    return EstandarModel(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      objSolicitudNuevamenorId: int.tryParse(solicitudId ?? '0') ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objOrigenCatalogoValorId: objOrigenCatalogoValorId ?? '',
      personasCargo: personasCargo ?? 0,
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      inicioNegocio: DateTime.tryParse(inicioNegocio.toString()) ??
          DateTime.now(), // fallback
      apoyanNegocio: apoyanNegocio ?? false,
      cuantosApoyan: cuantosApoyan ?? '',
      publicitarNegocio: publicitarNegocio ?? '',
      negocioProximosAnios: negocioProximosAnios ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      comoMejoraVida: comoMejoraVida ?? '',
      planesFuturo: planesFuturo ?? '',
      otrosDatosCliente: otrosDatosCliente ?? '',
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
    );
  }
}

extension RecurrenteEstandarModelMapper on RecurrenteEstandarDbLocal {
  RecurrenteEstandarModel toRecurrenteEstandarModel({
    required int tipoSolicitudId,
  }) {
    return RecurrenteEstandarModel(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      personasCargo: personasCargo ?? 0,
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      apoyanNegocio: apoyanNegocio ?? false,
      cuantosApoyan: cuantosApoyan ?? '',
      objSolicitudRecurrenteId: int.tryParse(solicitudId ?? '0') ?? 0,
      coincideRespuesta: coincideRespuesta ?? false,
      explicacionInversion: explicacionInversion ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      comoFortalece: comoFortalece ?? '',
      siguientePaso: siguientePaso ?? '',
      personaAutoSuficiente: personaAutoSuficiente ?? '',
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      comoMejoraEntorno: comoMejoraEntorno ?? '',
    );
  }
}

extension MejoraViviendaModelMapper on MejoraViviendaDbLocal {
  MejoraViviendaAnswer toMejoraViviendaModel({
    required int tipoSolicitudId,
  }) {
    return MejoraViviendaAnswer(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      solicitudNuevamenorId: int.tryParse(solicitudId ?? '0') ?? 0,
      username: '',
      tieneTrabajo: tieneTrabajo ?? false,
      database: LocalStorage().database,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objOrigenCatalogoValorId: objOrigenCatalogoValorId ?? '',
      objTipoComunidadId: objTipoComunidadId ?? '',
      necesidadesComunidad: necesidadesComunidad ?? '',
      personasCargo: personasCargo ?? '',
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      comoAyudara: comoAyudara ?? '',
      planesFuturo: planesFuturo ?? '',
      otrosDatosCliente: otrosDatosCliente ?? '',
    );
  }
}

extension RecurrenteMejoraViviendaModelMapper
    on RecurrenteMejoraViviendaDbLocal {
  MejoraViviendaRecurrente toRecurrenteMejoraViviendaModel({
    required int tipoSolicitudId,
  }) {
    return MejoraViviendaRecurrente(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      objSolicitudRecurrenteId: int.tryParse(solicitudId ?? '0') ?? 0,
      username: username ?? '',
      tieneTrabajo: tieneTrabajo ?? false,
      database: LocalStorage().database,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objTipoComunidadId: objTipoComunidadId ?? '',
      necesidadesComunidad: necesidadesComunidad ?? '',
      personasCargo: personasCargo ?? '',
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      coincideRespuesta: coincideRespuesta ?? false,
      explicacionInversion: explicacionInversion ?? '',
      viviendaAntesDespues: viviendaAntesDespues ?? '',
      mejoraSeguridadFamilia: mejoraSeguridadFamilia ?? '',
      quienApoya: quienApoya ?? '',
      siguienteMeta: siguienteMeta ?? '',
    );
  }
}

extension MicrediEstudioModelExtension on MiCrediEstudioDbLocal {
  MiCrediEstudioModel toMicrediEstudioModel({
    required int tipoSolicitudId,
  }) {
    return MiCrediEstudioModel(
      tipoSolitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      objSolicitudNuevamenorId: int.tryParse(solicitudId ?? '0') ?? 0,
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objOrigenCatalogoValorId: objOrigenCatalogoValorId ?? '',
      personasCargo: personasCargo ?? 0,
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      carrera: carrera ?? '',
      tiempoCarrera: tiempoCarrera ?? 0,
      universidad: universidad ?? '',
      motivoCarrera: motivoCarrera ?? '',
      relizandoProfesionalmente: relizandoProfesionalmente ?? false,
      explicacionRelizandoProfesionalmente:
          explicacionRelizandoProfesionalmente ?? '',
      quienApoya: quienApoya ?? '',
      ocupacionPadres: ocupacionPadres ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      comoAyudaCrecer: comoAyudaCrecer ?? '',
      optarOtroEstudio: optarOtroEstudio ?? false,
      cualEstudio: cualEstudio ?? '',
      planFuturo: planFuturo ?? '',
      aspiraLaboralmente: aspiraLaboralmente ?? '',
      otrosDatosCliente: otrosDatosCliente ?? '',
    );
  }
}

extension RecurrenteMicrediEstudioModelMapper
    on RecurrenteMiCrediEstudioDbLocal {
  RecurrenteMiCrediEstudioModel toRecurrenteMicrediEstudioModel({
    required int tipoSolicitudId,
  }) {
    return RecurrenteMiCrediEstudioModel(
      tipoSolicitud: tipoSolicitud ?? tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      personasCargo: personasCargo ?? 0,
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      carrera: carrera ?? '',
      tiempoCarrera: tiempoCarrera ?? 0,
      universidad: universidad ?? '',
      quienApoya: quienApoya ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      comoAyudaCrecer: comoAyudaCrecer ?? '',
      objSolicitudRecurrenteId: int.tryParse(solicitudId ?? '0') ?? 0,
      coincideRespuesta: false,
      explicacionInversion: explicacionInversion ?? '',
      comoAyudoProfesionalmente: comoAyudoProfesionalmente ?? '',
      siguientePaso: siguientePaso ?? '',
      alcanzaraMeta: alcanzaraMeta ?? false,
      explicacionAlcanzaraMeta: explicacionAlcanzaraMeta ?? '',
    );
  }
}

extension MujerEmprendeModelMapper on MujerEmprendeDbLocal {
  MujerEmprendeModel toMujerEmprendeModel({
    required int tipoSolicitudId,
  }) {
    return MujerEmprendeModel(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      objSolicitudNuevamenorId: int.tryParse(solicitudId ?? '0') ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objOrigenCatalogoValorId: objOrigenCatalogoValorId ?? '',
      personasCargo: personasCargo ?? 0,
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      motivoEmprender: motivoEmprender ?? '',
      conocioMujerEmprende: conocioMujerEmprende ?? '',
      impulsoOptar: impulsoOptar ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      quienApoya: quienApoya ?? ' ',
      comoImpactariaNegocio: comoImpactariaNegocio ?? '',
      comoMejoraCalidadVida: comoMejoraCalidadVida ?? '',
      otrosDatosCliente: otrosDatosCliente ?? '',
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
    );
  }
}

extension RecurrenteMujerEmprendeModelMapper on RecurrenteMujerEmprendeDbLocal {
  RecurrenteMujerEmprendeModel toRecurrenteMujerEmprendeModel({
    required int tipoSolicitudId,
  }) {
    return RecurrenteMujerEmprendeModel(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      objSolicitudRecurrenteId: int.tryParse(solicitudId ?? '0') ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      personasCargo: personasCargo ?? 0,
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      coincideRespuesta: coincideRespuesta ?? false,
      explicacionInversion: explicacionInversion ?? '',
      comoAyudo: comoAyudo ?? '',
      apoyanNegocio: apoyanNegocio ?? false,
      cuantosApoyan: cuantosApoyan ?? '',
      mejoraraEntorno: mejoraraEntorno ?? false,
      mejoraraEntornoExplicacion: mejoraraEntornoExplicacion ?? '',
      siguientePaso: siguientePaso ?? '',
      alcanzaraMeta: alcanzaraMeta ?? false,
      explicacionAlcanzaraMeta: explicacionAlcanzaraMeta ?? '',
      tieneTrabajo: tieneTrabajo ?? false,
      tieneTrabajoDescripcion: tieneTrabajoDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
    );
  }
}

extension SaneamientoModelMapper on SaneamientoDbLocal {
  AguaSaneamientoModel toAguaSaneamientoModel({
    required int tipoSolicitudId,
  }) {
    return AguaSaneamientoModel(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      objSolicitudNuevamenorId: int.tryParse(solicitudId ?? '0') ?? 0,
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objOrigenCatalogoValorId: objOrigenCatalogoValorId ?? '',
      personasCargo: personasCargo ?? '',
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      motivacionCredito: motivacionCredito ?? '',
      importanciaMejorarCondiciones: importanciaMejorarCondiciones ?? '',
      cumpliriaPropuesta: cumpliriaPropuesta ?? false,
      explicacionCumpliriaPropuesta: explicacionCumpliriaPropuesta ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      mejoraCalidadVida: mejoraCalidadVida ?? '',
      siguienteProyectoCalidadVida: siguienteProyectoCalidadVida ?? '',
      metasProximas: metasProximas ?? '',
      otrosDatosCliente: otrosDatosCliente ?? '',
    );
  }
}

extension RecurrenteSaneamientoModelMapper on RecurrenteSaneamientoDbLocal {
  RecurrenteAguaSaneamientoModel toAguaSaneamientoRecurrenteModel({
    required int tipoSolicitudId,
  }) {
    return RecurrenteAguaSaneamientoModel(
      database: LocalStorage().database,
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      personasCargo: personasCargo ?? '',
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      otrosDatosCliente: otrosDatosCliente ?? '',
      objSolicitudRecurrenteId: int.tryParse(solicitudId ?? '0') ?? 0,
      coincideRespuesta: coincideRespuesta ?? false,
      explicacionInversion: explicacionInversion ?? '',
      comoAyudoCondiciones: comoAyudoCondiciones ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      comoMejoraCondicionesEntorno: comoMejoraCondicionesEntorno ?? '',
      quienApoya: quienApoya ?? '',
      siguientePaso: siguientePaso ?? '',
      alcanzaraMeta: alcanzaraMeta ?? false,
      explicacionAlcanzaraMeta: explicacionAlcanzaraMeta ?? '',
    );
  }
}

extension EnergiaLimpiaModelMapper on EnergiaLimpiaDbLocal {
  EnergiaLimpiaModel toEnergiaLimpiaModel({
    required int tipoSolicitudId,
  }) {
    return EnergiaLimpiaModel(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      solicitudNuevamenorId: int.tryParse(solicitudId ?? '0') ?? 0,
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objOrigenCatalogoValorId: objOrigenCatalogoValorId ?? '',
      objTipoComunidadId: objTipoComunidadId ?? '',
      tieneProblemasEnergia: tieneProblemasEnergia ?? false,
      personasCargo: personasCargo ?? '',
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      planesFuturo: planesFuturo ?? '',
      otrosDatosCliente: otrosDatosCliente ?? '',
      problemasEnergiaDescripcion: problemasEnergiaDescripcion ?? '',
    );
  }
}

extension RecurrenteEnergiaLimpiaModelMapper on RecurrenteEnergiaLimpiaDbLocal {
  RecurrenteEnergiaLimpiaModel toRecurrenteEnergiaLimpiaModel({
    required int tipoSolicitudId,
  }) {
    return RecurrenteEnergiaLimpiaModel(
      tipoSolicitud: tipoSolicitudId.toTypeFormId(),
      database: LocalStorage().database,
      tieneTrabajo: tieneTrabajo ?? false,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? '',
      tiempoActividad: tiempoActividad ?? 0,
      otrosIngresos: otrosIngresos ?? false,
      otrosIngresosDescripcion: otrosIngresosDescripcion ?? '',
      objTipoComunidadId: objTipoComunidadId ?? '',
      tieneProblemasEnergia: tieneProblemasEnergia ?? false,
      personasCargo: personasCargo ?? '',
      numeroHijos: numeroHijos ?? 0,
      edadHijos: edadHijos ?? '',
      tipoEstudioHijos: tipoEstudioHijos ?? '',
      motivoPrestamo: motivoPrestamo ?? '',
      objSolicitudRecurrenteId: int.tryParse(solicitudId ?? '0') ?? 0,
      coincideRespuesta: coincideRespuesta ?? false,
      explicacionInversion: explicacionInversion ?? '',
      situacionAntesAhora: situacionAntesAhora ?? '',
      comoMejoraSituacion: comoMejoraSituacion ?? '',
      quienApoya: quienApoya ?? '',
      siguienteMeta: siguienteMeta ?? '',
      problemasEnergiaDescripcion: problemasEnergiaDescripcion ?? '',
    );
  }
}
