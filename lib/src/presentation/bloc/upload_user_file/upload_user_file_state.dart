// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_user_file_cubit.dart';

class UploadUserFileState extends Equatable {
  final String imagen1;
  final String imagen2;
  final String imagen3;
  final String imagen4;
  final String fotoFirma;
  final TypeSigner typeSigner;
  const UploadUserFileState({
    this.imagen3 = '',
    this.imagen4 = '',
    this.imagen1 = '',
    this.imagen2 = '',
    this.fotoFirma = '',
    this.typeSigner = TypeSigner.ninguno,
  });

  @override
  List<Object> get props => [
        imagen1,
        imagen2,
        imagen3,
        imagen4,
        fotoFirma,
        typeSigner,
      ];

  UploadUserFileState copyWith({
    String? imagen1,
    String? imagen2,
    String? imagen3,
    String? imagen4,
    String? fotoFirma,
    TypeSigner? typeSigner,
  }) {
    return UploadUserFileState(
      imagen1: imagen1 ?? this.imagen1,
      imagen2: imagen2 ?? this.imagen2,
      imagen3: imagen3 ?? this.imagen3,
      imagen4: imagen4 ?? this.imagen4,
      fotoFirma: fotoFirma ?? this.fotoFirma,
      typeSigner: typeSigner ?? this.typeSigner,
    );
  }
}

final class UploadUserFileInitial extends UploadUserFileState {}
