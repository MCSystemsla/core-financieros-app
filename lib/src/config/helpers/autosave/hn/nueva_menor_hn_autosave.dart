import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';

class NuevaMenorHnAutosave {
  final Box<SolicitudNuevaMenorHnLocalDb> box;
  final String uuid;
  final SolicitudNuevaMenorHnLocalDb Function(
      SolicitudNuevaMenorHnLocalDb? existing) buildModel;
  final void Function(SolicitudNuevaMenorHnLocalDb model) onSaved;

  Timer? _debounce;

  NuevaMenorHnAutosave({
    required this.box,
    required this.uuid,
    required this.buildModel,
    required this.onSaved,
  });

  void trigger() async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _save);
  }

  void _save() {
    try {
      final existing = box
          .query(SolicitudNuevaMenorHnLocalDb_.uuid.equals(uuid))
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
