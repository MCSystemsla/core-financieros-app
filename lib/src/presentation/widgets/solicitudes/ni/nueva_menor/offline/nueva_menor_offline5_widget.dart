// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorOffline5Widget extends StatefulWidget {
  final ResponseLocalDb responseLocalDb;
  final PageController pageController;
  const NuevaMenorOffline5Widget(
      {super.key, required this.pageController, required this.responseLocalDb});

  @override
  State<NuevaMenorOffline5Widget> createState() =>
      _NuevaMenorOffline5WidgetState();
}

class _NuevaMenorOffline5WidgetState extends State<NuevaMenorOffline5Widget>
    with AutomaticKeepAliveClientMixin {
  String? esPeps;
  String? nombreEntidadPeps;
  String? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? tieneFamiliarPeps;
  String? nombreFamiliarPeps;
  String? parentesco;
  String? cargoParentesco;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? nombreFamiliarPeps2;
  String? paisPepsVer;
  String? parentescoFamiliarPeps2Ver;
  String? paisPeps2Ver;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    esPeps = (widget.responseLocalDb.espeps);
    nombreEntidadPeps = widget.responseLocalDb.nombreDeEntidadPeps;
    paisPeps = widget.responseLocalDb.paisPeps;
    cargoOficialPeps = widget.responseLocalDb.cargoOficialPeps;
    tieneFamiliarPeps = widget.responseLocalDb.tieneFamiliarPeps;
    nombreFamiliarPeps2 = widget.responseLocalDb.nombreFamiliarPeps2;
    parentesco = widget.responseLocalDb.parentescoFamiliarPeps2;
    cargoParentesco = widget.responseLocalDb.cargoFamiliarPeps2;
    nombreEntidadPeps2 = widget.responseLocalDb.nombreEntidadPeps2;
    periodoPeps = widget.responseLocalDb.periodoPeps;
    periodoPeps2 = widget.responseLocalDb.periodoPeps2;
    paisPeps2 = widget.responseLocalDb.paisPeps2;
    paisPepsVer = widget.responseLocalDb.paisPepsVer;
    parentescoFamiliarPeps2Ver =
        widget.responseLocalDb.parentescoFamiliarPeps2Ver;
    paisPeps2Ver = widget.responseLocalDb.paisPeps2Ver;

    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                espeps: esPeps,
                nombreDeEntidadPeps: nombreEntidadPeps,
                paisPeps: paisPeps,
                cargoOficialPeps: cargoOficialPeps,
                tieneFamiliarPeps: tieneFamiliarPeps,
                nombreFamiliarPeps2: nombreFamiliarPeps2,
                parentescoFamiliarPeps2: parentesco,
                nombreEntidadPeps2: nombreEntidadPeps2,
                periodoPeps: periodoPeps,
                periodoPeps2: periodoPeps2,
                paisPeps2: paisPeps2,
                paisPepsVer: paisPepsVer,
                cargoFamiliarPeps2: cargoParentesco,
                parentescoFamiliarPeps2Ver: parentescoFamiliarPeps2Ver,
                paisPeps2Ver: paisPeps2Ver,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SolicitudNuevaMenorCubit, SolicitudNuevaMenorState>(
      builder: (context, state) {
        final cubit = context.watch<SolicitudNuevaMenorCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                SheetSearchDropdown(
                  selectedItem: Item(
                    name: esPeps ?? '',
                    value: esPeps,
                  ),
                  key: const Key('esPeps'),
                  title: 'Es PEPS',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null) return;

                    esPeps = item.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        espeps: esPeps,
                      ),
                    );

                    setState(() {});
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                if (esPeps == 'input.yes'.tr()) ...[
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: nombreEntidadPeps,
                    icon: Icon(
                      Icons.business,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre de Entidad PEPS',
                    hintText: 'Ingresa Nombre de Entidad PEPS',
                    isValid: null,
                    onChange: (value) {
                      nombreEntidadPeps = value;

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreDeEntidadPeps: nombreEntidadPeps,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  CatalogoValorNacionalidad(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),

                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: paisPeps ?? '',
                      nombre: paisPepsVer ?? '',
                      relacion: '',
                    ),
                    // initialValue: ,
                    hintText: 'input.select_option'.tr(),
                    title: 'País PEPS',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      paisPeps = item.valor;
                      paisPepsVer = item.nombre;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps: paisPeps,
                          paisPepsVer: paisPepsVer,
                        ),
                      );
                    },
                    codigo: 'PAIS',
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: cargoOficialPeps,
                    icon: Icon(
                      Icons.work,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cargo Oficial PEPS',
                    hintText: 'Ingresa Cargo Oficial PEPS',
                    isValid: null,
                    onChange: (value) {
                      cargoOficialPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoOficialPeps: cargoOficialPeps,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    initialValue: periodoPeps,
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Periodo PEPS',
                    hintText: 'Ingresa Periodo PEPS',
                    isValid: null,
                    onChange: (value) {
                      periodoPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps: periodoPeps,
                        ),
                      );
                    },
                  ),
                ],
                SheetSearchDropdown(
                  key: const Key('tieneFamiliarPeps'),
                  selectedItem: Item(
                    name: tieneFamiliarPeps ?? '',
                    value: tieneFamiliarPeps,
                  ),
                  title: 'Tiene Familiar PEPS?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null) return;
                    setState(() {
                      tieneFamiliarPeps = item.value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tieneFamiliarPeps: tieneFamiliarPeps,
                        ),
                      );
                    });
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                if (tieneFamiliarPeps == 'input.yes'.tr()) ...[
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: nombreFamiliarPeps2,
                    icon: Icon(
                      Icons.person,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre Familiar PEPS 2',
                    hintText: 'Ingresa Nombre Familiar PEPS 2',
                    isValid: null,
                    onChange: (value) {
                      nombreFamiliarPeps2 = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliarPeps2: nombreFamiliarPeps2,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: parentescoFamiliarPeps2Ver ?? '',
                      value: parentesco,
                    ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    hintText: 'input.select_option'.tr(),
                    codigo: 'PARENTESCO',
                    onChanged: (item) {
                      if (item == null) return;
                      parentesco = item.value;
                      parentescoFamiliarPeps2Ver = item.name;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoFamiliarPeps2: parentesco,
                          parentescoFamiliarPeps2Ver:
                              parentescoFamiliarPeps2Ver,
                        ),
                      );
                    },
                    title: 'Parentesco Familiar PEPS 2',
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: cargoParentesco,
                    icon: Icon(
                      Icons.work,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cargo Familiar PEPS 2',
                    hintText: 'Ingresa Cargo Familiar PEPS 2',
                    isValid: null,
                    onChange: (value) {
                      cargoParentesco = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoFamiliarPeps2: cargoParentesco,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: nombreEntidadPeps2,
                    icon: Icon(
                      Icons.business,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre Entidad PEPS 2',
                    hintText: 'Ingresa Nombre Entidad PEPS 2',
                    isValid: null,
                    onChange: (value) {
                      nombreEntidadPeps2 = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreEntidadPeps2: nombreEntidadPeps2,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    initialValue: periodoPeps2,
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Periodo PEPS 2',
                    hintText: 'Ingresa Periodo PEPS 2',
                    isValid: null,
                    onChange: (value) {
                      periodoPeps2 = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps2: periodoPeps2,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  CatalogoValorNacionalidad(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: paisPeps2 ?? '',
                      nombre: paisPeps2Ver ?? '',
                      relacion: '',
                    ),
                    title: 'País PEPS 2',
                    hintText: 'Selecciona País PEPS 2',
                    onChanged: (item) {
                      if (item == null) return;
                      paisPeps2 = item.valor;
                      paisPeps2Ver = item.nombre;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps2: paisPeps2,
                          paisPeps2Ver: paisPeps2Ver,
                        ),
                      );
                    },
                    codigo: 'PAIS',
                  ),
                ],
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Siguiente',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.pageController.previousPage(
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
