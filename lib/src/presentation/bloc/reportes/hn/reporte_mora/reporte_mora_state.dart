// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reporte_mora_cubit.dart';

class ReporteMoraState extends Equatable {
  final Status status;
  final String errorMsg;
  final Uint8List? filePath;
  const ReporteMoraState({
    this.status = Status.inProgress,
    this.errorMsg = '',
    this.filePath,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
      ];

  ReporteMoraState copyWith({
    Status? status,
    String? errorMsg,
    Uint8List? filePath,
  }) {
    return ReporteMoraState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      filePath: filePath ?? this.filePath,
    );
  }
}

final class ReporteMoraInitial extends ReporteMoraState {}
