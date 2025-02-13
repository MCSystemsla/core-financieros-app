import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/comunidad_response.dart';
import 'package:core_financiero_app/src/domain/repository/comunidad/comunidad_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'comunidades_state.dart';

class ComunidadesCubit extends Cubit<ComunidadesState> {
  final ComunidadRepository comunidadRepository;
  ComunidadesCubit(this.comunidadRepository) : super(ComunidadesInitial());
  final _logger = Logger();
  Future<void> getComunidades() async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      final resp = await comunidadRepository.getComunidades();
      emit(state.copyWith(
        comunidades: resp.mapaTipoComunidad,
        status: Status.done,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
      _logger.e(e);
    }
  }
}
