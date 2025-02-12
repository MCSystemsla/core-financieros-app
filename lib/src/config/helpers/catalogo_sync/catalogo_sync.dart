import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';

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
    final haveSyncDataExists = getIt<ObjectBoxService>().catalogoBox.isEmpty();

    return shouldSync || haveSyncDataExists;
  }
}
