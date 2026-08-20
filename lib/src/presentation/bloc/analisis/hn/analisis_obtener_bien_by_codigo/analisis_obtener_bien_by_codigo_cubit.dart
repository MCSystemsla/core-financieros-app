import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_obtener_bien_by_codigo_state.dart';

class AnalisisObtenerBienByCodigoCubit
    extends Cubit<AnalisisObtenerBienByCodigoState> {
  final AnalisisRepositoryHn _repository;
  AnalisisObtenerBienByCodigoCubit(this._repository)
      : super(AnalisisObtenerBienByCodigoInitial());

  Future<void> obtenerBienByCodigo({
    required String bienCodigo,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.obtenerGarantiaBienByCodigo(
        bienCodigo: bienCodigo,
      );
      emit(state.copyWith(
        status: Status.done,
        bienId: resp.data?.bienId,
        bienCodigo: resp.data?.bienCodigo,
        cedulaPropietario: resp.data?.cedulaPropietario,
        observaciones: resp.data?.observaciones,
        tipo: resp.data?.tipo,
        marca: resp.data?.marca,
        modelo: resp.data?.modelo,
        color: resp.data?.color,
        anio: resp.data?.anio,
        placa: resp.data?.placa,
        serie: resp.data?.serie,
        lugar: resp.data?.lugar,
        numeroReferencia: resp.data?.numeroReferencia,
        asiento: resp.data?.asiento,
        numTomo: resp.data?.numTomo,
        folio: resp.data?.folio,
        fechaInscripcion: resp.data?.fechaInscripcion?.toIso8601String(),
        areaVarasCuadradas: resp.data?.areaVarasCuadradas,
        areaMetrosCuadrados: resp.data?.areaMetrosCuadrados,
        direccion: resp.data?.direccion,
        objTipoGarantiaId: resp.data?.objTipoGarantiaId,
        departamentoCodigo: resp.data?.departamentoCodigo,
        departamentoNombre: resp.data?.departamentoNombre,
        municipioCodigo: resp.data?.municipioCodigo,
        municipioNombre: resp.data?.municipioNombre,
        aldeaCodigo: resp.data?.aldeaCodigo,
        aldeaNombre: resp.data?.aldeaNombre,
        analisisGarantiaId: resp.data?.analisisGarantiaId,
        numeroSolicitud: resp.data?.numeroSolicitud,
        montoGarantia: resp.data?.montoGarantia,
        articuloCodigo: resp.data?.articuloCodigo,
        articuloTipo: resp.data?.articuloTipo,
        articuloDescripcion: resp.data?.articuloDescripcion,
        tipoValoracionCodigo: resp.data?.tipoValoracionCodigo,
        tipoValoracionNombre: resp.data?.tipoValoracionNombre,
        valorComercial: resp.data?.valorComercial,
        valorAvaluo: resp.data?.valorAvaluo,
        evaluadorId: resp.data?.evaluadorId,
        evaluadorNombre: resp.data?.evaluadorNombre,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
