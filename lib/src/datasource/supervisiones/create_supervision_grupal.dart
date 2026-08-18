import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class CreateSupervisionGrupal {
  final int cicloGrupoID;
  final String lugarReunionGrupo;
  final String telefonoCasa;
  final String telefonoCelular;
  final String referenciasBuroCredito;
  final bool analisisVoluntadPago;
  final bool verificacionActivosFijos;
  final String otrasObservaciones;
  final double monto;

  CreateSupervisionGrupal({
    required this.cicloGrupoID,
    required this.lugarReunionGrupo,
    required this.telefonoCasa,
    required this.telefonoCelular,
    required this.referenciasBuroCredito,
    required this.analisisVoluntadPago,
    required this.verificacionActivosFijos,
    required this.otrasObservaciones,
    required this.monto,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'CicloGrupoID': cicloGrupoID,
        'LugarReunionGrupo': lugarReunionGrupo,
        'TelefonoCasa': telefonoCasa,
        'TelefonoCelular': telefonoCelular,
        'ReferenciasBuroCredito': referenciasBuroCredito,
        'AnalisisVoluntadPago': analisisVoluntadPago,
        'VerificacionActivosFijos': verificacionActivosFijos,
        'OtrasObservaciones': otrasObservaciones,
        'Monto': monto,
      };
}
