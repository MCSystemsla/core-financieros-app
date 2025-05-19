import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'upload_user_file_state.dart';

class UploadUserFileCubit extends Cubit<UploadUserFileState> {
  final ResponsesRepository repository;
  UploadUserFileCubit(this.repository) : super(UploadUserFileInitial());
  saveImages({
    required String imagen1,
    required String imagen2,
    required String imagen3,
  }) {
    emit(state.copyWith(
      imagen1: imagen1,
      imagen2: imagen2,
      imagen3: imagen3,
    ));
  }

  Future<void> uploadUserFiles({
    required String fotoFirma,
    required int solicitudId,
    required String formularioKiva,
    required String tipoSolicitud,
    required String numero,
    required String cedula,
    required TypeSigner typeSigner,
  }) async {
    await repository.uploadUserFiles(
      imagen1: state.imagen1,
      imagen2: state.imagen2,
      imagen3: state.imagen3,
      fotoFirma: fotoFirma,
      solicitudId: solicitudId,
      formularioKiva: formularioKiva,
      database: LocalStorage().database,
      tipoSolicitud: tipoSolicitud,
      numero: numero,
      cedula: cedula,
      typeSigner: typeSigner,
    );
  }

  Future<void> uploadUserFilesOffline({
    required String imagen1,
    required String imagen2,
    required String imagen3,
    required String fotoFirma,
    required int solicitudId,
    required String formularioKiva,
    required String tipoSolicitud,
    required String numero,
    required String cedula,
    required String typeSigner,
  }) async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      final (isOk, msg) = await repository.uploadUserFilesOffline(
        imagen1: imagen1,
        imagen2: imagen2,
        imagen3: imagen3,
        fotoFirma: fotoFirma,
        solicitudId: solicitudId,
        formularioKiva: formularioKiva,
        database: LocalStorage().database,
        tipoSolicitud: tipoSolicitud,
        numero: numero,
        cedula: cedula,
        typeSigner: typeSigner == TypeSigner.asesor.name
            ? TypeSigner.asesor
            : TypeSigner.cliente,
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: msg));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
