import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/local_db/analisis_fiador_ni_local_db.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_fiadores_ni_state.dart';

class AnalisisFiadoresNiCubit extends Cubit<AnalisisFiadoresNiState> {
  final AnalisisFormsRepositoryNi _repository;
  AnalisisFiadoresNiCubit(this._repository)
      : super(const AnalisisFiadoresNiState());

  Future<void> createAnalisisFiador({required int numeroSolicitud}) async {
    final fiador = buildFiador(numeroSolicitud: numeroSolicitud);
    _emitInProgress(fiador);
    try {
      await _repository.createAnalisisFiador(analisisFiadorNi: fiador);
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
        isNetworkError: e.status == ErrorNetworkCode.noConnection ||
            e.status == ErrorNetworkCode.timeOutError,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  /// Guarda el fiador en ObjectBox para enviarlo después desde
  /// `FiadoresNiPendientesScreen`. No hace ninguna llamada HTTP.
  Future<void> guardarFiadorLocal({required int numeroSolicitud}) async {
    final fiador = buildFiador(numeroSolicitud: numeroSolicitud);
    _emitInProgress(fiador);
    try {
      final localDb = global<AnalisisBoxServiceHn>();
      final userId = LocalStorage().userId;

      if (localDb.existsFiadorNiPendiente(
        numeroSolicitud: numeroSolicitud,
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

      localDb.saveFiadorNiPendiente(
        AnalisisFiadorNiLocalDb(
          uuid: const Uuid().v4(),
          numeroSolicitud: numeroSolicitud,
          userId: userId,
          nombreCompleto: [
            fiador.nombre1,
            fiador.nombre2,
            fiador.apellido1,
            fiador.apellido2,
          ].where((n) => n.trim().isNotEmpty).join(' '),
          cedula: fiador.cedula,
          fechaGuardado: DateTime.now(),
          payloadJson: json.encode(fiador.toJson()),
        ),
      );
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: 'No se pudo guardar el fiador en el teléfono: $e',
      ));
    }
  }

  /// Arma el body con los totales calculados (mismas fórmulas que HN).
  AnalisisFiadorNi buildFiador({required int numeroSolicitud}) {
    final totalIngresosFamiliares =
        state.salarioNetoCordoba + state.otrosIngresosCordoba;
    final gananciaNegocio =
        state.ventaNegocio - state.costoVenta - state.gastosOperativos;
    final saldoDisponible = totalIngresosFamiliares +
        gananciaNegocio +
        state.otrosIngresos -
        state.consumoFamiliar;

    return AnalisisFiadorNi(
      database: LocalStorage().database,
      numeroSolicitud: numeroSolicitud,
      nombre1: state.nombre1,
      nombre2: state.nombre2,
      apellido1: state.apellido1,
      apellido2: state.apellido2,
      fechaNacimiento: state.fechaNacimiento,
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
      gananciaNegocio: gananciaNegocio,
      otrosIngresos: state.otrosIngresos,
      fuenteOtrosIngresos: state.fuenteOtrosIngresos,
      consumoFamiliar: state.consumoFamiliar,
      saldoDisponible: saldoDisponible,
      tipoDocumentoCodigo: state.tipoDocumentoCodigo,
      // "Tipo de propiedad" alimenta ambos códigos, igual que en HN.
      tipoViviendaCodigo: state.tipoDomicilioCodigo,
    );
  }

  void _emitInProgress(AnalisisFiadorNi fiador) {
    emit(state.copyWith(
      status: Status.inProgress,
      isNetworkError: false,
      numeroSolicitud: fiador.numeroSolicitud,
      totalIngresosFamiliares: fiador.totalIngresosFamiliares,
      gananciaNegocio: fiador.gananciaNegocio,
      saldoDisponible: fiador.saldoDisponible,
    ));
  }

  void onFieldChanged(AnalisisFiadoresNiState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
