import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/reportes/hn/reports/reporte_mora_screen_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReportesScreenHn extends StatelessWidget {
  const ReportesScreenHn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        bottom: false,
        child: _Reportes(),
      ),
    );
  }
}

class _Reportes extends StatelessWidget {
  const _Reportes();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeaderWidget(
            title: 'Reportes',
            subtitle:
                'Consulta y descarga los reportes de tu cartera en formato PDF.',
            onBack: () => Navigator.pop(context),
          ),
          const Gap(24),
          const _CarteraSection(),
          const Gap(28),
        ],
      ).fadeIn(),
    );
  }
}

class _CarteraSection extends StatelessWidget {
  const _CarteraSection();

  @override
  Widget build(BuildContext context) {
    return SectionBlockWidget(
      label: 'CARTERA',
      children: [
        ModuleTileWidget(
          icon: Icons.warning_amber_rounded,
          iconColor: RedesignColors.red,
          iconBackground: RedesignColors.redTint,
          title: 'Reporte de Mora',
          subtitle: 'Clientes con pagos atrasados',
          tag: 'Solo en línea',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const ReporteMoraScreenHn(),
              ),
            );
          },
        ),
      ],
    );
  }
}
