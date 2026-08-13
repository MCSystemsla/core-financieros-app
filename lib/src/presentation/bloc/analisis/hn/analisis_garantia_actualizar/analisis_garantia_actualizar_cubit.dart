import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_actualizar_garantia.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_garantia_actualizar_state.dart';

class AnalisisGarantiaActualizarCubit
    extends Cubit<AnalisisGarantiaActualizarState> {
  final AnalisisRepositoryHn _repository;
  AnalisisGarantiaActualizarCubit(this._repository)
      : super(AnalisisGarantiaActualizarInitial());

  Future<void> actualizarGarantia() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.actualizarGarantia(
        data: AnalisisActualizarGarantia(
          codigoBien: state.codigoBien,
          objAnalisisGarantiaId: state.objAnalisisGarantiaId,
          observaciones: state.observaciones,
          cedulaPropietario: state.cedulaPropietario,
          departamentoCodigo: state.departamentoCodigo,
          municipioCodigo: state.municipioCodigo,
          aldeaCodigo: state.aldeaCodigo,
          valoracion: AnalisisActualizarGarantiaValoracion(
            valorComercial: state.valorComercial,
            valorAvaluo: state.valorAvaluo,
            tipoValoracionCodigo: state.tipoValoracionCodigo,
            objValuadorId: state.objValuadorId,
          ),
          detalle: AnalisisActualizarGarantiaDetalle(
            familia: state.familia,
            data: AnalisisActualizarGarantiaData(
              numEscritura: state.numEscritura,
              numTomo: state.numTomo,
              folio: state.folio,
              fechaInscripcion: DateTime.tryParse(state.fechaInscripcion),
              areaVarasCuadradas: state.areaVarasCuadradas,
              areaMetrosCuadrados: state.areaMetrosCuadrados,
              direccion: state.direccion,
            ),
          ),
        ),
      );
      emit(state.copyWith(
        status: Status.done,
      ));
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

  void onFieldChanged(AnalisisGarantiaActualizarState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
