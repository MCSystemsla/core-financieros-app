// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_user_file_cubit.dart';

class UploadUserFileState extends Equatable {
  final String imagen1;
  final String imagen2;
  final String imagen3;
  final String imagen4;
  final String fotoFirma;
  final TypeSigner typeSigner;
  final Status status;
  final String errorMsg;
  final int imageRetryAttempts;
  const UploadUserFileState({
    this.imagen3 = '',
    this.imagen4 = '',
    this.imagen1 = '',
    this.imagen2 = '',
    this.fotoFirma = '',
    this.typeSigner = TypeSigner.ninguno,
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.imageRetryAttempts = 0,
  });

  @override
  List<Object> get props => [
        imagen1,
        imagen2,
        imagen3,
        imagen4,
        fotoFirma,
        typeSigner,
        status,
        errorMsg,
        imageRetryAttempts,
      ];

  UploadUserFileState copyWith({
    String? imagen1,
    String? imagen2,
    String? imagen3,
    String? imagen4,
    String? fotoFirma,
    TypeSigner? typeSigner,
    Status? status,
    String? errorMsg,
    int? imageRetryAttempts,
  }) {
    return UploadUserFileState(
      imagen1: imagen1 ?? this.imagen1,
      imagen2: imagen2 ?? this.imagen2,
      imagen3: imagen3 ?? this.imagen3,
      imagen4: imagen4 ?? this.imagen4,
      fotoFirma: fotoFirma ?? this.fotoFirma,
      typeSigner: typeSigner ?? this.typeSigner,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      imageRetryAttempts: imageRetryAttempts ?? this.imageRetryAttempts,
    );
  }
}

final class UploadUserFileInitial extends UploadUserFileState {}
