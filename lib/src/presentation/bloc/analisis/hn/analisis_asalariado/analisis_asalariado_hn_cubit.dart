import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/analisis_asalariado_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/asalariado/analisis_asalariado_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_asalariado_hn_state.dart';

class AnalisisAsalariadoHnCubit extends Cubit<AnalisisAsalariadoHnState> {
  final AnalisisRepositoryHn _repository;
  late final AnalisisAsalariadoHnAutosave autoSaveHelper;
  AnalisisAsalariadoHnCubit(this._repository)
      : super(AnalisisAsalariadoHnInitial());

  Future<void> createAnalisisAsalariado() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createAnalisisAsalariado(
        analisisSolicitudAsalariado: AnalisisAsalariadoHn(
          database: state.database,
          numeroSolicitud: state.numeroSolicitud,
          activo: state.activo,
          cuentasXCobrar: state.cuentasXCobrar,
          valoresAcciones: state.valoresAcciones,
          menajeHogar: state.menajeHogar,
          vehiculo: state.vehiculo,
          maquinaria: state.maquinaria,
          bienesInmuebles: state.bienesInmuebles,
          totalActivo: state.totalActivo,
          cuentasXPagar: state.cuentasXPagar,
          prestamoBancoCp: state.prestamoBancoCp,
          prestamoBancoLp: state.prestamoBancoLp,
          otrasCuentasXPagar: state.otrasCuentasXPagar,
          totalPasivo: state.totalPasivo,
          patrimonio: state.patrimonio,
          pasivoPatrimonio: state.pasivoPatrimonio,
          ingresoNetoSalario: state.ingresoNetoSalario,
          otrosIngresos: state.otrosIngresos,
          totalIngresos: state.totalIngresos,
          alimentacion: state.alimentacion,
          educacion: state.educacion,
          serviciosBasicos: state.serviciosBasicos,
          aseoLimpieza: state.aseoLimpieza,
          vestimentaCalzado: state.vestimentaCalzado,
          transporteCombustibleMtto: state.transporteCombustibleMtto,
          imprevistos: state.imprevistos,
          amortizacionesDeudas: state.amortizacionesDeudas,
          otrosEgresos: state.otrosEgresos,
          totalEgresos: state.totalEgresos,
          disponible: state.disponible,
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
      activo: state.activo == 0 ? (prev?.activo ?? 0) : state.activo,
      cuentasXCobrar: state.cuentasXCobrar == 0
          ? (prev?.cuentasXCobrar ?? 0)
          : state.cuentasXCobrar,
      valoresAcciones: state.valoresAcciones == 0
          ? (prev?.valoresAcciones ?? 0)
          : state.valoresAcciones,
      menajeHogar:
          state.menajeHogar == 0 ? (prev?.menajeHogar ?? 0) : state.menajeHogar,
      vehiculo: state.vehiculo == 0 ? (prev?.vehiculo ?? 0) : state.vehiculo,
      maquinaria:
          state.maquinaria == 0 ? (prev?.maquinaria ?? 0) : state.maquinaria,
      bienesInmuebles: state.bienesInmuebles == 0
          ? (prev?.bienesInmuebles ?? 0)
          : state.bienesInmuebles,
      totalActivo:
          state.totalActivo == 0 ? (prev?.totalActivo ?? 0) : state.totalActivo,
      cuentasXPagar: state.cuentasXPagar == 0
          ? (prev?.cuentasXPagar ?? 0)
          : state.cuentasXPagar,
      prestamoBancoCp: state.prestamoBancoCp == 0
          ? (prev?.prestamoBancoCp ?? 0)
          : state.prestamoBancoCp,
      prestamoBancoLp: state.prestamoBancoLp == 0
          ? (prev?.prestamoBancoLp ?? 0)
          : state.prestamoBancoLp,
      otrasCuentasXPagar: state.otrasCuentasXPagar == 0
          ? (prev?.otrasCuentasXPagar ?? 0)
          : state.otrasCuentasXPagar,
      alimentacion: state.alimentacion == 0
          ? (prev?.alimentacion ?? 0)
          : state.alimentacion,
      educacion:
          state.educacion == 0 ? (prev?.educacion ?? 0) : state.educacion,
      serviciosBasicos: state.serviciosBasicos == 0
          ? (prev?.serviciosBasicos ?? 0)
          : state.serviciosBasicos,
      aseoLimpieza: state.aseoLimpieza == 0
          ? (prev?.aseoLimpieza ?? 0)
          : state.aseoLimpieza,
      vestimentaCalzado: state.vestimentaCalzado == 0
          ? (prev?.vestimentaCalzado ?? 0)
          : state.vestimentaCalzado,
      amortizacionesDeudas: state.amortizacionesDeudas == 0
          ? (prev?.amortizacionesDeudas ?? 0)
          : state.amortizacionesDeudas,
      aniosConocerReferido1: state.aniosConocerReferido1 == 0
          ? (prev?.aniosConocerReferido1 ?? 0)
          : state.aniosConocerReferido1,
      aniosConocerReferido2: state.aniosConocerReferido2 == 0
          ? (prev?.aniosConocerReferido2 ?? 0)
          : state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3 == 0
          ? (prev?.aniosConocerReferido3 ?? 0)
          : state.aniosConocerReferido3,
      cedulaReferencia1:
          _prefer(state.cedulaReferencia1, prev?.cedulaReferencia1),
      cedulaReferencia2:
          _prefer(state.cedulaReferencia2, prev?.cedulaReferencia2),
      cedulaReferencia3:
          _prefer(state.cedulaReferencia3, prev?.cedulaReferencia3),
      database: _prefer(state.database, prev?.database),
      direccionReferencia1:
          _prefer(state.direccionReferencia1, prev?.direccionReferencia1),
      direccionReferencia2:
          _prefer(state.direccionReferencia2, prev?.direccionReferencia2),
      direccionReferencia3:
          _prefer(state.direccionReferencia3, prev?.direccionReferencia3),
      telefonoReferencia1:
          _prefer(state.telefonoReferencia1, prev?.telefonoReferencia1),
      telefonoReferencia2:
          _prefer(state.telefonoReferencia2, prev?.telefonoReferencia2),
      telefonoReferencia3:
          _prefer(state.telefonoReferencia3, prev?.telefonoReferencia3),
      lugarTrabajoReferencia1:
          _prefer(state.lugarTrabajoReferencia1, prev?.lugarTrabajoReferencia1),
      lugarTrabajoReferencia2:
          _prefer(state.lugarTrabajoReferencia2, prev?.lugarTrabajoReferencia2),
      lugarTrabajoReferencia3:
          _prefer(state.lugarTrabajoReferencia3, prev?.lugarTrabajoReferencia3),
      resultadoVerificacion1:
          _prefer(state.resultadoVerificacion1, prev?.resultadoVerificacion1),
      resultadoVerificacion2:
          _prefer(state.resultadoVerificacion2, prev?.resultadoVerificacion2),
      resultadoVerificacion3:
          _prefer(state.resultadoVerificacion3, prev?.resultadoVerificacion3),
      disponible:
          state.disponible == 0 ? (prev?.disponible ?? 0) : state.disponible,
      nombreReferencia1:
          _prefer(state.nombreReferencia1, prev?.nombreReferencia1),
      imprevistos:
          state.imprevistos == 0 ? (prev?.imprevistos ?? 0) : state.imprevistos,
      ingresoNetoSalario: state.ingresoNetoSalario == 0
          ? (prev?.ingresoNetoSalario ?? 0)
          : state.ingresoNetoSalario,
      otrosIngresos: state.otrosIngresos == 0
          ? (prev?.otrosIngresos ?? 0)
          : state.otrosIngresos,
      totalIngresos: state.totalIngresos == 0
          ? (prev?.totalIngresos ?? 0)
          : state.totalIngresos,
      nombreReferencia2:
          _prefer(state.nombreReferencia2, prev?.nombreReferencia2),
      nombreReferencia3:
          _prefer(state.nombreReferencia3, prev?.nombreReferencia3),
      numeroSolicitud: state.numeroSolicitud == 0
          ? (prev?.numeroSolicitud ?? 0)
          : state.numeroSolicitud,
      otrosEgresos: state.otrosEgresos == 0
          ? (prev?.otrosEgresos ?? 0)
          : state.otrosEgresos,
      parentescoReferenciaCodigo1: _prefer(
          state.parentescoReferenciaCodigo1, prev?.parentescoReferenciaCodigo1),
      parentescoReferenciaCodigo2: _prefer(
          state.parentescoReferenciaCodigo2, prev?.parentescoReferenciaCodigo2),
      parentescoReferenciaCodigo3: _prefer(
          state.parentescoReferenciaCodigo3, prev?.parentescoReferenciaCodigo3),
      pasivoPatrimonio: state.pasivoPatrimonio == 0
          ? (prev?.pasivoPatrimonio ?? 0)
          : state.pasivoPatrimonio,
      patrimonio:
          state.patrimonio == 0 ? (prev?.patrimonio ?? 0) : state.patrimonio,
      totalEgresos: state.totalEgresos == 0
          ? (prev?.totalEgresos ?? 0)
          : state.totalEgresos,
      totalPasivo:
          state.totalPasivo == 0 ? (prev?.totalPasivo ?? 0) : state.totalPasivo,
      transporteCombustibleMtto: state.transporteCombustibleMtto == 0
          ? (prev?.transporteCombustibleMtto ?? 0)
          : state.transporteCombustibleMtto,
    );
  }

  void onFieldChanged(AnalisisAsalariadoHnState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';
}
