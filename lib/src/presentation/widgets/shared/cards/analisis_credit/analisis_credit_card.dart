import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solicitudes_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisCreditCard extends StatelessWidget {
  final int index;
  final bool animate;
  final bool enabled;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  final AnalisisSolicitudesInterceptorType? tipoSolicitud;
  const AnalisisCreditCard({
    super.key,
    required this.index,
    this.animate = true,
    this.enabled = true,
    required this.title,
    required this.subtitle,
    required this.description,
    this.tipoSolicitud,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      duration: animate ? const Duration(milliseconds: 500) : Duration.zero,
      delay: animate ? Duration(milliseconds: 100 * index) : Duration.zero,
      child: Hero(
        tag: 'analisis-credito-$index',
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: InkWell(
            onTap: enabled
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnalisisSolicitudesInterceptor(
                          index: index,
                          type: tipoSolicitud!,
                          title: title,
                          subtitle: subtitle,
                          description: description,
                          numeroSolicitud: numeroSolicitud,
                        ),
                      ),
                    );
                  }
                : null,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icono leading
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.indigo.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_outlined,
                      size: 24,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Info principal
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Numero Solicitud #12345',
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          subtitle,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                        ),
                        const Gap(4),
                        Text(
                          // 'C\$. 50,000',
                          description,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 28,
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
