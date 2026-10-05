import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Cabecera de solo lectura con los datos del cliente de una solicitud
/// (iniciales, nombre, cédula y etiquetas de número, fecha, tipo y sucursal).
/// Se usa en el primer paso de los formularios de supervisión.
class SolicitudClienteHeader extends StatelessWidget {
  final SupervisionData data;
  const SolicitudClienteHeader({super.key, required this.data});

  String get _initials {
    final parts = data.nombreCliente
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 ? parts.last[0] : '';
    return '$first$last'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 54,
                width: 54,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: RedesignColors.greenTint,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  _initials,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.green,
                  ),
                ),
              ),
              const Gap(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.nombreCliente,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        color: RedesignColors.ink,
                      ),
                    ),
                    const Gap(3),
                    Row(
                      children: [
                        const Icon(
                          Icons.credit_card_outlined,
                          size: 14,
                          color: RedesignColors.chevron,
                        ),
                        const Gap(5),
                        Flexible(
                          child: Text(
                            data.cedulaCliente,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
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
          const Gap(14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              CardTagWidget(
                label: 'Solicitud N. ${data.numeroSolicitud}',
                color: RedesignColors.indigo,
                background: RedesignColors.indigoTint,
              ),
              CardTagWidget(
                label: data.fecha.selectorFormat(),
                color: RedesignColors.amber,
                background: RedesignColors.amberTint,
              ),
              if (data.tipoSolicitud.isNotEmpty)
                CardTagWidget(
                  label: data.tipoSolicitud,
                  color: RedesignColors.teal,
                  background: RedesignColors.tealTint,
                ),
              if (data.sucursalSiglas.isNotEmpty)
                CardTagWidget(
                  label: data.sucursalSiglas,
                  color: RedesignColors.inkMuted,
                  background: RedesignColors.tagBackground,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
