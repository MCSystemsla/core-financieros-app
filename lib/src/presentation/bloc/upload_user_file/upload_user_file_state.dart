// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_user_file_cubit.dart';

class UploadUserFileState extends Equatable {
  final File? imagen1;
  final File? imagen2;
  final File? imagen3;
  final File? imagen4;
  final File? fotoFirma;
  final File? fotoCedula;
  const UploadUserFileState({
    this.imagen3,
    this.imagen4,
    this.imagen1,
    this.imagen2,
    this.fotoCedula,
    this.fotoFirma,
  });

  @override
  List<Object> get props => [
        imagen1!,
        imagen2!,
        imagen3!,
        imagen4!,
        fotoFirma!,
        fotoCedula!,
      ];

  UploadUserFileState copyWith({
    File? imagen1,
    File? imagen2,
    File? imagen3,
    File? imagen4,
    File? fotoFirma,
    File? fotoCedula,
  }) {
    return UploadUserFileState(
      imagen1: imagen1 ?? this.imagen1,
      imagen2: imagen2 ?? this.imagen2,
      imagen3: imagen3 ?? this.imagen3,
      imagen4: imagen4 ?? this.imagen4,
      fotoFirma: fotoFirma ?? this.fotoFirma,
      fotoCedula: fotoCedula ?? this.fotoCedula,
    );
  }
}

final class UploadUserFileInitial extends UploadUserFileState {}
