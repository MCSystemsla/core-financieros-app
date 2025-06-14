// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorEsPepsWidget extends StatefulWidget {
  const NuevaMenorEsPepsWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorEsPepsWidget> createState() => _NuevaMenorEsPepsWidgetState();
}

class _NuevaMenorEsPepsWidgetState extends State<NuevaMenorEsPepsWidget>
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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                validator: (value) => ClassValidator.validateRequired(value),
                isContainIcon: true,
                title: 'Es PEPS',
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  esPeps = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (esPeps == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.business,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de Entidad PEPS',
                hintText: 'Ingresa Nombre de Entidad PEPs',
                isValid: null,
                onChange: (value) {
                  nombreEntidadPeps = value;
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                hintText: 'Selecciona Pais PEPS',
                title: 'País PEPs',
                onChanged: (item) {
                  if (item == null || !mounted) return;
                  paisPeps = item.valor;
                },
                codigo: 'PAIS',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.work,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cargo Oficial PEPS',
                hintText: 'Ingresa Cargo Oficial PEPS',
                isValid: null,
                onChange: (value) {
                  cargoOficialPeps = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.calendar_today,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Período PEPS',
                hintText: 'Período PEPS',
                isValid: null,
                onChange: (value) {
                  periodoPeps = value;
                },
              ),
              const Gap(20),
            ],
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: '¿Tiene Familiar PEPS?	',
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  tieneFamiliarPeps = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (tieneFamiliarPeps == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.person,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre Familiar PEPS',
                hintText: 'Ingresa Nombre Familiar PEPS',
                isValid: null,
                onChange: (value) {
                  nombreFamiliarPeps2 = value;
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                codigo: 'PARENTESCO',
                onChanged: (item) {
                  if (item == null) return;
                  parentesco = item.value;
                },
                title: 'Parentesco Familiar PEPS',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.work,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cargo Familiar PEPS',
                hintText: 'Ingresa Cargo Familiar',
                isValid: null,
                onChange: (value) {
                  cargoParentesco = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.business,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de la Entidad PEPS',
                hintText: 'Ingresa Nombre Entidad PEPS',
                isValid: null,
                onChange: (value) {
                  nombreEntidadPeps2 = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.calendar_today,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Periodo Familiar PEPS',
                hintText: 'Ingresa Periodo Familiar PEPS',
                isValid: null,
                onChange: (value) {
                  periodoPeps2 = value;
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                title: 'País Familiar PEPS',
                hintText: 'Selecciona Familiar País PEPS',
                onChanged: (item) {
                  if (item == null) return;
                  paisPeps2 = item.valor;
                },
                codigo: 'PAIS',
              ),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        espeps: esPeps == 'input.yes'.tr(),
                        nombreDeEntidadPeps: nombreEntidadPeps,
                        paisPeps: paisPeps,
                        periodoPeps: periodoPeps,
                        cargoOficialPeps: cargoOficialPeps,
                        tieneFamiliarPeps:
                            tieneFamiliarPeps == 'input.yes'.tr(),
                        nombreFamiliar: nombreFamiliarPeps,
                        parentescoFamiliarPeps2: nombreFamiliarPeps,
                        cargoFamiliarPeps2: cargoParentesco,
                        nombreFamiliarPeps2: nombreFamiliarPeps2,
                        periodoPeps2: periodoPeps2,
                        paisPeps2: paisPeps2,
                        nombreEntidadPeps2: nombreEntidadPeps2,
                      );
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
  }

  @override
  bool get wantKeepAlive => true;
}
