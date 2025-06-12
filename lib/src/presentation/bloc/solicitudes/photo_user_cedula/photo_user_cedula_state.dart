// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'photo_user_cedula_cubit.dart';

class PhotoUserCedulaState extends Equatable {
  final String cedulaFrontPath;
  final String cedulaBackPath;
  const PhotoUserCedulaState({
    this.cedulaFrontPath = '',
    this.cedulaBackPath = '',
  });

  @override
  List<Object> get props => [cedulaFrontPath, cedulaBackPath];

  PhotoUserCedulaState copyWith({
    String? cedulaFrontPath,
    String? cedulaBackPath,
  }) {
    return PhotoUserCedulaState(
      cedulaFrontPath: cedulaFrontPath ?? this.cedulaFrontPath,
      cedulaBackPath: cedulaBackPath ?? this.cedulaBackPath,
    );
  }
}

final class PhotoUserCedulaInitial extends PhotoUserCedulaState {}
