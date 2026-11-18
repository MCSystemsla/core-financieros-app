/// Fechas clave de la temporada navideña que muestran un saludo en el Inicio.
enum SaludoFestivo { navidad, anioNuevo }

/// Decide cuándo se muestran las decoraciones navideñas.
///
/// La temporada va del 1 de diciembre al 6 de enero (Día de Reyes), así que
/// todo se apaga solo, sin otro release.
abstract class TemporadaNavidena {
  static bool activa([DateTime? fecha]) {
    final hoy = fecha ?? DateTime.now();
    return hoy.month == DateTime.december ||
        (hoy.month == DateTime.january && hoy.day <= 6);
  }

  /// Saludo del día: Navidad el 24 y 25 de diciembre, Año Nuevo el 31 de
  /// diciembre y el 1 de enero. Los demás días devuelve `null`.
  static SaludoFestivo? saludoDelDia([DateTime? fecha]) {
    final hoy = fecha ?? DateTime.now();
    if (hoy.month == DateTime.december && (hoy.day == 24 || hoy.day == 25)) {
      return SaludoFestivo.navidad;
    }
    if ((hoy.month == DateTime.december && hoy.day == 31) ||
        (hoy.month == DateTime.january && hoy.day == 1)) {
      return SaludoFestivo.anioNuevo;
    }
    return null;
  }

  /// Año al que pertenece el saludo: el 31 de diciembre ya cuenta como el año
  /// que empieza, para que el saludo de Año Nuevo tenga una sola clave.
  static int anioDelSaludo(SaludoFestivo saludo, [DateTime? fecha]) {
    final hoy = fecha ?? DateTime.now();
    return saludo == SaludoFestivo.anioNuevo && hoy.month == DateTime.december
        ? hoy.year + 1
        : hoy.year;
  }

  /// Clave con la que se recuerda que el asesor cerró el saludo, p. ej.
  /// `navidad-2026` o `anioNuevo-2027`.
  static String claveSaludo(SaludoFestivo saludo, [DateTime? fecha]) =>
      '${saludo.name}-${anioDelSaludo(saludo, fecha)}';
}
