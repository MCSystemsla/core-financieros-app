import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisAsalariadoFormWidget extends StatelessWidget {
  const AnalisisAsalariadoFormWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTitleCustom(
              title: Text(
                'Estado Patrimonial',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                ExpansionTitleCustom(
                  childrenPadding: EdgeInsets.symmetric(vertical: 15),
                  title: Text('Activos'),
                  finalStep: false,
                  children: [
                    OutlineTextfieldWidget(
                      title: 'Caja y Banco:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Valores y Acciones:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Menaje del hogar:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Vehiculo:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Maquinaria:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Balance inmuebles:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Total activos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                  ],
                ),
                ExpansionTitleCustom(
                  childrenPadding: EdgeInsets.symmetric(vertical: 15),
                  title: Text('Pasivos'),
                  finalStep: false,
                  children: [
                    OutlineTextfieldWidget(
                      title: 'Cuentas por pagar:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Préstamo banco corto plazo:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Préstamo banco largo plazo:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Otras cuentas por pagar:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Total pasivos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Patrimonio:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Pasivo + Patrimonio:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Estado de resultado',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      title: 'Ingresos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Ingreso(s) neto(s) por salario:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Otros ingresos (Debidamente comprobados):',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Total ingresos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Egresos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Alimentación:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Educación:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title:
                          'Servicios básicos (Agua, luz, gas, teléfono y cable):',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Aseo y limpieza:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Vestimenta y calzado:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Transporte/Combustible/Mantenimiento vehículo:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Imprevistos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Amortizaciones deudas pendientes:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Otros egresos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Total egresos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Disponible (Ingresos - Egresos):',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(30),
            CustomElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Siguiente',
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
