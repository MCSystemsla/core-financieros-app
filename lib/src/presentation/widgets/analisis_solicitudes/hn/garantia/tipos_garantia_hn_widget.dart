import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/crear_garantia_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TiposGarantiaHNWidget extends StatelessWidget {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final String cedulaCliente;
  const TiposGarantiaHNWidget({
    super.key,
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.cedulaCliente,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisGarantiaCubit, AnalisisGarantiaState>(
      builder: (context, state) {
        return AnalisisCardListHn(
          isLoading: state.status == Status.inProgress,
          title: 'Tipos de garantías',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AnalisisGarantiaCubit>(),
                  child: CrearGarantiaScreen(
                    numeroSolicitud: numeroSolicitud,
                    solicitudCodigo: solicitudCodigo,
                    cedulaCliente: cedulaCliente,
                  ),
                ),
              ),
            );
          },
          items: [
            AnalisisCardItem(
              icon: Icons.verified_user_rounded,
              label: 'Total garantías',
              value: state.analisisGarantia.length.toString(),
              color: Colors.indigo,
            ),
          ],
        );
      },
    );
  }
}
