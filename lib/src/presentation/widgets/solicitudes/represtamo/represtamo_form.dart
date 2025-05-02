import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form5.dart';
import 'package:flutter/material.dart';

class ReprestamoForm extends StatelessWidget {
  final PageController controller;
  final String cedula;

  const ReprestamoForm({
    super.key,
    required this.controller,
    required this.cedula,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Represtamo',
          imageUrl: ImageAsset.represtamoBg,
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              ReprestamoForm1(
                controller: controller,
                cedula: cedula,
              ),
              ReprestamoForm2(controller: controller),
              ReprestamoForm3(controller: controller),
              ReprestamoForm4(controller: controller),
              ReprestamoForm5(controller: controller),
            ],
          ),
        ),
      ],
    );
  }
}
