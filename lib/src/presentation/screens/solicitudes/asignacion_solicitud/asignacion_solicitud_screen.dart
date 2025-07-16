import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/asignacion_solicitud/nueva/asignacion_nueva_list_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AsignacionSolicitudScreen extends StatelessWidget {
  const AsignacionSolicitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Asignacion de Solicitud Credito'),
      ),
      body: const _AsignacionSolicitudView(),
    );
  }
}

class _AsignacionSolicitudView extends StatelessWidget {
  const _AsignacionSolicitudView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          const _Header(),
          const Gap(20),
          AsigancionCreditoCard(
            delayEffect: const Duration(milliseconds: 300),
            icon: Icon(
              Icons.wallet_outlined,
              size: 34,
              color: AppColors.getSecondaryColor(),
            ),
            title: 'Solicitudes Pendientes Nueva',
            solicitudesPendingTotal: '22',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const AsignacionListScreen(
                    typeForm: TypeForm.nueva,
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          AsigancionCreditoCard(
            delayEffect: const Duration(milliseconds: 600),
            icon: Icon(
              Icons.work_history_outlined,
              size: 34,
              color: AppColors.getSecondaryColor(),
            ),
            title: 'Solicitudes Pendientes Asalariado',
            solicitudesPendingTotal: '10',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const AsignacionListScreen(
                    typeForm: TypeForm.asalariado,
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          AsigancionCreditoCard(
            delayEffect: const Duration(milliseconds: 900),
            icon: Icon(
              Icons.collections_bookmark_outlined,
              size: 34,
              color: AppColors.getSecondaryColor(),
            ),
            title: 'Solicitudes Pendientes Represtamo',
            solicitudesPendingTotal: '15',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const AsignacionListScreen(
                    typeForm: TypeForm.represtamo,
                  ),
                ),
              );
            },
          ),
          const Gap(5),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          child: const Text(
            'Seleccionar un tipo de Credito',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          child: const Text(
            'Elige el tipo de crédito que este asesor gestionará. Esta asignación te ayudará a mantener un mejor control del equipo y las solicitudes activas.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class AsigancionCreditoCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Icon icon;
  final String solicitudesPendingTotal;
  final Duration delayEffect;
  const AsigancionCreditoCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.solicitudesPendingTotal,
    required this.delayEffect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: FadeIn(
        duration: const Duration(milliseconds: 300),
        delay: delayEffect,
        curve: Curves.easeIn,
        child: Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      icon,
                      const Gap(15),
                      SizedBox(
                        width: 220,
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  const Gap(12),
                  Text(
                    'Solicitudes pendientes por asignar',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const Gap(8),
                  Text(
                    solicitudesPendingTotal,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
