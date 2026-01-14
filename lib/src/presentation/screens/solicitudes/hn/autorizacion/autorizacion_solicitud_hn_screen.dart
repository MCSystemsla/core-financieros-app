// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/close_analisis_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/credit_producto/credit_product_item_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/filters/filters_by_estado_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/solicitudes/hn/cubit/autorizar_solicitud/autorizar_solicitud_cubit.dart';
import '../../../../bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';

class AutorizacionSolicitudHnScreen extends StatelessWidget {
  const AutorizacionSolicitudHnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesByEstadoHnCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          )..getSolicitudesByEstado(
              isAsignadaToAsesorCredito: true,
              estadoCredito: EstadoCredito.registrada,
            ),
        ),
        BlocProvider(
          create: (ctx) => AutorizarSolicitudCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          ),
        ),
      ],
      child: PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            context.push('/cartera');
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Autorización de Crédito'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Expanded(
                child: _AnalisisSolicitudesTitle(),
              ),
              const AnalisisFilterContentWidget(
                estadoCredito: EstadoCredito.registrada,
              ),
              BlocBuilder<SolicitudesByEstadoHnCubit,
                  SolicitudesByEstadoHnState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const Expanded(child: LoadingWidget()),
                    Status.error => OnErrorWidget(
                        errorMsg: state.errorMsg,
                        onPressed: () {
                          context
                              .read<SolicitudesByEstadoHnCubit>()
                              .getSolicitudesByEstado(
                                isAsignadaToAsesorCredito: true,
                                estadoCredito: EstadoCredito.registrada,
                              );
                        },
                      ),
                    Status.done => _ListDataWidget(
                        data: state.solicitudes,
                        isAsignadaToAsesorCredito:
                            state.isAsignadaToAsesorCredito,
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListDataWidget extends StatelessWidget {
  final List<SolicitudEstado> data;
  final bool isAsignadaToAsesorCredito;
  const _ListDataWidget({
    required this.data,
    required this.isAsignadaToAsesorCredito,
  });
  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Expanded(
        child: EmptyListWidget(
          message: 'No hay solicitudes por autorizar',
        ),
      );
    }
    return Expanded(
      flex: 4,
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CreditProductItemHN(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => BlocProvider.value(
                  value: context.read<AutorizarSolicitudCubit>(),
                  child: AutorizarSolicitudBottomSheet(
                    numeroSolicitud: int.tryParse(data[index].numero) ?? 0,
                    tipoSolicitud: data[index].tipoSolicitud,
                  ),
                ),
              );
            },
            isAsesorAsignado: isAsignadaToAsesorCredito,
            tipoSolicitud: data[index].tipoSolicitud,
            solicitudId: data[index].id,
            title: 'Numero Solicitud: ${data[index].numero}',
            fecha: data[index].fechaSolicitud,
            monto: data[index].monto!.toCurrencyString(
                  mantissaLength: 0,
                ),
            estadoCodigo: data[index].estado,
            sucursal: data[index].sucursal ?? 'N/A',
            nombreCliente: data[index].nombreCompleto,
            nombrePromotor: data[index].nombrePromotor,
          );
        },
      ),
    );
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
            'Autorizacion de Crédito',
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

class AutorizarSolicitudBottomSheet extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  const AutorizarSolicitudBottomSheet({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.21,
      minChildSize: 0.2,
      maxChildSize: 0.4,
      expand: false,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xfff9fafb),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 25,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Gap(18),
              BlocConsumer<AutorizarSolicitudCubit, AutorizarSolicitudState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == Status.done) {
                    CustomAlertDialog(
                      context: context,
                      title: 'Solicitud autorizada exitosamente.',
                      onDone: () {
                        context.pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                const AutorizacionSolicitudHnScreen(),
                          ),
                        );
                      },
                    ).showDialog(
                      context,
                      dialogType: DialogType.success,
                    );
                  }
                  if (state.status == Status.error) {
                    CustomAlertDialog(
                      context: context,
                      title: state.errorMsg,
                      onDone: () => context.pop(),
                    ).showDialog(
                      context,
                      dialogType: DialogType.error,
                    );
                  }
                },
                builder: (context, state) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      SelectableCardItem(
                        isLoading: state.status == Status.inProgress,
                        icon: Icons.verified_user,
                        color: const Color(0xFF2E7D32),
                        title: 'Autorizar Solicitud',
                        subtitle: 'Autorizar solicitud de crédito',
                        onTap: () => {
                          CloseAnalisisDialog(
                            context: context,
                            title:
                                '¿Estás seguro que desea autorizar la solicitud?',
                            onYes: () {
                              context.pop();
                              context
                                  .read<AutorizarSolicitudCubit>()
                                  .autorizarSolicitudCredito(
                                    numeroSolicitud: numeroSolicitud,
                                    tipoSolicitud: tipoSolicitud,
                                  );
                            },
                          ).showDialog(
                            context,
                            dialogType: DialogType.infoReverse,
                          )
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ).fadeIn();
      },
    );
  }
}
