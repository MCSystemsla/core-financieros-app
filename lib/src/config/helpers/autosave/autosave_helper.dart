import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';

class AutoSaveResponseLocalDb {
  final Box<ResponseLocalDb> box;
  final String uuid;
  final ResponseLocalDb Function(ResponseLocalDb? existing) buildModel;
  final void Function(ResponseLocalDb model) onSaved;

  Timer? _debounce;

  AutoSaveResponseLocalDb({
    required this.box,
    required this.uuid,
    required this.buildModel,
    required this.onSaved,
  });

  void trigger() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), _save);
  }

  void _save() {
    try {
      final existing =
          box.query(ResponseLocalDb_.uuid.equals(uuid)).build().findFirst();

      final model = buildModel(existing);
      box.put(model);
      onSaved(model);
    } catch (e, s) {
      log('🔥 Error en autosave: $e\n$s');
    }
  }
}
