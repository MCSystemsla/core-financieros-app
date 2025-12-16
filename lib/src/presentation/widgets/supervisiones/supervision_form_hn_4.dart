import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SupervisionFormHN4 extends StatefulWidget {
  final PageController pageController;
  const SupervisionFormHN4({
    super.key,
    required this.pageController,
  });

  @override
  State<SupervisionFormHN4> createState() => _SupervisionFormHN4State();
}

class _SupervisionFormHN4State extends State<SupervisionFormHN4> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final cubit = context.read<SupervisionCoordinadorCubit>();

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
        child: Form(
          key: formkey,
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
                title: 'Monto',
                icon: const Icon(Icons.food_bank),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      monto: int.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                title: 'Plazo en meses',
                icon: const Icon(Icons.food_bank),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      plazo: int.tryParse(value) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              SearchDropdownWidget(
                codigo: 'PRODUCTO',
                title: 'Producto',
                enabled: true,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      productoCodigo: v?.value,
                    ),
                  );
                },
              ),
              const Gap(10),
              CatalogoFrecuenciaPagoDropdown(
                enabled: true,
                title: 'Frecuencia de pago',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      frecuenciaCodigo: v?.valor,
                    ),
                  );
                },
              ),
              const Gap(25),
              BlocConsumer<SupervisionCoordinadorCubit,
                  SupervisionCoordinadorState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == Status.done) {
                    CustomAlertDialog(
                      context: context,
                      title: 'Supervisión enviada exitosamente.',
                      onDone: () => context.pop(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          enabled: state.status != Status.inProgress,
                          onPressed: () {
                            if (!formkey.currentState!.validate()) return;
                            context
                                .read<SupervisionCoordinadorCubit>()
                                .createSupervisonCoordinador();
                          },
                          text: state.status == Status.inProgress
                              ? 'Enviando...'
                              : 'Siguiente',
                          color: Colors.green,
                        ),
                        const Gap(10),
                        CustomElevatedButton(
                          onPressed: () {
                            widget.pageController.previousPage(
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
      ),
    );
  }
}
