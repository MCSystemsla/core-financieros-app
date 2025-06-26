// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoForm5View extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm5View({super.key, required this.controller});

  @override
  State<AsalariadoForm5View> createState() => _AsalariadoForm5ViewState();
}

class _AsalariadoForm5ViewState extends State<AsalariadoForm5View> {
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
  String? nombreEmpresa;
  String? barrioEmpresa;
  String? otrosIngresos;
  String? cargo;
  String? lugarTrabajoAnterior;
  String? fuenteOtrosIngresos;
  String? telefonoOficina;
  String telefonoCodeOficina = '+503';
  String? salarioNetoMensual;
  String? tiempoDeTrabajar;
  String? direccionEmpresa;
  String? totalIngresoMes;
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
                'Datos del empleo del solicitante',
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
                nombreEmpresa = value;
              },
              title: 'Nombre de la empresa',
              icon: const Icon(Icons.business),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                direccionEmpresa = value;
              },
              title: 'Dirección de la empresa',
              icon: const Icon(Icons.location_on),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                barrioEmpresa = value;
              },
              title: 'Barrio de la empresa',
              icon: const Icon(Icons.location_city),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                otrosIngresos = value.replaceAll(',', '');
              },
              inputFormatters: [
                CurrencyInputFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
              ],
              textInputType: TextInputType.number,
              title: 'Otros ingresos (C\$)',
              icon: const Icon(Icons.attach_money),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                cargo = value;
              },
              title: 'Cargo que Ocupa',
              icon: const Icon(Icons.badge),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                lugarTrabajoAnterior = value;
              },
              title: 'Lugar trabajo anterior',
              icon: const Icon(Icons.history),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                fuenteOtrosIngresos = value;
              },
              title: 'Fuente otros ingresos',
              icon: const Icon(Icons.money_off),
            ),
            const Gap(30),
            CountryInput(
              textInputType: TextInputType.phone,
              validator: (value) => ClassValidator.validateRequired(value),
              onCountryCodeChange: (value) {
                telefonoCodeOficina = value?.dialCode ?? '+503';
              },
              maxLength: 9,
              isRequired: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
                DashFormatter(),
              ],
              onChange: (value) {
                telefonoOficina = value;
              },
              title: 'Teléfono Oficina',
              icon: const Icon(Icons.phone),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                salarioNetoMensual = value.replaceAll(',', '');
              },
              textInputType: TextInputType.number,
              inputFormatters: [
                CurrencyInputFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
              ],
              title: 'Salario Neto Mensual (C\$)',
              icon: const Icon(Icons.money),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              validator: (value) => ClassValidator.validateRequired(value),
              textInputType: TextInputType.number,
              inputFormatters: [
                CurrencyInputFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
              ],
              title: 'Total ingresos mes (C\$)',
              icon: const Icon(Icons.summarize),
              onChange: (value) {
                totalIngresoMes = value.replaceAll(',', '');
              },
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                tiempoDeTrabajar = value;
              },
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              title: 'Tiempo de Trabajar',
              icon: const Icon(Icons.schedule),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  if ((double.tryParse(totalIngresoMes ?? '0') ?? 0) <
                      (double.tryParse(salarioNetoMensual ?? '0') ?? 0.0)) {
                    CustomAlertDialog(
                      context: context,
                      title:
                          'El total de ingresos del mes no puede ser menor al salario neto mensual',
                      onDone: () => context.pop(),
                    ).showDialog(context, dialogType: DialogType.warning);
                    return;
                  }
                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        nombreTrabajo: nombreEmpresa,
                        barrioTrabajo: barrioEmpresa,
                        otrosIngresosCordoba:
                            double.tryParse(otrosIngresos ?? '0'),
                        cargo: cargo,
                        lugarTrabajoAnterior: lugarTrabajoAnterior,
                        fuenteOtrosIngresos: fuenteOtrosIngresos,
                        telefonoTrabajo: telefonoCodeOficina +
                            telefonoOficina!.replaceAll('-', ''),
                        salarioNetoCordoba:
                            double.tryParse(salarioNetoMensual ?? '0'),
                        tiempoLaborar: tiempoDeTrabajar,
                        direccionTrabajo: direccionEmpresa,
                        totalIngresoMes:
                            double.tryParse(totalIngresoMes ?? '0'),
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
