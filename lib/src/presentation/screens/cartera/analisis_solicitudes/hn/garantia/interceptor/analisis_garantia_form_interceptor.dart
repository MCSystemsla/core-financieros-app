import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/analisis_garantia_form_hipotecario.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/analisis_garantia_form_liquida.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/analisis_garantia_form_prendario.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_garantia/tipo_garantia_enum.dart';
import 'package:flutter/material.dart';

class AnalisisGarantiaFormInterceptor extends StatelessWidget {
  final TipoGarantiaEnum? tipoGarantia;
  final int dpfsId;
  final int objAnalisisGarantiaID;
  final int? articuloGarantiaCodigo;
  final String? descripcion;
  const AnalisisGarantiaFormInterceptor({
    super.key,
    this.tipoGarantia,
    required this.dpfsId,
    required this.objAnalisisGarantiaID,
    required this.articuloGarantiaCodigo,
    this.descripcion,
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
      TipoGarantiaEnum.liquida => AnalisisGarantiaFormLiquida(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoGarantiaEnum.fiadorHipotecario =>
        const AnalisisGarantiaFormHipotecario(),
      TipoGarantiaEnum.hipotecario => const AnalisisGarantiaFormHipotecario(),
      TipoGarantiaEnum.fiadorSolidario => const Text(
          'Solidario',
        ),
      TipoGarantiaEnum.fiduciario => const Text(
          'Fiduciario',
        ),
      TipoGarantiaEnum.prendaAgraria => const Text(
          'Prenda agraria',
        ),
      _ => const SizedBox(),
    };
  }
}
