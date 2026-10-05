import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_garantia/fiadores_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateGarantiaModalSheet extends StatefulWidget {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final String cedulaCliente;
  const CreateGarantiaModalSheet({
    super.key,
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.cedulaCliente,
  });

  @override
  State<CreateGarantiaModalSheet> createState() =>
      _CreateGarantiaModalSheetState();
}

class _CreateGarantiaModalSheetState extends State<CreateGarantiaModalSheet> {
  final formKey = GlobalKey<FormState>();
  String? tipoGarantia;

  String? tipoPersona;
  String? tipoArticulo;
  String? cedulaFiador;
  String? fiadorId;
  double? montoGarantia;
  @override
  void initState() {
    super.initState();
    cedulaFiador = widget.cedulaCliente;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        maxChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const Gap(15),
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      codigo: 'TIPOGARANTIA',
                      title: 'Tipo Garantia',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() {
                          tipoGarantia = v.value;

                          tipoArticulo = null;
                        });
                        context
                            .read<AnalisisArticuloCubit>()
                            .getAnalisisGarantiasArticulos(
                              tipoGarantiaCodigo: v.value,
                            );
                      },
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      codigo: 'TIPOPERSONA',
                      title: 'Tipo Persona',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() {
                          tipoPersona = v.value;
                          fiadorId = null;
                          cedulaFiador = widget.cedulaCliente;
                        });
                        context
                            .read<FiadoresGarantiaCubit>()
                            .getFiadoresByNumeroSolicitud(
                              numeroSolicitud: widget.numeroSolicitud,
                              tipoFiadorCodigo: v.value,
                            );
                      },
                    ),
                    if (tipoPersona != null && tipoPersona != 'DEUDOR') ...[
                      const Gap(20),
                      BlocBuilder<FiadoresGarantiaCubit, FiadoresGarantiaState>(
                        builder: (context, state) {
                          final isLoading = state.status == Status.inProgress ||
                              state.status == Status.notStarted;
                          if (state.status == Status.error) {
                            return _DropdownErrorRetry(
                              title: 'Fiador',
                              message: state.errorMsg.isEmpty
                                  ? 'No se pudieron cargar los fiadores'
                                  : state.errorMsg,
                              onRetry: () => context
                                  .read<FiadoresGarantiaCubit>()
                                  .getFiadoresByNumeroSolicitud(
                                    numeroSolicitud: widget.numeroSolicitud,
                                    tipoFiadorCodigo: tipoPersona!,
                                  ),
                            );
                          }
                          final isEmpty = state.data.isEmpty;
                          return SheetSearchDropdown(
                            key: ValueKey('fiador-$tipoPersona'),
                            title: 'Fiador',
                            isRequired: true,
                            isLoading: isLoading,
                            enabled: !isLoading && !isEmpty,
                            hintText: isLoading
                                ? 'Cargando fiadores...'
                                : isEmpty
                                    ? 'No hay fiadores para este tipo de persona'
                                    : 'Selecciona fiador de garantia',
                            validator: (value) {
                              if (isLoading) {
                                return 'Espera a que carguen los fiadores';
                              }
                              if (isEmpty) {
                                return 'No hay fiadores disponibles';
                              }
                              return ClassValidator.validateRequired(
                                  value?.value);
                            },
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                fiadorId = v.value;
                                cedulaFiador =
                                    v.anotherValue ?? widget.cedulaCliente;
                              });
                            },
                            items: state.data
                                .map(
                                  (e) => Item(
                                    name: e.fiadorInfo,
                                    value: e.fiadorId,
                                    anotherValue: e.fiadorCedula,
                                  ),
                                )
                                .toList(),
                          );
                        },
                      )
                    ],
                    if (tipoGarantia != null) ...[
                      const Gap(20),
                      BlocBuilder<AnalisisArticuloCubit, AnalisisArticuloState>(
                        builder: (context, state) {
                          final isLoading = state.status == Status.inProgress ||
                              state.status == Status.notStarted;
                          if (state.status == Status.error) {
                            return _DropdownErrorRetry(
                              title: 'Articulo',
                              message: state.errorMsg.isEmpty
                                  ? 'No se pudieron cargar los articulos'
                                  : state.errorMsg,
                              onRetry: () => context
                                  .read<AnalisisArticuloCubit>()
                                  .getAnalisisGarantiasArticulos(
                                    tipoGarantiaCodigo: tipoGarantia!,
                                  ),
                            );
                          }
                          final isEmpty =
                              state.analisisGarantiaArticuloHn.isEmpty;
                          return SheetSearchDropdown(
                            key: ValueKey('articulo-$tipoGarantia'),
                            title: 'Articulo',
                            isRequired: true,
                            isLoading: isLoading,
                            enabled: !isLoading && !isEmpty,
                            hintText: isLoading
                                ? 'Cargando articulos...'
                                : isEmpty
                                    ? 'No hay articulos para este tipo de garantia'
                                    : 'Ingresa un articulo',
                            validator: (value) {
                              if (isLoading) {
                                return 'Espera a que carguen los articulos';
                              }
                              if (isEmpty) {
                                return 'No hay articulos disponibles';
                              }
                              return ClassValidator.validateRequired(
                                  value?.value.toString());
                            },
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                tipoArticulo = v.value.toString();
                              });
                            },
                            items: state.analisisGarantiaArticuloHn
                                .map(
                                  (e) =>
                                      Item(name: e.descripcion, value: e.valor),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                    const Gap(12),
                    OutlineTextfieldWidget(
                      title: 'Monto de la Garantia',
                      icon: Icon(
                        Icons.wallet,
                        color: AppColors.getPrimaryColor(),
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        montoGarantia = double.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    BlocConsumer<AnalisisGarantiaCubit, AnalisisGarantiaState>(
                      listenWhen: (prev, curr) =>
                          prev.statusCreate != curr.statusCreate,
                      listener: (context, state) {
                        if (state.statusCreate == Status.done) {
                          CustomAlertDialog(
                            context: context,
                            title: 'Garantia creada exitosamente',
                            onDone: () => {
                              context
                                  .read<AnalisisGarantiaCubit>()
                                  .getGarantiasByNumero(
                                    numeroSolicitud: widget.numeroSolicitud,
                                  ),
                              context.pop(),
                              context.pop(),
                            },
                          ).showDialog(
                            context,
                            dialogType: DialogType.success,
                          );
                        }
                        if (state.statusCreate == Status.error) {
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
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: CustomElevatedButton(
                            enabled: state.statusCreate != Status.inProgress,
                            text: state.statusCreate == Status.inProgress
                                ? 'Creando...'
                                : 'Crear',
                            // ignore: deprecated_member_use
                            color: AppColors.greenLatern.withOpacity(0.4),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              context
                                  .read<AnalisisGarantiaCubit>()
                                  .createAnalisisGarantia(
                                    numeroSolicitud: widget.numeroSolicitud,
                                    solicitudCodigo: widget.solicitudCodigo,
                                    analisisGarantia: AnalisisGarantia(
                                      tipoGarantiaCodigo: tipoGarantia!,
                                      tipoPersonaCodigo: tipoPersona!,
                                      articuloCodigo:
                                          int.tryParse(tipoArticulo ?? '0') ??
                                              0,
                                      cedulaPropietario: cedulaFiador!,
                                      fiadorId:
                                          int.tryParse(fiadorId ?? '0') ?? 0,
                                      montoGarantia: montoGarantia!,
                                    ),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DropdownErrorRetry extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const _DropdownErrorRetry({
    required this.title,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(8),
          Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.red, size: 20),
              const Gap(8),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: AppColors.red, fontSize: 13),
                ),
              ),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
