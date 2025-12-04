import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/analisis_garantia_form_prendario.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_garantia/tipo_garantia_enum.dart';
import 'package:flutter/material.dart';

class AnalisisGarantiaFormInterceptor extends StatelessWidget {
  final TipoGarantiaEnum tipoGarantia;
  final int dpfsId;
  final int objAnalisisGarantiaID;
  final int articuloGarantiaCodigo;
  final String? descripcion;
  const AnalisisGarantiaFormInterceptor({
    super.key,
    required this.tipoGarantia,
    required this.dpfsId,
    required this.objAnalisisGarantiaID,
    required this.articuloGarantiaCodigo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return switch (tipoGarantia) {
      TipoGarantiaEnum.fiadorPrendario => AnalisisGarantiaFormPrendario(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoGarantiaEnum.liquida => AnalisisGarantiaFormPrendario(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      _ => const SizedBox(),
    };
  }
}
