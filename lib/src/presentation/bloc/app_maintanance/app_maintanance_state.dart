part of 'app_maintanance_cubit.dart';

sealed class AppMaintananceState extends Equatable {
  const AppMaintananceState();

  @override
  List<Object> get props => [];
}

final class AppMaintananceInitial extends AppMaintananceState {}

final class OnAppMaintananceLoading extends AppMaintananceState {}

final class OnAppMaintananceSuccess extends AppMaintananceState {}

final class OnAppMaintananceError extends AppMaintananceState {
  final String errorMsg;

  const OnAppMaintananceError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class OnMaintenanceModeDetected extends AppMaintananceState {
  final bool isMaintenanceMode;
  final String message;
  final DateTime from;
  final DateTime to;

  const OnMaintenanceModeDetected({
    required this.isMaintenanceMode,
    required this.message,
    required this.from,
    required this.to,
  });

  @override
  List<Object> get props => [isMaintenanceMode, message, from, to];
}
