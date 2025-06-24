import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_actividad_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_beneficiario_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_business_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_data_client_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_espeps_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_monto_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_working_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NuevaMenorForm extends StatelessWidget {
  final String cedula;
  final Item tipoDocumento;
  final Item paisEmisor;

  const NuevaMenorForm({
    super.key,
    required this.pageController,
    required this.cedula,
    required this.tipoDocumento,
    required this.paisEmisor,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
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
                onCedulaFrontTaken: (imagePath) {
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        cedulaFrontPath: imagePath,
                      );
                },
                onCedulaBackTaken: (imagePath) {
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        cedulaBackPath: imagePath,
                      );
                },
              ),
              NuevaMenorDataClientWidget(
                cedula: cedula,
                controller: pageController,
                tipoDocumento: tipoDocumento,
                paisEmisor: paisEmisor,
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
              NuevaMenorBeneficiarioWidget(
                pageController: pageController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
