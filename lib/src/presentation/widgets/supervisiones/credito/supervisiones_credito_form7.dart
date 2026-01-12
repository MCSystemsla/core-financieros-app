import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_credito/supervision_credito_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/home/home_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SupervisionesCreditoForm7 extends StatefulWidget {
  final PageController pagecontroller;
  final SupervisionData data;

  const SupervisionesCreditoForm7({
    super.key,
    required this.pagecontroller,
    required this.data,
  });

  @override
  State<SupervisionesCreditoForm7> createState() =>
      _SupervisionesCreditoForm7State();
}

class _SupervisionesCreditoForm7State extends State<SupervisionesCreditoForm7>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SupervisionCreditoCubit>();

    return BlocBuilder<SupervisionCreditoCubit, SupervisionCreditoState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Propuesta',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Gap(10),
                OutlineTextfieldWidget(
                  title:
                      'Monto del credito: ${widget.data.monto.toCurrencyString()}',
                  icon: const Icon(Icons.food_bank),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value, allowPeriod: true);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        monto: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(10),
                OutlineTextfieldWidget(
                  title: 'Plazo en meses: ${widget.data.plazoSolicitud}',
                  icon: const Icon(Icons.food_bank),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        plazo: int.tryParse(value) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(10),
                SearchDropdownWidget(
                  title: 'Producto del credito: ${widget.data.producto}',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'PRODUCTO',
                  enabled: true,
                  isRequired: true,
                  onChanged: (v) {
                    if (v == null) return;
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        productoCodigo: v.value,
                      ),
                    );
                  },
                  hintText: 'Ingresa Producto',
                ),
                // const Gap(10),
                // OutlineTextfieldWidget(
                //   title: 'Tasa del credito: ${data.tasa}',
                //   icon: const Icon(Icons.food_bank),
                //   inputFormatters: [
                //     CurrencyInputFormatter(),
                //   ],
                //   onChange: (value) {
                //     final newValue = toNumericString(value, allowPeriod: true);
                //     cubit.onFieldChanged(
                //       () => cubit.state.copyWith(
                //         tasa: double.tryParse(newValue) ?? 0,
                //       ),
                //     );
                //   },
                // ),
                const Gap(25),
                BlocConsumer<SupervisionCreditoCubit, SupervisionCreditoState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  listener: (context, state) {
                    if (state.status == Status.done) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Supervision creada exitosamente',
                        onDone: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                      ).showDialog(context, dialogType: DialogType.success);
                    }
                    if (state.status == Status.error) {
                      CustomAlertDialog(
                        context: context,
                        title: state.errorMsg,
                        onDone: () => context.pop(),
                      ).showDialog(context);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          CustomElevatedButton(
                            enabled: state.status != Status.inProgress,
                            onPressed: () {
                              context
                                  .read<SupervisionCreditoCubit>()
                                  .createSupervisionCredito();
                            },
                            text: state.status == Status.inProgress
                                ? 'Creando...'
                                : 'Enviar',
                            color: Colors.green,
                          ),
                          const Gap(10),
                          CustomElevatedButton(
                            onPressed: () {
                              widget.pagecontroller.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            text: 'Anterior',
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
