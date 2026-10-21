import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_form_screen.dart';
import 'package:equatable/equatable.dart';

part 'analisis_fiadores_ni_state.dart';

class AnalisisFiadoresNiCubit extends Cubit<AnalisisFiadoresNiState> {
  final AnalisisFormsRepositoryNi _repository;
  AnalisisFiadoresNiCubit(this._repository)
      : super(const AnalisisFiadoresNiState());

  Future<void> createAnalisisFiador({required int numeroSolicitud}) async {
    // Sin empresario los montos del negocio se envían en 0.
    final ventaNegocio = state.esEmpresario ? state.ventaNegocio : 0.0;
    final costoVenta = state.esEmpresario ? state.costoVenta : 0.0;
    final gastosOperativos = state.esEmpresario ? state.gastosOperativos : 0.0;

    final totalIngresosFamiliares =
        state.salarioNetoCordoba + state.otrosIngresosCordoba;
    final gananciaNegocio = ventaNegocio - costoVenta - gastosOperativos;
    final saldoDisponible = totalIngresosFamiliares +
        gananciaNegocio +
        state.otrosIngresos -
        state.consumoFamiliar;

    emit(state.copyWith(
      status: Status.inProgress,
      numeroSolicitud: numeroSolicitud,
      ventaNegocio: ventaNegocio,
      costoVenta: costoVenta,
      gastosOperativos: gastosOperativos,
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
          direccionTrabajo: state.direccionTrabajo,
          barrioTrabajo: state.barrioTrabajo,
          telefonoTrabajo: state.telefonoTrabajo,
          lugarTrabajoAnterior: state.lugarTrabajoAnterior,
          personasACargo: state.personasACargo,
          cantidadDependientes: state.cantidadDependientes,
          tieneDocumentosDomicilio: state.tieneDocumentosDomicilio,
          tipoDomicilioCodigo: state.tipoDomicilioCodigo,
          duenoVivienda: state.duenoVivienda,
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
          ventaNegocio: ventaNegocio,
          costoVenta: costoVenta,
          gastosOperativos: gastosOperativos,
          gananciaNegocio: gananciaNegocio,
          otrosIngresos: state.otrosIngresos,
          consumoFamiliar: state.consumoFamiliar,
          saldoDisponible: saldoDisponible,
          tipoDocumentoCodigo: state.tipoDocumentoCodigo,
          tipoFiadorCodigo: state.tipoFiadorCodigo,
          escolaridadCodigo: state.escolaridadCodigo,
          ocupacionCodigo: state.ocupacionCodigo,
          profesionCodigo: state.profesionCodigo,
          paisNacimientoCodigo: state.paisNacimientoCodigo,
          nacionalidad1Codigo: state.nacionalidad1Codigo,
          cantidadHijos: state.cantidadHijos,
          // "Tipo de propiedad" alimenta ambos códigos, igual que en HN.
          tipoViviendaCodigo: state.tipoDomicilioCodigo,
          tipoPersonaCNBSCodigo: state.tipoPersonaCNBSCodigo,
          estatusCodigo: state.estatusCodigo,
          tipoClienteCodigo: state.tipoClienteCodigo,
          actividadEconomicaCNBS1Codigo: state.actividadEconomicaCNBS1Codigo,
          actividadEconomicaDescripcion1: state.actividadEconomicaDescripcion1,
          paisOcupacionCodigo: state.paisOcupacionCodigo,
          departamentoOcupacionCodigo: state.departamentoOcupacionCodigo,
          municipioOcupacionCodigo: state.municipioOcupacionCodigo,
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

  void setTipoFiador(FiadoresNiFormType tipo) {
    emit(state.copyWith(tipoFiadorCodigo: tipo.codigo));
  }

  void onFieldChanged(AnalisisFiadoresNiState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
