import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/represtamo/analisis_represtamo_hn_local_db.dart';

class AnalisisReprestamoHnAutosave {
  final Box<AnalisisReprestamoHnLocalDb> box;
  final String uuid;
  final int numeroSolicitud;
  final AnalisisReprestamoHnLocalDb Function(
      AnalisisReprestamoHnLocalDb? existing) buildModel;
  final void Function(AnalisisReprestamoHnLocalDb model) onSaved;

  Timer? _debounce;

  AnalisisReprestamoHnAutosave({
    required this.box,
    required this.uuid,
    required this.buildModel,
    required this.onSaved,
    required this.numeroSolicitud,
  });

  void trigger() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _save);
  }

  void _save() {
    try {
      final existing = box
          .query(AnalisisReprestamoHnLocalDb_.numeroSolicitud
              .equals(numeroSolicitud))
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
