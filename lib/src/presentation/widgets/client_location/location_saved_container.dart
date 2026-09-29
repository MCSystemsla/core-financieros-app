import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/ubicacion_cliente/ubicacion_cliente_hn_local_db.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UbicacionGuardadaCard extends StatelessWidget {
  final UbicacionClienteHnLocalDb ubicacion;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onUnpin;

  const UbicacionGuardadaCard({
    super.key,
    required this.ubicacion,
    this.isSelected = false,
    this.onTap,
    this.onDelete,
    this.onUnpin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 10),
      child: Material(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? RedesignColors.teal : RedesignColors.border,
                width: isSelected ? 1.6 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? RedesignColors.teal
                            : RedesignColors.tealTint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        size: 20,
                        color: isSelected
                            ? RedesignColors.surface
                            : RedesignColors.teal,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ubicacion.tipoUbicacionNombre ?? '-',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: RedesignColors.ink,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            ubicacion.referenciaAdicional ??
                                'Sin referencia adicional',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: RedesignColors.inkMuted,
                            ),
                          ),
                          const Gap(4),
                          Row(
                            children: [
                              const Icon(
                                Icons.gps_fixed,
                                size: 12,
                                color: RedesignColors.chevron,
                              ),
                              const Gap(4),
                              Expanded(
                                child: Text(
                                  '${ubicacion.latitude?.toStringAsFixed(5)}, '
                                  '${ubicacion.longitude?.toStringAsFixed(5)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: RedesignColors.inkMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: isSelected
                            ? ElevatedButton.icon(
                                onPressed: onUnpin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: RedesignColors.teal,
                                  foregroundColor: RedesignColors.surface,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.push_pin_rounded,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Desfijar',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : OutlinedButton.icon(
                                onPressed: onTap,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: RedesignColors.ink,
                                  side: const BorderSide(
                                    color: RedesignColors.border,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.push_pin_outlined,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Fijar ubicación',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const Gap(8),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: IconButton(
                        onPressed: onDelete,
                        tooltip: 'Eliminar',
                        style: IconButton.styleFrom(
                          backgroundColor: RedesignColors.redTint,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                          color: RedesignColors.red,
                        ),
                      ),
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
