// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SolicitudAsalariadoOffline6 extends StatefulWidget {
  final PageController controller;
  const SolicitudAsalariadoOffline6({
    super.key,
    required this.controller,
  });

  @override
  State<SolicitudAsalariadoOffline6> createState() =>
      _SolicitudAsalariadoOffline6State();
}

class _SolicitudAsalariadoOffline6State
    extends State<SolicitudAsalariadoOffline6>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudAslariadoHnCubit>();
    return BlocBuilder<SolicitudAslariadoHnCubit, SolicitudAslariadoHnState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const MiCreditoProgress(
                  currentStep: 6,
                  steps: 7,
                ),
                const Gap(30),
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      initialValue: state.nombreFamiliarCercano,
                      hintText: 'Nombre de Familiar Cercano',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      title: 'Nombre Familiar Cercano',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(250),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            nombreFamiliarCercano: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.direccionFamiliarCercano,
                      hintText: 'Dirección de Familiar Cercano',
                      icon:
                          Icon(Icons.home, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.words,
                      title: 'Dirección Familiar Cercano',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            direccionFamiliarCercano: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    CountryInput(
                      initialValue: state.telefonoFamiliarCercano,
                      isRequired: false,
                      maxLength: 15,
                      hintText: 'Teléfono de Familiar Cercano',
                      icon:
                          Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      title: 'Teléfono Familiar Cercano',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            telefonoFamiliarCercano: value,
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
