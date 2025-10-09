// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:flutter/material.dart';

class ReprestamoHnForm extends StatelessWidget {
  const ReprestamoHnForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final pageController = PageController();
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Represtamo',
        ),
        Expanded(
          child: PageView(
            // physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddCedulaPhotosScreen(
                controller: pageController,
                onCedulaFrontTaken: (imagePath) {},
                onCedulaBackTaken: (imagePath) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
