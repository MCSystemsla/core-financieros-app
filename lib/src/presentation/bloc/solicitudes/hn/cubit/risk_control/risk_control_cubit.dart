import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'risk_control_state.dart';

class RiskControlCubit extends Cubit<RiskControlState> {
  final SolicitudesCreditoHnRepository _repository;
  RiskControlCubit(this._repository) : super(RiskControlInitial());

  Future<void> getRiskControlByUserInfo({
    required String nombre1,
    required String nombre2,
    required String apellido1,
    required String apellido2,
    required String tipoIdentificacion,
    required String identificacion,
    required String tipoOrganizacion,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getRiskControlByUserInfo(
        nombre1: nombre1,
        nombre2: nombre2,
        apellido1: apellido1,
        apellido2: apellido2,
        tipoIdentificacionCodigo: tipoIdentificacion,
        identificacion: identificacion,
        tipoOrganizacionCodigo: tipoOrganizacion,
      );

      emit(state.copyWith(
        status: Status.done,
        filePath: resp,
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
}
