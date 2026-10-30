import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Número de la solicitud para los textos: `'sin número'` si es provisional.
String numeroSolicitudLabel(int numeroSolicitud, {String prefijo = '#'}) =>
    numeroSolicitud < 0 ? 'sin número' : '$prefijo$numeroSolicitud';

/// Aviso ámbar para los módulos abiertos con un número provisional (SPEC 06):
/// la solicitud se creó offline y todavía no tiene número, así que nada se
/// envía al backend.
class SinNumeroNoticeWidget extends StatelessWidget {
  const SinNumeroNoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RedesignColors.amberTint,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.hourglass_top_rounded,
            size: 20,
            color: RedesignColors.amber,
          ),
          Gap(10),
          Expanded(
            child: Text(
              'Esta solicitud aún no tiene número. Se envía cuando esté autorizada.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: RedesignColors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
