import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class CameraService {
  static Future<(String, XFile)> takeAndsavePhoto({
    required CameraController controller,
  }) async {
    final photo = await controller.takePicture();
    final appDir = await getApplicationDocumentsDirectory();
    final customDir = Directory('${appDir.path}/MyImages');

    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
      log('Directorio creado: ${customDir.path}');
    }

    final localPath =
        '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final imageFile = File(photo.path);
    await imageFile.copy(localPath);
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

    // Guardar imagen recortada en archivo temporal
    final directory = await getTemporaryDirectory();
    final croppedPath =
        '${directory.path}/cedula_cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final croppedFile = File(croppedPath)
      ..writeAsBytesSync(img.encodeJpg(croppedImage));

    return (croppedPath, croppedFile);
  }
}
