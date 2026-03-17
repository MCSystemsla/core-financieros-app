import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/comite/fuentes_financiamientos/fuentes_financiamientos_cubit.dart';

class FuentesFinanciamientosDropdown extends StatelessWidget {
  final Item? selectedItem;
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  const FuentesFinanciamientosDropdown({
    super.key,
    required this.onChanged,
    this.validator,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FuentesFinanciamientosCubit,
        FuentesFinanciamientosState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const LoadingWidget(),
          Status.error => Text(state.errorMsg),
          Status.done => SheetSearchDropdown(
              selectedItem: selectedItem,
              title: 'Fuentes de Financiamiento',
              isRequired: true,
              onChanged: onChanged,
              validator: validator,
              hintText: 'Selecciona una Fuente de Financiamiento',
              enabled: true,
              items: state.data
                  .map((e) => Item(
                        value: e.valor,
                        name: e.nombre,
                        anotherValue: e.disponibleUsd,
                      ))
                  .toList(),
            ),
          _ => const SizedBox.shrink()
        };
      },
    );
  }
}
