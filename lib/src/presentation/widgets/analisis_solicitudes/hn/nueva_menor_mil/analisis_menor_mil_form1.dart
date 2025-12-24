import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisMenorMilForm1 extends StatefulWidget {
  const AnalisisMenorMilForm1({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisMenorMilForm1> createState() => _AnalisisMenorMilForm1State();
}

class _AnalisisMenorMilForm1State extends State<AnalisisMenorMilForm1> {
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
                'Balance general expresado en lempira',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _ActivosForm(),
            const Gap(20),
            _PasivosForm(),
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

class _PasivosForm extends StatelessWidget {
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
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Pasivos',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Proveedores',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.add_box),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Cuentas por cobrar',
            textInputType: TextInputType.number,
            onChange: (value) {},
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Otras deudas',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.wallet),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total pasivos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Capital',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Pasivos + Capital',
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

class _ActivosForm extends StatelessWidget {
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
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Activos',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Caja',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.add_box),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Banco',
            textInputType: TextInputType.number,
            onChange: (value) {},
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Cuentas por cobrar',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.wallet),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Inventario',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Otros activos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Otros activos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total activos circulantes',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Activos fijos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total activo',
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
