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
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SolicitudAsalariadoOffline5 extends StatefulWidget {
  final PageController controller;

  const SolicitudAsalariadoOffline5({
    super.key,
    required this.controller,
  });

  @override
  State<SolicitudAsalariadoOffline5> createState() =>
      _SolicitudAsalariadoOffline5State();
}

class _SolicitudAsalariadoOffline5State
    extends State<SolicitudAsalariadoOffline5>
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
                  currentStep: 5,
                  steps: 7,
                ),
                const Gap(30),
                Column(
                  children: [
                    SheetSearchDropdown(
                      selectedItem: Item(
                        name: state.espeps,
                        value: state.espeps,
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      title: 'Es PEPS?',
                      isRequired: true,
                      onChanged: (item) {
                        if (item == null || !mounted) return;

                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            espeps: item.value,
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
                    if (state.espeps == 'input.yes'.tr()) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.nombreDeEntidadPeps,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Nombre de Entidad PEPS',
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        icon: Icon(Icons.account_balance,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        title: 'Nombre de Entidad PEPS',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              nombreDeEntidadPeps: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.periodoPeps,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Periodo PEPS',
                        icon: Icon(Icons.schedule,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.datetime,
                        textCapitalization: TextCapitalization.none,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(100),
                        ],
                        title: 'Periodo PEPS',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              periodoPeps: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.cargoOficialPeps,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Cargo Oficial PEPS',
                        icon: Icon(Icons.work,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        title: 'Cargo Oficial PEPS',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              cargoOficialPeps: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      CatalogoValorNacionalidad(
                        selectedItem: ItemNacionalidad(
                          id: 0,
                          valor: state.paisPeps,
                          nombre: state.paisPeps,
                          relacion: '',
                        ),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                        codigo: 'PAIS',
                        hintText: 'País PEPS',
                        title: 'País PEPS',
                        onChanged: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              paisPeps: value.valor,
                            ),
                          );
                        },
                      ),
                    ],
                    SheetSearchDropdown(
                      selectedItem: Item(
                        name: state.tieneFamiliarPeps,
                        value: state.tieneFamiliarPeps,
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      title: '¿Tiene Familiar PEPS?',
                      isRequired: true,
                      onChanged: (item) {
                        if (item == null || !mounted) return;

                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tieneFamiliarPeps: item.value,
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
                    if (state.tieneFamiliarPeps == 'input.yes'.tr()) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.nombreFamiliarPeps2,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Nombre Familiar PEPS',
                        icon: Icon(Icons.person,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        title: 'Nombre Familiar PEPS',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              nombreFamiliarPeps2: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.parentescoFamiliarPeps2,
                          value: state.parentescoFamiliarPeps2,
                        ),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        hintText: 'Parentesco Familiar PEPS',
                        title: 'Parentesco Familiar PEPS',
                        codigo: 'PARENTESCO',
                        flavor: global<FlavorCubit>().state.flavor,
                        onChanged: (item) {
                          if (item == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              parentescoFamiliarPeps2: item.value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.cargoFamiliarPeps2,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Cargo Familiar PEPS',
                        icon: Icon(Icons.work_outline,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        title: 'Cargo Familiar PEPS',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              cargoFamiliarPeps2: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.nombreEntidadPeps2,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Nombre Entidad PEPS 2',
                        icon: Icon(Icons.apartment,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        title: 'Nombre Entidad PEPS 2',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              nombreEntidadPeps2: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.periodoPeps2,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Periodo PEPS 2',
                        icon: Icon(Icons.date_range,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.number,
                        textCapitalization: TextCapitalization.none,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        title: 'Periodo PEPS 2',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              periodoPeps2: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      CatalogoValorNacionalidad(
                        selectedItem: ItemNacionalidad(
                          id: 0,
                          valor: state.paisPeps2,
                          nombre: state.paisPeps2,
                          relacion: '',
                        ),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                        codigo: 'PAIS',
                        hintText: 'País PEPS 2',
                        title: 'País PEPS 2',
                        onChanged: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              paisPeps2: value.valor,
                            ),
                          );
                        },
                      ),
                    ],
                    SheetSearchDropdown(
                      selectedItem: Item(
                        name: state.esFamiliarEmpleado,
                        value: state.esFamiliarEmpleado,
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      title: '¿Es Familiar de Empleado?',
                      isRequired: true,
                      onChanged: (item) {
                        if (item == null || !mounted) return;

                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            esFamiliarEmpleado: item.value,
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
                    if (state.esFamiliarEmpleado == 'input.yes'.tr()) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.nombreFamiliar,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Nombre Empleado',
                        icon: Icon(Icons.person_outline,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        title: 'Nombre Familiar Empleado',
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              nombreFamiliar: value,
                            ),
                          );
                        },
                      ),
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.cedulaFamiliar,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Cédula Familiar',
                        icon: Icon(Icons.credit_card,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        title: 'Cédula Familiar',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(25),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              cedulaFamiliar: value,
                            ),
                          );
                        },
                      ),
                    ],
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
