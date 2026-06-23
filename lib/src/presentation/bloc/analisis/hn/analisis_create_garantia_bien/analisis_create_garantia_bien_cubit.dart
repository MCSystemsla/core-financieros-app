import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/create_garantia_asignacion_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/create_garantia_bien_schema_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_create_garantia_bien_state.dart';

class AnalisisCreateGarantiaBienCubit
    extends Cubit<AnalisisCreateGarantiaBienState> {
  final AnalisisRepositoryHn _repository;
  AnalisisCreateGarantiaBienCubit(this._repository)
      : super(AnalisisCreateGarantiaBienInitial());

  Future<void> createGarantiaBien({
    required String familia,
    required int objAnalisisGarantiaId,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.createGarantiaBien(
        data: CreateGarantiaBienSchemaHn(
          observaciones: state.observaciones,
          objAnalisisGarantiaID: objAnalisisGarantiaId,
          departamentoCodigo: state.departamentoCodigo,
          municipioCodigo: state.municipioCodigo,
          aldeaCodigo: state.aldeaCodigo,
          cedulaPropietario: state.cedulaPropietario,
          valoracion: GarantiaAsignacionValoracion(
            valorComercial: state.valorComercial,
            valorAvaluo: state.valorAvaluo,
            objValuadorId: state.objValuadorID,
            tipoValoracionCodigo: state.tipoValoracionCodigo,
          ),
          detalle: DetalleGarantiaHn(
            familia: familia,
            data: DetalleGarantiaHnData(
              numTomo: state.numTomo,
              folio: state.folio,
              numEscritura: state.numEscritura,
              fechaInscripcion: DateTime.tryParse(state.fechaInscripcion),
              areaVaras2: state.areaVaras2,
              areaMetros2: state.areaMetros2,
              direccion: state.direccion,
              tipo: state.tipo,
              marca: state.marca,
              modelo: state.modelo,
              anio: state.anio,
              color: state.color,
              placa: state.placa,
              serie: state.serie,
              objValuadorID: state.objValuadorID,
              tipoValoracionCodigo: state.tipoValoracionCodigo,
              observaciones: state.observaciones,
              valorComercial: state.valorComercial,
              valorAvaluo: state.valorAvaluo,
              lugar: state.lugar,
              numeroReferencia: state.numeroReferencia,
              descripcion: state.descripcion,
            ),
          ),
        ),
      );
      emit(state.copyWith(
        status: Status.done,
        succesMsg: resp.message,
        objGarantiaBienId: resp.id,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        erroMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          erroMsg: e.toString(),
        ),
      );
    }
  }

  void onFieldChanged(AnalisisCreateGarantiaBienState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
