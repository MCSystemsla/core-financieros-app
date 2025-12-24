import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisMenorMilForm3 extends StatefulWidget {
  final PageController pageController;
  const AnalisisMenorMilForm3({super.key, required this.pageController});

  @override
  State<AnalisisMenorMilForm3> createState() => _AnalisisMenorMilForm3State();
}

class _AnalisisMenorMilForm3State extends State<AnalisisMenorMilForm3> {
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
                'Constancias, licencias y permisos',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _RucForm(),
            const Gap(10),
            _MatriculaForm(),
            const Gap(10),
            _LicenciaForm(),
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

class _LicenciaForm extends StatelessWidget {
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
              'Licencia',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Licencia',
            icon: const Icon(Icons.add_box),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Nombre de institución',
            textInputType: TextInputType.number,
            onChange: (value) {},
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de emisión',
            icon: const Icon(Icons.wallet),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de vencimiento',
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

class _MatriculaForm extends StatelessWidget {
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
              'Matricula',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Matricula',
            icon: const Icon(Icons.add_box),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Nombre de institución',
            textInputType: TextInputType.number,
            onChange: (value) {},
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de emisión',
            icon: const Icon(Icons.wallet),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de vencimiento',
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

class _RucForm extends StatelessWidget {
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
              'RUC',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Numero de RUC',
            icon: const Icon(Icons.add_box),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Nombre de institución',
            textInputType: TextInputType.number,
            onChange: (value) {},
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de emisión de RUC',
            icon: const Icon(Icons.wallet),
            onChange: (value) {},
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de vencimiento de RUC',
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
