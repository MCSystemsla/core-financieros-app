import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/nueva_mayor_mil/analisis_nueva_mayor_a_mil_hn_local_db.dart';

class NuevaMayorAMilAutosaveHN {
  final Box<AnalisisNuevaMayorAMilHnLocalDb> box;
  final String uuid;
  final int numeroSolicitud;
  final AnalisisNuevaMayorAMilHnLocalDb Function(
      AnalisisNuevaMayorAMilHnLocalDb? existing) buildModel;
  final void Function(AnalisisNuevaMayorAMilHnLocalDb model) onSaved;

  Timer? _debounce;

  NuevaMayorAMilAutosaveHN({
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
          .query(AnalisisNuevaMayorAMilHnLocalDb_.numeroSolicitud
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
