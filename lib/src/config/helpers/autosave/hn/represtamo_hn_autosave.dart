import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/local_db/solicitud_represtamo_hn_local_db.dart';

class ReprestamoHnAutosave {
  final Box<SolicitudReprestamoHnLocalDb> box;
  final String uuid;
  final SolicitudReprestamoHnLocalDb Function(
      SolicitudReprestamoHnLocalDb? existing) buildModel;
  final void Function(SolicitudReprestamoHnLocalDb model) onSaved;

  Timer? _debounce;

  ReprestamoHnAutosave({
    required this.box,
    required this.uuid,
    required this.buildModel,
    required this.onSaved,
  });

  void trigger() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _save);
  }

  void _save() {
    try {
      final existing = box
          .query(SolicitudReprestamoHnLocalDb_.uuid.equals(uuid))
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
