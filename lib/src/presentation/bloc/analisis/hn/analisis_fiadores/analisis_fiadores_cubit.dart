import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/services/pdf/images_to_pdf_service.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/local_db/analisis_fiador_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/expediente_digital/expediente_digital_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'analisis_fiadores_state.dart';

class AnalisisFiadoresCubit extends Cubit<AnalisisFiadoresState> {
  final AnalisisRepositoryHn _repository;
  final ExpedienteDigitalRepository _expedienteRepository;
  AnalisisFiadoresCubit(this._repository, this._expedienteRepository)
      : super(AnalisisFiadoresInitial());

  Future<void> createAnalisisFiador() async {
    final fiador = buildFiador();
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.createAnalisisFiador(
        analisisFiadoresHn: fiador,
      );
      if (resp.data.id.isEmpty) {
        emit(state.copyWith(
          status: Status.error,
          errorMsg:
              'El servidor no devolvió el ID del fiador, no se puede registrar la firma.',
        ));
        return;
      }
      emit(state.copyWith(fiadorId: resp.data.id));
      await fiadoresEnviarFirmaDigital();
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  /// Guarda el fiador en ObjectBox para enviarlo después desde
  /// `FiadoresHnPendientesScreen`. Copia las fotos de la cédula y la firma a
  /// `fiadores_hn/<uuid>/`. No hace ninguna llamada HTTP.
  Future<void> guardarFiadorLocal() async {
    emit(state.copyWith(status: Status.inProgress));
    Directory? filesDir;
    try {
      final localDb = global<AnalisisBoxServiceHn>();
      final userId = LocalStorage().userId;
      final fiador = buildFiador();

      if (localDb.existsFiadorHnPendiente(
        numeroSolicitud: fiador.numeroSolicitud,
        cedula: fiador.cedula,
        userId: userId,
      )) {
        emit(state.copyWith(
          status: Status.error,
          errorMsg:
              'Ya hay un fiador pendiente con esta cédula en esta solicitud',
        ));
        return;
      }

      final archivos = [
        state.cedulaFrontPath,
        state.cedulaBackPath,
        state.firmaFiador,
      ];
      if (archivos.any((path) => path.isEmpty || !File(path).existsSync())) {
        emit(state.copyWith(
          status: Status.error,
          errorMsg:
              'Faltan las fotos de la cédula o la firma del fiador. Vuelve a tomarlas.',
        ));
        return;
      }

      final uuid = const Uuid().v4();
      final dir = await getApplicationDocumentsDirectory();
      filesDir = Directory('${dir.path}/fiadores_hn/$uuid');
      await filesDir.create(recursive: true);
      final cedulaFront = await File(state.cedulaFrontPath)
          .copy('${filesDir.path}/cedula_frente.jpg');
      final cedulaBack = await File(state.cedulaBackPath)
          .copy('${filesDir.path}/cedula_reverso.jpg');
      final firma =
          await File(state.firmaFiador).copy('${filesDir.path}/firma.png');

      localDb.saveFiadorHnPendiente(
        AnalisisFiadorHnLocalDb(
          uuid: uuid,
          numeroSolicitud: fiador.numeroSolicitud,
          userId: userId,
          tipoFiadorCodigo: fiador.tipoFiadorCodigo,
          nombreCompleto: [
            fiador.nombre1,
            fiador.nombre2,
            fiador.apellido1,
            fiador.apellido2,
          ].where((n) => n.trim().isNotEmpty).join(' '),
          cedula: fiador.cedula,
          fechaGuardado: DateTime.now(),
          payloadJson: json.encode(fiador.toJson()),
          cedulaFrontPath: cedulaFront.path,
          cedulaBackPath: cedulaBack.path,
          firmaPath: firma.path,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      if (filesDir != null && await filesDir.exists()) {
        await filesDir.delete(recursive: true);
      }
      emit(state.copyWith(
        status: Status.error,
        errorMsg: 'No se pudo guardar el fiador en el teléfono: $e',
      ));
    }
  }

  /// Arma el body con los totales calculados.
  AnalisisFiadoresHn buildFiador() {
    final totalIngresosFamiliares =
        state.salarioNetoCordoba + state.otrosIngresosCordoba;
    final ganaciasNegocio =
        state.ventaNegocio - state.costoVenta - state.gastosOperativos;
    final saldoDisponible = totalIngresosFamiliares +
        ganaciasNegocio +
        state.otrosIngresos -
        state.consumoFamiliar;

    return AnalisisFiadoresHn(
      database: state.database,
      numeroSolicitud: state.numeroSolicitud,
      nombre1: state.nombre1,
      nombre2: state.nombre2,
      apellido1: state.apellido1,
      apellido2: state.apellido2,
      fechaNacimiento: DateTime.tryParse(state.fechaNacimiento),
      cedula: state.cedula,
      telefono: state.telefono,
      celular: state.celular,
      direccion: state.direccion,
      barrioCasa: state.barrioCasa,
      municipioCodigo: state.municipioCodigo,
      departamentoCodigo: state.departamentoCodigo,
      paisCodigo: state.paisCodigo,
      email: state.email,
      sexoCodigo: state.sexoCodigo,
      estadoCivilCodigo: state.estadoCivilCodigo,
      relacionClienteCodigo: state.relacionClienteCodigo,
      esAsalariado: state.esAsalariado,
      empresa: state.empresa,
      cargo: state.cargo,
      tiempoLaborar: state.tiempoLaborar,
      esEmpresario: state.esEmpresario,
      actividadCodigo: state.actividadCodigo,
      tiempoActividad: state.tiempoActividad,
      direccionTrabajo: state.direccionTrabajo,
      barrioTrabajo: state.barrioTrabajo,
      telefonoTrabajo: state.telefonoTrabajo,
      lugarTrabajoAnterior: state.lugarTrabajoAnterior,
      personasACargo: state.personasACargo,
      cantidadDependientes: state.cantidadDependientes,
      tieneDocumentosDomicilio: state.tieneDocumentosDomicilio,
      tipoDomicilioCodigo: state.tipoDomicilioCodigo,
      duenoVivienda: state.duenoVivienda,
      pagoAlquiler: state.pagoAlquiler,
      profesion: state.profesion,
      anosVivirDomicilio: state.anosVivirDomicilio,
      nombreFamiliarCercano: state.nombreFamiliarCercano,
      parentescoFamiliarCercanoCodigo: state.parentescoFamiliarCercanoCodigo,
      direccionFamiliarCercano: state.direccionFamiliarCercano,
      telefonoFamiliarCercano: state.telefonoFamiliarCercano,
      salarioNetoCordoba: state.salarioNetoCordoba,
      otrosIngresosCordoba: state.otrosIngresosCordoba,
      totalIngresosFamiliares: totalIngresosFamiliares,
      ventaNegocio: state.ventaNegocio,
      costoVenta: state.costoVenta,
      gastosOperativos: state.gastosOperativos,
      gananciaNegocio: ganaciasNegocio,
      otrosIngresos: state.otrosIngresos,
      fuenteOtrosIngresos: state.fuenteOtrosIngresos,
      consumoFamiliar: state.consumoFamiliar,
      saldoDisponible: saldoDisponible.toInt(),
      activo: state.activo,
      sucursal: state.sucursal,
      usuarioCreacion: state.usuarioCreacion,
      maquinaCreacion: state.maquinaCreacion,
      tipoDocumentoCodigo: state.tipoDocumentoCodigo,
      esFirmaDigitalFiador: state.esFirmaDigitalFiador,
      rtn: state.rtn,
      aldeaCodigo: state.aldeaCodigo,
      caserioCasa: state.caserioCasa,
      tipoFiadorCodigo: state.tipoFiadorCodigo,
      escolaridadCodigo: state.escolaridadCodigo,
      ocupacionCodigo: state.ocupacionCodigo,
      profesionCodigo: state.profesionCodigo,
      paisNacimientoCodigo: state.paisNacimientoCodigo,
      fechaEmisionCedula: DateTime.tryParse(state.fechaEmisionCedula),
      fechaVencimientoCedula: DateTime.tryParse(state.fechaVencimientoCedula),
      nacionalidad1Codigo: state.nacionalidad1Codigo,
      nacionalidad2Codigo: state.nacionalidad2Codigo,
      nacionalidad3Codigo: state.nacionalidad3Codigo,
      cantidadHijos: state.cantidadHijos,
      tipoViviendaCodigo: state.tipoViviendaCodigo,
      tipoPersonaCnbsCodigo: state.tipoPersonaCnbsCodigo,
      estatusCodigo: state.estatusCodigo,
      tipoClienteCodigo: state.tipoClienteCodigo,
      actividadEconomicaCnbs1Codigo: state.actividadEconomicaCnbs1Codigo,
      actividadEconomicaDescripcion1: state.actividadEconomicaDescripcion1,
      actividadEconomicaCnbs2Codigo: state.actividadEconomicaCnbs2Codigo,
      actividadEconomicaDescripcion2: state.actividadEconomicaDescripcion2,
      actividadEconomicaCnbs3Codigo: state.actividadEconomicaCnbs3Codigo,
      actividadEconomicaDescripcion3: state.actividadEconomicaDescripcion3,
      ejerceApnfd: state.ejerceApnfd,
      nombreNegocio: state.nombreNegocio,
      tiempoNegocio: state.tiempoNegocio,
      nivelAproximadoIngresosCodigo: state.nivelAproximadoIngresosCodigo,
      puesto: state.puesto,
      condicionLocalCodigo: state.condicionLocalCodigo,
      horarioVisita: state.horarioVisita,
      horarioTrabajo: state.horarioTrabajo,
      paisOcupacionCodigo: state.paisOcupacionCodigo,
      departamentoOcupacionCodigo: state.departamentoOcupacionCodigo,
      municipioOcupacionCodigo: state.municipioOcupacionCodigo,
      aldeaOcupacionCodigo: state.aldeaOcupacionCodigo,
      caserioOcupacion: state.caserioOcupacion,
      celularOcupacion: state.celularOcupacion,
      historialCredito: state.historialCredito,
    );
  }

  void onFieldChanged(AnalisisFiadoresState Function() copyWithFn) {
    emit(copyWithFn());
    // autoSaveHelper.trigger();
  }

  void setRelacionCliente(String? tipoFiadorCodigo, int numeroSolicitud) {
    emit(state.copyWith(
      tipoFiadorCodigo: tipoFiadorCodigo,
      numeroSolicitud: numeroSolicitud,
    ));
  }

  void createHistorialCredito({required HistorialCredito historialCredito}) {
    emit(
      state.copyWith(
        historialCredito: [...state.historialCredito, historialCredito],
      ),
    );
  }

  void editHistorialCredito({required HistorialCredito historialCredito}) {
    emit(
      state.copyWith(
        historialCredito: state.historialCredito
            .map((e) => e.uuid == historialCredito.uuid ? historialCredito : e)
            .toList(),
      ),
    );
  }

  void deleteHistorialCredito({required String uuid}) {
    emit(
      state.copyWith(
        historialCredito: state.historialCredito.where((e) {
          return e.uuid != uuid;
        }).toList(),
      ),
    );
  }

  Future<void> fiadoresEnviarFirmaDigital() async {
    if (state.fiadorId.isEmpty) {
      emit(state.copyWith(
        status: Status.error,
        firmaStatus: Status.error,
        errorMsg:
            'No se encontró el ID del fiador, no se puede enviar la firma.',
      ));
      return;
    }
    if (state.firmaFiador.isEmpty || !File(state.firmaFiador).existsSync()) {
      emit(state.copyWith(
        status: Status.error,
        firmaStatus: Status.error,
        errorMsg:
            'No se encontró la firma del fiador en el dispositivo. Vuelve a firmar.',
      ));
      return;
    }
    emit(state.copyWith(
        status: Status.inProgress, firmaStatus: Status.inProgress));
    try {
      final (isOk, message) = await _repository.fiadoresEnviarFirmaDigital(
        idFiador: state.fiadorId,
        firmaFiador: state.firmaFiador,
      );
      if (!isOk) {
        emit(state.copyWith(
          status: Status.error,
          firmaStatus: Status.error,
          errorMsg: message,
        ));
        return;
      }
      await subirCedulaFiadorHn(
        expedienteRepository: _expedienteRepository,
        cedulaFrontPath: state.cedulaFrontPath,
        cedulaBackPath: state.cedulaBackPath,
        cedula: state.cedula,
        numeroSolicitud: state.numeroSolicitud,
        fiadorId: state.fiadorId,
      );
      emit(state.copyWith(status: Status.done, firmaStatus: Status.done));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        firmaStatus: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

}

/// Junta las fotos de la cédula del fiador en un PDF y lo sube al expediente
/// digital. Si algo falla, solo se reporta: el fiador ya quedó creado y no se
/// bloquea el flujo. La usan el envío en línea y el de pendientes offline.
Future<void> subirCedulaFiadorHn({
  required ExpedienteDigitalRepository expedienteRepository,
  required String cedulaFrontPath,
  required String cedulaBackPath,
  required String cedula,
  required int numeroSolicitud,
  required String fiadorId,
}) async {
  if (cedulaFrontPath.isEmpty || cedulaBackPath.isEmpty) return;

  File? pdf;
  try {
    pdf = await ImagesToPdfService.generate(
      imagePaths: [cedulaFrontPath, cedulaBackPath],
      fileName: 'cedula_fiador_$fiadorId',
    );
    await expedienteRepository.uploadDigitalFile(
      tipo: DigitalFileTipo.analisis,
      cedula: cedula,
      numeroSolicitud: numeroSolicitud,
      filename: DigitalFilename.cedulaFiador,
      pdfPath: pdf.path,
    );
  } catch (e) {
    await ErrorReporter.registerError(
      errorMessage: 'Error generando PDF de cédula del fiador: $e',
      statusCode: '400',
      username: LocalStorage().currentUserName,
    );
  } finally {
    if (pdf != null) await ImagesToPdfService.deletePdf(pdf);
  }
}
