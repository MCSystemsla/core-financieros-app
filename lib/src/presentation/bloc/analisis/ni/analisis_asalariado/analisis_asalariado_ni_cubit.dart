import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/analisis_asalariado_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/asalariado/analisis_asalariado_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_asalariado_ni_state.dart';

class AnalisisAsalariadoNiCubit extends Cubit<AnalisisAsalariadoNiState> {
  final AnalisisFormsRepositoryNi _repository;
  late final AnalisisAsalariadoHnAutosave autoSaveHelper;
  AnalisisAsalariadoNiCubit(this._repository)
      : super(AnalisisAsalariadoHnInitial());

  Future<void> createAnalisisAsalariado() async {
    final incobrablesxCobrar = global<ObjectBoxService>()
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
      await _repository.createAnalisisAsalariado(
        analisisSolicitudAsalariado: AnalisisAsalariadoHn(
          fechaVerificacion1: state.fechaVerificacion1.isEmpty
              ? DateTime.now()
              : DateTime.parse(state.fechaVerificacion1),
          fechaVerificacion2: state.fechaVerificacion2.isEmpty
              ? DateTime.now()
              : DateTime.parse(state.fechaVerificacion2),
          fechaVerificacion3: state.fechaVerificacion3.isNotEmpty
              ? DateTime.tryParse(state.fechaVerificacion3)
              : null,
          objEmpleadoVerificaReferenciaID1:
              state.objEmpleadoVerificaReferenciaID1,
          objEmpleadoVerificaReferenciaID2:
              state.objEmpleadoVerificaReferenciaID2,
          objEmpleadoVerificaReferenciaID3:
              state.objEmpleadoVerificaReferenciaID3,
          database: state.database,
          numeroSolicitud: state.numeroSolicitud,
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

  void initAutoSave({String? uuid, required int numeroSolicitud}) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid, numeroSolicitud: numeroSolicitud));

    autoSaveHelper = AnalisisAsalariadoHnAutosave(
      box: localDbProvider.analisisAsalariadoHnLocalDb,
      buildModel: _buildModel,
      uuid: newUuid,
      numeroSolicitud: numeroSolicitud,
      onSaved: (m) {
        emit(state.copyWith(
          idLocalResponse: m.id,
          uuid: m.uuid,
          numeroSolicitud: m.numeroSolicitud,
        ));
      },
    );
  }

  void loadFromLocalDb(AnalisisAsalariadoHnLocalDb? solicitud) {
    onFieldChanged(
      () => state.copyWith(
        activo: solicitud?.activo,
        alimentacion: solicitud?.alimentacion,
        amortizacionesDeudas: solicitud?.amortizacionesDeudas,
        aniosConocerReferido1: solicitud?.aniosConocerReferido1,
        aniosConocerReferido2: solicitud?.aniosConocerReferido2,
        aniosConocerReferido3: solicitud?.aniosConocerReferido3,
        aseoLimpieza: solicitud?.aseoLimpieza,
        bienesInmuebles: solicitud?.bienesInmuebles,
        cedulaReferencia1: solicitud?.cedulaReferencia1,
        cedulaReferencia2: solicitud?.cedulaReferencia2,
        cedulaReferencia3: solicitud?.cedulaReferencia3,
        cuentasXCobrar: solicitud?.cuentasXCobrar,
        cuentasXPagar: solicitud?.cuentasXPagar,
        database: solicitud?.database,
        direccionReferencia1: solicitud?.direccionReferencia1,
        direccionReferencia2: solicitud?.direccionReferencia2,
        direccionReferencia3: solicitud?.direccionReferencia3,
        disponible: solicitud?.disponible,
        educacion: solicitud?.educacion,
        imprevistos: solicitud?.imprevistos,
        ingresoNetoSalario: solicitud?.ingresoNetoSalario,
        lugarTrabajoReferencia1: solicitud?.lugarTrabajoReferencia1,
        lugarTrabajoReferencia2: solicitud?.lugarTrabajoReferencia2,
        lugarTrabajoReferencia3: solicitud?.lugarTrabajoReferencia3,
        nombreReferencia1: solicitud?.nombreReferencia1,
        nombreReferencia2: solicitud?.nombreReferencia2,
        nombreReferencia3: solicitud?.nombreReferencia3,
        maquinaria: solicitud?.maquinaria,
        menajeHogar: solicitud?.menajeHogar,
        numeroSolicitud: solicitud?.numeroSolicitud,
        otrasCuentasXPagar: solicitud?.otrasCuentasXPagar,
        otrosEgresos: solicitud?.otrosEgresos,
        otrosIngresos: solicitud?.otrosIngresos,
        patrimonio: solicitud?.patrimonio,
        parentescoReferenciaCodigo1: solicitud?.parentescoReferenciaCodigo1,
        parentescoReferenciaCodigo2: solicitud?.parentescoReferenciaCodigo2,
        parentescoReferenciaCodigo3: solicitud?.parentescoReferenciaCodigo3,
        pasivoPatrimonio: solicitud?.pasivoPatrimonio,
        prestamoBancoCp: solicitud?.prestamoBancoCp,
        prestamoBancoLp: solicitud?.prestamoBancoLp,
        resultadoVerificacion1: solicitud?.resultadoVerificacion1,
        resultadoVerificacion2: solicitud?.resultadoVerificacion2,
        resultadoVerificacion3: solicitud?.resultadoVerificacion3,
        serviciosBasicos: solicitud?.serviciosBasicos,
        telefonoReferencia1: solicitud?.telefonoReferencia1,
        telefonoReferencia2: solicitud?.telefonoReferencia2,
        telefonoReferencia3: solicitud?.telefonoReferencia3,
        totalActivo: solicitud?.totalActivo,
        totalPasivo: solicitud?.totalPasivo,
        totalEgresos: solicitud?.totalEgresos,
        totalIngresos: solicitud?.totalIngresos,
        transporteCombustibleMtto: solicitud?.transporteCombustibleMtto,
        valoresAcciones: solicitud?.valoresAcciones,
        uuid: solicitud?.uuid,
        vehiculo: solicitud?.vehiculo,
        vestimentaCalzado: solicitud?.vestimentaCalzado,
        objEmpleadoVerificaReferenciaID1:
            solicitud?.objEmpleadoVerificaReferenciaID1,
        objEmpleadoVerificaReferenciaID2:
            solicitud?.objEmpleadoVerificaReferenciaID2,
        objEmpleadoVerificaReferenciaID3:
            solicitud?.objEmpleadoVerificaReferenciaID3,
        fechaVerificacion1:
            solicitud?.fechaVerificacion1?.toUtc().toIso8601String(),
        fechaVerificacion2:
            solicitud?.fechaVerificacion2?.toUtc().toIso8601String(),
        fechaVerificacion3:
            solicitud?.fechaVerificacion3?.toUtc().toIso8601String(),
      ),
    );
  }

  AnalisisAsalariadoHnLocalDb _buildModel(
    AnalisisAsalariadoHnLocalDb? existing,
  ) {
    final prev = existing;

    return AnalisisAsalariadoHnLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      objEmpleadoVerificaReferenciaID1: state.objEmpleadoVerificaReferenciaID1,
      objEmpleadoVerificaReferenciaID2: state.objEmpleadoVerificaReferenciaID2,
      objEmpleadoVerificaReferenciaID3: state.objEmpleadoVerificaReferenciaID3,
      activo: state.activo,
      cuentasXCobrar: state.cuentasXCobrar,
      valoresAcciones: state.valoresAcciones,
      menajeHogar:
          state.menajeHogar,
      vehiculo: state.vehiculo,
      maquinaria:
          state.maquinaria,
      bienesInmuebles: state.bienesInmuebles,
      totalActivo:
          state.totalActivo,
      cuentasXPagar: state.cuentasXPagar,
      prestamoBancoCp: state.prestamoBancoCp,
      prestamoBancoLp: state.prestamoBancoLp,
      otrasCuentasXPagar: state.otrasCuentasXPagar,
      alimentacion: state.alimentacion,
      educacion:
          state.educacion,
      serviciosBasicos: state.serviciosBasicos,
      aseoLimpieza: state.aseoLimpieza,
      vestimentaCalzado: state.vestimentaCalzado,
      amortizacionesDeudas: state.amortizacionesDeudas,
      aniosConocerReferido1: state.aniosConocerReferido1,
      aniosConocerReferido2: state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3,
      cedulaReferencia1:
          state.cedulaReferencia1,
      cedulaReferencia2:
          state.cedulaReferencia2,
      cedulaReferencia3:
          state.cedulaReferencia3,
      database: state.database,
      direccionReferencia1:
          state.direccionReferencia1,
      direccionReferencia2:
          state.direccionReferencia2,
      direccionReferencia3:
          state.direccionReferencia3,
      telefonoReferencia1:
          state.telefonoReferencia1,
      telefonoReferencia2:
          state.telefonoReferencia2,
      telefonoReferencia3:
          state.telefonoReferencia3,
      lugarTrabajoReferencia1:
          state.lugarTrabajoReferencia1,
      lugarTrabajoReferencia2:
          state.lugarTrabajoReferencia2,
      lugarTrabajoReferencia3:
          state.lugarTrabajoReferencia3,
      resultadoVerificacion1:
          state.resultadoVerificacion1,
      resultadoVerificacion2:
          state.resultadoVerificacion2,
      resultadoVerificacion3:
          state.resultadoVerificacion3,
      disponible:
          state.disponible,
      nombreReferencia1:
          state.nombreReferencia1,
      imprevistos:
          state.imprevistos,
      ingresoNetoSalario: state.ingresoNetoSalario,
      otrosIngresos: state.otrosIngresos,
      totalIngresos: state.totalIngresos,
      nombreReferencia2:
          state.nombreReferencia2,
      nombreReferencia3:
          state.nombreReferencia3,
      numeroSolicitud: state.numeroSolicitud,
      otrosEgresos: state.otrosEgresos,
      parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
      parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
      parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
      pasivoPatrimonio: state.pasivoPatrimonio,
      patrimonio:
          state.patrimonio,
      totalEgresos: state.totalEgresos,
      totalPasivo:
          state.totalPasivo,
      transporteCombustibleMtto: state.transporteCombustibleMtto,
      fechaVerificacion1: DateTime.tryParse(state.fechaVerificacion1),
      fechaVerificacion2: DateTime.tryParse(state.fechaVerificacion2),
      fechaVerificacion3:
          DateTime.tryParse(state.fechaVerificacion3),
    );
  }

  void onFieldChanged(AnalisisAsalariadoNiState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }
}
