import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class CatalogoSync {
  static bool _shouldForceSync() {
    final lastSyncMillis = LocalStorage().lastUpdate;

    final lastSyncDate = DateTime.fromMillisecondsSinceEpoch(lastSyncMillis);
    final now = DateTime.now();
    final difference = now.difference(lastSyncDate);
    // Se debe sincronizar cada 5 horas
    return difference.inHours >= 5;
  }

  static bool needToSync() {
    final shouldSync = _shouldForceSync();

    return shouldSync;
  }
}
