class AnalisisGarantiaObtenerDetalleDpf {
  final AnalisisGarantiaObtenerDetalleDpfData data;

  AnalisisGarantiaObtenerDetalleDpf({
    required this.data,
  });

  factory AnalisisGarantiaObtenerDetalleDpf.fromJson(
          Map<String, dynamic> json) =>
      AnalisisGarantiaObtenerDetalleDpf(
        data: AnalisisGarantiaObtenerDetalleDpfData.fromJson(json['data']),
      );
}

class AnalisisGarantiaObtenerDetalleDpfData {
  final int dpfId;
  final String numeroCuenta;
  final int valorInicial;
  final int valorComercial;
  final String observaciones;

  AnalisisGarantiaObtenerDetalleDpfData({
    required this.dpfId,
    required this.numeroCuenta,
    required this.valorInicial,
    required this.valorComercial,
    required this.observaciones,
  });

  factory AnalisisGarantiaObtenerDetalleDpfData.fromJson(
          Map<String, dynamic> json) =>
      AnalisisGarantiaObtenerDetalleDpfData(
        dpfId: json['DpfID'],
        numeroCuenta: json['NumeroCuenta'],
        valorInicial: json['ValorInicial'],
        valorComercial: json['ValorComercial'],
        observaciones: json['Observaciones'],
      );
}
