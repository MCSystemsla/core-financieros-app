import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_actividad_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_beneficiario_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_business_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_data_client_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_espeps_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_monto_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_working_data_widget.dart';
import 'package:flutter/material.dart';

class NuevaMenorForm extends StatelessWidget {
  const NuevaMenorForm({
    super.key,
    required this.pageController,
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
              // NuevaMenorCreditoWidget(
              //   pageController: pageController,
              // ),
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
