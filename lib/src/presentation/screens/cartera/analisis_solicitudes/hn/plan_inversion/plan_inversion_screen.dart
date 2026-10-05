// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_plan_inversion/analisis_plan_inversion_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
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
        backgroundColor: RedesignColors.background,
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
                dialogType: DialogType.warning,
              );
            }
          },
          builder: (context, state) {
            final hasData = state.planInversion.isNotEmpty;
            final isLoading = state.status == Status.inProgress;
            final totalInversion = state.planInversion.fold<int>(
              0,
              (sum, e) => sum + e.total,
            );
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScreenHeaderWidget(
                    title: 'Plan de inversión',
                    subtitle:
                        'Solicitud #$numeroSolicitud. Detalla en qué se invertirá el crédito.',
                    onBack: () => Navigator.pop(context),
                  ),
                  const Gap(18),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      children: [
                        _ResumenInversionCard(
                          total: totalInversion,
                          items: state.planInversion.length,
                        ),
                        const Gap(22),
                        const Text(
                          'ARTÍCULOS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                            color: RedesignColors.inkMuted,
                          ),
                        ),
                        const Gap(10),
                        if (!hasData) const _EmptyPlanInversion(),
                        for (final e in state.planInversion) ...[
                          _PlanInversionItemCard(
                            planInversion: e,
                            onTap: () => {
                              showHistorialCreditoOptionsBottomSheet(
                                context: context,
                                onEdit: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
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
                          ),
                          const Gap(8),
                        ],
                        const Gap(4),
                        _AgregarArticuloButton(
                          onTap: () => {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (ctx) => _NivelProduccionSheetrHn(
                                cubit: context
                                    .read<AnalisisPlanInversionHnCubit>(),
                                numeroSolicitud: state.numeroSolicitud,
                              ),
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                    decoration: const BoxDecoration(
                      color: RedesignColors.surface,
                      border: Border(
                        top: BorderSide(color: RedesignColors.border),
                      ),
                    ),
                    child: CustomElevatedButton(
                      enabled: hasData && !isLoading,
                      onPressed: () {
                        context
                            .read<AnalisisPlanInversionHnCubit>()
                            .createAnalisisPlanInversion();
                      },
                      text: isLoading ? 'Enviando...' : 'Enviar',
                      color: RedesignColors.green,
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
              color: RedesignColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                        height: 4,
                        decoration: BoxDecoration(
                          color: RedesignColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const Gap(18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isUpdate
                                ? 'Editar artículo'
                                : 'Nuevo artículo',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                              color: RedesignColors.ink,
                            ),
                          ),
                          const Gap(4),
                          const Text(
                            'El total se calcula con cantidad × precio unitario.',
                            style: TextStyle(
                              fontSize: 13,
                              color: RedesignColors.inkMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(12),
                    OutlineTextfieldWidget(
                      initialValue: cantidad?.toString().toNullIfEmptyOrZero(),
                      title: 'Cantidad',
                      icon: const Icon(
                        Icons.numbers_rounded,
                        color: RedesignColors.inkMuted,
                      ),
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
                      icon: const Icon(
                        Icons.inventory_2_outlined,
                        color: RedesignColors.inkMuted,
                      ),
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
                      icon: const Icon(
                        Icons.payments_outlined,
                        color: RedesignColors.inkMuted,
                      ),
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
                        text: widget.isUpdate ? 'Guardar cambios' : 'Agregar',
                        color: RedesignColors.ink,
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

class _ResumenInversionCard extends StatelessWidget {
  final int total;
  final int items;
  const _ResumenInversionCard({required this.total, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: RedesignColors.greenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: RedesignColors.green,
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total a invertir',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: RedesignColors.inkMuted,
                  ),
                ),
                const Gap(2),
                Text(
                  total.toCurrencyString(mantissaLength: 0),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    color: RedesignColors.ink,
                  ),
                ),
              ],
            ),
          ),
          CardTagWidget(
            label: items == 1 ? '1 artículo' : '$items artículos',
            color: RedesignColors.green,
            background: RedesignColors.greenTint,
          ),
        ],
      ),
    );
  }
}

class _PlanInversionItemCard extends StatelessWidget {
  final PlanInversion planInversion;
  final VoidCallback onTap;
  const _PlanInversionItemCard({
    required this.planInversion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: RedesignColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: RedesignColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: RedesignColors.tagBackground,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  '${planInversion.cantidad}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planInversion.descripcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: RedesignColors.ink,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      '${planInversion.cantidad} × ${planInversion.precioUnitario.toCurrencyString(mantissaLength: 0)}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: RedesignColors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Text(
                planInversion.total.toCurrencyString(mantissaLength: 0),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.green,
                ),
              ),
              const Gap(4),
              const Icon(
                Icons.more_vert_rounded,
                size: 20,
                color: RedesignColors.chevron,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyPlanInversion extends StatelessWidget {
  const _EmptyPlanInversion();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 40,
            color: RedesignColors.chevron,
          ),
          Gap(10),
          Text(
            'Aún no hay artículos',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: RedesignColors.ink,
            ),
          ),
          Gap(4),
          Text(
            'Agrega lo que el cliente comprará con el crédito.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: RedesignColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgregarArticuloButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AgregarArticuloButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: RedesignColors.surface.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: RedesignColors.chevron,
              width: 1.2,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_rounded,
                color: RedesignColors.ink,
              ),
              Gap(6),
              Text(
                'Agregar artículo',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: RedesignColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
