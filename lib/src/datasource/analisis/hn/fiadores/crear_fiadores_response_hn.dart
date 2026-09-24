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
        ok: json['ok'] as bool? ?? false,
        message: json['message']?.toString() ?? '',
        data: CrearFiadorDataHN.fromJson(
          json['data'] as Map<String, dynamic>? ?? const {},
        ),
      );
}

class CrearFiadorDataHN {
  final String id;
  final int numeroSolicitud;

  CrearFiadorDataHN({
    required this.id,
    required this.numeroSolicitud,
  });

  factory CrearFiadorDataHN.fromJson(Map<String, dynamic> json) {
    final rawId = json['FiadorID'] ?? json['id'] ?? json['Id'];
    final rawNumeroSolicitud = json['FiadorSolicitude'];

    return CrearFiadorDataHN(
      id: rawId?.toString() ?? '',
      numeroSolicitud: rawNumeroSolicitud is num
          ? rawNumeroSolicitud.toInt()
          : int.tryParse(rawNumeroSolicitud?.toString() ?? '') ?? 0,
    );
  }
}
