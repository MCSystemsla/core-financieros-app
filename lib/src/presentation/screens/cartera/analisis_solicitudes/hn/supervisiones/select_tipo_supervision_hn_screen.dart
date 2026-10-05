import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/supervisiones_search_solicitudes_by_numero_or_cedula_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectTipoSupervisionHnScreen extends StatelessWidget {
  const SelectTipoSupervisionHnScreen({super.key});

  void _goToSearch(BuildContext context, TipoSupervisorEnum tipoSupervisor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SupervisionesSearchSolicitudesByNumeroOrCedulaScreen(
          tipoSupervisor: tipoSupervisor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            ScreenHeaderWidget(
              title: 'Tipo de supervisión',
              subtitle:
                  'Elige el tipo de supervisión que vas a realizar. Luego buscarás la solicitud por número o cédula.',
              onBack: () => Navigator.pop(context),
            ),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ModuleTileWidget(
                    icon: Icons.manage_accounts_outlined,
                    iconColor: RedesignColors.indigo,
                    iconBackground: RedesignColors.indigoTint,
                    title: 'Coordinador',
                    subtitle: 'Crear supervisión de coordinador',
                    onPressed: () =>
                        _goToSearch(context, TipoSupervisorEnum.coordinador),
                  ),
                  const Gap(10),
                  ModuleTileWidget(
                    icon: Icons.public,
                    iconColor: RedesignColors.green,
                    iconBackground: RedesignColors.greenTint,
                    title: 'Regional',
                    subtitle: 'Crear supervisión regional',
                    onPressed: () =>
                        _goToSearch(context, TipoSupervisorEnum.regional),
                  ),
                  const Gap(10),
                  ModuleTileWidget(
                    icon: Icons.request_quote_outlined,
                    iconColor: RedesignColors.amber,
                    iconBackground: RedesignColors.amberTint,
                    title: 'Crédito',
                    subtitle: 'Crear supervisión de crédito',
                    onPressed: () =>
                        _goToSearch(context, TipoSupervisorEnum.credito),
                  ),
                  const Gap(10),
                  ModuleTileWidget(
                    icon: Icons.shield_outlined,
                    iconColor: RedesignColors.red,
                    iconBackground: RedesignColors.redTint,
                    title: 'Riesgo',
                    subtitle: 'Crear supervisión de riesgo',
                    onPressed: () =>
                        _goToSearch(context, TipoSupervisorEnum.riesgo),
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
