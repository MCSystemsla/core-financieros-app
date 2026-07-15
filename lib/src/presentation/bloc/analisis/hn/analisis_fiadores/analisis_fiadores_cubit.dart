import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_fiadores_state.dart';

class AnalisisFiadoresCubit extends Cubit<AnalisisFiadoresState> {
  final AnalisisRepositoryHn _repository;
  AnalisisFiadoresCubit(this._repository) : super(AnalisisFiadoresInitial());

  Future<void> createAnalisisFiador() async {
    final totalIngresosFamiliares =
        state.salarioNetoCordoba + state.otrosIngresosCordoba;
    final ganaciasNegocio =
        state.ventaNegocio - state.costoVenta - state.gastosOperativos;
    final saldoDisponible = totalIngresosFamiliares +
        ganaciasNegocio +
        state.otrosIngresos -
        state.consumoFamiliar;
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.createAnalisisFiador(
        analisisFiadoresHn: AnalisisFiadoresHn(
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
          fechaVencimientoCedula:
              DateTime.tryParse(state.fechaVencimientoCedula),
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
        ),
      );
      emit(state.copyWith(status: Status.done, fiadorId: resp.data.id));
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
    await _repository.fiadoresEnviarFirmaDigital(
      idFiador: state.fiadorId,
      firmaFiador: state.firmaFiador,
    );
  }
}
