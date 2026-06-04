import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepository _repository;
  OtpCubit(this._repository) : super(OtpInitial());

  Timer? _timer;

  Future<void> generateOTP() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.generateOTP();

      emit(state.copyWith(
        status: Status.done,
        token: resp.data.token,
        remainingSeconds: resp.data.fechaVenceOtp
            .difference(resp.data.fechaCreacionOtp)
            .inSeconds,
        expiresAt: resp.data.fechaVenceOtp,
        createdAt: resp.data.fechaCreacionOtp,
      ));
      _startTimer();
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void _startTimer() {
    _timer?.cancel();

    final total = state.expiresAt!
        .toLocal()
        .difference(state.createdAt!.toLocal())
        .inSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = state.remainingSeconds - 1;

      if (remaining <= 0) {
        _timer?.cancel();
        emit(state.copyWith(remainingSeconds: 0, percent: 1.0));
        generateOTP();
        return;
      }

      if (remaining != state.remainingSeconds) {
        final double currentPercent = (total - remaining) / total;
        emit(state.copyWith(
          remainingSeconds: remaining,
          percent: currentPercent,
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
