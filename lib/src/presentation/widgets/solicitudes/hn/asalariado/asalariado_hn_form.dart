import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form8.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsalariadoHnForm extends StatelessWidget {
  const AsalariadoHnForm({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Asalariado',
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddCedulaPhotosScreen(
                controller: pageController,
                onCedulaFrontTaken: (imagePath) {
                  context.read<SolicitudAslariadoHnCubit>().saveCedula(
                        imagenFrontal: imagePath,
                      );
                },
                onCedulaBackTaken: (imagePath) {
                  context.read<SolicitudAslariadoHnCubit>().saveCedula(
                        imagenTrasera: imagePath,
                      );
                },
              ),
              AsalariadoHnForm1(
                controller: pageController,
              ),
              AsalariadoHnForm2(
                controller: pageController,
              ),
              AsalariadoHnForm3(
                controller: pageController,
              ),
              AsalariadoHnForm4(
                controller: pageController,
              ),
              AsalariadoHnForm5(
                controller: pageController,
              ),
              AsalariadoHnForm6(
                controller: pageController,
              ),
              AsalariadoHnForm7(
                controller: pageController,
              ),
              AsalariadoHnForm8(
                controller: pageController,
              ),
              AsalariadoHnForm9(
                controller: pageController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
