import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/nueva_menor_mil/nueva_menor_mil_local_db.dart';

class NuevaMenorMilAutosaveHN {
  final Box<NuevaMenorMilLocalDb> box;
  final String uuid;
  final int numeroSolicitud;
  final NuevaMenorMilLocalDb Function(NuevaMenorMilLocalDb? existing)
      buildModel;
  final void Function(NuevaMenorMilLocalDb model) onSaved;

  Timer? _debounce;

  NuevaMenorMilAutosaveHN({
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
          .query(NuevaMenorMilLocalDb_.numeroSolicitud.equals(numeroSolicitud))
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
