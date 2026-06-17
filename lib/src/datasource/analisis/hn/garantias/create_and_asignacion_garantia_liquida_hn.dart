import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class CreateAndAsignacionGarantiaLiquidaHn {
  final int articuloCodigo;
  final int objCuentaDpfid;
  final int objAnalisisGarantiaId;
  final double valorComercial;
  final double montoInicial;
  final String estadoCodigo;
  final int porcentajeCobertura;
  final String observaciones;
  final GarantiaDpfDetalle garantiaDpfDetalle;

  CreateAndAsignacionGarantiaLiquidaHn({
    required this.articuloCodigo,
    required this.objCuentaDpfid,
    required this.objAnalisisGarantiaId,
    required this.valorComercial,
    required this.montoInicial,
    required this.estadoCodigo,
    required this.porcentajeCobertura,
    required this.observaciones,
    required this.garantiaDpfDetalle,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'ArticuloCodigo': articuloCodigo,
        'objCuentaDPFID': objCuentaDpfid,
        'objAnalisisGarantiaID': objAnalisisGarantiaId,
        'ValorComercial': valorComercial,
        'MontoInicial': montoInicial,
        'EstadoCodigo': 'ACT',
        'PorcentajeCobertura': porcentajeCobertura,
        'Observaciones': observaciones,
        'GarantiaDPFDetalle': garantiaDpfDetalle.toJson(),
      };
}

class GarantiaDpfDetalle {
  final String formaAplicacionCodigo;
  final String comentario;

  GarantiaDpfDetalle({
    required this.formaAplicacionCodigo,
    required this.comentario,
  });

  Map<String, dynamic> toJson() => {
        'FormaAplicacionCodigo': 'MAN',
        'Comentario': comentario,
      };
}
