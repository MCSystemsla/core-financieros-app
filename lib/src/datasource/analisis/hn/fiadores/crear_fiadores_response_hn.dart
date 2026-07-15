class CrearFiadorResponseHn {
  final bool ok;
  final String message;
  final CrearFiadorDataHN data;

  CrearFiadorResponseHn({
    required this.ok,
    required this.message,
    required this.data,
  });

  factory CrearFiadorResponseHn.fromJson(Map<String, dynamic> json) =>
      CrearFiadorResponseHn(
        ok: json['ok'],
        message: json['message'],
        data: CrearFiadorDataHN.fromJson(json['data']),
      );
}

class CrearFiadorDataHN {
  final String id;
  final int numeroSolicitud;

  CrearFiadorDataHN({
    required this.id,
    required this.numeroSolicitud,
  });

  factory CrearFiadorDataHN.fromJson(Map<String, dynamic> json) =>
      CrearFiadorDataHN(
        id: json['ID'],
        numeroSolicitud: json['NumeroSolicitud'],
      );
}
