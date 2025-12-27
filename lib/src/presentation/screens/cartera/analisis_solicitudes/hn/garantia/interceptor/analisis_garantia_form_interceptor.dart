import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/prendario/analisis_garantia_form_prendario_maquinaria.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/prendario/analisis_garantia_form_prendario_mobiliario.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/prendario/analisis_garantia_form_prendario_taxi.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/analisis_garantia_form_hipotecario.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/analisis_garantia_form_liquida.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/forms/analisis_garantia_form_prendario_vehiculo.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';

class AnalisisGarantiaFormInterceptor extends StatelessWidget {
  final int dpfsId;
  final int objAnalisisGarantiaID;
  final int? articuloGarantiaCodigo;
  final String? descripcion;
  final TipoArticuloEnum? tipoArticulo;
  const AnalisisGarantiaFormInterceptor({
    super.key,
    required this.dpfsId,
    required this.objAnalisisGarantiaID,
    required this.articuloGarantiaCodigo,
    this.tipoArticulo,
    this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return switch (tipoArticulo) {
      TipoArticuloEnum.dpf => AnalisisGarantiaFormLiquida(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoArticuloEnum.edificio => AnalisisGarantiaFormHipotecario(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoArticuloEnum.casa => AnalisisGarantiaFormHipotecario(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoArticuloEnum.terreno => AnalisisGarantiaFormHipotecario(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoArticuloEnum.taxi => AnalisisGarantiaFormPrendarioTaxi(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoArticuloEnum.vehiculo => AnalisisGarantiaFormVehiculo(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoArticuloEnum.mobiliarioYEquipo =>
        AnalisisGarantiaFormPrendarioMobiliario(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      TipoArticuloEnum.maquinaria => AnalisisGarantiaFormPrendarioMaquinaria(
          dpfsId: dpfsId,
          objAnalisisGarantiaID: objAnalisisGarantiaID,
          articuloGarantiaCodigo: articuloGarantiaCodigo,
          descripcion: descripcion,
        ),
      _ => const SizedBox(),
    };
  }
}
