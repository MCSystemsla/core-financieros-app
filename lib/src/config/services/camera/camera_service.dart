// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/config/helpers/android_version/android_version.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class CameraService {
  static Future<(String, XFile)> takeAndsavePhoto({
    required CameraController controller,
    String numeroSoicitud = 'numero_solicitud',
  }) async {
    final photo = await controller.takePicture();
    final appDir = await getApplicationDocumentsDirectory();
    final customDir = Directory('${appDir.path}/KivaImages');
    final customDirImages = Directory(
        '/storage/emulated/0/Core_Financiero_App/Kiva/$numeroSoicitud');
    final androidVersion = await AndroidVersionHelper.getAndroidVersion();
    final isAndroidVersionIsPermission =
        androidVersion != null && androidVersion >= 30;

    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
      log('Directorio creado: ${customDir.path}');
    }
    if (isAndroidVersionIsPermission) {
      if (!await customDirImages.exists()) {
        await customDirImages.create(recursive: true);
        log('Directorio creado: ${customDirImages.path}');
      }
    }
    final localPath =
        '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final imageFile = File(photo.path);
    await imageFile.copy(localPath);
    log('Imagen guardada en: $localPath');

    if (isAndroidVersionIsPermission) {
      final localPathImages =
          '${customDirImages.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFileImages = File(photo.path);
      await imageFileImages.copy(localPathImages);
      log('Imagen guardada en Downloads: $localPathImages');
    }
    return (localPath, photo);
  }

  static Future<(String, File)> takeImageAndSaveWithCropped({
    required CameraController controller,
  }) async {
    final (savedPath, photo) = await takeAndsavePhoto(controller: controller);
    final Uint8List originalBytes = await photo.readAsBytes();
    final img.Image? decodedImage = img.decodeImage(originalBytes);
    if (decodedImage == null) {
      throw Exception('No se pudo decodificar la imagen');
    }

    final imageWidth = decodedImage.width;
    final imageHeight = decodedImage.height;

    final frameWidth = (imageWidth * 0.7).round();
    final frameHeight = (imageHeight * 0.25).round();

    final left = ((imageWidth - frameWidth) / 2).round();
    final top = ((imageHeight - frameHeight) / 2).round();
    final croppedImage = img.copyCrop(
      decodedImage,
      x: left,
      y: top,
      width: frameWidth,
      height: frameHeight,
    );

    final directory = await getApplicationDocumentsDirectory();
    final croppedDir = Directory('${directory.path}/cedulas_solicitudes');
    if (!await croppedDir.exists()) {
      await croppedDir.create(recursive: true);
      log('Directorio creado: ${croppedDir.path}');
    }
    final croppedPath =
        '${croppedDir.path}/cedula_cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';

    log('Ruta de imagen recortada: $croppedPath');
    final croppedFile = File(croppedPath)
      ..writeAsBytesSync(img.encodeJpg(croppedImage));

    return (croppedPath, croppedFile);
  }
}
