import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervisiones_credito_form7.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_5.dart';

class SupervisionesFormCreditoHnScreen extends StatelessWidget {
  const SupervisionesFormCreditoHnScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pagecontroller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Supervision Credito'),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pagecontroller,
        children: [
          SupervisionCreditoForm1(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm2(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm3(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm4(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm5(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm6(
            pagecontroller: pagecontroller,
          ),
          SupervisionesCreditoForm7(
            pagecontroller: pagecontroller,
          ),
        ],
      ),
    );
  }
}
