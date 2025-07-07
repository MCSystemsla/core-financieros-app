import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form.dart';
import 'package:equatable/equatable.dart';

part 'user_by_cedula_state.dart';

class UserByCedulaCubit extends Cubit<UserByCedulaState> {
  final SolicitudesCreditoRepository _repository;
  UserByCedulaCubit(this._repository) : super(UserByCedulaInitial());

  Future<void> getUserByCedula({
    required String cedula,
    required Item tipoDocumento,
    required Item paisEmisor,
  }) async {
    try {
      emit(OnUserByCedulaLoading());
      final (resp, isNewUserCedula, code) =
          await _repository.getUserByCedula(cedula: cedula);

      if (isNewUserCedula) {
        emit(
          OnUserByCedulaSuccess(
            isNewUserCedula: isNewUserCedula,
            userByCedula: UserByCedulaSolicitud(
              cedula: cedula,
              tipoDocumento: tipoDocumento.value,
              paisEmisor: paisEmisor,
            ),
          ),
        );
        return;
      }
      emit(
        OnUserByCedulaSuccess(
          isNewUserCedula: isNewUserCedula,
          userByCedula: UserByCedulaSolicitud(
            cedula: cedula,
            tipoDocumento: resp?.data.tipoDocumento ?? '',
            paisEmisor: paisEmisor,
            primerNombre: resp?.data.primerNombre,
            segundoNombre: resp?.data.segundoNombre,
            primerApellido: resp?.data.primerApellido,
            segundoApellido: resp?.data.segundoApellido,
            fechaNacimiento: resp?.data.fechaNacimiento,
            fechaEmision: resp?.data.fechaEmision,
            fechaVencimiento: resp?.data.fechaExpira,
          ),
        ),
      );
    } on AppException catch (e) {
      emit(
        OnUserByCedulaError(
          errorMsg: e.optionalMsg,
          userByCedula: UserByCedulaSolicitud(
            cedula: cedula,
            tipoDocumento: tipoDocumento.value,
            paisEmisor: paisEmisor,
          ),
        ),
      );
    } catch (e) {
      emit(OnUserByCedulaError(
        errorMsg: e.toString(),
        userByCedula: UserByCedulaSolicitud(
          cedula: cedula,
          tipoDocumento: tipoDocumento.value,
          paisEmisor: paisEmisor,
        ),
      ));
    }
  }
}
