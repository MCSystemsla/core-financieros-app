import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatesWidget extends StatefulWidget {
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
  State<DatesWidget> createState() => _DatesWidgetState();
}

class _DatesWidgetState extends State<DatesWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WhiteCard(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: size.width * .4,
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => widget.onSelectedDate(),
              child: Container(
                width: 130,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.greyWithOpacityV4,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.selectedDate),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey,
                          ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.getPrimaryColor(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
