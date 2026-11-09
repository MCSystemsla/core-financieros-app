import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/// Pregunta de fecha de los formularios Kiva: la pregunta arriba y un campo
/// que abre el selector al tocarlo ([onSelectedDate]).
class DatesWidget extends StatelessWidget {
  final DateTime? initialDate;
  final String title;
  final VoidCallback onSelectedDate;
  final DateTime selectedDate;
  const DatesWidget({
    super.key,
    this.initialDate,
    required this.title,
    required this.onSelectedDate,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return KivaPreguntaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KivaPreguntaTitulo(title),
          const Gap(10),
          Material(
            color: RedesignColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: RedesignColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onSelectedDate,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(selectedDate),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: RedesignColors.ink,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: RedesignColors.teal,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
