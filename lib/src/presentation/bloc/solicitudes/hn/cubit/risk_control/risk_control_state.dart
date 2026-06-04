// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'risk_control_cubit.dart';

class RiskControlState extends Equatable {
  final Status status;
  final String errorMsg;
  final bool fileExists;
  final Uint8List? filePath;

  const RiskControlState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.fileExists = false,
    this.filePath,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        fileExists,
      ];

  RiskControlState copyWith({
    Status? status,
    String? errorMsg,
    bool? fileExists,
    Uint8List? filePath,
  }) {
    return RiskControlState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      fileExists: fileExists ?? this.fileExists,
      filePath: filePath ?? this.filePath,
    );
  }
}

final class RiskControlInitial extends RiskControlState {}
