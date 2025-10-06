// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm3 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm3({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm3> createState() => _NuevaMenorForm3State();
}

class _NuevaMenorForm3State extends State<NuevaMenorForm3> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 3,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nombre Negocio',
                  icon:
                      Icon(Icons.business, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Nombre Negocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Dirección Negocio',
                  icon: Icon(Icons.location_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  title: 'Dirección Negocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Tiempo de Funcionamiento',
                  icon: Icon(Icons.access_time,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'TiempoFuncionamientoNegocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Sector ID',
                  icon:
                      Icon(Icons.pin_drop, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objSectorID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Barrio Negocio',
                  icon:
                      Icon(Icons.apartment, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Barrio Negocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Municipio Negocio ID',
                  icon: Icon(Icons.location_city,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objMunicipioNegocioID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Condición Negocio ID',
                  icon: Icon(Icons.info, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objCondicionNegocioID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Teléfono Negocio',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'TelefonoNegocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Celular Negocio',
                  icon: Icon(Icons.smartphone,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Celular Negocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Puesto Negocio',
                  icon: Icon(Icons.storefront,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'puestoNegocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Aldea Negocio ID',
                  icon:
                      Icon(Icons.home_work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objAldeaNegocioID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Departamento Negocio ID',
                  icon: Icon(Icons.map, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objDepartamentoNegocioID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Caserio Negocio',
                  icon: Icon(Icons.home, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'CaserioNegocio',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nivel Aproximado Ingresos ID',
                  icon: Icon(Icons.monetization_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objNivelAproximadoIngresosID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Horario Trabajo',
                  icon: Icon(Icons.work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'HorarioTrabajo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Horario Visita',
                  icon:
                      Icon(Icons.schedule, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'HorarioVisita',
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
}
