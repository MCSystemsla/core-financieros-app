import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/asalariado/analisis_asalariados_form_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/stepper/analisis_solicitud_asalariado_stepper.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_credit_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudAsalariadoFormScreen extends StatefulWidget {
  final int index;
  const AnalisisSolicitudAsalariadoFormScreen({
    super.key,
    required this.index,
  });

  @override
  State<AnalisisSolicitudAsalariadoFormScreen> createState() =>
      _AnalisisSolicitudAsalariadoFormScreenState();
}

class _AnalisisSolicitudAsalariadoFormScreenState
    extends State<AnalisisSolicitudAsalariadoFormScreen> {
  final pageController = PageController();
  int activeStep = 0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page == activeStep) return;
      setState(() => activeStep = page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: AnalisisCreditCard(
              enabled: false,
              index: widget.index,
              animate: false,
              title: 'Numero Solicitud #12345',
              subtitle: 'Jaime Velásquez',
              description: 'C\$. 50,000',
            ),
          ),
          const Gap(20),
          Expanded(
            child: AnalisisSolicitudAsalariadoStepper(
              activeStep: activeStep,
            ),
          ),
          const Gap(20),
          Expanded(
            flex: 3,
            child: PageView(
              controller: pageController,
              children: [
                AnalisisAsalariadoFormWidget(
                  pageController: pageController,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ExpansionTitleCustom(
                          title: Text(
                            'Referencia 1',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          finalStep: true,
                          children: const [
                            _AnalisisReferencia1(),
                          ],
                        ),
                        ExpansionTitleCustom(
                          title: Text(
                            'Referencia 2',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          finalStep: true,
                          children: const [
                            _AnalisisReferencia2(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalisisReferencia2 extends StatelessWidget {
  const _AnalisisReferencia2();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OutlineTextfieldWidget(
          title: 'Nombres y apellidos:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Tipo de Parentesco:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Direccion:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Centro laboral:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Numero de cédula:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Empleado que verifica:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Telefono:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Resultado de verificación:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Anos de conocer referido:',
          icon: Icon(Icons.person_3_sharp),
        ),
      ],
    );
  }
}

class _AnalisisReferencia1 extends StatelessWidget {
  const _AnalisisReferencia1();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OutlineTextfieldWidget(
          title: 'Nombres y apellidos:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Dirección:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Número de cédula:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Teléfono:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Años de conocer referido:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Tipo de Parentesco:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Centro laboral:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Fecha de verificación:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Empleado que verifica:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Resultado de verificación:',
          icon: Icon(Icons.person_3_sharp),
        ),
      ],
    );
  }
}
