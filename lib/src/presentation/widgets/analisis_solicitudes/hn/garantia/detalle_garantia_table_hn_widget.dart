import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/crear_garantia_detalle_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetalleGarantiaTableHNWidget extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoPersonaCodigo;
  final String cedulaCliente;
  const DetalleGarantiaTableHNWidget({
    super.key,
    required this.numeroSolicitud,
    required this.tipoPersonaCodigo,
    required this.cedulaCliente,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisArticuloCubit, AnalisisArticuloState>(
      builder: (context, state) {
        return AnalisisCardListHn(
          isLoading: state.status == Status.inProgress,
          title: 'Detalle Garantía',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AnalisisArticuloCubit>(),
                  child: CrearGarantiaDetalleScreen(
                    garantias: context
                        .read<AnalisisGarantiaCubit>()
                        .state
                        .analisisGarantia,
                    numeroSolicitud: numeroSolicitud,
                    tipoPersonaCodigo: tipoPersonaCodigo,
                    cedulaCliente: cedulaCliente,
                  ),
                ),
              ),
            );
          },
          items: [
            AnalisisCardItem(
              icon: Icons.payments_rounded,
              label: 'Total Valor Comercial',
              value: 'N/A',
              color: Colors.indigo,
            ),
            AnalisisCardItem(
              icon: Icons.inventory_2_rounded,
              label: 'Cantidad de Artículos',
              value: state.analisisGarantiaArticuloHn.length.toString(),
              color: Colors.blueGrey,
            ),
          ],
        );
      },
    );
  }
}
