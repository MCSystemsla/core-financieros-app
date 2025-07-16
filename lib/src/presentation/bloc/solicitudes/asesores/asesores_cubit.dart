// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asesor/asesor.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'asesores_state.dart';

class AsesoresCubit extends Cubit<AsesoresState> {
  final SolicitudesCreditoRepository _repository;
  AsesoresCubit(this._repository) : super(AsesoresInitial());
  final _logger = Logger();
  Future<void> getAsesores() async {
    emit(OnAsesoresLoading());
    try {
      final (isOk, data) = await _repository.getAsesores();
      emit(OnAsesoresSuccess(asesor: data));
    } catch (e) {
      emit(OnAsesoresError());
      _logger.e(e);
    }
  }
}
