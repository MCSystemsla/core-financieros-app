import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_form7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asalariado/asalariado_historial_credito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Same order as the PageView children below. The offline view
// (AsalariadoOfflineView) has the same steps.
const asalariadoNiSteps = [
  'Documento de identidad',
  'Datos generales',
  'Beneficiario y PEPS',
  'Domicilio',
  'Actividad económica',
  'Empleo e ingresos',
  'Familiar y estado civil',
  'Historial crediticio',
  'Crédito solicitado',
];

class AsalariadoForm extends StatelessWidget {
  final PageController controller;

  const AsalariadoForm({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: RedesignColors.background,
      child: SafeArea(
        child: Column(
          children: [
            FormStepHeaderWidget(
              title: 'Solicitud Asalariado',
              controller: controller,
              steps: asalariadoNiSteps,
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  AddCedulaPhotosScreen(
                    controller: controller,
                    onCedulaFrontTaken: (imagePath) {
                      context.read<SolicitudAsalariadoCubit>().saveCedula(
                            cedulaFrontPath: imagePath,
                          );
                    },
                    onCedulaBackTaken: (imagePath) {
                      context.read<SolicitudAsalariadoCubit>().saveCedula(
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
                  AsalariadoHistorialCredito(
                    controller: controller,
                  ),
                  AsalariadoForm7(
                    controller: controller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
