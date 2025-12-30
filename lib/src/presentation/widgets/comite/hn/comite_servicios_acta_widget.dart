import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_create_service_schema.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_servicios_response.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_create_servicios/comite_create_servicios_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_servicios/comite_servicios_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ComiteServiciosActaWidget extends StatelessWidget {
  final int comiteId;
  final int numeroSolicitud;
  final int plazoCredito;
  final double montoCredito;
  final double capitalAdeudado;
  final int primaSegurosDanios;
  final bool esGrupal;
  final bool esMayorA60;
  final bool esDPF;
  final bool esCreditoHipotecario;

  const ComiteServiciosActaWidget({
    super.key,
    required this.comiteId,
    required this.numeroSolicitud,
    required this.plazoCredito,
    required this.montoCredito,
    required this.capitalAdeudado,
    required this.primaSegurosDanios,
    this.esGrupal = false,
    this.esMayorA60 = false,
    this.esDPF = false,
    this.esCreditoHipotecario = false,
  });

  @override
  Widget build(BuildContext context) {
    final repository = ComiteRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ComiteServiciosCubit(
            repository,
          )..getComiteServicios(
              numeroSolicitud: numeroSolicitud,
              plazoCredito: plazoCredito,
              montoCredito: montoCredito,
              capitalAdeudado: capitalAdeudado,
              primaSegurosDanios: primaSegurosDanios,
              esGrupal: esGrupal,
              esMayorA60: esMayorA60,
              esDPF: esDPF,
              esCreditoHipotecario: esCreditoHipotecario,
            ),
        ),
        BlocProvider(
          create: (ctx) => ComiteCreateServiciosCubit(
            repository,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Servicios Acta'),
        ),
        bottomNavigationBar: _BottomButton(
          comiteId: comiteId,
        ),
        body: BlocBuilder<ComiteServiciosCubit, ComiteServiciosState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.done => _ListItems(
                  data: state.data,
                ),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context.read<ComiteServiciosCubit>().getComiteServicios(
                          numeroSolicitud: numeroSolicitud,
                          plazoCredito: plazoCredito,
                          montoCredito: montoCredito,
                          capitalAdeudado: capitalAdeudado,
                          primaSegurosDanios: primaSegurosDanios,
                          esGrupal: esGrupal,
                          esMayorA60: esMayorA60,
                          esDPF: esDPF,
                          esCreditoHipotecario: esCreditoHipotecario,
                        );
                  },
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class _ListItems extends StatelessWidget {
  final List<ComiteServicesData> data;
  const _ListItems({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Expanded(
        child: EmptyListWidget(
          message: 'No hay servicios para mostrar',
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          ListView.builder(
            itemCount: data.length,
            addAutomaticKeepAlives: true,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _Item(
                data: data[index],
              );
            },
          ).fadeIn(),
        ],
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    required this.data,
  });

  final ComiteServicesData data;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.data.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 25,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: CustomSwitch(
        title: widget.data.nombre,
        subtitle: 'Monto: ${widget.data.monto.toCurrencyString()}',
        value: isSelected,
        onChanged: (v) {
          final servicio = ServicioData(
            servicioId: widget.data.id,
            montoServicio: widget.data.monto.toInt(),
          );
          setState(() => isSelected = v);
          if (!v) {
            context.read<ComiteCreateServiciosCubit>().deleteServicios(
                  servicio: servicio,
                );
            return;
          }

          context.read<ComiteCreateServiciosCubit>().saveServicios(
                servicio: servicio,
              );
        },
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final int comiteId;
  const _BottomButton({required this.comiteId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComiteCreateServiciosCubit, ComiteCreateServiciosState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Servicios creados exitosamente',
            onDone: () => {
              context.pop(),
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
        return Padding(
          padding: const EdgeInsets.all(15),
          child: CustomElevatedButton(
            color: Colors.green,
            enabled:
                state.status != Status.inProgress && state.servicios.isNotEmpty,
            icon: state.status == Status.inProgress
                ? Container(
                    width: 15,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.add, color: Colors.white),
            text: state.status == Status.inProgress
                ? 'Creando...'
                : 'Crear Servicios',
            onPressed: () => context
                .read<ComiteCreateServiciosCubit>()
                .crearServicios(comiteId: comiteId),
          ),
        );
      },
    );
  }
}
