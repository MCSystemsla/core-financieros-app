// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
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
  String? direccionTrabajoConyugue;
  String? tiempoLaborarConyugue;
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
              onChange: (value) {
                nombreFamiliarCercano = value;
              },
              title: 'Nombre',
              icon: const Icon(Icons.person_outline),
            ),
            const Gap(30),
            CountryInput(
              onChange: (value) {
                telefonoFamiliarCercano = value;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
                DashFormatter(),
              ],
              maxLength: 15,
              isRequired: false,
              hintText: 'Ingresa Telefono',
              title: 'Telefono',
              icon: const Icon(Icons.phone_outlined),
              textInputType: TextInputType.phone,
            ),
            const Gap(30),
            SearchDropdownWidget(
              codigo: 'PARENTESCO',
              onChanged: (item) {
                parentescoFamiliarCercano = item;
                setState(() {});
              },
              title: 'Parentesco',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                direccionDomicilioFamiiiar = value;
              },
              title: 'Dirección Domicilio',
              icon: const Icon(Icons.location_on_outlined),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Datos de conyugue',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                nombreConyuge = value;
              },
              title: 'Nombre y Apellido',
              icon: const Icon(Icons.badge_outlined),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                nacionalidadConyuge = value;
              },
              title: 'Nacionalidad del conyugue',
              icon: const Icon(Icons.flag_outlined),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                profesionConyuge = value;
              },
              title: 'Profesión',
              icon: const Icon(Icons.work_outline),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: '¿Trabaja?:',
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
                onChange: (value) {
                  direccionTrabajoConyugue = value;
                },
                title: 'Direccion de la Empresa',
                icon: const Icon(Icons.badge_outlined),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChange: (value) {
                  tiempoLaborarConyugue = value;
                },
                title: 'Tiempo de laborar',
                icon: const Icon(Icons.badge_outlined),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  salarioNetoMensualConyuge = value;
                },
                title: 'Salario Neto Mensual (C\$)',
                icon: const Icon(Icons.attach_money_outlined),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  otrosIngresosConyuge = value;
                },
                title: 'Otros ingresos (C\$)',
                icon: const Icon(Icons.money_off_csred_outlined),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                onChange: (value) {
                  fuenteOtrosIngresosConyuge = value;
                },
                title: 'Fuentes otros ingresos',
                icon: const Icon(Icons.source_outlined),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  totalIngresosMesConyuge = value;
                },
                title: 'Total ingresos mes (C\$)',
                icon: const Icon(Icons.calculate_outlined),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                onChange: (value) {
                  observaciones = value;
                },
                title: 'Observaciones',
                icon: const Icon(Icons.note_alt_outlined),
              ),
              const Gap(30),
              OutlineTextfieldWidget(
                onChange: (value) {
                  nombreDelaEmpresaConyuge = value;
                },
                title: 'Nombres de la empresa',
                icon: const Icon(Icons.business_outlined),
              ),
              const Gap(30),
              CountryInput(
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
                        telefonoTrabajoConyugue: telefonoOficinaConyuge,
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
