import 'dart:io';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:logger/logger.dart';

abstract class DeleteFolder {
  Future<void> saveLastDeleteDate();
  Future<bool> shouldDeleteFolder({required Duration determiningTime});
  Future<void> deleteCoreFinancieroFolderByDetermineDate();
}

class DeleteFolderImpl extends DeleteFolder {
  final _logger = Logger();
  @override
  Future<bool> shouldDeleteFolder({required Duration determiningTime}) async {
    final lastDeleteDate = LocalStorage().lastDeleteDate;

    if (lastDeleteDate.isEmpty) return true;

    final lastDate = DateTime.tryParse(lastDeleteDate);
    if (lastDate == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastDate);

    return difference >= determiningTime;
  }

  @override
  Future<void> deleteCoreFinancieroFolderByDetermineDate() async {
    try {
      final needsDelete =
          await shouldDeleteFolder(determiningTime: const Duration(days: 6));

      if (!needsDelete) return;
      final folder = Directory('/storage/emulated/0/Core_Financiero_App/');

      if (!await folder.exists()) {
        _logger.d('🧹 Carpeta `Core_Financiero_App` No Existe');
        return;
      }

      await folder.delete(recursive: true);
      await saveLastDeleteDate();
      _logger.d('Carpeta `Core_Financiero_App` borrada');
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  Future<void> saveLastDeleteDate() async {
    await LocalStorage().setLastDeleteDate(DateTime.now().toIso8601String());
  }
}
