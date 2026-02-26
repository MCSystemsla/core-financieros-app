import 'dart:convert';

ComiteCalculoDatosResponse comiteCalculoDatosResponseFromJson(String str) =>
    ComiteCalculoDatosResponse.fromJson(json.decode(str));

String comiteCalculoDatosResponseToJson(ComiteCalculoDatosResponse data) =>
    json.encode(data.toJson());

class ComiteCalculoDatosResponse {
  final ComiteData data;

  const ComiteCalculoDatosResponse({
    required this.data,
  });

  factory ComiteCalculoDatosResponse.fromJson(Map<String, dynamic> json) =>
      ComiteCalculoDatosResponse(
        data: ComiteData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}

class ComiteData {
  final ComiteInteres interes;
  final ComiteComision comision;
  final ComiteSeguros seguros;
  final double montoSolicitado;
  final double montoTotal;

  const ComiteData({
    required this.interes,
    required this.comision,
    required this.seguros,
    required this.montoSolicitado,
    required this.montoTotal,
  });

  factory ComiteData.fromJson(Map<String, dynamic> json) => ComiteData(
        interes: ComiteInteres.fromJson(json['Interes']),
        comision: ComiteComision.fromJson(json['Comision']),
        seguros: ComiteSeguros.fromJson(json['Seguros']),
        montoSolicitado: json['MontoSolicitado']?.toDouble(),
        montoTotal: json['MontoTotal']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'Interes': interes.toJson(),
        'Comision': comision.toJson(),
        'Seguros': seguros.toJson(),
        'MontoSolicitado': montoSolicitado,
        'MontoTotal': montoTotal,
      };
}

class ComiteComision {
  final double monto;
  final double tasa;

  const ComiteComision({
    required this.monto,
    required this.tasa,
  });

  factory ComiteComision.fromJson(Map<String, dynamic> json) => ComiteComision(
        monto: json['Monto']?.toDouble(),
        tasa: json['Tasa']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'Monto': monto,
        'Tasa': tasa,
      };
}

class ComiteInteres {
  final double tasaInteresCorriente;
  final double tasaInteresMoratorio;

  const ComiteInteres({
    required this.tasaInteresCorriente,
    required this.tasaInteresMoratorio,
  });

  factory ComiteInteres.fromJson(Map<String, dynamic> json) => ComiteInteres(
        tasaInteresCorriente: json['TasaInteresCorriente']?.toDouble(),
        tasaInteresMoratorio: json['TasaInteresMoratorio']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'TasaInteresCorriente': tasaInteresCorriente,
        'TasaInteresMoratorio': tasaInteresMoratorio,
      };
}

class ComiteSeguros {
  final double saldoDeudor;
  final double telemedicina;
  final double agricola;
  final double mapfre;
  final double vida;
  final double montoTotalSeguros;

  const ComiteSeguros({
    required this.saldoDeudor,
    required this.telemedicina,
    required this.agricola,
    required this.mapfre,
    required this.vida,
    required this.montoTotalSeguros,
  });

  factory ComiteSeguros.fromJson(Map<String, dynamic> json) => ComiteSeguros(
        saldoDeudor: json['SaldoDeudor']?.toDouble(),
        telemedicina: json['Telemedicina']?.toDouble(),
        agricola: json['Agricola']?.toDouble(),
        mapfre: json['Mapfre']?.toDouble(),
        vida: json['Vida']?.toDouble(),
        montoTotalSeguros: json['MontoTotalSeguros']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'SaldoDeudor': saldoDeudor,
        'Telemedicina': telemedicina,
        'Agricola': agricola,
        'Mapfre': mapfre,
        'Vida': vida,
        'MontoTotalSeguros': montoTotalSeguros,
      };
}
