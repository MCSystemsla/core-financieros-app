import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'photo_user_cedula_state.dart';

class PhotoUserCedulaCubit extends Cubit<PhotoUserCedulaState> {
  PhotoUserCedulaCubit() : super(PhotoUserCedulaInitial());

  savePhotosPath({
    String? cedulaFrontPath,
    String? cedulaBackPath,
  }) {
    emit(state.copyWith(
      cedulaBackPath: cedulaBackPath,
      cedulaFrontPath: cedulaFrontPath,
    ));
  }
}
