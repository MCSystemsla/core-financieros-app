import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NivelProduccionArticuloCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final int precioVentaUnidad;
  final VoidCallback onTap;

  const NivelProduccionArticuloCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.onTap,
    required this.precioVentaUnidad,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {},
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
                  Icons.edit_calendar_rounded,
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                    ),
                    Text(
                      'Precio Venta Unidad: ${precioVentaUnidad.toCurrencyFormat}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                    ),
                    const Gap(4),
                    Text(
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
    );
  }
}
