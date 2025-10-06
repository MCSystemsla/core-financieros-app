// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_asalariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoHnForm9 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm9({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm9> createState() => _AsalariadoHnForm9State();
}

class _AsalariadoHnForm9State extends State<AsalariadoHnForm9> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudAsalariadoHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 9,
              steps: 9,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  hintText: 'Sector',
                  icon:
                      Icon(Icons.business, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objSectorID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Producto',
                  icon: Icon(Icons.shopping_bag,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objProductoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Moneda',
                  icon: Icon(Icons.monetization_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objMonedaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Propósito',
                  icon: Icon(Icons.flag, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objPropositoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Monto',
                  icon: Icon(Icons.attach_money,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Monto',
                  inputFormatters: [
                    CurrencyInputFormatter(),
                  ],
                  onChange: (value) {
                    final newValue = value.replaceAll(',', '');
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        monto: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Frecuencia',
                  icon: Icon(Icons.repeat, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objFrecuenciaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Plazo de Solicitud',
                  icon:
                      Icon(Icons.schedule, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'PlazoSolicitud',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        plazoSolicitud: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Fecha Primer Pago',
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'FechaPrimerPagoSolicitud',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Cuota',
                  icon: Icon(Icons.payment, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Cuota',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Observación',
                  icon: Icon(Icons.note, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Observacion',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        observacion: value,
                      ),
                    );
                  },
                ),
              ],
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutLineButton(
                onPressed: () {
                  context.pushReplacement('/solicitudes');
                },
                text: 'Cancelar',
                textColor: AppColors.red,
                color: AppColors.red,
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
