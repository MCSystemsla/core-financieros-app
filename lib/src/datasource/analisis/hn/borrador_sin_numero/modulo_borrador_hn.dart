/// Módulos del análisis HN que guardan datos locales por `numeroSolicitud`.
enum ModuloBorradorHn { analisis, planInversion, fiadores, imagenes, ubicacion }

/// Resultado de vincular un borrador sin número con la solicitud AUT.
class VinculoBorradorResultado {
  /// Módulos cuyos datos pasaron al número real.
  final Set<ModuloBorradorHn> vinculados;

  /// Módulos descartados porque el número real ya tenía datos.
  final Set<ModuloBorradorHn> conDatosPrevios;

  /// El análisis se descartó porque el monto de la AUT cambió el formulario.
  final bool analisisDescartadoPorMonto;

  const VinculoBorradorResultado({
    required this.vinculados,
    required this.conDatosPrevios,
    required this.analisisDescartadoPorMonto,
  });
}
