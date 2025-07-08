import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_by_cedula_solicitud.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form5.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReprestamoForm extends StatelessWidget {
  final PageController controller;
  final UserByCedulaSolicitud userByCedulaSolicitud;

  const ReprestamoForm({
    super.key,
    required this.controller,
    required this.userByCedulaSolicitud,
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
              AddCedulaPhotosScreen(
                controller: controller,
                onCedulaFrontTaken: (imagePath) {
                  context.read<SolicitudReprestamoCubit>().saveCedula(
                        cedulaFrontPath: imagePath,
                      );
                },
                onCedulaBackTaken: (imagePath) {
                  context.read<SolicitudReprestamoCubit>().saveCedula(
                        cedulaBackPath: imagePath,
                      );
                },
              ),
              ReprestamoForm1(
                controller: controller,
                userByCedulaSolicitud: userByCedulaSolicitud,
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
