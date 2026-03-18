// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm4 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm4({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm4> createState() => _NuevaMenorForm4State();
}

class _NuevaMenorForm4State extends State<NuevaMenorForm4>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  bool trabajaConyuge = false;
  Item? estadoCivil;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 4,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                SearchDropdownWidget(
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Ingresa Profesión',
                  title: 'Profesión del Cliente',
                  codigo: 'PROFESION',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        profesionCodigo: item.value,
                        profesion: item.name,
                        profesionCodigoNombre: item.name,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'OCUPACION',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ocupacion: item.name,
                        ocupacionCodigo: item.value,
                        ocupacionCodigoNombre: item.name,
                      ),
                    );
                  },
                  hintText: 'Ingresa Ocupación',
                  title: 'Ocupación Actual',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'ESTADOCIVIL',
                  title: 'Estado Civil',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      estadoCivil = item;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        estadoCivilCodigo: item.value,
                        estadoCivilCodigoNombre: item.name,
                      ),
                    );
                  },
                ),
                if (estadoCivil?.value == 'UNI' ||
                    estadoCivil?.value == 'CAS') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(250),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Ingresa Nombres del Cónyuge',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nombres del Cónyuge',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreConyugue: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(250),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Ingresa Apellidos del Cónyuge',
                    icon: Icon(
                      Icons.person,
                      color: AppColors.getPrimaryColor(),
                    ),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'Apellidos del Cónyuge',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          apellidosConyugue: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Nacionalidad Cónyuge',
                    title: 'Nacionalidad del Cónyuge',
                    codigo: 'PAIS',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nacionalidadConyugue: item.valor,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  SheetSearchDropdown(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    title: '¿El Cónyuge Trabaja?',
                    isRequired: true,
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        trabajaConyuge = item.value == 'input.yes'.tr();
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          trabajaConyugue: item.value,
                        ),
                      );
                    },
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                  ),
                  if (trabajaConyuge) ...[
                    const Gap(30),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(100),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Trabajo Cónyuge',
                      icon: Icon(Icons.work_outline,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'Centro de Trabajo del Cónyuge',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            trabajoConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(100),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Dirección Trabajo Cónyuge',
                      icon: Icon(Icons.location_on,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.words,
                      title: 'Dirección del Trabajo del Cónyuge',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            direccionTrabajoConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    CountryInput(
                      maxLength: 15,
                      countryCodeInput: CountryCodeInput.hn,
                      isRequired: true,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Teléfono Trabajo Cónyuge',
                      icon:
                          Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      title: 'Teléfono del Trabajo del Cónyuge',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            telefonoTrabajoConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Años del Lugar de Trabajo del Cónyuge',
                      icon: Icon(Icons.location_on,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      title: 'Años del Lugar de Trabajo del Cónyuge',
                      onChange: (value) {
                        final newValue = int.tryParse(value);
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            aniosLugarTrabajoConyuge: newValue,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      inputFormatters: [
                        CurrencyInputFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Ingresos Mensuales del Cónyuge',
                      icon: Icon(Icons.wallet,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      title: 'Ingresos Mensuales del Cónyuge',
                      onChange: (value) {
                        final newValue =
                            toNumericString(value, allowPeriod: true);
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            ingresoMensualConyuge: double.tryParse(newValue),
                          ),
                        );
                      },
                    ),
                  ],
                  const Gap(30),
                  SearchDropdownWidget(
                    codigo: 'TIPODOCUMENTOPERSONA',
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    hintText: 'Tipo Documento Cónyuge',
                    title: 'Tipo de Documento del Cónyuge',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tipoDocumentoConyugue: value?.value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Documento Cónyuge',
                    icon: Icon(Icons.credit_card,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    title: 'Número de Documento del Cónyuge',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(50),
                    ],
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          documentoConyuge: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Actividad Descripción Cónyuge',
                    icon: Icon(Icons.description,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Descripción de Actividad del Cónyuge',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadDescripcionConyugue: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  validator: (value) => ClassValidator.validateNotZero(value),
                  hintText: 'Ingresos Netos',
                  icon: Icon(Icons.wallet, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Ingresos Netos Mensuales',
                  inputFormatters: [
                    CurrencyInputFormatter(mantissaLength: 0),
                  ],
                  onChange: (value) {
                    final newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                    final ingresosNetos = int.tryParse(newValue) ?? 0;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ingresosNetos: ingresosNetos,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Experiencia',
                  icon:
                      Icon(Icons.timeline, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  title: 'Años de Experiencia Laboral',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    final newValue = value.replaceAll(',', '');
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        exeperiencia: int.tryParse(newValue) ?? 0,
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
