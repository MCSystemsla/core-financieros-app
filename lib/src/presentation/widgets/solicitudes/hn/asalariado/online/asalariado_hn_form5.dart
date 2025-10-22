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

class AsalariadoHnForm5 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm5({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm5> createState() => _AsalariadoHnForm5State();
}

class _AsalariadoHnForm5State extends State<AsalariadoHnForm5>
    with AutomaticKeepAliveClientMixin {
  bool esPeps = false;
  bool tieneFamiliarPeps = false;
  bool esFamiliarEmpleado = false;
  bool esApnfd = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudAslariadoHnCubit>();
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
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: 'Es PEPS?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      esPeps = item.value == 'input.yes'.tr();
                    });
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
                if (esPeps) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre de Entidad PEPS',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Periodo PEPS',
                    icon: Icon(Icons.schedule,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.datetime,
                    textCapitalization: TextCapitalization.none,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Cargo Oficial PEPS',
                    icon: Icon(Icons.work, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
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
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: '¿Tiene Familiar PEPS?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneFamiliarPeps = item.value == 'input.yes'.tr();
                    });
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
                if (tieneFamiliarPeps) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre Familiar PEPS',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Cargo Familiar PEPS',
                    icon: Icon(Icons.work_outline,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre Entidad PEPS 2',
                    icon: Icon(Icons.apartment,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
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
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: '¿Es Familiar de Empleado?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneFamiliarPeps = item.value == 'input.yes'.tr();
                    });
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
                if (tieneFamiliarPeps) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre Empleado',
                    icon: Icon(Icons.person_outline,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    title: 'Nombre Familiar Empleado',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliarPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
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
  }

  @override
  bool get wantKeepAlive => true;
}
