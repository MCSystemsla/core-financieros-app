part of 'subir_otros_archivos_cubit.dart';

class SubirOtrosArchivosState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<String> imagePaths;
  const SubirOtrosArchivosState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.imagePaths = const [],
  });

  @override
  List<Object> get props => [status, errorMsg, imagePaths];

  SubirOtrosArchivosState copyWith({
    Status? status,
    String? errorMsg,
    List<String>? imagePaths,
  }) {
    return SubirOtrosArchivosState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      imagePaths: imagePaths ?? this.imagePaths,
    );
  }
}
