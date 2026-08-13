import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/actualizar/prendario/derecho_actualizar_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/actualizar/prendario/maquinaria_actualizar_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/actualizar/prendario/vehiculo_actualizar_garantia_form.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';
import 'package:flutter/material.dart';

class ActualizarDetalleBienPrendario extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final TipoArticuloEnum tipoArticulo;
  final String tipoPersonaCodigo;
  const ActualizarDetalleBienPrendario({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.tipoArticulo,
    required this.tipoPersonaCodigo,
  });

  @override
  State<ActualizarDetalleBienPrendario> createState() =>
      _ActualizarDetalleBienPrendarioState();
}

class _ActualizarDetalleBienPrendarioState
    extends State<ActualizarDetalleBienPrendario> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.tipoArticulo) {
      TipoArticuloEnum.vehiculo => VehiculoActualizarGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      TipoArticuloEnum.maquinaria => MaquinariaActualizarGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      TipoArticuloEnum.taxi => MaquinariaActualizarGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      TipoArticuloEnum.derecho => DerechoActualizarGarantiaForm(
          objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
          tipoPersonaCodigo: widget.tipoPersonaCodigo,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
