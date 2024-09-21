import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_de_conyuge_y_seguro_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_de_credito_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_de_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_personales_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_general_widget.dart';
import 'package:flutter/material.dart';

class CreditoScreen extends StatelessWidget {
  const CreditoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de Credito'),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CreditoGeneralesWidget(
            pageController: pageController,
          ),
          CreditoDatosPersonalesWidget(
            controller: pageController,
          ),
          CreditoDatosDeConyugeYSeguroWidget(
            pageController: pageController,
          ),
          CreditoDatosDeNegocioWidget(
            pageController: pageController,
          ),
          CreditoDatosDeCreditoWidget(
            pageController: pageController,
          )
        ],
      ),
    );
  }
}
