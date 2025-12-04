import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<DateTime?> pickDate(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Locale? locale,
}) {
  final now = DateTime.now();

  return showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: firstDate ?? DateTime(2000),
    lastDate: lastDate ?? DateTime(2101),
    locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
  );
}
