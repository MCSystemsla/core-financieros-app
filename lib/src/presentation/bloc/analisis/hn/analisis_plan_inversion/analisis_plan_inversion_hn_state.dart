// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_plan_inversion_hn_cubit.dart';

class AnalisisPlanInversionHnState extends Equatable {
  final String errorMsg;
  final Status status;
  final int numeroSolicitud;
  final String database;
  final List<PlanInversion> planInversion;

  /// Fecha del último cambio del borrador local; `null` si no hay borrador.
  final DateTime? fechaBorrador;
  const AnalisisPlanInversionHnState({
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.database = '',
    this.planInversion = const [],
    this.status = Status.notStarted,
    this.fechaBorrador,
  });

  @override
  List<Object?> get props => [
        status,
        numeroSolicitud,
        database,
        planInversion,
        errorMsg,
        fechaBorrador,
      ];

  AnalisisPlanInversionHnState copyWith({
    String? errorMsg,
    Status? status,
    int? numeroSolicitud,
    String? database,
    List<PlanInversion>? planInversion,
    DateTime? Function()? fechaBorrador,
  }) {
    return AnalisisPlanInversionHnState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      database: database ?? this.database,
      planInversion: planInversion ?? this.planInversion,
      fechaBorrador:
          fechaBorrador != null ? fechaBorrador() : this.fechaBorrador,
    );
  }
}

final class AnalisisPlanInversionHnInitial
    extends AnalisisPlanInversionHnState {}
