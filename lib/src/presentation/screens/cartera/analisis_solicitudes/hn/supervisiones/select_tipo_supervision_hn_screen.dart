import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/supervisiones_search_solicitudes_by_numero_or_cedula_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectTipoSupervisionHnScreen extends StatelessWidget {
  const SelectTipoSupervisionHnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Tipo Supervisor'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Gap(20),
            SelectableCardItem(
              color: const Color(0xFF1565C0),
              icon: Icons.manage_accounts,
              title: 'Coordinador',
              subtitle: 'Crear Supervisión de Coordinador',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SupervisionesSearchSolicitudesByNumeroOrCedulaScreen(
                      tipoSupervisor: TipoSupervisorEnum.coordinador,
                    ),
                  ),
                );
              },
            ),
            const Gap(10),
            SelectableCardItem(
              color: const Color(0xFF2E7D32),
              icon: Icons.public,
              title: 'Regional',
              subtitle: 'Crear Supervisión de Regional',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) =>
                //         const SupervisionesSearchSolicitudesByNumeroOrCedulaScreen(
                //       tipoSupervisor: TipoSupervisorEnum.regional,
                //     ),
                //   ),
                // );
              },
            ),
            const Gap(10),
            SelectableCardItem(
              color: const Color(0xFFFFA000),
              icon: Icons.request_quote,
              title: 'Credito',
              subtitle: 'Crear Supervisión de Credito',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) =>
                //         const SupervisionesSearchSolicitudesByNumeroOrCedulaScreen(
                //       tipoSupervisor: TipoSupervisorEnum.credito,
                //     ),
                //   ),
                // );
              },
            ),
            const Gap(10),
            SelectableCardItem(
              color: const Color(0xFFD32F2F),
              icon: Icons.shield,
              title: 'Riesgo',
              subtitle: 'Crear Supervisión de Riesgo',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) =>
                //         const SupervisionesSearchSolicitudesByNumeroOrCedulaScreen(
                //       tipoSupervisor: TipoSupervisorEnum.riesgo,
                //     ),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
