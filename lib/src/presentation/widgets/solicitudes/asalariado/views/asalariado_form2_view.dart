// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoForm2View extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm2View({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoForm2View> createState() => _AsalariadoForm2ViewState();
}

class _AsalariadoForm2ViewState extends State<AsalariadoForm2View> {
  @override
  Widget build(BuildContext context) {
    return _FormContent(
      controller: widget.controller,
    );
  }
}

class _FormContent extends StatefulWidget {
  final PageController controller;
  const _FormContent({required this.controller});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  String telefonoCodeBeneficiario = '+503';
  String? beneficiarioSeguro;
  Item? parentesco;
  String? cedula;
  String? telefono;
  String? esPeps;
  String? nombreEntidad;
  String? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? familiarPeps;
  String? nombreFamiliarPeps;
  String? parentescoFamiliarPeps;
  String? cargoFamiliarPeps;
  String? nombreEntidadPeps;
  String? periodoFamiliarPeps;
  String? paisPepsFamiliar;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Beneficiarios del Seguro',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                beneficiarioSeguro = value;
              },
              title: 'Nombre y Apellido Beneficiario del Seguro',
              icon: const Icon(Icons.person),
            ),
            const Gap(30),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (item) {
                parentesco = item;
                setState(() {});
              },
              codigo: 'PARENTESCO',
              title: 'Paréntesco  del beneficiario del Seguro',
              hintText: 'input.select_option'.tr(),
            ),
            const Gap(30),
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
              onChange: (value) {
                cedula = value;
              },
              title: 'Cédula Beneficiario del Seguro',
              icon: const Icon(Icons.badge),
            ),
            const Gap(30),
            CountryInput(
              validator: (value) => ClassValidator.validateRequired(value),
              onCountryCodeChange: (value) {
                telefonoCodeBeneficiario = value?.dialCode ?? '';
              },
              textInputType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
                DashFormatter(),
              ],
              onChange: (value) {
                telefono = value;
              },
              isRequired: false,
              hintText: 'Ingresa Teléfono',
              maxLength: 10,
              title: 'Teléfono Beneficiario del Seguro',
              icon: const Icon(Icons.badge),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Información Adicional',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                validator: (value) => ClassValidator.validateRequired(value),
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    '¿Has desempeñado un cargo público y/o figura pública de alto nivel en los últimos 10 años? (PEPS)',
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  esPeps = item;
                  setState(() {});
                },
                // validator: (value) {},
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (esPeps == 'input.yes'.tr()) ...[
              const Gap(30),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  nombreEntidad = value;
                },
                title: 'Nombre de la Entidad PEPS',
                icon: const Icon(Icons.account_balance),
              ),
              const Gap(30),
              CatalogoValorNacionalidad(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                hintText: 'input.select_option'.tr(),
                title: 'País PEPS',
                onChanged: (item) {
                  if (item == null) return;
                  paisPeps = item.valor;

                  setState(() {});
                },
                codigo: 'PAIS',
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  periodoPeps = value;
                },
                title: 'Período PEPS',
                icon: const Icon(Icons.date_range),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  cargoOficialPeps = value;
                },
                title: 'Cargo Oficial PEPS',
                icon: const Icon(Icons.work),
              ),
              const Gap(30),
            ],
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    '¿Eres familia de una persona que ha desempeñado un cargo público o figura pública de alto nivel? (PEPS)',

                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  familiarPeps = item;
                  setState(() {});
                },
                // validator: (value) {},
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
                validator: (value) => ClassValidator.validateRequired(value),
              ),
            ),
            if (familiarPeps == 'input.yes'.tr()) ...[
              const Gap(30),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  nombreFamiliarPeps = value;
                },
                title: 'Nombre del Familiar PEPS',
                icon: const Icon(Icons.person),
                validator: (value) => ClassValidator.validateRequired(value),
              ),
              const Gap(30),
              SearchDropdownWidget(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                hintText: 'input.select_option'.tr(),
                onChanged: (item) {
                  parentescoFamiliarPeps = item?.value;
                  setState(() {});
                },
                codigo: 'PARENTESCO',
                title: 'Parentesco familiar PEPS',
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cargoFamiliarPeps = value;
                },
                title: 'Cargo del Familiar PEPS',
                icon: const Icon(Icons.work),
                validator: (value) => ClassValidator.validateRequired(value),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  nombreEntidadPeps = value;
                },
                title: 'Nombre de la Entidad familiar PEPS',
                icon: const Icon(Icons.account_balance),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  periodoFamiliarPeps = value;
                },
                title: 'Período familiar PEPS',
                icon: const Icon(Icons.date_range),
              ),
              const Gap(30),
              CatalogoValorNacionalidad(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                hintText: 'input.select_option'.tr(),
                codigo: 'PAIS',
                title: 'País familiar PEPS',
                onChanged: (item) {
                  paisPepsFamiliar = item?.valor;
                },
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

                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        beneficiarioSeguro: beneficiarioSeguro,
                        objParentescoBeneficiarioSeguroId: parentesco?.value,
                        objParentescoBeneficiarioSeguroIdVer: parentesco?.name,
                        cedulaBeneficiarioSeguro: cedula,
                        telefonoBeneficiario: telefonoCodeBeneficiario +
                            telefono!.trim().replaceAll('-', ''),
                        espeps: esPeps == 'input.yes'.tr(),
                        nombreDeEntidadPeps: nombreEntidad,
                        paisPeps: paisPeps,
                        periodoPeps: periodoPeps,
                        cargoOficialPeps: cargoOficialPeps,
                        tieneFamiliarPeps: familiarPeps == 'input.yes'.tr(),
                        nombreFamiliarPeps2: nombreFamiliarPeps,
                        parentescoFamiliarPeps2: parentescoFamiliarPeps,
                        cargoFamiliarPeps2: cargoFamiliarPeps,
                        nombreEntidadPeps2: nombreEntidadPeps,
                        periodoPeps2: periodoFamiliarPeps,
                        paisPeps2: paisPepsFamiliar,
                      );
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
}
