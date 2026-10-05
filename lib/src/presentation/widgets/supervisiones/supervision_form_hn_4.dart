import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class SupervisionFormHN4 extends StatefulWidget {
  final PageController pageController;
  final String tipoSolicitud;
  final int montoSolicitud;
  final int cuotaSolicitud;
  final int plazoSolicitud;
  final String producto;
  final String frecuenciaPago;
  const SupervisionFormHN4({
    super.key,
    required this.pageController,
    required this.tipoSolicitud,
    required this.montoSolicitud,
    required this.cuotaSolicitud,
    required this.plazoSolicitud,
    required this.producto,
    required this.frecuenciaPago,
  });

  @override
  State<SupervisionFormHN4> createState() => _SupervisionFormHN4State();
}

class _SupervisionFormHN4State extends State<SupervisionFormHN4>
    with AutomaticKeepAliveClientMixin {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SupervisionCoordinadorCubit>();

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
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
                margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                child: const Text(
                  'Propuesta',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                title:
                    'Monto\n Monto de solicitud: ${widget.montoSolicitud.toCurrencyString()}',
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
                title:
                    'Plazo en meses\n Plazo de solicitud: ${widget.plazoSolicitud}',
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
                title: 'Producto\n Producto de solicitud: ${widget.producto}',
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
                title:
                    'Frecuencia de pago:\n Frecuencia de pago de solicitud: ${widget.frecuenciaPago}',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      frecuenciaCodigo: v?.valor,
                    ),
                  );
                },
              ),
              const Gap(25),
              // El progreso/resultado del envío lo muestra
              // SendingSupervisionView.
              BlocBuilder<SupervisionCoordinadorCubit,
                  SupervisionCoordinadorState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
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
                                .createSupervisonCoordinador(
                                  tipoSolicitud: widget.tipoSolicitud,
                                );
                          },
                          text: state.status == Status.inProgress
                              ? 'Enviando...'
                              : 'Enviar',
                          color: RedesignColors.green,
                        ),
                        const Gap(10),
                        CustomOutLineButton(
                          onPressed: () {
                            widget.pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Anterior',
                          color: RedesignColors.border,
                          textColor: RedesignColors.ink,
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

  @override
  bool get wantKeepAlive => true;
}
