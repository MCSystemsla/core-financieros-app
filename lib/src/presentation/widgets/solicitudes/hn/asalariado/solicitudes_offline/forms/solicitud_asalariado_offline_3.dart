// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class SolicitudAsalariadoOffline3 extends StatefulWidget {
  final PageController controller;
  const SolicitudAsalariadoOffline3({
    super.key,
    required this.controller,
  });

  @override
  State<SolicitudAsalariadoOffline3> createState() =>
      _SolicitudAsalariadoOffline3State();
}

class _SolicitudAsalariadoOffline3State
    extends State<SolicitudAsalariadoOffline3>
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
                  currentStep: 3,
                  steps: 7,
                ),
                const Gap(30),
                Column(
                  children: [
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: state.profesionCodigo,
                        value: state.profesionCodigo,
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      hintText: 'Profesión',
                      title: 'Profesion',
                      codigo: 'PROFESION',
                      flavor: global<FlavorCubit>().state.flavor,
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            profesionCodigo: item.value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: state.ocupacionCodigo,
                        value: state.ocupacionCodigo,
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      hintText: 'Ocupación',
                      title: 'Ocupacion',
                      codigo: 'OCUPACION',
                      flavor: global<FlavorCubit>().state.flavor,
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            ocupacionCodigo: item.value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.cargo,
                      hintText: 'Cargo',
                      icon:
                          Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'Cargo',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            cargo: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.nombreTrabajo,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Nombre del Trabajo',
                      icon: Icon(Icons.business,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'Nombre del Trabajo',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(100),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            nombreTrabajo: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.direccionTrabajo,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Dirección del Trabajo',
                      icon: Icon(Icons.location_on,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      title: 'Direccion del Trabajo',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            direccionTrabajo: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.barrioTrabajo,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Barrio del Trabajo',
                      icon: Icon(Icons.location_city,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'Barrio del Trabajo',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(50),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            barrioTrabajo: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    CountryInput(
                      initialValue: state.telefonoTrabajo,
                      isRequired: false,
                      maxLength: 15,
                      countryCodeInput: CountryCodeInput.hn,
                      hintText: 'Teléfono del Trabajo',
                      icon:
                          Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      title: 'Telefono del Trabajo',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            telefonoTrabajo: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.tiempoLaborar,
                      hintText: 'Tiempo de Laborar',
                      icon: Icon(Icons.access_time,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      title: 'Tiempo de Laborar',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tiempoLaborar: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.lugarTrabajoAnterior,
                      hintText: 'Lugar de Trabajo Anterior',
                      icon: Icon(Icons.work_history,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'Lugar del Trabajo Anterior',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(100),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            lugarTrabajoAnterior: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.salarioNetoCordoba.toCurrencyString(),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Salario Neto',
                      icon: Icon(Icons.wallet,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      title: 'Salario Neto',
                      inputFormatters: [
                        CurrencyInputFormatter(mantissaLength: 0),
                      ],
                      onChange: (value) {
                        final newValue =
                            value.replaceAll(RegExp(r'[^0-9]'), '');
                        final salarioNeto = int.tryParse(newValue) ?? 0;

                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            salarioNetoCordoba: salarioNeto,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue:
                          state.otrosIngresosCordoba.toCurrencyString(),
                      hintText: 'Otros Ingresos',
                      icon: Icon(Icons.payments,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      title: 'Otros Ingresos',
                      inputFormatters: [
                        CurrencyInputFormatter(mantissaLength: 0),
                      ],
                      onChange: (value) {
                        final newValue =
                            value.replaceAll(RegExp(r'[^0-9]'), '');
                        final otrosIngresos = int.tryParse(newValue) ?? 0;
                        cubit.onFieldChanged(
                          () => state.copyWith(
                            otrosIngresosCordoba: otrosIngresos,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.fuenteOtrosIngresos,
                      hintText: 'Fuente de Otros Ingresos',
                      icon: Icon(Icons.source,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(100),
                      ],
                      title: 'Fuente Otros Ingresos',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => state.copyWith(
                            fuenteOtrosIngresos: value,
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
                    text: 'Atras',
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
