// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReprestamoFormHn4 extends StatefulWidget {
  final PageController controller;
  const ReprestamoFormHn4({
    super.key,
    required this.controller,
  });

  @override
  State<ReprestamoFormHn4> createState() => _ReprestamoFormHn4State();
}

class _ReprestamoFormHn4State extends State<ReprestamoFormHn4>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudReprestamoHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 1,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  title: 'Nombre Beneficiario Seguro',
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  hintText: 'Ingresa Nombre Beneficiario Seguro',
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        beneficiarioSeguro: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  title: 'Cedula Beneficiario Seguro',
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  hintText: 'Cedula Beneficiario Seguro',
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedulaBeneficiarioSeguro: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  enabled: true,
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'PARENTESCO',
                  title: 'Parentesco Familiar Seguro',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        parentescoBeneficiarioSeguroCodigo: value.value,
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
                  widget.controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                text: 'Anterior',
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

  @override
  bool get wantKeepAlive => true;
}
