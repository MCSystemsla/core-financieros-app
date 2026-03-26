import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String comiteAprobacionToJson(ComiteAprobacion data) =>
    json.encode(data.toJson());

class ComiteAprobacion {
  final int numeroSolicitud;
  final String observacion;
  final String formaPagoCodigo;
  final String tipoSolicitudCodigo;
  final String productoCodigo;
  final bool isMenorMil;
  final int? grupoID;
  final bool esUltimoRegistro;
  final ModificaActa modificaActa;
  final InsertaAprobacion insertaAprobacion;

  ComiteAprobacion({
    required this.numeroSolicitud,
    required this.observacion,
    required this.formaPagoCodigo,
    required this.tipoSolicitudCodigo,
    required this.productoCodigo,
    required this.isMenorMil,
    required this.modificaActa,
    required this.insertaAprobacion,
    required this.esUltimoRegistro,
    this.grupoID,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'database': LocalStorage().database,
      'NumeroSolicitud': numeroSolicitud,
      'Observacion': observacion,
      'FormaPagoCodigo': formaPagoCodigo,
      'TipoSolicitudCodigo': tipoSolicitudCodigo,
      'ProductoCodigo': productoCodigo,
      'IsMenorMil': isMenorMil,
      'modificaActa': modificaActa.toJson(),
      'insertaAprobacion': insertaAprobacion.toJson(),
      'GrupoID': grupoID == 0 ? null : grupoID,
      'EsUltimoRegistro': grupoID == 0 ? null : esUltimoRegistro,
    };
    data.removeWhere(
      (key, value) => value == null,
    );
    return data;
  }
}

class InsertaAprobacion {
  final String estadoSolicitudCodigo;
  final String periodicidadPrinicipalCodigo;
  final String periodicidadInteresCodigo;
  final bool alVencimiento;
  final String tipoComiteAprobacionCodigo;
  final bool aprobacionDigital;
  final bool esRecalculado;

  InsertaAprobacion({
    required this.estadoSolicitudCodigo,
    required this.periodicidadPrinicipalCodigo,
    required this.periodicidadInteresCodigo,
    required this.alVencimiento,
    required this.tipoComiteAprobacionCodigo,
    required this.aprobacionDigital,
    required this.esRecalculado,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'EstadoSolicitudCodigo': 'APROBADO',
      'PeriodicidadPrinicipalCodigo': periodicidadPrinicipalCodigo,
      'PeriodicidadInteresCodigo': periodicidadInteresCodigo,
      'AlVencimiento': alVencimiento,
      'TipoComiteAprobacionCodigo': tipoComiteAprobacionCodigo,
      'FechaAprobacion': DateTime.now().toUtc().toIso8601String(),
      'AprobacionDigital': aprobacionDigital,
      'EsRecalculado': esRecalculado,
    };
    data.removeWhere(
      (key, value) => value == '',
    );
    return data;
  }
}

class ModificaActa {
  final double monto;
  final double montoSeguro;
  final double porcentajeComision;
  final int plazo;
  final String sectorCodigo;
  final String actividadCodigo;
  final String fuenteFinanciamientoCodigo;
  final double tasaInteresCorriente;
  final double tasaInteresMoratorio;
  final String monedaDesembolsoCodigo;
  final String tipoDesembolsoCodigo;
  final int promotorId;
  final bool esReestructurado;
  final bool comisionFinanciada;
  final bool cuotaNivelada;
  final double montoSinComision;
  final int periodoGracia;
  final bool esRetencion;
  final double seguroMemorialMensual;
  final double porcentajeSaldoDeudorAprobado;
  final double montoTelemedicinaAprobada;
  final double porcentajeAgricolaAprobado;
  final double tasaMillarSeguroMapfre;
  final String numeroBienAdj;
  final String tipoCreditoNombre;
  final String tipoProgramaCodigo;

  ModificaActa({
    required this.monto,
    required this.montoSeguro,
    required this.porcentajeComision,
    required this.plazo,
    required this.sectorCodigo,
    required this.actividadCodigo,
    required this.fuenteFinanciamientoCodigo,
    required this.tasaInteresCorriente,
    required this.tasaInteresMoratorio,
    required this.monedaDesembolsoCodigo,
    required this.tipoDesembolsoCodigo,
    required this.promotorId,
    required this.esReestructurado,
    required this.comisionFinanciada,
    required this.cuotaNivelada,
    required this.montoSinComision,
    required this.periodoGracia,
    required this.esRetencion,
    required this.seguroMemorialMensual,
    required this.porcentajeSaldoDeudorAprobado,
    required this.montoTelemedicinaAprobada,
    required this.porcentajeAgricolaAprobado,
    required this.tasaMillarSeguroMapfre,
    required this.numeroBienAdj,
    required this.tipoCreditoNombre,
    required this.tipoProgramaCodigo,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'Monto': monto,
      'MontoSeguro': montoSeguro,
      'PorcentajeComision': porcentajeComision,
      'Plazo': plazo,
      'SectorCodigo': sectorCodigo,
      'ActividadCodigo': actividadCodigo,
      'FuenteFinanciamientoCodigo': fuenteFinanciamientoCodigo,
      'TasaInteresCorriente': tasaInteresCorriente,
      'TasaInteresMoratorio': tasaInteresMoratorio,
      'MonedaDesembolsoCodigo': monedaDesembolsoCodigo,
      'TipoDesembolsoCodigo': tipoDesembolsoCodigo,
      'PromotorId': promotorId,
      'EsReestructurado': esReestructurado,
      'ComisionFinanciada': comisionFinanciada,
      'CuotaNivelada': cuotaNivelada,
      'MontoSinComision': montoSinComision,
      'PeriodoGracia': periodoGracia,
      'EsRetencion': esRetencion,
      'SeguroMemorialMensual': seguroMemorialMensual,
      'PorcentajeSaldoDeudorAprobado': porcentajeSaldoDeudorAprobado,
      'MontoTelemedicinaAprobada': montoTelemedicinaAprobada,
      'PorcentajeAgricolaAprobado': porcentajeAgricolaAprobado,
      'TasaMillarSeguroMapfre': tasaMillarSeguroMapfre,
      'NumeroBienAdj': numeroBienAdj,
      'TipoCreditoNombre': tipoCreditoNombre,
      'TipoProgramaCodigo': tipoProgramaCodigo,
    };
    data.removeWhere(
      (key, value) => value == '',
    );
    return data;
  }
}
