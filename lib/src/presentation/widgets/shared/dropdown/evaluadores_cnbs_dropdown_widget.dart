import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/evaluadores_cnbs/evaluadores_cnbs_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnEvaluadorChanged = void Function(Item? value);
typedef EvaluadorValidator = String? Function(Item? value);

class EvaluadoresCnbsDropdownWidget extends StatelessWidget {
  final OnEvaluadorChanged? onChanged;
  final EvaluadorValidator? validator;
  final String? initialValue;
  final bool enabled;
  const EvaluadoresCnbsDropdownWidget({
    super.key,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvaluadoresCnbsCubit, EvaluadoresCnbsState>(
      buildWhen: (prev, curr) => prev.evaluadoresCnbs != curr.evaluadoresCnbs,
      builder: (context, state) {
        final dropdownItems = state.evaluadoresCnbs
            .map((e) => Item(
                  name: e.nombreValuador,
                  value: e.codigoCnbs,
                ))
            .toList();

        return SheetSearchDropdown(
          title: 'Evaluador',
          hintText: 'Selecciona un evaluador',
          isRequired: true,
          enabled: enabled,
          items: dropdownItems,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          validator: validator,
        );
      },
    );
  }
}
