import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class ComiteUserInfoWidget extends StatelessWidget {
  final ComiteSolicitudData data;
  const ComiteUserInfoWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Datos del solicitante',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Divider(height: 1),
            _InfoRow(
              icon: Icons.document_scanner,
              title: 'Acta',
              value: data.actaNumero.toString(),
            ),
            _InfoRow(
              icon: Icons.description,
              title: 'Numero de solicitud',
              value: data.numeroSolicitud ?? '',
            ),
            _InfoRow(
              icon: Icons.person,
              title: 'Solicitante',
              value: data.nombreCompletoCliente ?? '',
            ),
            _InfoRow(
              icon: Icons.person_3,
              title: 'Nombre oficial de credito',
              value: data.nombreOficialCredito ?? '',
            ),
            _InfoRow(
              icon: Icons.star,
              title: 'Estado de la solicitud',
              value: data.estadoComiteCodigo ?? '',
            ),
            _InfoRow(
              icon: Icons.money,
              title: 'Monto solicitado',
              value: data.monto?.toCurrencyString() ?? '',
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.getPrimaryColor()),
          const Gap(12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
