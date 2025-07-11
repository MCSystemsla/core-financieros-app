import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class CatalogoSync {
  static bool _shouldForceSync() {
    final lastSyncMillis = LocalStorage().lastUpdate;

    final lastSyncDate = DateTime.fromMillisecondsSinceEpoch(lastSyncMillis);
    final now = DateTime.now();
    final difference = now.difference(lastSyncDate);

    return difference.inHours >= 24;
  }

  static bool needToSync() {
    final shouldSync = _shouldForceSync();

    return shouldSync;
  }
}
