import 'dart:io';
import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SaveMapSnapshotHelper {
  Future<Uint8List?> saveMapSnapshot({
    required GoogleMapController controller,
  }) async {
    return await controller.takeSnapshot();
  }

  Future<File?> saveMapSnapshotToFile({
    required GoogleMapController controller,
    required String fileName,
  }) async {
    final Uint8List? snapshot = await saveMapSnapshot(controller: controller);
    if (snapshot == null) return null;

    final File file = File(fileName);
    await file.writeAsBytes(snapshot, flush: true);
    return file;
  }
}
