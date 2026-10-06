/// No se pudo generar el PDF a partir de las imágenes.
///
/// [imagePath] trae la ruta de la imagen que causó el fallo, si aplica.
class ImagesToPdfException implements Exception {
  final String message;
  final String? imagePath;

  const ImagesToPdfException(this.message, {this.imagePath});

  @override
  String toString() => imagePath == null
      ? 'ImagesToPdfException: $message'
      : 'ImagesToPdfException: $message ($imagePath)';
}
