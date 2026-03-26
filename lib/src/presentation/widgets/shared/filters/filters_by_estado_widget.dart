import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';

class AnalisisFilterContentWidget extends StatefulWidget {
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;

  const AnalisisFilterContentWidget({
    super.key,
    required this.estadoCredito,
    this.isAsignadaToAsesorCredito = true,
  });

  @override
  State<AnalisisFilterContentWidget> createState() =>
      _AnalisisFilterContentWidgetState();
}

class _AnalisisFilterContentWidgetState
    extends State<AnalisisFilterContentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesByEstadoHnCubit, SolicitudesByEstadoHnState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.done => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SearchBarCustom(
                      onItemSelected: (s) {},
                      onPressed: () {},
                      onTap: () => showFilterGetByCedualAndNumeroSolicitud(
                        context,
                        context.read<SolicitudesByEstadoHnCubit>(),
                        estadoCredito: widget.estadoCredito,
                        isAsignadaToAsesorCredito:
                            widget.isAsignadaToAsesorCredito,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: FilterView(
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

void showFilterGetByCedualAndNumeroSolicitud(
  BuildContext context,
  SolicitudesByEstadoHnCubit cubit, {
  required EstadoCredito estadoCredito,
  required bool isAsignadaToAsesorCredito,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => _FilterModal(
      cubit: cubit,
      estadoCredito: estadoCredito,
      isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
    ),
  );
}

class _FilterModal extends StatefulWidget {
  final SolicitudesByEstadoHnCubit cubit;
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;

  const _FilterModal({
    required this.cubit,
    required this.estadoCredito,
    required this.isAsignadaToAsesorCredito,
  });

  @override
  State<_FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<_FilterModal> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider.value(
      value: widget.cubit,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: bottomInset,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: BlocBuilder<SolicitudesByEstadoHnCubit,
              SolicitudesByEstadoHnState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          const Icon(Icons.filter_alt_rounded,
                              color: Colors.indigo),
                          const Gap(15),
                          Text(
                            'Filtrar por tipo de solicitud',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Text(
                        'Filtra las solicitudes por Cédula Cliente y Número Solicitud',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const Gap(20),

                      // Filtro Número Solicitud
                      SwitchListTile(
                        value: state.isNumeroSolicitudFilter,
                        title: const Text('Número Solicitud'),
                        subtitle: const Text('Filtra por número de solicitud'),
                        onChanged: (val) => widget.cubit.onFieldChanged(
                            () => state.copyWith(isNumeroSolicitudFilter: val)),
                      ),
                      if (state.isNumeroSolicitudFilter)
                        FadeIn(
                          child: OutlineTextfieldWidget(
                            initialValue: state.numeroSolicitud,
                            title: 'Ingresa el número de solicitud',
                            hintText: 'Ej: 2321',
                            icon: const Icon(Icons.request_page),
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChange: (val) => widget.cubit.onFieldChanged(
                                () => state.copyWith(numeroSolicitud: val)),
                            validator: (value) =>
                                ClassValidator.validateRequired(value),
                          ),
                        ),
                      const Gap(20),

                      // Filtro Cédula
                      SwitchListTile(
                        value: state.isCedulaSolicitudFilter,
                        title: const Text('Cédula del Cliente'),
                        subtitle: const Text('Filtra por cédula del cliente'),
                        onChanged: (val) => widget.cubit.onFieldChanged(
                            () => state.copyWith(isCedulaSolicitudFilter: val)),
                      ),
                      if (state.isCedulaSolicitudFilter)
                        FadeIn(
                          child: OutlineTextfieldWidget(
                            initialValue: state.cedulaCliente,
                            title: 'Ingresa cédula del Cliente',
                            hintText: 'Ej: 0809199901218T',
                            icon: const Icon(Icons.person),
                            inputFormatters: [UpperCaseTextFormatter()],
                            onChange: (val) => widget.cubit.onFieldChanged(
                                () => state.copyWith(cedulaCliente: val)),
                            validator: (value) =>
                                ClassValidator.validateRequired(value),
                          ),
                        ),
                      const Gap(30),
                      // if (state.isNumeroSolicitudFilter)
                      // FadeIn(
                      //   child: OutlineTextfieldWidget(
                      //     initialValue: state.numeroSolicitud,
                      //     onChange: (value) {},
                      //     validator: (value) =>
                      //         ClassValidator.validateRequired(value),
                      //     title: 'Ingresa el nombre del cliente',
                      //     hintText: 'Ej: Dery Galeas',
                      //     icon: const Icon(Icons.request_page),
                      //     textInputType: TextInputType.number,
                      //     inputFormatters: [
                      //       FilteringTextInputFormatter.digitsOnly,
                      //     ],
                      //   ),
                      // ),
                      // const Gap(20),

                      // Botón Limpiar
                      CustomElevatedButton(
                        text: 'Limpiar Filtros',
                        color: AppColors.red,
                        icon: const Icon(Icons.filter_alt_off_rounded,
                            color: Colors.white),
                        onPressed: () {
                          widget.cubit.cleanState();
                          widget.cubit.getSolicitudesByEstado(
                            estadoCredito: widget.estadoCredito,
                            isAsignadaToAsesorCredito:
                                widget.isAsignadaToAsesorCredito,
                          );
                          Navigator.pop(context);
                        },
                      ),
                      const Gap(20),

                      // Botón Guardar
                      CustomElevatedButton(
                        text: 'Guardar Cambios',
                        enabled: state.isNumeroSolicitudFilter ||
                            state.isCedulaSolicitudFilter,
                        color: AppColors.getSecondaryColor(),
                        icon: const Icon(Icons.save, color: Colors.white),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;

                          widget.cubit.onFieldChanged(() => state.copyWith(
                                numeroSolicitud: state.isNumeroSolicitudFilter
                                    ? state.numeroSolicitud
                                    : null,
                                cedulaCliente: state.isCedulaSolicitudFilter
                                    ? state.cedulaCliente
                                    : null,
                              ));

                          widget.cubit.getSolicitudesByEstado(
                            estadoCredito: widget.estadoCredito,
                            isAsignadaToAsesorCredito:
                                widget.isAsignadaToAsesorCredito,
                          );
                          Navigator.pop(context);
                        },
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
