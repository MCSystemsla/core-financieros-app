import 'dart:convert';

KivaConfiguracionResponse kivaConfiguracionFromJson(String str) =>
    KivaConfiguracionResponse.fromJson(json.decode(str));

class KivaConfiguracionResponse {
  final List<KivaConfigurationData> data;

  KivaConfiguracionResponse({
    required this.data,
  });

  factory KivaConfiguracionResponse.fromJson(Map<String, dynamic> json) =>
      KivaConfiguracionResponse(
        data: List<KivaConfigurationData>.from(
            json['data']?.map((x) => KivaConfigurationData.fromJson(x))),
      );
}

class KivaConfigurationData {
  final String? productoCodigo;
  final String? producto;
  final bool? esRecurrente;
  final String? formularioKiva;
  final int? montoMinimo;
  final int? montoMaximo;
  final int? plazoMinimo;
  final int? plazoMaximo;
  final bool? aplicaMigrantesEconomicos;
  final bool? masculino;
  final bool? femenino;

  KivaConfigurationData({
    this.productoCodigo,
    this.producto,
    this.esRecurrente,
    this.formularioKiva,
    this.montoMinimo,
    this.montoMaximo,
    this.plazoMinimo,
    this.plazoMaximo,
    this.aplicaMigrantesEconomicos,
    this.masculino,
    this.femenino,
  });

  factory KivaConfigurationData.fromJson(Map<String, dynamic> json) =>
      KivaConfigurationData(
        productoCodigo: json['ProductoCodigo'],
        producto: json['Producto'],
        esRecurrente: json['EsRecurrente'],
        formularioKiva: json['FormularioKiva'],
        montoMinimo: json['MontoMinimo'],
        montoMaximo: json['MontoMaximo'],
        plazoMinimo: json['PlazoMinimo'],
        plazoMaximo: json['PlazoMaximo'],
        aplicaMigrantesEconomicos: json['AplicaMigrantesEconomicos'],
        masculino: json['Masculino'],
        femenino: json['Femenino'],
      );

  Map<String, dynamic> toJson() => {
        'ProductoCodigo': productoCodigo,
        'Producto': producto,
        'EsRecurrente': esRecurrente,
        'FormularioKiva': formularioKiva,
        'MontoMinimo': montoMinimo,
        'MontoMaximo': montoMaximo,
        'PlazoMinimo': plazoMinimo,
        'PlazoMaximo': plazoMaximo,
        'AplicaMigrantesEconomicos': aplicaMigrantesEconomicos,
      };
}
