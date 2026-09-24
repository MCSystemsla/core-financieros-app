import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'actualizar_analisis_asalariado_hn_state.dart';

class ActualizarAnalisisAsalariadoHnCubit
    extends Cubit<ActualizarAnalisisAsalariadoHnState> {
  final AnalisisRepositoryHn _repository;
  ActualizarAnalisisAsalariadoHnCubit(this._repository)
      : super(ActualizarAnalisisAsalariadoHnInitial());

  Future<void> cargarAnalisis({
    required String numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(loadStatus: Status.inProgress));
    try {
      final data = await _repository.getAnalisisDataAsalariado(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      String idToString(int? id) => id == null || id == 0 ? '' : '$id';

      emit(
        state.copyWith(
          loadStatus: Status.done,
          numeroSolicitud: int.tryParse(numeroSolicitud) ?? 0,
          activo: data.activo?.toDouble(),
          cuentasXCobrar: data.cuentasXCobrar?.toDouble(),
          valoresAcciones: data.valoresAcciones?.toInt(),
          menajeHogar: data.menajeHogar?.toDouble(),
          vehiculo: data.vehiculo?.toInt(),
          maquinaria: data.maquinaria?.toDouble(),
          bienesInmuebles: data.bienesInmuebles?.toInt(),
          cuentasXPagar: data.cuentasXPagar?.toInt(),
          prestamoBancoCp: data.prestamoBancoCp?.toDouble(),
          prestamoBancoLp: data.prestamoBancoLp?.toInt(),
          otrasCuentasXPagar: data.otrasCuentasXPagar?.toDouble(),
          ingresoNetoSalario: data.ingresoNetoSalario?.toDouble(),
          otrosIngresos: data.otrosIngresos?.toDouble(),
          alimentacion: data.alimentacion?.toInt(),
          educacion: data.educacion?.toInt(),
          serviciosBasicos: data.serviciosBasicos?.toInt(),
          aseoLimpieza: data.aseoLimpieza?.toInt(),
          vestimentaCalzado: data.vestimentaCalzado?.toInt(),
          transporteCombustibleMtto: data.transporteCombustibleMtto?.toInt(),
          amortizacionesDeudas: data.amortizacionesDeudas?.toInt(),
          otrosEgresos: data.otrosEgresos?.toInt(),
          fechaVerificacion1: data.fechaVerificacion1?.toIso8601String(),
          nombreReferencia1: data.nombreReferencia1,
          cedulaReferencia1: data.cedulaReferencia1,
          direccionReferencia1: data.direccionReferencia1,
          telefonoReferencia1: data.telefonoReferencia1,
          lugarTrabajoReferencia1: data.lugarTrabajoReferencia1,
          aniosConocerReferido1: data.aniosConocerReferido1,
          parentescoReferenciaCodigo1: data.parentescoReferenciaCodigo1,
          resultadoVerificacion1: data.resultadoVerificacion1,
          objEmpleadoVerificaReferenciaID1:
              idToString(data.objEmpleadoVerificaReferenciaId1),
          fechaVerificacion2: data.fechaVerificacion2?.toIso8601String(),
          nombreReferencia2: data.nombreReferencia2,
          cedulaReferencia2: data.cedulaReferencia2,
          direccionReferencia2: data.direccionReferencia2,
          telefonoReferencia2: data.telefonoReferencia2,
          lugarTrabajoReferencia2: data.lugarTrabajoReferencia2,
          aniosConocerReferido2: data.aniosConocerReferido2,
          parentescoReferenciaCodigo2: data.parentescoReferenciaCodigo2,
          resultadoVerificacion2: data.resultadoVerificacion2,
          objEmpleadoVerificaReferenciaID2:
              idToString(data.objEmpleadoVerificaReferenciaId2),
          fechaVerificacion3: data.fechaVerificacion3?.toIso8601String(),
          nombreReferencia3: data.nombreReferencia3,
          cedulaReferencia3: data.cedulaReferencia3,
          direccionReferencia3: data.direccionReferencia3,
          telefonoReferencia3: data.telefonoReferencia3,
          lugarTrabajoReferencia3: data.lugarTrabajoReferencia3,
          aniosConocerReferido3: data.aniosConocerReferido3,
          parentescoReferenciaCodigo3: data.parentescoReferenciaCodigo3,
          resultadoVerificacion3: data.resultadoVerificacion3,
          objEmpleadoVerificaReferenciaID3:
              idToString(data.objEmpleadoVerificaReferenciaId3),
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(
        loadStatus: Status.error,
        loadErrorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        loadStatus: Status.error,
        loadErrorMsg: e.toString(),
      ));
    }
  }

  Future<void> actualizarAnalisisAsalariado() async {
    final incobrablesxCobrar = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'INCOBRABLESDECXCOBRAR');
    final totalActivosCalc = state.activo +
        state.cuentasXCobrar +
        state.valoresAcciones +
        state.menajeHogar +
        state.vehiculo +
        state.maquinaria +
        state.bienesInmuebles;
    final totalPasivosCalc = state.cuentasXPagar +
        state.prestamoBancoCp +
        state.prestamoBancoLp +
        state.otrasCuentasXPagar;

    final totalPatrimonioCalc = totalActivosCalc - totalPasivosCalc;

    final totalPasivosPatrimonioCalc = totalPasivosCalc + totalPatrimonioCalc;

    final totalIngresosCalc = state.ingresoNetoSalario + state.otrosIngresos;

    final imprevistosCalc = (state.alimentacion +
            state.educacion +
            state.serviciosBasicos +
            state.aseoLimpieza +
            state.vestimentaCalzado +
            state.transporteCombustibleMtto) *
        double.parse(incobrablesxCobrar?.valor ?? '0');

    final totalEgresosCalc = (state.alimentacion +
        state.educacion +
        state.serviciosBasicos +
        state.aseoLimpieza +
        state.vestimentaCalzado +
        state.transporteCombustibleMtto +
        imprevistosCalc +
        state.otrosEgresos +
        state.amortizacionesDeudas);

    final disponiblesCalc = totalIngresosCalc - totalEgresosCalc;

    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.updateAnalisisAsalariado(
        analisis: AnalisisAsalariadoHn(
          database: LocalStorage().database,
          numeroSolicitud: state.numeroSolicitud,
          fechaVerificacion1:
              DateTime.tryParse(state.fechaVerificacion1) ?? DateTime.now(),
          fechaVerificacion2:
              DateTime.tryParse(state.fechaVerificacion2) ?? DateTime.now(),
          fechaVerificacion3: DateTime.tryParse(state.fechaVerificacion3),
          objEmpleadoVerificaReferenciaID1:
              state.objEmpleadoVerificaReferenciaID1,
          objEmpleadoVerificaReferenciaID2:
              state.objEmpleadoVerificaReferenciaID2,
          objEmpleadoVerificaReferenciaID3:
              state.objEmpleadoVerificaReferenciaID3,
          activo: state.activo,
          cuentasXCobrar: state.cuentasXCobrar,
          valoresAcciones: state.valoresAcciones,
          menajeHogar: state.menajeHogar,
          vehiculo: state.vehiculo,
          maquinaria: state.maquinaria,
          bienesInmuebles: state.bienesInmuebles,
          totalActivo: totalActivosCalc,
          cuentasXPagar: state.cuentasXPagar,
          prestamoBancoCp: state.prestamoBancoCp,
          prestamoBancoLp: state.prestamoBancoLp,
          otrasCuentasXPagar: state.otrasCuentasXPagar,
          totalPasivo: totalPasivosCalc,
          patrimonio: totalPatrimonioCalc.toInt(),
          pasivoPatrimonio: totalPasivosPatrimonioCalc,
          ingresoNetoSalario: state.ingresoNetoSalario,
          otrosIngresos: state.otrosIngresos,
          totalIngresos: totalIngresosCalc,
          alimentacion: state.alimentacion,
          educacion: state.educacion,
          serviciosBasicos: state.serviciosBasicos,
          aseoLimpieza: state.aseoLimpieza,
          vestimentaCalzado: state.vestimentaCalzado,
          transporteCombustibleMtto: state.transporteCombustibleMtto,
          imprevistos: imprevistosCalc.toInt(),
          amortizacionesDeudas: state.amortizacionesDeudas,
          otrosEgresos: state.otrosEgresos,
          totalEgresos: totalEgresosCalc.toInt(),
          disponible: disponiblesCalc,
          nombreReferencia1: state.nombreReferencia1,
          cedulaReferencia1: state.cedulaReferencia1,
          direccionReferencia1: state.direccionReferencia1,
          telefonoReferencia1: state.telefonoReferencia1,
          lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
          aniosConocerReferido1: state.aniosConocerReferido1,
          parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
          resultadoVerificacion1: state.resultadoVerificacion1,
          nombreReferencia2: state.nombreReferencia2,
          cedulaReferencia2: state.cedulaReferencia2,
          direccionReferencia2: state.direccionReferencia2,
          telefonoReferencia2: state.telefonoReferencia2,
          lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
          aniosConocerReferido2: state.aniosConocerReferido2,
          parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
          resultadoVerificacion2: state.resultadoVerificacion2,
          nombreReferencia3: state.nombreReferencia3,
          cedulaReferencia3: state.cedulaReferencia3,
          direccionReferencia3: state.direccionReferencia3,
          telefonoReferencia3: state.telefonoReferencia3,
          lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
          aniosConocerReferido3: state.aniosConocerReferido3,
          parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
          resultadoVerificacion3: state.resultadoVerificacion3,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void onFieldChanged(
    ActualizarAnalisisAsalariadoHnState Function() copyWithFn,
  ) {
    emit(copyWithFn());
  }

  /// Limpia la referencia 3 cuando el asesor la quita del formulario.
  void limpiarReferencia3() {
    emit(
      state.copyWith(
        fechaVerificacion3: '',
        nombreReferencia3: '',
        cedulaReferencia3: '',
        direccionReferencia3: '',
        telefonoReferencia3: '',
        lugarTrabajoReferencia3: '',
        aniosConocerReferido3: 0,
        parentescoReferenciaCodigo3: '',
        resultadoVerificacion3: '',
        objEmpleadoVerificaReferenciaID3: '',
      ),
    );
  }
}
