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

class UpdateSolicitudAsalariadoForm4 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudAsalariadoForm4({super.key, required this.controller});

  @override
  State<UpdateSolicitudAsalariadoForm4> createState() =>
      _UpdateSolicitudAsalariadoForm4State();
}

class _UpdateSolicitudAsalariadoForm4State
    extends State<UpdateSolicitudAsalariadoForm4> {
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
                    name: cubit.state.estadoCivilNombre,
                    value: cubit.state.estadoCivilCodigo,
                  ),
                  codigo: 'ESTADOCIVIL',
                  title: 'Estado Civil',
                  flavor: global<FlavorCubit>().state.flavor,
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      estadoCivil = item;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        estadoCivilCodigo: item.value,
                      ),
                    );
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                ),
                if (cubit.state.estadoCivilCodigo == 'UNI' ||
                    cubit.state.estadoCivilCodigo == 'CAS') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.nombreConyugue,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre del Cónyuge',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nombre del Cónyuge',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(250),
                    ],
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreConyugue: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: cubit.state.profesionNombre,
                      value: cubit.state.profesionCodigo,
                    ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'PROFESION',
                    flavor: global<FlavorCubit>().state.flavor,
                    hintText: 'Profesión del Cónyuge',
                    title: 'Profesion del Conjugue',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          profesionConyugue: value.value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: cubit.state.tipoDocumentoConyugeNombre,
                      value: cubit.state.tipoDocumentoConyugeCodigo,
                    ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'TIPODOCUMENTOPERSONA',
                    flavor: global<FlavorCubit>().state.flavor,
                    hintText: 'Tipo documento conyuge',
                    title: 'Tipo documento conyuge',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tipoDocumentoConyugeCodigo: value.value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.documentoConyuge,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Documento Cónyuge',
                    icon: Icon(
                      Icons.person,
                      color: AppColors.getPrimaryColor(),
                    ),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'Documento Cónyuge',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(250),
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
                  SheetSearchDropdown(
                    selectedItem: Item(
                      name: cubit.state.trabajaConyugue
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                      value: cubit.state.trabajaConyugue.toString(),
                    ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    title: 'Trabaja Cónyuge?',
                    hintText: 'input.select.option'.tr(),
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
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                  ),
                  if (cubit.state.trabajaConyugue) ...[
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.trabajoConyugue,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Trabajo del Cónyuge',
                      icon: Icon(Icons.business,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'Trabajo del Cónyuge',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(100),
                      ],
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
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Dirección del Trabajo del Cónyuge',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      icon: Icon(Icons.location_on,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      title: 'Direccion del Trabajo del Cónyuge',
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
                      isRequired: true,
                      maxLength: 15,
                      countryCodeInput: CountryCodeInput.hn,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Teléfono del Trabajo del Cónyuge',
                      icon:
                          Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                      initialValue: cubit.state.tiempoLaborarConyugue,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Tiempo de Laborar del Cónyuge',
                      icon: Icon(Icons.access_time,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      title: 'Tiempo de laborar del Cónyuge',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tiempoLaborarConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue:
                          cubit.state.sueldoMesConyugue.toCurrencyString(),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Sueldo Mensual del Cónyuge',
                      icon: Icon(Icons.wallet,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      title: 'Sueldo Mensual del Cónyuge',
                      inputFormatters: [
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue =
                            value.replaceAll(RegExp(r'[^0-9]'), '');
                        final sueldoMensual = int.tryParse(newValue) ?? 0;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            sueldoMesConyugue: sueldoMensual,
                          ),
                        );
                      },
                    ),
                  ],
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue:
                        cubit.state.otrosIngresosConyugue.toCurrencyString(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Otros Ingresos del Cónyuge',
                    icon: Icon(Icons.payments,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    title: 'Otros Ingresos del Cónyuge',
                    inputFormatters: [
                      CurrencyInputFormatter(
                        mantissaLength: 0,
                      ),
                    ],
                    onChange: (value) {
                      final newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      final otrosIngresos = int.tryParse(newValue) ?? 0;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          otrosIngresosConyugue: otrosIngresos,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.fuenteOtrosIngresosConyugue,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Fuente de Otros Ingresos del Cónyuge',
                    icon:
                        Icon(Icons.source, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                    ],
                    title: 'Fuente de Otros Ingresos del Cónyuge',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          fuenteOtrosIngresosConyugue: value,
                        ),
                      );
                    },
                  ),
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
                    hintText: 'Nacionalidad del Cónyuge',
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
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.personasACargo.toString(),
                  hintText: 'Personas a Cargo',
                  icon: Icon(Icons.group, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Personas a Cargo',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        personasACargo: int.tryParse(value) ?? 0,
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
