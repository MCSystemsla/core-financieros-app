import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/services/pdf/images_to_pdf_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/images_to_pdf_exception.dart';
import 'package:core_financiero_app/src/domain/repository/expediente_digital/expediente_digital_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'subir_otros_archivos_state.dart';

/// Sube al expediente digital cualquier documento armado a partir de fotos
/// (RTN, recibos, etc.). El tipo de documento lo define el [filename] que
/// recibe [subirArchivo].
class SubirOtrosArchivosCubit extends Cubit<SubirOtrosArchivosState> {
  final ExpedienteDigitalRepository _expedienteRepository;
  SubirOtrosArchivosCubit(this._expedienteRepository)
      : super(const SubirOtrosArchivosState());

  void addImage(String path) {
    emit(state.copyWith(imagePaths: [...state.imagePaths, path]));
  }

  void removeImage(int index) {
    emit(state.copyWith(
      imagePaths: [...state.imagePaths]..removeAt(index),
    ));
  }

  void resetStatus() {
    emit(state.copyWith(status: Status.notStarted, errorMsg: ''));
  }

  /// Junta las fotos en un PDF y lo sube al expediente como
  /// [DigitalFilename.pdfName]. El PDF temporal siempre se borra.
  Future<void> subirArchivo({
    required DigitalFilename filename,
    required String cedulaCliente,
    required int numeroSolicitud,
  }) async {
    if (state.imagePaths.isEmpty) return;
    emit(state.copyWith(status: Status.inProgress, errorMsg: ''));

    File? pdf;
    try {
      pdf = await ImagesToPdfService.generate(
        imagePaths: state.imagePaths,
        fileName: '${filename.codigo.toLowerCase()}_$numeroSolicitud',
      );
      final (isOk, message) = await _expedienteRepository.uploadDigitalFile(
        tipo: DigitalFileTipo.analisis,
        cedula: cedulaCliente,
        numeroSolicitud: numeroSolicitud,
        filename: filename,
        pdfPath: pdf.path,
      );
      emit(state.copyWith(
        status: isOk ? Status.done : Status.error,
        errorMsg: isOk ? '' : message,
      ));
    } on ImagesToPdfException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: 'No se pudo generar el PDF: ${e.message}',
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    } finally {
      if (pdf != null) await ImagesToPdfService.deletePdf(pdf);
    }
  }
}
