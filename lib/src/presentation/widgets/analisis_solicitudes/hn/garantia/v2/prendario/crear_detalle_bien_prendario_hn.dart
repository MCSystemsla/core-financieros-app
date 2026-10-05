import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/prendario/derecho_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/prendario/maquinaria_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/prendario/vehiculo_garantia_form.dart';

import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';
import 'package:flutter/material.dart';

class CrearDetalleBienPrendario extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final TipoArticuloEnum tipoArticulo;
  final String tipoPersonaCodigo;
  const CrearDetalleBienPrendario({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.tipoArticulo,
    required this.tipoPersonaCodigo,
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
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      TipoArticuloEnum.maquinaria => MaquinariaGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      TipoArticuloEnum.taxi => MaquinariaGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      TipoArticuloEnum.derecho => DerechoGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
