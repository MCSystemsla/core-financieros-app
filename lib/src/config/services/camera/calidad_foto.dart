import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Resultado de la revisión automática de una foto: brillo medio (0–255) y
/// nitidez (varianza del laplaciano sobre una copia de 320 px de ancho).
///
/// Los umbrales son orientativos: sirven para sugerir repetir la foto, nunca
/// para bloquearla.
class CalidadFoto {
  final double brillo;
  final double nitidez;

  const CalidadFoto({required this.brillo, required this.nitidez});

  static const brilloMinimo = 70.0;
  static const brilloMaximo = 210.0;
  static const nitidezMinima = 60.0;

  bool get oscura => brillo < brilloMinimo;
  bool get muyClara => brillo > brilloMaximo;
  bool get borrosa => nitidez < nitidezMinima;
  bool get buenaLuz => !oscura && !muyClara;
  bool get esBuena => buenaLuz && !borrosa;

  /// Analiza la foto en un isolate. Devuelve `null` si no se pudo leer.
  static Future<CalidadFoto?> analizar(String path) =>
      compute(_analizarSync, path);
}

CalidadFoto? _analizarSync(String path) {
  try {
    final original = img.decodeImage(File(path).readAsBytesSync());
    if (original == null) return null;
    final imagen = img.copyResize(original, width: 320);
    final w = imagen.width;
    final h = imagen.height;
    if (w < 3 || h < 3) return null;

    final gris = Float64List(w * h);
    var suma = 0.0;
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        final p = imagen.getPixel(x, y);
        final l = 0.299 * p.r + 0.587 * p.g + 0.114 * p.b;
        gris[y * w + x] = l;
        suma += l;
      }
    }

    var s = 0.0;
    var s2 = 0.0;
    var n = 0;
    for (var y = 1; y < h - 1; y++) {
      for (var x = 1; x < w - 1; x++) {
        final i = y * w + x;
        final lap =
            gris[i - 1] + gris[i + 1] + gris[i - w] + gris[i + w] - 4 * gris[i];
        s += lap;
        s2 += lap * lap;
        n++;
      }
    }
    final media = s / n;
    return CalidadFoto(
      brillo: suma / (w * h),
      nitidez: s2 / n - media * media,
    );
  } catch (_) {
    return null;
  }
}
