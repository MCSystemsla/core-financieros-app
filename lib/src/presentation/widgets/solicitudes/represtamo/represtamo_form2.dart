// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReprestamoForm2 extends StatefulWidget {
  final PageController controller;
  const ReprestamoForm2({super.key, required this.controller});

  @override
  State<ReprestamoForm2> createState() => _ReprestamoForm2State();
}

class _ReprestamoForm2State extends State<ReprestamoForm2>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? familiarEmpleado;
  String? familiarEntidad;
  String? tieneFamiliarPeps;
  String? nombreEmpleado;
  String? cedulaEmpleado;
  String? espeps;
  String? nombreDeEntidadPeps;
  Item? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? nombreFamiliarPeps2;
  Item? parentescoFamiliarPeps2;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  Item? paisPeps2;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudReprestamoCubit>();
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Es familiar de un empleado?'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  familiarEmpleado = item;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      esFamiliarEmpleado: familiarEmpleado == 'input.yes'.tr(),
                    ),
                  );
                  setState(() {});
                },
                validator: (value) => ClassValidator.validateRequired(value),
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (familiarEmpleado == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.person,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre del empleado',
                hintText: 'Ingresa Nombre del empleado',
                isValid: null,
                onChange: (value) {
                  nombreEmpleado = value;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      nombreFamiliar: nombreEmpleado,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) =>
                    ClassValidator.validateMaxIntValueAndMinValue(
                  value,
                  14,
                  isNicaraguaCedula: true,
                  isRequired: true,
                ),
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cédula del empleado',
                hintText: 'Ingresa Cédula del empleado',
                isValid: null,
                onChange: (value) {
                  cedulaEmpleado = value;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      cedulaFamiliar: cedulaEmpleado,
                    ),
                  );
                },
              ),
            ],
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    '¿Has desempeñado un cargo público y/o figura pública de alto nivel en los últimos 10 años?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                validator: (value) => ClassValidator.validateRequired(value),
                onChanged: (item) {
                  if (item == null) return;
                  espeps = item;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      esPeps: espeps == 'input.yes'.tr(),
                    ),
                  );
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (espeps == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de la entidad',
                hintText: 'Ingresa Nombre de la entidad',
                isValid: null,
                onChange: (value) {
                  nombreDeEntidadPeps = value;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      nombreDeEntidadPeps: nombreDeEntidadPeps,
                    ),
                  );
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                hintText: 'input.select_option'.tr(),
                title: 'Pais',
                onChanged: (item) {
                  if (item == null) return;
                  paisPeps = Item(name: item.nombre, value: item.valor);
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      paisPeps: paisPeps?.value,
                      paisPepsVer: paisPeps?.name,
                    ),
                  );
                  setState(() {});
                },
                codigo: 'PAIS',
                validator: (value) =>
                    ClassValidator.validateRequired(value.valor),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.perm_identity_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Periodo',
                hintText: 'Ingrese periodo',
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
              const Gap(20),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cargo oficial',
                hintText: 'Ingrese cargo oficial',
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
            ],
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    '¿Eres familia de una persona que ha desempeñado un cargo público o figura pública de alto nivel?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  tieneFamiliarPeps = item;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      tieneFamiliarPeps: tieneFamiliarPeps == 'input.yes'.tr(),
                    ),
                  );
                  setState(() {});
                },
                validator: (value) => ClassValidator.validateRequired(value),
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (tieneFamiliarPeps == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre del familiar',
                hintText: 'Ingrese Nombre del familiar',
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
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cargo Familiar',
                hintText: 'Ingrese cargo familiar',
                isValid: null,
                onChange: (value) {
                  cargoFamiliarPeps2 = value;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      cargoFamiliarPeps2: cargoFamiliarPeps2,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de la entidad',
                hintText: 'Ingrese nombre de la entidad',
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
              SearchDropdownWidget(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                onChanged: (item) {
                  if (item == null) return;
                  parentescoFamiliarPeps2 =
                      Item(name: item.name, value: item.value);
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      parentescoFamiliarPeps2: parentescoFamiliarPeps2?.value,
                      parentescoFamiliarPeps2Ver: parentescoFamiliarPeps2?.name,
                    ),
                  );
                  setState(() {});
                },
                codigo: 'PARENTESCO',
                title: 'Parentesco',
                hintText: 'input.select_option'.tr(),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Periodo',
                hintText: 'Ingrese período',
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
                hintText: 'input.select_option'.tr(),
                title: 'País',
                onChanged: (item) {
                  if (item == null) return;
                  paisPeps2 = Item(name: item.nombre, value: item.valor);
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      paisPeps2: paisPeps2?.value,
                      paisPeps2Ver: paisPeps2?.name,
                    ),
                  );
                  setState(() {});
                },
                codigo: 'PAIS',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
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

                  widget.controller.nextPage(
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
  }

  @override
  bool get wantKeepAlive => true;
}
