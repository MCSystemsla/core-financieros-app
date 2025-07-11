import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';

class ReprestamoAutosave {
  final Box<ReprestamoResponsesLocalDb> box;
  final String uuid;
  final ReprestamoResponsesLocalDb Function(
      ReprestamoResponsesLocalDb? existing) buildModel;
  final void Function(ReprestamoResponsesLocalDb model) onSaved;

  Timer? _debounce;

  ReprestamoAutosave({
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
      final existing = box
          .query(ReprestamoResponsesLocalDb_.uuid.equals(uuid))
          .build()
          .findFirst();

      final model = buildModel(existing);
      box.put(model);
      onSaved(model);
    } catch (e, s) {
      log('🔥 Error en autosave: $e\n$s');
    }
  }
}
