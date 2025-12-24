import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisMenorMilForm2 extends StatefulWidget {
  final PageController pageController;
  const AnalisisMenorMilForm2({super.key, required this.pageController});

  @override
  State<AnalisisMenorMilForm2> createState() => _AnalisisMenorMilForm2State();
}

class _AnalisisMenorMilForm2State extends State<AnalisisMenorMilForm2> {
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
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Estado de resultado expresado en Lempira',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _EstadoResultadoForm(),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: Colors.green,
                  ),
                  const Gap(10),
                  CustomElevatedButton(
                    onPressed: () {
                      widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Anterior',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _EstadoResultadoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlineTextfieldWidget(
            title: 'Ventas de contado',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.add_box),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Recuperaciones',
            textInputType: TextInputType.number,
            onChange: (value) {},
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Total ingresos',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.wallet),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Costo de Venta (0.73%)',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Gastos operativos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Margen bruto del negocio',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Otros ingresos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Gastos unidad familiar',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Disponibilidad U.F Familiar',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'D.P.P (90%)',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
