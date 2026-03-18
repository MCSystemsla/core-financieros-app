import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/comite/tipos_credito/tipos_credito_cubit.dart';

class TiposCreditoDropdown extends StatelessWidget {
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  final Item? selectedItem;
  final bool isRequired;
  const TiposCreditoDropdown({
    super.key,
    required this.onChanged,
    this.validator,
    this.selectedItem,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TiposCreditoCubit, TiposCreditoState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const LoadingWidget(),
          Status.error => Text(state.errorMsg),
          Status.done => SheetSearchDropdown(
              title: 'Tipo de crédito ${isRequired ? '*' : ''}',
              isRequired: true,
              onChanged: onChanged,
              validator: validator,
              selectedItem: selectedItem,
              hintText: 'Selecciona un tipo de crédito',
              enabled: true,
              items: state.data
                  .map((e) => Item(value: e.id, name: e.nombre))
                  .toList(),
            ),
          _ => const SizedBox.shrink()
        };
      },
    );
  }
}
