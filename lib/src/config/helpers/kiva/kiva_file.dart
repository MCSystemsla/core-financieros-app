import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class KivaFile {
  static Future<String?> saveImageSignature(
      {required SignatureController controller}) async {
    final directory = await getApplicationDocumentsDirectory();
    final customDir = Directory('${directory.path}/MySignatures');

    // Crea el directorio si no existe
    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
      log('Directorio creado: ${customDir.path}');
    }

    // Define la ruta de la imagen directamente en el directorio
    final localPath =
        '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    // Genera la imagen de la firma
    final signatureImage = await controller.toPngBytes();

    if (signatureImage != null) {
      // Guarda la imagen directamente en el directorio
      final file = File(localPath);
      await file.writeAsBytes(signatureImage);
      log('Firma guardada en: $localPath');
      return localPath; // Retorna la ruta del archivo guardado
    } else {
      log('No se pudo generar la imagen de la firma.');
      return null;
    }
  }
}
