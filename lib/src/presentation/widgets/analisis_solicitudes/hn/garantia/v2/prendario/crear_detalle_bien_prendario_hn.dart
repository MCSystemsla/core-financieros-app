import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/prendario/derecho_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/prendario/maquinaria_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/prendario/vehiculo_garantia_form.dart';

import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';
import 'package:flutter/material.dart';

class CrearDetalleBienPrendario extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final TipoArticuloEnum tipoArticulo;
  const CrearDetalleBienPrendario({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.tipoArticulo,
  });

  @override
  State<CrearDetalleBienPrendario> createState() =>
      _CrearDetalleBienPrendarioState();
}

class _CrearDetalleBienPrendarioState extends State<CrearDetalleBienPrendario> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.tipoArticulo) {
      TipoArticuloEnum.vehiculo => VehiculoGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
        ),
      TipoArticuloEnum.maquinaria => MaquinariaGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
        ),
      TipoArticuloEnum.taxi => MaquinariaGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
        ),
      TipoArticuloEnum.derecho => DerechoGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
