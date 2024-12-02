import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'upload_user_file_state.dart';

class UploadUserFileCubit extends Cubit<UploadUserFileState> {
  final ResponsesRepository repository;
  UploadUserFileCubit(this.repository) : super(UploadUserFileInitial());
  void saveImages({
    File? imagen1,
    File? imagen2,
    File? imagen3,
    File? fotoFirma,
    File? fotoCedula,
  }) {
    emit(state.copyWith(
      imagen1: imagen1,
      imagen2: imagen2,
      imagen3: imagen3,
      fotoFirma: fotoFirma,
      fotoCedula: fotoCedula,
    ));
  }

  Future<void> uploadUserFiles({
    required File fotoFirma,
    required int solicitudId,
  }) async {
    await repository.uploadUserFiles(
      imagen1: state.imagen1!,
      imagen2: state.imagen2!,
      imagen3: state.imagen3!,
      fotoFirma: fotoFirma,
      fotoCedula: state.fotoCedula!,
      solicitudId: solicitudId,
      formularioKiva: 'ScrKivaCreditoEstandarRecurrente',
      database: 'MC_CH',
    );
  }

  Future<void> uploadUserFilesOffline({
    required String imagen1,
    required String imagen2,
    required String imagen3,
    required String fotoCedula,
    required String fotoFirma,
    required int solicitudId,
  }) async {
    await repository.uploadUserFilesOffline(
      imagen1: imagen1,
      imagen2: imagen2,
      imagen3: imagen3,
      fotoFirma: fotoFirma,
      fotoCedula: fotoCedula,
      solicitudId: solicitudId,
      formularioKiva: 'ScrKivaCreditoEstandarRecurrente',
      database: LocalStorage().database,
    );
  }

  void saveSignature({required Uint8List signatureImage}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/signature.png';

      // Guarda la imagen en el archivo
      final file = File(filePath);
      await file.writeAsBytes(signatureImage);

      emit(state.copyWith(fotoFirma: file));
      // Actualiza el estado con la ruta del archivo
      log('Firma guardada en: $filePath');
    } catch (e) {
      log('Error al guardar la firma: $e');
    }
  }
}
