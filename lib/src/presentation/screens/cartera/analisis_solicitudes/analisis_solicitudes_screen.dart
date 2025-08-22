import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/solicitudes/analisis_solicitudes_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_credit_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudesScreen extends StatelessWidget {
  const AnalisisSolicitudesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AnalisisSolicitudesCubit(
        SolicitudCreditoRepositoryImpl(),
      )..getSolicitudesByEstado(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analisis de solicitudes'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            const Expanded(
              child: _AnalisisSolicitudesTitle(),
            ),
            BlocBuilder<AnalisisSolicitudesCubit, AnalisisSolicitudesState>(
              builder: (context, state) {
                return switch (state.status) {
                  Status.inProgress => const Expanded(child: LoadingWidget()),
                  Status.error => Text('Error : ${state.errorMsg} '),
                  Status.done => Expanded(
                      flex: 5,
                      child: ListView.builder(
                        itemCount: state.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return AnalisisCreditCard(
                            tipoSolicitud: getTipoSolicitud(
                              tipoSolicitud: state.data[index].tipoSolicitud,
                              monto: state.data[index].monto!,
                            ),
                            index: index,
                            title:
                                'Numero Solicitud: ${state.data[index].numero} ${state.data[index].tipoSolicitud}',
                            subtitle: state.data[index].nombreCompleto ?? 'N/A',
                            description:
                                state.data[index].monto?.toCurrencyString() ??
                                    'N/A',
                          );
                        },
                      ),
                    ),
                  _ => const SizedBox(),
                };
              },
            ),
            const Gap(15),
          ],
        ),
      ),
    );
  }

  AnalisisSolicitudesInterceptorType getTipoSolicitud({
    required String tipoSolicitud,
    required String monto,
  }) {
    final montoInt = int.tryParse(monto) ?? 0;

    switch (tipoSolicitud) {
      case 'NUEVAMENOR':
        return montoInt >= 1000
            ? AnalisisSolicitudesInterceptorType.nuevaMayorAMil
            : AnalisisSolicitudesInterceptorType.nueva;

      case 'REPRESTAMO':
        return montoInt >= 1000
            ? AnalisisSolicitudesInterceptorType.represtamoMayorAMil
            : AnalisisSolicitudesInterceptorType.represtamo;

      case 'ASALARIADO':
        return AnalisisSolicitudesInterceptorType.asalariado;

      default:
        return AnalisisSolicitudesInterceptorType.nueva;
    }
  }
}

class _AnalisisSolicitudesTitle extends StatelessWidget {
  const _AnalisisSolicitudesTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analisis de solicitudes credito',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Gap(10),
          Text(
            'Evaluación detallada de las solicitudes de crédito para determinar su viabilidad y cumplimiento de criterios financieros.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}
