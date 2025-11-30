import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum _PickerStep { hourA, hourB }

class TimePickerBottomSheet extends StatefulWidget {
  final DateTime initial;
  final bool use24hFormat;
  final ValueChanged<String> onSelected;

  const TimePickerBottomSheet({
    super.key,
    required this.initial,
    required this.use24hFormat,
    required this.onSelected,
  });

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late DateTime hourA;
  late DateTime hourB;

  _PickerStep step = _PickerStep.hourA;

  @override
  void initState() {
    super.initState();
    hourA = widget.initial;
    hourB = widget.initial;
  }

  String _format(DateTime a, DateTime b) {
    final hA = a.hour.toString().padLeft(2, '0');
    final mA = a.minute.toString().padLeft(2, '0');
    final hB = b.hour.toString().padLeft(2, '0');
    final mB = b.minute.toString().padLeft(2, '0');
    return '$hA:$mA - $hB:$mB';
  }

  Widget _buildPicker() {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      use24hFormat: widget.use24hFormat,
      initialDateTime: step == _PickerStep.hourA ? hourA : hourB,
      onDateTimeChanged: (value) {
        setState(() {
          switch (step) {
            case _PickerStep.hourA:
              hourA = value;
              break;
            case _PickerStep.hourB:
              hourB = value;
              break;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Gap(12),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const Gap(12),
          FadeIn(
            key: ValueKey(step),
            duration: const Duration(milliseconds: 300),
            child: Text(
              step == _PickerStep.hourA
                  ? 'Ingrese hora inicial'
                  : 'Ingrese hora final',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
            ),
          ),
          const Gap(10),
          const Divider(height: 1),
          Expanded(
            child: FadeIn(
              key: ValueKey(step),
              duration: const Duration(milliseconds: 300),
              child: _buildPicker(),
            ),
          ),
          const Divider(height: 1),
          CupertinoButton(
            child: const Text(
              'Aceptar',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              if (step == _PickerStep.hourA) {
                setState(() {
                  step = _PickerStep.hourB;
                });
                return;
              }

              widget.onSelected(_format(hourA, hourB));

              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }
}
