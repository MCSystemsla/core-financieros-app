import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form7.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserByCedulaSolicitud {
  final String? primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;
  final String cedula;
  final DateTime? fechaEmision;
  final DateTime? fechaVencimiento;
  final DateTime? fechaNacimiento;
  final String tipoDocumento;
  final String? tipoPersona;
  final Item? paisEmisor;
  final String? sexo;

  UserByCedulaSolicitud({
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    required this.cedula,
    this.fechaEmision,
    this.fechaVencimiento,
    this.fechaNacimiento,
    required this.tipoDocumento,
    this.paisEmisor,
    this.tipoPersona,
    this.sexo,
  });
}

class AsalariadoForm extends StatelessWidget {
  final PageController controller;

  const AsalariadoForm({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Asalariado',
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
                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        cedulaFrontPath: imagePath,
                      );
                },
                onCedulaBackTaken: (imagePath) {
                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        cedulaBackPath: imagePath,
                      );
                },
              ),
              AsalariadoForm1(
                controller: controller,
              ),
              AsalariadoForm2(
                controller: controller,
              ),
              AsalariadoForm3(
                controller: controller,
              ),
              AsalariadoForm4(
                controller: controller,
              ),
              AsalariadoForm5(
                controller: controller,
              ),
              AsalariadoForm6(
                controller: controller,
              ),
              AsalariadoForm7(
                controller: controller,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
