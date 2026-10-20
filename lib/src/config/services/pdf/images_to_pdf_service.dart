import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:core_financiero_app/src/domain/exceptions/images_to_pdf_exception.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Convierte una lista de imágenes locales en un único PDF para el
/// expediente digital. Compartido por todos los países.
class ImagesToPdfService {
  static const int maxImageDimension = 2400;
  static const int jpgQuality = 75;
  static const String pdfDirectoryName = 'expediente_pdfs';

  /// Margen de cada página, en puntos PDF.
  static const double _pageMargin = 20;

  /// Genera `<outputDirectory ?? Documents/expediente_pdfs>/<fileName>.pdf`
  /// con una página por imagen de [imagePaths], en el mismo orden.
  ///
  /// [fileName] va sin extensión (ej. `expediente_12345`). Si ya existe un
  /// PDF con ese nombre, se sobrescribe. [outputDirectory] solo se usa en
  /// tests; en la app se omite.
  ///
  /// Lanza [ImagesToPdfException] si la lista está vacía, si [fileName] no es
  /// válido o si alguna imagen no existe o no se puede decodificar. En ese
  /// caso no escribe ningún archivo.
  static Future<File> generate({
    required List<String> imagePaths,
    required String fileName,
    Directory? outputDirectory,
  }) async {
    if (imagePaths.isEmpty) {
      throw const ImagesToPdfException('No hay imágenes para generar el PDF');
    }
    if (fileName.isEmpty || fileName.contains('/') || fileName.contains(r'\')) {
      throw ImagesToPdfException('Nombre de PDF no válido: "$fileName"');
    }

    final paths = List<String>.of(imagePaths);
    final pdfBytes = await Isolate.run(() async {
      final jpgImages = <Uint8List>[];
      for (final path in paths) {
        jpgImages.add(_prepareImage(path));
      }
      return _buildPdf(jpgImages);
    });

    final directory = outputDirectory ??
        Directory(
          '${(await getApplicationDocumentsDirectory()).path}/$pdfDirectoryName',
        );
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final pdf = File('${directory.path}/$fileName.pdf');
    return pdf.writeAsBytes(pdfBytes, flush: true);
  }

  /// Borra [pdf] si existe. No falla si ya fue borrado.
  static Future<void> deletePdf(File pdf) async {
    if (await pdf.exists()) {
      await pdf.delete();
    }
  }

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

  /// Arma el PDF con una página A4 vertical por imagen, en el mismo orden
  /// de [jpgImages]. Cada imagen va centrada y sin recorte dentro del margen.
  static Future<Uint8List> _buildPdf(List<Uint8List> jpgImages) {
    final doc = pw.Document();
    for (final bytes in jpgImages) {
      final image = pw.MemoryImage(bytes);
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(_pageMargin),
          build: (_) => pw.Center(
            child: pw.Image(image, fit: pw.BoxFit.contain),
          ),
        ),
      );
    }
    return doc.save();
  }
}
