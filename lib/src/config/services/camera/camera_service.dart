import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

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
}
