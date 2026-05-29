import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/espeps_autorizacion_form/espeps_autorizacion_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/espeps_autorizacion_form/peps_forma_de_pago_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/espeps_autorizacion_form/peps_informacion_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/peps_productos_y_servicios_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EspepsAuthorizationPage1 extends StatelessWidget {
  final PageController pageController;

  const EspepsAuthorizationPage1({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _AnalisisSolicitudesTitle(),
          const Gap(10),
          const PepsProductosYServiciosUtilizaWidget(),
          const Divider(),
          const Gap(20),
          const PepsInformacionNegocioWidget(),
          const Divider(),
          const Gap(20),
          const PepsFormaDePagoNegocioWidget(),
          const Divider(),
          const Gap(20),
          esPepsSiguienteButton(context, pageController),
          esPepsAtrasButton(context, pageController),
        ],
      ),
    );
  }
}

class _AnalisisSolicitudesTitle extends StatelessWidget {
  const _AnalisisSolicitudesTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Formulario de autorización de cliente PEPS',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Gap(10),
          Text(
            'Formulario obligatorio para la declaración, identificación y debida diligencia de Personas Expuestas Políticamente (PEPS),',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}
