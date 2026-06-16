import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_create_service_schema.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_servicios_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/comite/comite_create_servicios/comite_create_servicios_cubit.dart';
import '../../../../bloc/comite/comite_servicios/comite_servicios_cubit.dart';

class V2ServiciosComiteGrupalScreen extends StatefulWidget {
  final int comiteId;
  final num monto;
  final int plazoCredito;
  const V2ServiciosComiteGrupalScreen({
    super.key,
    required this.comiteId,
    required this.monto,
    required this.plazoCredito,
  });

  @override
  State<V2ServiciosComiteGrupalScreen> createState() =>
      _V2ServiciosComiteGrupalScreenState();
}

class _V2ServiciosComiteGrupalScreenState
    extends State<V2ServiciosComiteGrupalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _BottomService(
        comite: widget.comiteId,
        monto: widget.monto,
        plazoCredito: widget.plazoCredito,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text('Gestionar Servicios'),
      ),
      body: const _ContenidoModal(),
    );
  }
}

class _BottomService extends StatelessWidget {
  final int comite;
  final num monto;
  final int plazoCredito;
  const _BottomService({
    required this.comite,
    required this.monto,
    required this.plazoCredito,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComiteCreateServiciosCubit, ComiteCreateServiciosState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
              context: context,
              title: 'Servicios creados exitosamente',
              onDone: () {
                context.pop();
                Navigator.of(context).pop(true);
              }).showDialog(
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
            dialogType: DialogType.warning,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: CustomElevatedButton(
              color: Colors.green,
              enabled: state.status != Status.inProgress &&
                  state.servicios.isNotEmpty,
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
              onPressed: () {
                context.read<ComiteCreateServiciosCubit>().crearServicios(
                      comiteId: comite,
                      montoCredito: monto.toDouble(),
                      plazoCredito: plazoCredito,
                    );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ContenidoModal extends StatelessWidget {
  const _ContenidoModal();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<ComiteServiciosCubit, ComiteServiciosState>(
        builder: (context, state) {
          return switch (state.status) {
            Status.inProgress => const ModernLoadingWidget(
                message: 'Cargando servicios...',
              ),
            Status.error => const Text('error'),
            Status.done => _ListItems(data: state.data),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _ListItems extends StatefulWidget {
  final List<ComiteServicesData> data;
  const _ListItems({
    required this.data,
  });

  @override
  State<_ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<_ListItems> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ComiteCreateServiciosCubit>();
    final serviciosSeleccionados = widget.data.where((e) => e.isSelected);
    if (serviciosSeleccionados.isEmpty) return;
    cubit.saveAllServicios(
        servicios: serviciosSeleccionados
            .map((e) => ServicioData(
                  servicioId: e.id,
                  montoServicio: e.monto.toDouble(),
                  tipoCalculo: e.tipoCalculo,
                  nombreServicio: e.nombre,
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
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
            itemCount: widget.data.length,
            addAutomaticKeepAlives: true,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _Item(
                data: widget.data[index],
              );
            },
          ).fadeIn(),
          const Gap(30),
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
        onChanged: (v) async {
          final servicio = ServicioData(
            servicioId: widget.data.id,
            montoServicio: widget.data.monto.toDouble(),
            tipoCalculo: widget.data.tipoCalculo,
            nombreServicio: widget.data.nombre,
          );

          setState(() => isSelected = v);

          if (!v) {
            context.read<ComiteCreateServiciosCubit>().deleteServicios(
                  servicio: servicio,
                );
            return;
          }
          if (widget.data.tipoCalculo == 'MANUAL') {
            final monto = await _openMontoManualSheet(context);

            if (monto == null) {
              setState(() => isSelected = false);
              return;
            }
            if (!context.mounted) return;

            context.read<ComiteCreateServiciosCubit>().saveServicios(
                  servicio: ServicioData(
                    servicioId: widget.data.id,
                    montoServicio: monto,
                    tipoCalculo: widget.data.tipoCalculo,
                    nombreServicio: widget.data.nombre,
                  ),
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

Future<double?> _openMontoManualSheet(BuildContext context) {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showModalBottomSheet<double>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const Gap(20),

                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFFE8F0FE),
                      child: Icon(
                        Icons.attach_money_rounded,
                        size: 28,
                        color: Colors.blue,
                      ),
                    ),

                    const Gap(16),

                    const Text(
                      'Monto del servicio',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Gap(6),

                    const Text(
                      'Ingrese el monto que desea aplicar',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Gap(24),

                    /// Campo monto
                    OutlineTextfieldWidget(
                      padding: EdgeInsets.zero,
                      textEditingController: controller,
                      title: 'Monto del servicio',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: Icon(
                        Icons.attach_money_rounded,
                        color: AppColors.getPrimaryColor(),
                      ),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        CurrencyInputFormatter(),
                      ],
                    ),

                    const Gap(24),

                    /// Botón guardar
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'Guardar servicio',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          final value = toNumericString(
                            controller.text,
                            allowPeriod: true,
                          );

                          Navigator.pop(context, double.tryParse(value));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
