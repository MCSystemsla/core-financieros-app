import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_fiadores_ni_state.dart';

class AnalisisFiadoresNiCubit extends Cubit<AnalisisFiadoresNiState> {
  final AnalisisFormsRepositoryNi _repository;
  AnalisisFiadoresNiCubit(this._repository)
      : super(const AnalisisFiadoresNiState());

  Future<void> createAnalisisFiador({required int numeroSolicitud}) async {
    final totalIngresosFamiliares =
        state.salarioNetoCordoba + state.otrosIngresosCordoba;
    final gananciaNegocio =
        state.ventaNegocio - state.costoVenta - state.gastosOperativos;
    final saldoDisponible = totalIngresosFamiliares +
        gananciaNegocio +
        state.otrosIngresos -
        state.consumoFamiliar;

    emit(state.copyWith(
      status: Status.inProgress,
      numeroSolicitud: numeroSolicitud,
      totalIngresosFamiliares: totalIngresosFamiliares,
      gananciaNegocio: gananciaNegocio,
      saldoDisponible: saldoDisponible,
    ));
    try {
      await _repository.createAnalisisFiador(
        analisisFiadorNi: AnalisisFiadorNi(
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
          parentescoFamiliarCercanoCodigo:
              state.parentescoFamiliarCercanoCodigo,
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
        ),
      );
      emit(state.copyWith(status: Status.done));
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

  void onFieldChanged(AnalisisFiadoresNiState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
