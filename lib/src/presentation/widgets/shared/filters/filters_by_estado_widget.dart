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
import 'package:go_router/go_router.dart';

import '../../../bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';

class AnalisisFilterContentWidget extends StatefulWidget {
  final EstadoCredito estadoCredito;
  const AnalisisFilterContentWidget({
    super.key,
    required this.estadoCredito,
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
                        widget.estadoCredito,
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
  SolicitudesByEstadoHnCubit cubit,
  EstadoCredito estadoCredito,
) {
  final bottomInset = MediaQuery.of(context).viewInsets.bottom;
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: bottomInset,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<SolicitudesByEstadoHnCubit,
                  SolicitudesByEstadoHnState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.filter_alt_rounded,
                                size: 24,
                                color: Colors.indigo,
                              ),
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
                            'Filtra las solicitudes por Cedula Cliente y Numero Solciitud',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                          const Gap(20),
                          SwitchListTile(
                            value: state.isNumeroSolicitudFilter,
                            onChanged: (value) {
                              cubit.onFieldChanged(
                                () => state.copyWith(
                                  isNumeroSolicitudFilter: value,
                                ),
                              );
                            },
                            title: const Text('Numero Solicitud'),
                            subtitle: const Text(
                              'Filtra las solicitudes por numero de solicitud',
                            ),
                          ),
                          if (state.isNumeroSolicitudFilter)
                            FadeIn(
                              child: OutlineTextfieldWidget(
                                initialValue: state.numeroSolicitud,
                                onChange: (value) {
                                  cubit.onFieldChanged(
                                    () => state.copyWith(
                                      numeroSolicitud: value,
                                    ),
                                  );
                                },
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                title: 'Ingresa el numero de solicitud',
                                hintText: 'Ej: 2321',
                                icon: const Icon(Icons.request_page),
                                textInputType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          const Gap(20),
                          SwitchListTile(
                            value: state.isCedulaSolicitudFilter,
                            onChanged: (value) {
                              cubit.onFieldChanged(
                                () => state.copyWith(
                                  isCedulaSolicitudFilter: value,
                                ),
                              );
                            },
                            title: const Text('Cedula del Cliente'),
                            subtitle: const Text(
                              'Filtra las solicitudes por cedula del cliente',
                            ),
                          ),
                          if (state.isCedulaSolicitudFilter)
                            FadeIn(
                              child: OutlineTextfieldWidget(
                                initialValue: state.cedulaCliente,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                title: 'Ingresa cedula del Cliente',
                                hintText: 'Ej: 0809199901218T',
                                icon: const Icon(Icons.person),
                                onChange: (value) {
                                  cubit.onFieldChanged(
                                    () => state.copyWith(
                                      cedulaCliente: value,
                                    ),
                                  );
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                              ),
                            ),
                          const Gap(20),
                          SwitchListTile(
                            value: false,
                            onChanged: (value) {},
                            title: const Text('Nombre de cliente'),
                            subtitle: const Text(
                              'Filtrar por nombre de cliente',
                            ),
                          ),
                          // if (state.isNumeroSolicitudFilter)
                          //   FadeIn(
                          //     child: OutlineTextfieldWidget(
                          //       initialValue: state.numeroSolicitud,
                          //       onChange: (value) {},
                          //       validator: (value) =>
                          //           ClassValidator.validateRequired(value),
                          //       title: 'Ingresa el nombre del cliente',
                          //       hintText: 'Ej: Dery Galeas',
                          //       icon: const Icon(Icons.request_page),
                          //       textInputType: TextInputType.number,
                          //       inputFormatters: [
                          //         FilteringTextInputFormatter.digitsOnly,
                          //       ],
                          //     ),
                          //   ),
                          const Gap(20),
                          CustomElevatedButton(
                            onPressed: () {
                              cubit.cleanState();
                              cubit.getSolicitudesByEstado(
                                estadoCredito: estadoCredito,
                                isAsignadaToAsesorCredito: true,
                              );
                              context.pop();
                            },
                            text: 'Limpiar Filtros',
                            color: AppColors.red,
                            icon: const Icon(
                              Icons.filter_alt_off_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(20),
                          CustomElevatedButton(
                            enabled: state.isNumeroSolicitudFilter ||
                                state.isCedulaSolicitudFilter,
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              if (!state.isNumeroSolicitudFilter) {
                                cubit.onFieldChanged(
                                  () => state.copyWith(
                                    numeroSolicitud: null,
                                  ),
                                );
                              }
                              if (!state.isCedulaSolicitudFilter) {
                                cubit.onFieldChanged(
                                  () => state.copyWith(
                                    cedulaCliente: null,
                                  ),
                                );
                              }
                              cubit.getSolicitudesByEstado(
                                estadoCredito: estadoCredito,
                                isAsignadaToAsesorCredito: true,
                              );
                              context.pop();
                            },
                            text: 'Guardar Cambios',
                            color: AppColors.getSecondaryColor(),
                            icon: const Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}
