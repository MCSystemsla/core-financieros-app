import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/analisis_grupal_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_grupal_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/grupal/analisis_grupal_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_grupal_state.dart';

class AnalisisGrupalCubit extends Cubit<AnalisisGrupalState> {
  final AnalisisRepositoryHn _repository;
  late final AnalisisGrupalHnAutosave autoSaveHelper;

  AnalisisGrupalCubit(this._repository) : super(AnalisisGrupalInitial());

  Future<void> createAnalisisGrupal() async {
    emit(state.copyWith(status: Status.inProgress));
    final totalIngresos = state.ingresosNegociosSalarios +
        state.ingresosRemesas +
        state.ingresosOtraActividad +
        state.ingresosConyuge;

    final totalGastos = state.compras +
        state.pagoCuotasOtrasInst +
        state.gastosFamiliares +
        state.otrosGastos;

    final flujoNeto = totalIngresos - totalGastos;

    try {
      await _repository.createAnalisisGrupal(
        analisisSolicitudGrupal: AnalisisGrupal(
          database: state.database,
          tipoSolicitud: state.tipoSolicitud,
          numeroSolicitud: state.numeroSolicitud,
          ingresosNegociosSalarios: state.ingresosNegociosSalarios,
          ingresosRemesas: state.ingresosRemesas,
          ingresosOtraActividad: state.ingresosOtraActividad,
          ingresosConyuge: state.ingresosConyuge,
          totalIngresos: totalIngresos,
          compras: state.compras,
          pagoCuotasOtrasInst: state.pagoCuotasOtrasInst,
          gastosFamiliares: state.gastosFamiliares,
          otrosGastos: state.otrosGastos,
          totalGastos: totalGastos,
          flujoNeto: flujoNeto,
          comentarios: state.comentarios,
          creditoNormal: state.creditoNormal,
          creditoRefinanciado: state.creditoRefinanciado,
          creditoReadecuado: state.creditoReadecuado,
          recapitalizacion: state.recapitalizacion,
          creditoParalelo: state.creditoParalelo,
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

  void onFieldChanged(AnalisisGrupalState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  void initAutoSave({
    String? uuid,
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(
      uuid: newUuid,
      numeroSolicitud: numeroSolicitud,
      tipoSolicitud: tipoSolicitud,
    ));

    autoSaveHelper = AnalisisGrupalHnAutosave(
      box: localDbProvider.analisisGrupalHnLocalDb,
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

  AnalisisGrupalHnLocalDb _buildModel(
    AnalisisGrupalHnLocalDb? existing,
  ) {
    final prev = existing;

    return AnalisisGrupalHnLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      numeroSolicitud: state.numeroSolicitud == 0
          ? (prev?.numeroSolicitud ?? 0)
          : state.numeroSolicitud,
      pagoCuotasOtrasInst: state.pagoCuotasOtrasInst == 0
          ? (prev?.pagoCuotasOtrasInst ?? 0)
          : state.pagoCuotasOtrasInst,
      compras: state.compras == 0 ? (prev?.compras ?? 0) : state.compras,
      flujoNeto:
          state.flujoNeto == 0 ? (prev?.flujoNeto ?? 0) : state.flujoNeto,
      gastosFamiliares: state.gastosFamiliares == 0
          ? (prev?.gastosFamiliares ?? 0)
          : state.gastosFamiliares,
      otrosGastos:
          state.otrosGastos == 0 ? (prev?.otrosGastos ?? 0) : state.otrosGastos,
      totalGastos:
          state.totalGastos == 0 ? (prev?.totalGastos ?? 0) : state.totalGastos,
      ingresosConyuge: state.ingresosConyuge == 0
          ? (prev?.ingresosConyuge ?? 0)
          : state.ingresosConyuge,
      ingresosRemesas: state.ingresosRemesas == 0
          ? (prev?.ingresosRemesas ?? 0)
          : state.ingresosRemesas,
      ingresosOtraActividad: state.ingresosOtraActividad == 0
          ? (prev?.ingresosOtraActividad ?? 0)
          : state.ingresosOtraActividad,
      ingresosNegociosSalarios: state.ingresosNegociosSalarios == 0
          ? (prev?.ingresosNegociosSalarios ?? 0)
          : state.ingresosNegociosSalarios,
      totalIngresos: state.totalIngresos == 0
          ? (prev?.totalIngresos ?? 0)
          : state.totalIngresos,
      comentarios: _prefer(state.comentarios, prev?.comentarios),
      creditoNormal: _preferBool(state.creditoNormal, prev?.creditoNormal),
      creditoRefinanciado:
          _preferBool(state.creditoRefinanciado, prev?.creditoRefinanciado),
      creditoReadecuado:
          _preferBool(state.creditoReadecuado, prev?.creditoReadecuado),
      recapitalizacion:
          _preferBool(state.recapitalizacion, prev?.recapitalizacion),
      creditoParalelo:
          _preferBool(state.creditoParalelo, prev?.creditoParalelo),
    );
  }

  void loadFromLocalDb(AnalisisGrupalHnLocalDb? solicitud) {
    onFieldChanged(
      () => state.copyWith(
        pagoCuotasOtrasInst: solicitud?.pagoCuotasOtrasInst,
        compras: solicitud?.compras,
        flujoNeto: solicitud?.flujoNeto,
        gastosFamiliares: solicitud?.gastosFamiliares,
        otrosGastos: solicitud?.otrosGastos,
        totalGastos: solicitud?.totalGastos,
        ingresosConyuge: solicitud?.ingresosConyuge,
        ingresosRemesas: solicitud?.ingresosRemesas,
        ingresosOtraActividad: solicitud?.ingresosOtraActividad,
        ingresosNegociosSalarios: solicitud?.ingresosNegociosSalarios,
        totalIngresos: solicitud?.totalIngresos,
        comentarios: solicitud?.comentarios,
        creditoNormal: solicitud?.creditoNormal,
        creditoRefinanciado: solicitud?.creditoRefinanciado,
        creditoReadecuado: solicitud?.creditoReadecuado,
        recapitalizacion: solicitud?.recapitalizacion,
        creditoParalelo: solicitud?.creditoParalelo,
        numeroSolicitud: solicitud?.numeroSolicitud,
        tipoSolicitud: solicitud?.tipoSolicitud,
        uuid: solicitud?.uuid,
        idLocalResponse: solicitud?.id,
      ),
    );
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';

  bool _preferBool(bool? current, bool? previous) =>
      current ?? previous ?? false;
}
