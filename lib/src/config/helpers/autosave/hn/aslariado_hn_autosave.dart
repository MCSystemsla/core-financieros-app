import 'dart:async';
import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';

class AutoSaveSolicitudAsalariadoHN {
  final Box<SolicitudAsalariadoHnDbLocal> box;
  final String uuid;
  final SolicitudAsalariadoHnDbLocal Function(
      SolicitudAsalariadoHnDbLocal? existing) buildModel;
  final void Function(SolicitudAsalariadoHnDbLocal model) onSaved;

  Timer? _debounce;

  AutoSaveSolicitudAsalariadoHN({
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
          .query(SolicitudAsalariadoHnDbLocal_.uuid.equals(uuid))
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
