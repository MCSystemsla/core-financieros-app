// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_have_cedula_cubit.dart';

class UserHaveCedulaState extends Equatable {
  final Status status;
  final String errorMsg;
  final bool tieneFotoCedula;
  final bool isUserSelectUpdateImage;
  const UserHaveCedulaState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.tieneFotoCedula = false,
    this.isUserSelectUpdateImage = false,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        tieneFotoCedula,
        isUserSelectUpdateImage,
      ];

  UserHaveCedulaState copyWith({
    Status? status,
    String? errorMsg,
    bool? tieneFotoCedula,
    bool? isUserSelectUpdateImage,
  }) {
    return UserHaveCedulaState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      tieneFotoCedula: tieneFotoCedula ?? this.tieneFotoCedula,
      isUserSelectUpdateImage:
          isUserSelectUpdateImage ?? this.isUserSelectUpdateImage,
    );
  }
}

final class UserHaveCedulaInitial extends UserHaveCedulaState {}
