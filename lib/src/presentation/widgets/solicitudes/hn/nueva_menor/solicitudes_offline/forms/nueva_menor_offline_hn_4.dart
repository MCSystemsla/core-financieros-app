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

class NuevaMenorOfflineHn4 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorOfflineHn4({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorOfflineHn4> createState() => _NuevaMenorOfflineHn4State();
}

class _NuevaMenorOfflineHn4State extends State<NuevaMenorOfflineHn4> {
  final formKey = GlobalKey<FormState>();
  Item? estadoCivil;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    return BlocBuilder<SolicitudNuevaMenorHnCubit, SolicitudNuevaMenorHnState>(
      builder: (context, state) {
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
                        name: cubit.state.profesion,
                        value: cubit.state.profesionCodigo,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      hintText: 'Ingresa Profesión',
                      title: 'Profesión',
                      codigo: 'PROFESION',
                      flavor: global<FlavorCubit>().state.flavor,
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            profesionCodigo: item.value,
                            profesion: item.name,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.ocupacion,
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
                            ocupacion: item.name,
                            ocupacionCodigo: item.value,
                          ),
                        );
                      },
                      hintText: 'Ingresa Ocupación',
                      title: 'Ocupación',
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.estadoCivilCodigo,
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

                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            estadoCivilCodigo: item.value,
                          ),
                        );
                      },
                    ),
                    if (state.estadoCivilCodigo == 'UNI' ||
                        state.estadoCivilCodigo == 'CAS') ...[
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
                        hintText: 'Ingresa Nombre Cónyuge',
                        icon: Icon(Icons.person,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        title: 'Nombre Conyugue',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              nombreConyugue: value,
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
                        hintText: 'Ingresa Nacionalidad Cónyugue',
                        title: 'Nacionalidad Conyugue',
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
                          name: cubit.state.trabajaConyugue,
                          value: cubit.state.trabajaConyugue,
                        ),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        title: '¿Trabaja Cónyugue?',
                        isRequired: true,
                        onChanged: (item) {
                          if (item == null || !mounted) return;

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
                      if (state.trabajaConyugue == 'input.yes'.tr()) ...[
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
                          hintText: 'Trabajo Cónyugue',
                          icon: Icon(Icons.work_outline,
                              color: AppColors.getPrimaryColor()),
                          textInputType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          title: 'Trabajo Conyugue',
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
                          initialValue: cubit.state.direccionTrabajoConyugue,
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
                          title: 'Dirección Trabajo Conyugue',
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
                          icon: Icon(Icons.phone,
                              color: AppColors.getPrimaryColor()),
                          textInputType: TextInputType.phone,
                          textCapitalization: TextCapitalization.none,
                          title: 'Telefono Trabajo Conyugue',
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
                        title: 'Documento Conyugue',
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
                        initialValue: cubit.state.actividadDescripcionConyugue,
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
                        title: 'Actividad Descripción Conyugue',
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
                      initialValue:
                          cubit.state.ingresosNetos.toCurrencyString(),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Ingresos Netos',
                      icon: Icon(Icons.wallet,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      title: 'Ingresos Netos',
                      inputFormatters: [
                        CurrencyInputFormatter(),
                      ],
                      onChange: (value) {
                        final newValue = value.replaceAll(',', '');
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            ingresosNetos: int.tryParse(newValue) ?? 0,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.exeperiencia.toString(),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Ingresa Experiencia',
                      icon: Icon(Icons.timeline,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      title: 'Experiencia',
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
      },
    );
  }
}
