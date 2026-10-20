import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_actividad_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_beneficiario_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_business_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_data_client_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_espeps_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_historial_crediticio.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_monto_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/nueva_menor/nueva_menor_working_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Same order as the PageView children below. The offline screen
// (CrearSolicitudOfflineScreen) has the same steps.
const nuevaMenorNiSteps = [
  'Documento de identidad',
  'Datos generales',
  'Domicilio',
  'Estado civil y familia',
  'Negocio',
  'Persona expuesta (PEPS)',
  'Crédito solicitado',
  'Historial crediticio',
  'Beneficiarios del seguro',
];

class NuevaMenorForm extends StatelessWidget {
  const NuevaMenorForm({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: RedesignColors.background,
      child: SafeArea(
        child: Column(
          children: [
            FormStepHeaderWidget(
              title: 'Solicitud Nueva Menor',
              controller: pageController,
              steps: nuevaMenorNiSteps,
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  AddCedulaPhotosScreen(
                    controller: pageController,
                    onCedulaFrontTaken: (imagePath) {
                      context.read<SolicitudNuevaMenorCubit>().saveCedula(
                            cedulaFrontPath: imagePath,
                          );
                    },
                    onCedulaBackTaken: (imagePath) {
                      context.read<SolicitudNuevaMenorCubit>().saveCedula(
                            cedulaBackPath: imagePath,
                          );
                    },
                  ),
                  NuevaMenorDataClientWidget(
                    controller: pageController,
                  ),
                  NuevaMenorWorkingDataWidget(
                    controller: pageController,
                  ),
                  NuevaMenorMontoWidget(
                    pageController: pageController,
                  ),
                  NuevaMenorBusinessDataWidget(
                    pageController: pageController,
                  ),
                  NuevaMenorEsPepsWidget(
                    pageController: pageController,
                  ),
                  NuevaMenorCreditoWidget(
                    pageController: pageController,
                  ),
                  NuevaMenorHistorialCrediticio(
                    controller: pageController,
                  ),
                  NuevaMenorBeneficiarioWidget(
                    pageController: pageController,
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
