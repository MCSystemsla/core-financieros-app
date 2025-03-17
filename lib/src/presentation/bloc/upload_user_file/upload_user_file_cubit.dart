import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
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

  void saveFirmaAsesor({required String firmaAsesorPath}) {
    emit(state.copyWith(firmaAsesor: firmaAsesorPath));
  }

  Future<void> uploadUserFiles({
    required String fotoFirma,
    required int solicitudId,
    required String formularioKiva,
    required String tipoSolicitud,
    required String numero,
    required String cedula,
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
      fotoAsesorFirma: state.firmaAsesor,
      numero: numero,
      cedula: cedula,
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
    required String imagenAsesor,
    required String numero,
    required String cedula,
  }) async {
    await repository.uploadUserFilesOffline(
      imagen1: imagen1,
      imagen2: imagen2,
      imagen3: imagen3,
      fotoFirma: fotoFirma,
      solicitudId: solicitudId,
      formularioKiva: formularioKiva,
      database: LocalStorage().database,
      tipoSolicitud: tipoSolicitud,
      imagenAsesor: imagenAsesor,
      numero: numero,
      cedula: cedula,
    );
  }
}
