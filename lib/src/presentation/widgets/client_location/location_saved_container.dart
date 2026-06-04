import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/ubicacion_cliente/ubicacion_cliente_hn_local_db.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UbicacionGuardadaCard extends StatelessWidget {
  final UbicacionClienteHnLocalDb ubicacion;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const UbicacionGuardadaCard({
    super.key,
    required this.ubicacion,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.getPrimaryColor();

    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: primaryColor,
                      ),
                    ),
                    const Spacer(),

                    /// STATUS
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 14,
                            color: Colors.green,
                          ),
                          Gap(6),
                          Text(
                            'Guardada',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Gap(18),

                /// TIPO UBICACION
                Text(
                  ubicacion.tipoUbicacionNombre ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),

                const Gap(12),

                /// REFERENCIA
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        ubicacion.referenciaAdicional ??
                            'Sin referencia adicional',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                /// COORDENADAS
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.gps_fixed,
                        size: 18,
                        color: primaryColor,
                      ),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          '${ubicacion.latitude}, ${ubicacion.longitude}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(12),

                /// ACTIONS
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.map_outlined),
                        label: const Text('Ver'),
                      ),
                    ),
                    const Gap(10),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
