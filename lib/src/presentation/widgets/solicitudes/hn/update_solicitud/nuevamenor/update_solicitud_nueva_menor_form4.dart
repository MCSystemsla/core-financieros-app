import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
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
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudNuevaMenorForm4 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudNuevaMenorForm4({
    super.key,
    required this.controller,
  });

  @override
  State<UpdateSolicitudNuevaMenorForm4> createState() =>
      _UpdateSolicitudNuevaMenorForm4State();
}

class _UpdateSolicitudNuevaMenorForm4State
    extends State<UpdateSolicitudNuevaMenorForm4> {
  final formKey = GlobalKey<FormState>();
  bool trabajaConyuge = false;
  Item? estadoCivil;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
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
                  selectedItem: Item(
                    name: cubit.state.profesionNombre,
                    value: cubit.state.profesionCodigo,
                  ),
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
                        profesionNombre: item.name,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.ocupacionNombre,
                    value: cubit.state.ocupacionCodigo,
                  ),
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'OCUPACION',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ocupacionNombre: item.name,
                        ocupacionCodigo: item.value,
                      ),
                    );
                  },
                  hintText: 'Ingresa Ocupación',
                  title: 'Ocupación Actual',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.estadoCivilNombre,
                    value: cubit.state.estadoCivilCodigo,
                  ),
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
                        estadoCivilNombre: item.name,
                      ),
                    );
                  },
                ),
                if (estadoCivil?.value == 'UNI' ||
                    estadoCivil?.value == 'CAS') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.nombreConyugue,
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
                  // const Gap(30),
                  // OutlineTextfieldWidget(
                  //   isRequired: true,
                  //   inputFormatters: [
                  //     UpperCaseTextFormatter(),
                  //     LengthLimitingTextInputFormatter(250),
                  //   ],
                  //   validator: (value) =>
                  //       ClassValidator.validateRequired(value),
                  //   hintText: 'Ingresa Apellidos del Cónyuge',
                  //   icon: Icon(
                  //     Icons.person,
                  //     color: AppColors.getPrimaryColor(),
                  //   ),
                  //   textInputType: TextInputType.name,
                  //   textCapitalization: TextCapitalization.words,
                  //   title: 'Apellidos del Cónyuge',
                  //   onChange: (value) {
                  //     cubit.onFieldChanged(
                  //       () => cubit.state.copyWith(
                  //           // apellidosConyugue: value,
                  //           ),
                  //     );
                  //   },
                  // ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.nacionalidadConyugue,
                      nombre: cubit.state.nacionalidadConyugue,
                      relacion: '',
                    ),
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
                    selectedItem: Item(
                      name: cubit.state.trabajaConyugue
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                      value: cubit.state.trabajaConyugue,
                    ),
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
                      initialValue: cubit.state.trabajoConyugue,
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
                      initialValue: cubit.state.direccionTrabajoConyugue,
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
                      initialValue: cubit.state.telefonoTrabajoConyugue,
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
                  ],
                  const Gap(30),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: cubit.state.tipoDocumentoNombre,
                      value: cubit.state.tipoDocumentoCodigo,
                    ),
                    codigo: 'TIPODOCUMENTOPERSONA',
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    hintText: 'Tipo Documento Cónyuge',
                    title: 'Tipo de Documento del Cónyuge',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tipoDocumentoCodigo: value?.value,
                          tipoDocumentoNombre: value?.name,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.documentoConyuge,
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
                    initialValue: cubit.state.actividadDescripcionConyuge,
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
                          actividadDescripcionConyuge: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.ingresosNetos.toCurrencyString(),
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
                  initialValue: cubit.state.experiencia,
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
                        experiencia: newValue,
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
                // ignore: deprecated_member_use
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
}
