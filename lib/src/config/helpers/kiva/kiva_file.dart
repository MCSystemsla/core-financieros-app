import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/src/config/helpers/android_version/android_version.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class KivaFile {
  static Future<String?> saveImageSignature({
    required SignatureController controller,
    String numeroSoicitud = 'numeroSoicitud',
  }) async {
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

    final customDirImages = Directory(
        '/storage/emulated/0/Core_Financiero_App/Kiva/$numeroSoicitud');

    final androidVersion = await AndroidVersionHelper.getAndroidVersion();
    final isAndroidVersionIsPermission =
        androidVersion != null && androidVersion >= 30;

    if (isAndroidVersionIsPermission) {
      if (!await customDirImages.exists()) {
        await customDirImages.create(recursive: true);
        log('Directorio creado: ${customDirImages.path}');
      }
    }
    if (isAndroidVersionIsPermission) {
      if (signatureImage != null) {
        final localPathImages =
            '${customDirImages.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final file = File(localPathImages);
        await file.writeAsBytes(signatureImage);
        log('Imagen guardada en Downloads: $localPathImages');
      }
    }

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
