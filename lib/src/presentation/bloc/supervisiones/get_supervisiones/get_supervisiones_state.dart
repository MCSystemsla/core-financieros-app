// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_supervisiones_cubit.dart';

class GetSupervisionesState extends Equatable {
  final Status status;
  final List<SupervisionData> data;
  final String errorMsg;
  final String nombreCoordinador;

  const GetSupervisionesState({
    this.status = Status.notStarted,
    this.data = const [],
    this.errorMsg = '',
    this.nombreCoordinador = '',
  });

  @override
  List<Object> get props => [
        status,
        data,
        errorMsg,
        nombreCoordinador,
      ];

  GetSupervisionesState copyWith({
    Status? status,
    List<SupervisionData>? data,
    String? errorMsg,
    String? nombreCoordinador,
  }) {
    return GetSupervisionesState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
      nombreCoordinador: nombreCoordinador ?? this.nombreCoordinador,
    );
  }
}

final class GetSupervisionesInitial extends GetSupervisionesState {}
