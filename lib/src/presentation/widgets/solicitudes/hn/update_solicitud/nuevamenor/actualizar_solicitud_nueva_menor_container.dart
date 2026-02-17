import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/update_solicitud_nueva_menor_form8.dart';
import 'package:flutter/material.dart';

class ActualizarSolicitudNuevaMenorContainer extends StatefulWidget {
  final bool isSolicitudGrupal;
  const ActualizarSolicitudNuevaMenorContainer({
    super.key,
    required this.isSolicitudGrupal,
  });

  @override
  State<ActualizarSolicitudNuevaMenorContainer> createState() =>
      _ActualizarSolicitudNuevaMenorContainerState();
}

class _ActualizarSolicitudNuevaMenorContainerState
    extends State<ActualizarSolicitudNuevaMenorContainer> {
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Column(
      children: [
        const Navbar(
          title: 'Actualizar Solicitud Nueva Menor',
        ),
        Expanded(
          child: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                UpdateSolicitudNuevaMenorForm1(
                  controller: pageController,
                  isSolicitudGrupal: widget.isSolicitudGrupal,
                ),
                UpdateSolicitudNuevaMenorForm2(
                  controller: pageController,
                ),
                UpdateSolicitudNuevaMenorForm3(
                  controller: pageController,
                ),
                UpdateSolicitudNuevaMenorForm4(
                  controller: pageController,
                ),
                UpdateSolicitudNuevaMenorForm5(
                  controller: pageController,
                ),
                UpdateSolicitudNuevaMenorForm6(
                  controller: pageController,
                ),
                UpdateSolicitudNuevaMenorForm7(
                  controller: pageController,
                ),
                UpdateSolicitudNuevaMenorForm8(
                  controller: pageController,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
