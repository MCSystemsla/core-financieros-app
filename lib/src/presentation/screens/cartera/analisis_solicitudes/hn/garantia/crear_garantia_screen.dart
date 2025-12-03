import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/crear_garantia_moda_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CrearGarantiaScreen extends StatelessWidget {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final String cedulaCliente;
  const CrearGarantiaScreen({
    super.key,
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.cedulaCliente,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Garantía'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => BlocProvider.value(
              value: context.read<AnalisisGarantiaCubit>(),
              child: CreateGarantiaModalSheet(
                numeroSolicitud: numeroSolicitud,
                solicitudCodigo: solicitudCodigo,
                cedulaCliente: cedulaCliente,
              ),
            ),
          );
        },
        backgroundColor: Colors.black,
        label: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Gap(5),
            Text(
              'Crear Garantia',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AnalisisGarantiaCubit, AnalisisGarantiaState>(
        builder: (context, state) {
          return switch (state.status) {
            Status.inProgress => const LoadingWidget(),
            Status.error => Text('Error: ${state.errorMsg}'),
            Status.done => SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.analisisGarantia.length,
                      itemBuilder: (context, index) {
                        final e = state.analisisGarantia[index];
                        return AnalisisCardVentasDay(
                          subtitle: e.tipoGarantia,
                          title: 'Cedula Cliente ${e.cedulaCliente}',
                          description: e.tipoPersona,
                          onTap: () {
                            showHistorialCreditoOptionsBottomSheet(
                              context: context,
                              onEdit: () => {},
                              onDelete: () {},
                            );
                          },
                        );
                      },
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
