import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form8.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form1.dart';

class NuevaMenorHnForm extends StatelessWidget {
  const NuevaMenorHnForm({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Nueva Menor',
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddCedulaPhotosScreen(
                controller: pageController,
                onCedulaFrontTaken: (imagePath) {},
                onCedulaBackTaken: (imagePath) {},
              ),
              NuevaMenorForm1(
                controller: pageController,
              ),
              NuevaMenorForm2(
                controller: pageController,
              ),
              NuevaMenorForm3(
                controller: pageController,
              ),
              NuevaMenorForm4(
                controller: pageController,
              ),
              NuevaMenorForm5(
                controller: pageController,
              ),
              NuevaMenorForm6(
                controller: pageController,
              ),
              NuevaMenorForm7(
                controller: pageController,
              ),
              NuevaMenorForm8(
                controller: pageController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
