// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_plan_inversion/analisis_plan_inversion_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/add_item_card/add_item_custom_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class PlanInversionScreen extends StatelessWidget {
  final int numeroSolicitud;
  const PlanInversionScreen({super.key, required this.numeroSolicitud});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AnalisisPlanInversionHnCubit(
        AnalisisRepositoryHNImpl(),
      )..serNumeroSolicitud(numeroSolicitud),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Plan de inversion'),
        ),
        body: BlocConsumer<AnalisisPlanInversionHnCubit,
            AnalisisPlanInversionHnState>(
          listener: (context, state) {
            if (state.status == Status.done) {
              CustomAlertDialog(
                context: context,
                title: 'Plan de inversion creado exitosamente',
                onDone: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const AnalisisInterceptorByFlavor(),
                    ),
                  )
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
            final hasData = state.planInversion.isNotEmpty;
            final isLoading = state.status == Status.inProgress;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(20),
                  ListView.builder(
                    itemCount: state.planInversion.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final e = state.planInversion[index];

                      return AnalisisCardVentasDay(
                        subtitle: e.total.toCurrencyString(
                          mantissaLength: 0,
                        ),
                        title: e.cantidad.toString(),
                        description: e.descripcion,
                        onTap: () => {
                          showHistorialCreditoOptionsBottomSheet(
                            context: context,
                            onEdit: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (ctx) => _NivelProduccionSheetrHn(
                                  cubit: context
                                      .read<AnalisisPlanInversionHnCubit>(),
                                  numeroSolicitud: numeroSolicitud,
                                  isUpdate: true,
                                  planInversion: e,
                                ),
                              );
                            },
                            onDelete: () {
                              context
                                  .read<AnalisisPlanInversionHnCubit>()
                                  .deletePlanInversion(uuid: e.uuid);
                            },
                          ),
                        },
                      );
                    },
                  ),
                  const Gap(20),
                  AddItemCustomCard(
                    title: 'Crear plan de inversion',
                    onTap: () => {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (ctx) => _NivelProduccionSheetrHn(
                          cubit: context.read<AnalisisPlanInversionHnCubit>(),
                          numeroSolicitud: state.numeroSolicitud,
                        ),
                      ),
                    },
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomElevatedButton(
                      enabled: hasData && !isLoading,
                      onPressed: () {
                        context
                            .read<AnalisisPlanInversionHnCubit>()
                            .createAnalisisPlanInversion();
                      },
                      text: isLoading ? 'Enviando...' : 'Enviar',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NivelProduccionSheetrHn extends StatefulWidget {
  final AnalisisPlanInversionHnCubit cubit;
  final int numeroSolicitud;
  final PlanInversion? planInversion;
  final bool isUpdate;
  const _NivelProduccionSheetrHn({
    required this.cubit,
    required this.numeroSolicitud,
    this.planInversion,
    this.isUpdate = false,
  });

  @override
  State<_NivelProduccionSheetrHn> createState() =>
      _NivelProduccionSheetrHnState();
}

class _NivelProduccionSheetrHnState extends State<_NivelProduccionSheetrHn> {
  final formKey = GlobalKey<FormState>();
  int? cantidad;
  String? description;
  double? precioUnitario;
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      cantidad = widget.planInversion?.cantidad;
      description = widget.planInversion?.descripcion;
      precioUnitario = widget.planInversion?.precioUnitario;
    }
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
                    OutlineTextfieldWidget(
                      initialValue: cantidad?.toString().toNullIfEmptyOrZero(),
                      title: 'Cantidad',
                      icon: const Icon(Icons.comment_bank_sharp),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        cantidad = int.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: description,
                      title: 'Descripcion',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.text,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        description = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: precioUnitario
                          ?.toCurrencyString(
                            mantissaLength: 0,
                          )
                          .toNullIfEmptyOrZero(),
                      textAlign: TextAlign.end,
                      title: 'Precio Unitario ',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,\.]')),
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        precioUnitario = double.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled: true,
                        text: 'Crear',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          if (widget.isUpdate) {
                            widget.cubit.editPlanInversion(
                              planInversion: PlanInversion(
                                cantidad: cantidad!,
                                descripcion: description!,
                                precioUnitario: precioUnitario!,
                                total: ((cantidad ?? 0) * (precioUnitario ?? 0))
                                    .toInt(),
                                uuid: widget.planInversion?.uuid ?? '',
                              ),
                            );
                            context.pop();
                            return;
                          }

                          widget.cubit.createPlanInversion(
                            planInversion: PlanInversion(
                              uuid: const Uuid().v4(),
                              cantidad: cantidad!,
                              descripcion: description!,
                              precioUnitario: precioUnitario!,
                              total: ((cantidad ?? 0) * (precioUnitario ?? 0))
                                  .toInt(),
                            ),
                          );
                          context.pop();
                        },
                      ),
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
