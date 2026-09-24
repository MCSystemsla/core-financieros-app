import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form8.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/update_solicitud_asalariado_form9.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_historial_credito.dart';
import 'package:flutter/material.dart';

class ActualizarSolicitudAsalariadoContainer extends StatefulWidget {
  const ActualizarSolicitudAsalariadoContainer({
    super.key,
  });

  @override
  State<ActualizarSolicitudAsalariadoContainer> createState() =>
      _ActualizarSolicitudAsalariadoContainerState();
}

class _ActualizarSolicitudAsalariadoContainerState
    extends State<ActualizarSolicitudAsalariadoContainer> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Navbar(
          title: 'Actualizar Solicitud Asalariado',
        ),
        Expanded(
          child: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                UpdateSolicitudAsalariadoForm1(
                  controller: pageController,
                ),
                UpdateSolicitudAsalariadoForm2(
                  controller: pageController,
                ),
                UpdateSolicitudAsalariadoForm3(
                  controller: pageController,
                ),
                UpdateSolicitudAsalariadoForm4(
                  controller: pageController,
                ),
                UpdateSolicitudAsalariadoForm5(
                  controller: pageController,
                ),
                UpdateSolicitudAsalariadoForm6(
                  controller: pageController,
                ),
                UpdateSolicitudAsalariadoForm7(
                  controller: pageController,
                ),
                UpdateSolicitudAsalariadoForm8(
                  controller: pageController,
                ),
                UpdateSolicitudNuevaMenorHistorialCredito(
                  controller: pageController,
                  currentStep: 9,
                  steps: 10,
                ),
                UpdateSolicitudAsalariadoForm9(
                  controller: pageController,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
