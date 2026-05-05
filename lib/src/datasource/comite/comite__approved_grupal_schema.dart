import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class ComiteApprovedGrupalSchema {
  final int grupoId;
  final List<ComiteGroupMember> groupMembers;

  ComiteApprovedGrupalSchema({
    required this.grupoId,
    required this.groupMembers,
  });

  Map<String, dynamic> toJson() => {
        'EsAprobacionMasiva': true,
        'database': LocalStorage().database,
        'GrupoID': grupoId,
        'groupMembers': List<dynamic>.from(groupMembers.map((x) => x.toJson())),
      };
}

class ComiteGroupMember {
  final int numeroSolicitud;
  final String observacion;
  final String formaPagoCodigo;
  final String tipoSolicitudCodigo;
  final String productoCodigo;
  final GrupalModificaActa modificaActa;
  final GrupalInsertaAprobacion insertaAprobacion;

  ComiteGroupMember({
    required this.numeroSolicitud,
    required this.observacion,
    required this.formaPagoCodigo,
    required this.tipoSolicitudCodigo,
    required this.productoCodigo,
    required this.modificaActa,
    required this.insertaAprobacion,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'NumeroSolicitud': numeroSolicitud,
      'Observacion': observacion,
      'FormaPagoCodigo': formaPagoCodigo,
      'TipoSolicitudCodigo': tipoSolicitudCodigo,
      'ProductoCodigo': productoCodigo,
      'modificaActa': modificaActa.toJson(),
      'insertaAprobacion': insertaAprobacion.toJson(),
    };
    data.removeWhere(
        (key, value) => value == '' || value == null || value == 0);
    return data;
  }
}

class GrupalInsertaAprobacion {
  final String periodicidadPrinicipalCodigo;
  final String periodicidadInteresCodigo;
  final bool alVencimiento;
  final DateTime fechaAprobacion;
  final bool aprobacionDigital;
  final bool esRecalculado;

  GrupalInsertaAprobacion({
    required this.periodicidadPrinicipalCodigo,
    required this.periodicidadInteresCodigo,
    required this.alVencimiento,
    required this.fechaAprobacion,
    required this.aprobacionDigital,
    required this.esRecalculado,
  });

  Map<String, dynamic> toJson() => {
        'PeriodicidadPrinicipalCodigo': periodicidadPrinicipalCodigo,
        'PeriodicidadInteresCodigo': periodicidadInteresCodigo,
        'AlVencimiento': alVencimiento,
        'FechaAprobacion': fechaAprobacion.toUtc().toIso8601String(),
        'AprobacionDigital': aprobacionDigital,
        'EsRecalculado': esRecalculado,
      };
}

class GrupalModificaActa {
  final num monto;
  final num montoSeguro;
  final num porcentajeComision;
  final int plazo;
  final String sectorCodigo;
  final String actividadCodigo;
  final String fuenteFinanciamientoCodigo;
  final int tasaInteresCorriente;
  final int tasaInteresMoratorio;
  final String monedaDesembolsoCodigo;
  final String tipoDesembolsoCodigo;
  final int promotorId;
  final bool esReestructurado;
  final bool comisionFinanciada;
  final bool cuotaNivelada;
  final num montoSinComision;
  final int periodoGracia;
  final bool esRetencion;
  final int seguroMemorialMensual;
  final bool usaConfiguracionCompartida;
  final String tipoCreditoNombre;
  final String tipoProgramaCodigo;

  GrupalModificaActa({
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
    required this.usaConfiguracionCompartida,
    required this.tipoCreditoNombre,
    required this.tipoProgramaCodigo,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
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
      'UsaConfiguracionCompartida': usaConfiguracionCompartida,
      'TipoCreditoNombre': tipoCreditoNombre,
      'TipoProgramaCodigo': tipoProgramaCodigo,
    };
    data.removeWhere(
        (key, value) => value == '' || value == null || value == 0);
    return data;
  }
}
