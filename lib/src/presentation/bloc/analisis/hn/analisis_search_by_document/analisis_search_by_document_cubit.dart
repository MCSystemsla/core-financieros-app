import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_search_by_document_state.dart';

class AnalisisSearchByDocumentCubit
    extends Cubit<AnalisisSearchByDocumentState> {
  final AnalisisRepositoryHn _repository;
  AnalisisSearchByDocumentCubit(this._repository)
      : super(AnalisisSearchByDocumentInitial());

  Future<void> getUserByDocument({
    required String primerNombre,
    required String segundoNombre,
    required String primerApellido,
    required String segundoApellido,
    required String cedula,
    required String tipoDocumentoCodigo,
  }) async {
    emit(state.copyWith(status: UserByDocumentStatus.inProgress));
    try {
      final resp = await _repository.getAnalisisFiadorByDocument(
        cedula: cedula,
        tipoDocumentoCodigo: tipoDocumentoCodigo,
      );
      if (resp?.data == null) {
        emit(state.copyWith(
          status: UserByDocumentStatus.isNewUser,
          primerNombre: primerNombre,
          segundoNombre: segundoNombre,
          primerApellido: primerApellido,
          segundoApellido: segundoApellido,
          tipoDocumento: tipoDocumentoCodigo,
          cedula: cedula,
        ));
        return;
      }
      emit(state.copyWith(
        primerNombre: resp?.data?.primerNombre,
        segundoNombre: resp?.data?.segundoNombre,
        primerApellido: resp?.data?.primerApellido,
        segundoApellido: resp?.data?.segundoApellido,
        fechaNacimiento: resp?.data?.fechaNacimiento?.toUtc().toIso8601String(),
        fechaEmision: resp?.data?.fechaEmision?.toUtc().toIso8601String(),
        fechaExpira: resp?.data?.fechaExpira?.toUtc().toIso8601String(),
        cedula: resp?.data?.cedula,
        departamento: resp?.data?.departamento,
        direccion: resp?.data?.direccion,
        municipio: resp?.data?.municipio,
        sexo: resp?.data?.sexo,
        pais: resp?.data?.pais,
        tipoDocumento: resp?.data?.tipoDocumento,
        status: UserByDocumentStatus.done,
      ));
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: UserByDocumentStatus.error,
          errorMsg: e.optionalMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserByDocumentStatus.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
