import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class PepsInformacionHn {
  final InformacionPeps informacionPeps;
  final List<FamiliaresPep> familiaresPeps;
  final List<DetallePep> detallePeps;
  final List<RelacionPep> relacionPeps;

  PepsInformacionHn({
    required this.informacionPeps,
    required this.familiaresPeps,
    required this.detallePeps,
    required this.relacionPeps,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'InformacionPeps': informacionPeps.toJson(),
        'FamiliaresPeps':
            List<dynamic>.from(familiaresPeps.map((x) => x.toJson())),
        'DetallePeps': List<dynamic>.from(detallePeps.map((x) => x.toJson())),
        'RelacionPeps': List<dynamic>.from(relacionPeps.map((x) => x.toJson())),
      };
}

class DetallePep {
  final String cargo;
  final String nombreInstitucion;
  final int periodo;
  final String? familiarReferencia;
  final String? nombreFamiliarReferencia;

  DetallePep({
    required this.cargo,
    required this.nombreInstitucion,
    required this.periodo,
    required this.familiarReferencia,
    required this.nombreFamiliarReferencia,
  });

  Map<String, dynamic> toJson() => {
        'Cargo': cargo,
        'NombreInstitucion': nombreInstitucion,
        'Periodo': periodo,
        'FamiliarReferencia': familiarReferencia,
      };
}

class FamiliaresPep {
  final String referenciaTemporal;
  final String parentescoCodigo;
  final String nombre1;
  final String? nombre2;
  final String apellido1;
  final String? apellido2;

  FamiliaresPep({
    required this.referenciaTemporal,
    required this.parentescoCodigo,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
  });

  Map<String, dynamic> toJson() => {
        'ReferenciaTemporal': referenciaTemporal,
        'ParentescoCodigo': parentescoCodigo,
        'Nombre1': nombre1,
        'Nombre2': nombre2,
        'Apellido1': apellido1,
        'Apellido2': apellido2,
      };
}

class InformacionPeps {
  final int numeroSolicitud;
  final bool servicioCredito;
  final bool servicioCuentaAhorro;
  final bool servicioDpf;
  final bool servicioRemesa;
  final String servicioOtros;
  final double negocioPorcentajeAccion;
  final int negocioCantidadSucursal;
  final String negocioCiudadSucursales;
  final bool negocioEsProveedorEstado;
  final String negocioAdquirienteInstitucion;
  final bool pagoEfectivoDolar;
  final bool pagoEfectivoLempira;
  final bool pagoCheque;
  final bool pagoTctd;
  final bool pagoDepositoCuenta;
  final bool pagoOtrosBancos;
  final bool manejaBienesPublicos;
  final String descripcionBienesPublicos;
  final String negocioProveedores;

  InformacionPeps({
    required this.numeroSolicitud,
    required this.servicioCredito,
    required this.servicioCuentaAhorro,
    required this.servicioDpf,
    required this.servicioRemesa,
    required this.servicioOtros,
    required this.negocioPorcentajeAccion,
    required this.negocioCantidadSucursal,
    required this.negocioCiudadSucursales,
    required this.negocioEsProveedorEstado,
    required this.negocioAdquirienteInstitucion,
    required this.pagoEfectivoDolar,
    required this.pagoEfectivoLempira,
    required this.pagoCheque,
    required this.pagoTctd,
    required this.pagoDepositoCuenta,
    required this.pagoOtrosBancos,
    required this.manejaBienesPublicos,
    required this.descripcionBienesPublicos,
    required this.negocioProveedores,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'NumeroSolicitud': numeroSolicitud,
      'ServicioCredito': servicioCredito,
      'ServicioCuentaAhorro': servicioCuentaAhorro,
      'ServicioDpf': servicioDpf,
      'ServicioRemesa': servicioRemesa,
      'ServicioOtros': servicioOtros,
      'NegocioPorcentajeAccion': negocioPorcentajeAccion,
      'NegocioCantidadSucursal': negocioCantidadSucursal,
      'NegocioCiudadSucursales': negocioCiudadSucursales,
      'NegocioEsProveedorEstado': negocioEsProveedorEstado,
      'NegocioAdquirienteInstitucion': negocioAdquirienteInstitucion,
      'PagoEfectivoDolar': pagoEfectivoDolar,
      'PagoEfectivoLempira': pagoEfectivoLempira,
      'PagoCheque': pagoCheque,
      'PagoTCTD': pagoTctd,
      'PagoDepositoCuenta': pagoDepositoCuenta,
      'PagoOtrosBancos': pagoOtrosBancos,
      'ManejaBienesPublicos': manejaBienesPublicos,
      'DescripcionBienesPublicos': descripcionBienesPublicos,
      'NegocioProveedores': negocioProveedores,
    };
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}

class RelacionPep {
  final String tipoRelacionCodigo;
  final String nombre;
  final String uuid;

  RelacionPep({
    required this.tipoRelacionCodigo,
    required this.nombre,
    required this.uuid,
  });

  Map<String, dynamic> toJson() => {
        'TipoRelacionCodigo': tipoRelacionCodigo,
        'Nombre': nombre,
      };
}
