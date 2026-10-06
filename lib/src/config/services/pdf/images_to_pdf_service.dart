import 'dart:io';
import 'dart:typed_data';

import 'package:core_financiero_app/src/domain/exceptions/images_to_pdf_exception.dart';
import 'package:image/image.dart' as img;

/// Convierte una lista de imágenes locales en un único PDF para el
/// expediente digital. Compartido por todos los países.
class ImagesToPdfService {
  static const int maxImageDimension = 1600;
  static const int jpgQuality = 75;
  static const String pdfDirectoryName = 'expediente_pdfs';

  /// Lee la imagen en [path], corrige su orientación EXIF, la reduce a
  /// [maxImageDimension] px de lado máximo (nunca la agranda) y la devuelve
  /// como JPG con calidad [jpgQuality].
  ///
  /// Es síncrono a propósito: corre dentro de `Isolate.run`.
  static Uint8List _prepareImage(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      throw ImagesToPdfException('La imagen no existe', imagePath: path);
    }

    final img.Image? decoded;
    try {
      decoded = img.decodeImage(file.readAsBytesSync());
    } catch (_) {
      throw ImagesToPdfException(
        'No se pudo decodificar la imagen',
        imagePath: path,
      );
    }
    if (decoded == null) {
      throw ImagesToPdfException(
        'No se pudo decodificar la imagen',
        imagePath: path,
      );
    }

    var image = img.bakeOrientation(decoded);
    if (image.width > maxImageDimension || image.height > maxImageDimension) {
      image = image.width >= image.height
          ? img.copyResize(image, width: maxImageDimension)
          : img.copyResize(image, height: maxImageDimension);
    }

    return img.encodeJpg(image, quality: jpgQuality);
  }
}
