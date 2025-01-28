import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_catalogo_state.dart';

class SolicitudCatalogoCubit extends Cubit<SolicitudCatalogoState> {
  final SolicitudesCreditoRepository _repository;
  SolicitudCatalogoCubit(this._repository) : super(SolicitudCatalogoInitial());

  Future<void> getCatalogoByCodigo({required String codigo}) async {
    emit(SolicitudCatalogoLoading());
    try {
      final data = await _repository.getCatalogoByCodigo(codigo: codigo);
      emit(SolicitudCatalogoSuccess(data: data));
    } catch (e) {
      emit(SolicitudCatalogoError(error: e.toString()));
    }
  }
}
