import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class CreateSupervisionRegional {
  final int numeroSolicitud;
  final bool buroCreditoBueno;
  final bool buroCreditoRegular;
  final bool buroCreditoMalas;
  final bool referenciaComunidadBuena;
  final bool referenciaComunidadMala;
  final bool referenciaComunidadRegular;
  final bool referenciaComunidadBuena2;
  final bool referenciaComunidadMala2;
  final bool referenciaComunidadRegular2;
  final bool tipoViviendaAlquilada;
  final bool tipoViviendaPropia;
  final bool tipoViviendaFamiliar;
  final bool conocimientoNegocioAlto;
  final bool conocimientoNegocioMedio;
  final bool conocimientoNegocioBajo;
  final bool nivelVentasAcordeSi;
  final bool nivelVentasAcordeNo;
  final bool nivelVentasAcordeNa;
  final bool costoVentaAdecuadoSi;
  final bool costoVentaAdecuadoNo;
  final bool costoVentaAdecuadoNa;
  final bool realidadClienteSi;
  final bool realidadClienteNo;
  final bool realidadClienteNa;
  final bool razonCuotaSi;
  final bool razonCuotaNo;
  final bool razonCuotaNa;
  final int razonCuotaMonto;
  final bool razonEndeudamientoSi;
  final bool razonEndeudamientoNo;
  final bool razonEndeudamientoNa;
  final bool garantiaRevisadaSi;
  final bool garantiaRevisadaNo;
  final bool garantiaRevisadaNa;
  final bool fiadorRevisadoSi;
  final bool fiadorRevisadoNo;
  final bool fiadorRevisadoNa;
  final double monto;
  final int plazo;
  final String productoCodigo;
  final String frecuenciaCodigo;
  final String infoSocioEconomica;
  final String infoFinanciera;
  final String recomendacionFinal;
  final String nombreRefComunidad1;
  final String direccionRefComunidad1;
  final String nombreRefComunidad2;
  final String direccionRefComunidad2;
  final String tiempoNegocio;
  final String tipoSolicitud;

  CreateSupervisionRegional({
    required this.numeroSolicitud,
    required this.buroCreditoBueno,
    required this.buroCreditoRegular,
    required this.buroCreditoMalas,
    required this.referenciaComunidadBuena,
    required this.referenciaComunidadMala,
    required this.referenciaComunidadRegular,
    required this.referenciaComunidadBuena2,
    required this.referenciaComunidadMala2,
    required this.referenciaComunidadRegular2,
    required this.tipoViviendaAlquilada,
    required this.tipoViviendaPropia,
    required this.tipoViviendaFamiliar,
    required this.conocimientoNegocioAlto,
    required this.conocimientoNegocioMedio,
    required this.conocimientoNegocioBajo,
    required this.nivelVentasAcordeSi,
    required this.nivelVentasAcordeNo,
    required this.nivelVentasAcordeNa,
    required this.costoVentaAdecuadoSi,
    required this.costoVentaAdecuadoNo,
    required this.costoVentaAdecuadoNa,
    required this.realidadClienteSi,
    required this.realidadClienteNo,
    required this.realidadClienteNa,
    required this.razonCuotaSi,
    required this.razonCuotaNo,
    required this.razonCuotaNa,
    required this.razonCuotaMonto,
    required this.razonEndeudamientoSi,
    required this.razonEndeudamientoNo,
    required this.razonEndeudamientoNa,
    required this.garantiaRevisadaSi,
    required this.garantiaRevisadaNo,
    required this.garantiaRevisadaNa,
    required this.fiadorRevisadoSi,
    required this.fiadorRevisadoNo,
    required this.fiadorRevisadoNa,
    required this.monto,
    required this.plazo,
    required this.productoCodigo,
    required this.frecuenciaCodigo,
    required this.infoSocioEconomica,
    required this.infoFinanciera,
    required this.recomendacionFinal,
    required this.nombreRefComunidad1,
    required this.direccionRefComunidad1,
    required this.nombreRefComunidad2,
    required this.direccionRefComunidad2,
    required this.tiempoNegocio,
    required this.tipoSolicitud,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
        'BuroCreditoBueno': buroCreditoBueno,
        'BuroCreditoRegular': buroCreditoRegular,
        'BuroCreditoMalas': buroCreditoMalas,
        'ReferenciaComunidadBuena': referenciaComunidadBuena,
        'ReferenciaComunidadMala': referenciaComunidadMala,
        'ReferenciaComunidadRegular': referenciaComunidadRegular,
        'ReferenciaComunidadBuena2': referenciaComunidadBuena2,
        'ReferenciaComunidadMala2': referenciaComunidadMala2,
        'ReferenciaComunidadRegular2': referenciaComunidadRegular2,
        'TipoViviendaAlquilada': tipoViviendaAlquilada,
        'TipoViviendaPropia': tipoViviendaPropia,
        'TipoViviendaFamiliar': tipoViviendaFamiliar,
        'ConocimientoNegocioAlto': conocimientoNegocioAlto,
        'ConocimientoNegocioMedio': conocimientoNegocioMedio,
        'ConocimientoNegocioBajo': conocimientoNegocioBajo,
        'NivelVentasAcordeSi': nivelVentasAcordeSi,
        'NivelVentasAcordeNO': nivelVentasAcordeNo,
        'NivelVentasAcordeNA': nivelVentasAcordeNa,
        'CostoVentaAdecuadoSI': costoVentaAdecuadoSi,
        'CostoVentaAdecuadoNO': costoVentaAdecuadoNo,
        'CostoVentaAdecuadoNA': costoVentaAdecuadoNa,
        'RealidadClienteSI': realidadClienteSi,
        'RealidadClienteNO': realidadClienteNo,
        'RealidadClienteNA': realidadClienteNa,
        'RazonCuotaSI': razonCuotaSi,
        'RazonCuotaNO': razonCuotaNo,
        'RazonCuotaNA': razonCuotaNa,
        'RazonCuotaMonto': razonCuotaMonto,
        'RazonEndeudamientoSI': razonEndeudamientoSi,
        'RazonEndeudamientoNO': razonEndeudamientoNo,
        'RazonEndeudamientoNA': razonEndeudamientoNa,
        'GarantiaRevisadaSI': garantiaRevisadaSi,
        'GarantiaRevisadaNO': garantiaRevisadaNo,
        'GarantiaRevisadaNA': garantiaRevisadaNa,
        'FiadorRevisadoSI': fiadorRevisadoSi,
        'FiadorRevisadoNO': fiadorRevisadoNo,
        'FiadorRevisadoNA': fiadorRevisadoNa,
        'Monto': monto,
        'Plazo': plazo,
        'ProductoCodigo': productoCodigo,
        'FrecuenciaCodigo': frecuenciaCodigo,
        'InfoSocioEconomica': infoSocioEconomica,
        'InfoFinanciera': infoFinanciera,
        'RecomendacionFinal': recomendacionFinal,
        'NombreRefComunidad1': nombreRefComunidad1,
        'DireccionRefComunidad1': direccionRefComunidad1,
        'NombreRefComunidad2': nombreRefComunidad2,
        'DireccionRefComunidad2': direccionRefComunidad2,
        'TiempoNegocio': tiempoNegocio,
        'TipoSolicitud': tipoSolicitud,
      };
}
