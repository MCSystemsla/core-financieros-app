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

class AsalariadoForm6 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm6({super.key, required this.controller});

  @override
  State<AsalariadoForm6> createState() => _AsalariadoForm6State();
}

class _AsalariadoForm6State extends State<AsalariadoForm6>
    with AutomaticKeepAliveClientMixin {
  String? nombreFamiliarCercano;
  String? telefonoFamiliarCercano;
  Item? parentescoFamiliarCercano;
  String? direccionDomicilioFamiiiar;
  String? nombreConyuge;
  String? nacionalidadConyuge;
  String? profesionConyuge;
  String? trabajaConyuge;
  String? salarioNetoMensualConyuge;
  String? otrosIngresosConyuge;
  String? fuenteOtrosIngresosConyuge;
  String? totalIngresosMesConyuge;
  String? observaciones;
  String? nombreDelaEmpresaConyuge;
  String? telefonoOficinaConyuge;
  String telefonoOficinaCodeConyuge = '+503';
  String? direccionTrabajoConyugue;
  String? tiempoLaborarConyugue;
  String? estadoCivil;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                'Datos familiar no cercano que no viva con usted',
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
                nombreFamiliarCercano = value;
              },
              title: 'Nombre y Apellido del familiar no cercano',
              icon: const Icon(Icons.person_outline),
            ),
            const Gap(30),
            CountryInput(
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                telefonoFamiliarCercano = value;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                DashFormatter(),
              ],
              maxLength: 16,
              isRequired: false,
              hintText: 'Ingresa Teléfono de la persona no cercana',
              title: 'Teléfono del familiar no cercano',
              icon: const Icon(Icons.phone_outlined),
              textInputType: TextInputType.phone,
            ),
            const Gap(30),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'PARENTESCO',
              onChanged: (item) {
                parentescoFamiliarCercano = item;
                setState(() {});
              },
              title: 'Parentesco del familiar no cercano',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                direccionDomicilioFamiiiar = value;
              },
              title: 'Dirección Domicilio del familiar no cercano',
              icon: const Icon(Icons.location_on_outlined),
            ),
            const Divider(),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Datos Civil del solicitante',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              hintText: 'input.select_option'.tr(),
              onChanged: (item) {
                estadoCivil = item?.value;
                setState(() {});
              },
              codigo: 'ESTADOCIVIL',
              title: 'Estado civil ',
            ),
            if (estadoCivil == 'CAS' || estadoCivil == 'UNI') ...[
              const Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Datos de Cónyuge',
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
                  nombreConyuge = value;
                },
                title: 'Nombre y Apellido del Cónyuge',
                icon: const Icon(Icons.badge_outlined),
              ),
              const Gap(30),
              CatalogoValorNacionalidad(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                codigo: 'PAIS',
                title: 'Nacionalidad del Cónyuge',
                onChanged: (item) {
                  nacionalidadConyuge = item?.valor;
                  setState(() {});
                },
                hintText: 'input.select_option'.tr(),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  profesionConyuge = value;
                },
                title: 'Profesión del Cónyuge',
                icon: const Icon(Icons.work_outline),
              ),
              const Gap(30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: JLuxDropdown(
                  validator: (value) => ClassValidator.validateRequired(value),
                  dropdownColor: Colors.white,
                  isContainIcon: true,
                  title: '¿Trabaja su Cónyuge?:',
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    trabajaConyuge = item;
                    setState(() {});
                  },
                  // validator: (value) {},
                  toStringItem: (item) => item,
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (trabajaConyuge == 'input.yes'.tr()) ...[
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    nombreDelaEmpresaConyuge = value;
                  },
                  title: 'Nombre de la empresa donde trabaja su Cónyuge',
                  icon: const Icon(Icons.business_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    direccionTrabajoConyugue = value;
                  },
                  title: 'Dirección de la Empresa donde trabaja su Cónyuge',
                  icon: const Icon(Icons.badge_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  onChange: (value) {
                    tiempoLaborarConyugue = value;
                  },
                  title: 'Tiempo de laborar su Cónyuge',
                  icon: const Icon(Icons.badge_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    salarioNetoMensualConyuge = value;
                  },
                  title: 'Salario Neto Mensual Cónyuge (C\$)',
                  icon: const Icon(Icons.attach_money_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    otrosIngresosConyuge = value;
                  },
                  title: 'Otros ingresos Cónyuge (C\$)',
                  icon: const Icon(Icons.money_off_csred_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    fuenteOtrosIngresosConyuge = value;
                  },
                  title: 'Fuentes otros ingresos Cónyuge',
                  icon: const Icon(Icons.source_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChange: (value) {
                    totalIngresosMesConyuge = value;
                  },
                  title: 'Total ingresos mes Cónyuge (C\$)',
                  icon: const Icon(Icons.calculate_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    observaciones = value;
                  },
                  title: 'Observaciones del Cónyuge',
                  icon: const Icon(Icons.note_alt_outlined),
                ),
                const Gap(30),
                CountryInput(
                  validator: (value) => ClassValidator.validateRequired(value),
                  onCountryCodeChange: (value) {
                    telefonoOficinaCodeConyuge = value?.dialCode ?? '+503';
                  },
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                    DashFormatter(),
                  ],
                  onChange: (value) {
                    telefonoOficinaConyuge = value;
                  },
                  maxLength: 15,
                  isRequired: false,
                  title: 'Teléfono Oficina',
                  icon: const Icon(Icons.phone_iphone_outlined),
                ),
              ],
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
                        direccionTrabajoConyugue: direccionTrabajoConyugue,
                        tiempoLaborarConyugue: tiempoLaborarConyugue,
                        nombreFamiliarCercano: nombreFamiliarCercano,
                        telefonoFamiliarCercano: telefonoFamiliarCercano,
                        objParentescoFamiliarCercanoId:
                            parentescoFamiliarCercano?.value,
                        objParentescoFamiliarCercanoIdVer:
                            parentescoFamiliarCercano?.name,
                        direccionFamiliarCercano: direccionDomicilioFamiiiar,
                        nombreConyugue: nombreConyuge,
                        nacionalidadConyugue: nacionalidadConyuge,
                        profesionConyugue: profesionConyuge,
                        trabajaConyugue: trabajaConyuge == 'input.yes'.tr(),
                        sueldoMesConyugue:
                            double.tryParse(salarioNetoMensualConyuge ?? '0'),
                        otrosIngresosConyugue:
                            double.tryParse(otrosIngresosConyuge ?? '0'),
                        fuenteOtrosIngresosConyugue: fuenteOtrosIngresosConyuge,
                        totalIngresoMesConyugue:
                            double.tryParse(totalIngresosMesConyuge ?? '0'),
                        observacion: observaciones,
                        trabajoConyugue: nombreDelaEmpresaConyuge,
                        telefonoTrabajoConyugue: telefonoOficinaCodeConyuge +
                            (telefonoOficinaConyuge ?? '').replaceAll('-', ''),
                        objEstadoCivilId: estadoCivil,
                        objEstadoCivilIdVer: estadoCivil,
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

  @override
  bool get wantKeepAlive => true;
}
