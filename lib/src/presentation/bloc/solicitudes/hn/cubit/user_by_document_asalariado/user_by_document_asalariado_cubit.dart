import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_cubit.dart';
import 'package:equatable/equatable.dart';

part 'user_by_document_asalariado_state.dart';

class UserByDocumentAsalariadoCubit
    extends Cubit<UserByDocumentAsalariadoState> {
  final SolicitudesCreditoHnRepository _repository;
  UserByDocumentAsalariadoCubit(this._repository)
      : super(UserByDocumentAsalariadoInitial());

  Future<void> getUserByDocument({
    required String nombre,
    required String cedula,
    required String tipoDocumentoCodigo,
  }) async {
    emit(state.copyWith(status: UserByDocumentStatus.inProgress));
    try {
      final (resp, isNewUser) = await _repository.getUserByDocumentAsalariado(
        nombre: nombre,
        cedula: cedula,
        tipoDocumentoCodigo: tipoDocumentoCodigo,
      );
      if (isNewUser && resp == null) {
        emit(state.copyWith(
          status: UserByDocumentStatus.isNewUser,
          cedula: cedula,
          tipoDocumento: tipoDocumentoCodigo,
        ));
        return;
      }

      emit(state.copyWith(
        status: UserByDocumentStatus.done,
        primerNombre: resp?.data.primerNombre,
        segundoNombre: resp?.data.segundoNombre,
        fechaNacimiento: resp?.data.fechaNacimiento?.toUtc().toIso8601String(),
        tipoDocumento: resp?.data.tipoDocumento,
        cedula: resp?.data.cedula,
        fechaExpira: resp?.data.fechaExpira?.toUtc().toIso8601String(),
        departamento: resp?.data.departamento,
        direccion: resp?.data.direccion,
        fechaEmision: resp?.data.fechaEmision?.toUtc().toIso8601String(),
        municipio: resp?.data.municipio,
        pais: resp?.data.pais,
        primerApellido: resp?.data.primerApellido,
        segundoApellido: resp?.data.segundoApellido,
        sexo: resp?.data.sexo,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: UserByDocumentStatus.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserByDocumentStatus.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
