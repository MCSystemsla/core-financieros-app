import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';

class AsalariadoAutosave {
  final Box<AsalariadoResponsesLocalDb> box;
  final String uuid;
  final AsalariadoResponsesLocalDb Function(
      AsalariadoResponsesLocalDb? existing) buildModel;
  final void Function(AsalariadoResponsesLocalDb model) onSaved;

  Timer? _debounce;

  AsalariadoAutosave({
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
          .query(AsalariadoResponsesLocalDb_.uuid.equals(uuid))
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
