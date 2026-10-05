// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'supervision_grupal_cubit.dart';

class SupervisionGrupalState extends Equatable {
  final Status status;
  final String errorMsg;
  final int cicloGrupoID;
  final String lugarReunionGrupo;
  final String telefonoCasa;
  final String telefonoCelular;
  final String referenciasBuroCredito;
  final bool analisisVoluntadPago;
  final bool verificacionActivosFijos;
  final String otrasObservaciones;
  final double monto;

  const SupervisionGrupalState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.cicloGrupoID = 0,
    this.lugarReunionGrupo = '',
    this.telefonoCasa = '',
    this.telefonoCelular = '',
    this.referenciasBuroCredito = '',
    this.analisisVoluntadPago = false,
    this.verificacionActivosFijos = false,
    this.otrasObservaciones = '',
    this.monto = 0,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        cicloGrupoID,
        lugarReunionGrupo,
        telefonoCasa,
        telefonoCelular,
        referenciasBuroCredito,
        analisisVoluntadPago,
        verificacionActivosFijos,
        otrasObservaciones,
        monto,
      ];

  SupervisionGrupalState copyWith({
    Status? status,
    String? errorMsg,
    int? cicloGrupoID,
    String? lugarReunionGrupo,
    String? telefonoCasa,
    String? telefonoCelular,
    String? referenciasBuroCredito,
    bool? analisisVoluntadPago,
    bool? verificacionActivosFijos,
    String? otrasObservaciones,
    double? monto,
  }) {
    return SupervisionGrupalState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      cicloGrupoID: cicloGrupoID ?? this.cicloGrupoID,
      lugarReunionGrupo: lugarReunionGrupo ?? this.lugarReunionGrupo,
      telefonoCasa: telefonoCasa ?? this.telefonoCasa,
      telefonoCelular: telefonoCelular ?? this.telefonoCelular,
      referenciasBuroCredito:
          referenciasBuroCredito ?? this.referenciasBuroCredito,
      analisisVoluntadPago: analisisVoluntadPago ?? this.analisisVoluntadPago,
      verificacionActivosFijos:
          verificacionActivosFijos ?? this.verificacionActivosFijos,
      otrasObservaciones: otrasObservaciones ?? this.otrasObservaciones,
      monto: monto ?? this.monto,
    );
  }
}

final class SupervisionGrupalInitial extends SupervisionGrupalState {}
