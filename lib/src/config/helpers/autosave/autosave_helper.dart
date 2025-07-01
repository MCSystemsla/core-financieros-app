import 'dart:async';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';

class AutoSaveResponseLocalDb {
  final Box<ResponseLocalDb> box;
  final ResponseLocalDb Function() buildModel;
  final void Function(ResponseLocalDb model)? onSaved;
  final Duration debounceDuration;

  Timer? _debounce;
  String uuid;

  AutoSaveResponseLocalDb({
    required this.box,
    required this.buildModel,
    required this.uuid,
    this.onSaved,
    this.debounceDuration = const Duration(seconds: 1),
  });

  void trigger() {
    _debounce?.cancel();
    _debounce = Timer(debounceDuration, _save);
  }

  void forceSave() {
    _debounce?.cancel();
    _save();
  }

  void _save() {
    final model = buildModel();
    final existing =
        box.query(ResponseLocalDb_.uuid.equals(uuid)).build().findFirst();

    if (existing != null) {
      model.id = existing.id;
    }

    box.put(model);
    onSaved?.call(model);
  }

  void dispose() {
    _debounce?.cancel();
  }
}
