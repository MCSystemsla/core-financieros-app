import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_obtener_bien_by_codigo/analisis_obtener_bien_by_codigo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/actualizar/prendario/derecho_actualizar_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/actualizar/prendario/maquinaria_actualizar_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/actualizar/prendario/vehiculo_actualizar_garantia_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<AnalisisObtenerBienByCodigoCubit,
        AnalisisObtenerBienByCodigoState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const LoadingWidget(),
          Status.error => OnErrorWidget(
              errorMsg: state.errorMsg,
              onPressed: () {},
            ),
          Status.done => switch (widget.tipoArticulo) {
              TipoArticuloEnum.vehiculo => VehiculoActualizarGarantiaForm(
                  objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
                  tipoPersonaCodigo: widget.tipoPersonaCodigo,
                  bien: state,
                ),
              TipoArticuloEnum.maquinaria => MaquinariaActualizarGarantiaForm(
                  objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
                  tipoPersonaCodigo: widget.tipoPersonaCodigo,
                  bien: state,
                ),
              TipoArticuloEnum.taxi => MaquinariaActualizarGarantiaForm(
                  objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
                  tipoPersonaCodigo: widget.tipoPersonaCodigo,
                  bien: state,
                ),
              TipoArticuloEnum.derecho => DerechoActualizarGarantiaForm(
                  objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
                  tipoPersonaCodigo: widget.tipoPersonaCodigo,
                  bien: state,
                ),
              _ => const SizedBox.shrink(),
            },
          _ => const SizedBox(),
        };
      },
    );
  }
}
