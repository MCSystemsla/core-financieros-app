// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoHnForm3 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm3({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm3> createState() => _AsalariadoHnForm3State();
}

class _AsalariadoHnForm3State extends State<AsalariadoHnForm3> {
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
                  hintText: 'Profesión',
                  icon: Icon(Icons.school, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objprofesionID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ocupación',
                  icon: Icon(Icons.work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objOcupacionID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Cargo',
                  icon: Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Cargo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Nombre del Trabajo',
                  icon:
                      Icon(Icons.business, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'NombreTrabajo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Dirección del Trabajo',
                  icon: Icon(Icons.location_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'DireccionTrabajo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Barrio del Trabajo',
                  icon: Icon(Icons.location_city,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'BarrioTrabajo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Teléfono del Trabajo',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'TelefonoTrabajo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Tiempo de Laborar',
                  icon: Icon(Icons.access_time,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'TiempoLaborar',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Lugar de Trabajo Anterior',
                  icon: Icon(Icons.work_history,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'LugarTrabajoAnterior',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Salario Neto en Córdobas',
                  icon: Icon(Icons.attach_money,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'SalarioNetoCordoba',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Total Ingresos al Mes',
                  icon: Icon(Icons.account_balance_wallet,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'TotalIngresoMes',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Otros Ingresos en Córdobas',
                  icon:
                      Icon(Icons.payments, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'OtrosIngresosCordoba',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Fuente de Otros Ingresos',
                  icon: Icon(Icons.source, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'FuenteOtrosIngresos',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Nivel Aproximado de Ingresos',
                  icon: Icon(Icons.stacked_bar_chart,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'ObjNivelAproximadoDeIngresosID',
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
                  context.pushReplacement('/solicitudes');
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
