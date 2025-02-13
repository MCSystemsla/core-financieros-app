import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'logo_state.dart';

class LogoCubit extends Cubit<LogoState> {
  final AuthRepository repository;
  LogoCubit(this.repository) : super(LogoInitial());

  Future getLogo() async {
    try {
      emit(OnLogoLoading());
      final resp = await repository.getLogo();
      emit(OnLogoSuccess(imgUrl: resp));
    } catch (e) {
      emit(OnLogoError());
    }
  }
}
