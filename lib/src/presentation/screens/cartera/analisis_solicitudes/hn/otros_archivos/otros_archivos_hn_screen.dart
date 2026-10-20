import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/expediente_digital/expediente_digital_repository.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/otros_archivos/subir_otros_archivos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OtrosArchivosHnScreen extends StatelessWidget {
  final String numeroSolicitud;
  final String cedulaCliente;
  const OtrosArchivosHnScreen({
    super.key,
    required this.numeroSolicitud,
    required this.cedulaCliente,
  });

  @override
  Widget build(BuildContext context) {
    final archivos = [
      ModuleTileWidget(
        icon: Icons.badge_outlined,
        iconColor: RedesignColors.indigo,
        iconBackground: RedesignColors.indigoTint,
        title: 'Agregar RTN',
        subtitle: 'Sube el RTN del cliente al expediente',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubirOtrosArchivosScreen(
              numeroSolicitud: numeroSolicitud,
              cedulaCliente: cedulaCliente,
              filename: DigitalFilename.rucClienteNegocio,
              documentName: 'RTN',
              title: 'Agregar RTN',
              subtitle:
                  'Toma una foto clara de cada página del RTN del cliente. Se unirán en un solo PDF para el expediente.',
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeaderWidget(
              title: 'Otros archivos',
              subtitle:
                  'Elige el documento que quieres adjuntar al expediente de la solicitud.',
              onBack: () => Navigator.pop(context),
            ),
            const Gap(24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: archivos.length,
                separatorBuilder: (_, __) => const Gap(10),
                itemBuilder: (_, index) => archivos[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
