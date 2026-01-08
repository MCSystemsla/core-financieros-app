import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String createSupervisionCreditoToJson(CreateSupervisionCredito data) =>
    json.encode(data.toJson());

class CreateSupervisionCredito {
  final int numeroSolicitud;
  final bool razonCuota;
  final bool endeudamientoFuturo;
  final bool documentos;
  final bool ingresosFueraNegocio;
  final bool garantiaDictamenLegal;
  final double tasa;
  final String planInversionObservacion;
  final bool referenciaComunidadBuena;
  final bool referenciaComunidadMala;
  final bool buroCreditoBueno;
  final bool buroCreditoRegular;
  final bool buroCreditoMalas;
  final int monto;
  final int plazo;
  final String productoCodigo;

  CreateSupervisionCredito({
    required this.numeroSolicitud,
    required this.razonCuota,
    required this.endeudamientoFuturo,
    required this.documentos,
    required this.ingresosFueraNegocio,
    required this.garantiaDictamenLegal,
    required this.tasa,
    required this.planInversionObservacion,
    required this.referenciaComunidadBuena,
    required this.referenciaComunidadMala,
    required this.buroCreditoBueno,
    required this.buroCreditoRegular,
    required this.buroCreditoMalas,
    required this.monto,
    required this.plazo,
    required this.productoCodigo,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
        'RazonCuota': razonCuota,
        'EndeudamientoFuturo': endeudamientoFuturo,
        'Documentos': documentos,
        'IngresosFueraNegocio': ingresosFueraNegocio,
        'GarantiaDictamenLegal': garantiaDictamenLegal,
        'Tasa': tasa,
        'PlanInversionObservacion': planInversionObservacion,
        'ReferenciaComunidadBuena': referenciaComunidadBuena,
        'ReferenciaComunidadMala': referenciaComunidadMala,
        'BuroCreditoBueno': buroCreditoBueno,
        'BuroCreditoRegular': buroCreditoRegular,
        'BuroCreditoMalas': buroCreditoMalas,
        'Monto': monto,
        'Plazo': plazo,
        'ProductoCodigo': productoCodigo,
      };
}
