import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form7.dart';
import 'package:flutter/material.dart';

class UserByCedulaSolicitud {
  final String primerNombre;
  final String segundoNombre;
  final String primerApellido;
  final String segundoApellido;
  final String cedula;
  final DateTime fechaEmision;
  final DateTime fechaVencimiento;
  final DateTime fechaNacimiento;
  final String tipoDocumento;

  UserByCedulaSolicitud({
    required this.primerNombre,
    required this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.cedula,
    required this.fechaEmision,
    required this.fechaVencimiento,
    required this.fechaNacimiento,
    required this.tipoDocumento,
  });
}

class AsalariadoForm extends StatelessWidget {
  final PageController controller;
  final UserByCedulaSolicitud? userByCedulaSolicitud;

  const AsalariadoForm({
    super.key,
    required this.controller,
    this.userByCedulaSolicitud,
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
              AsalariadoForm1(
                userByCedulaSolicitud: userByCedulaSolicitud,
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
