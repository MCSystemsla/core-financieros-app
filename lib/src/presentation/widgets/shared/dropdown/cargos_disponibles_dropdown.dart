import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/solicitudes/cargos_disponibles/cargos_disponibles_cubit.dart';

class CargosDisponiblesDropdown extends StatelessWidget {
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  final int? grupoCodigo;
  const CargosDisponiblesDropdown({
    super.key,
    required this.onChanged,
    this.validator,
    this.grupoCodigo,
  });

  @override
  Widget build(BuildContext context) {
    final connectionStatus =
        context.read<InternetConnectionCubit>().state.connectionStatus;
    return switch (connectionStatus) {
      ConnectionStatus.disconnected => SearchDropdownWidget(
          key: const Key('cargoGrupoDropdown'),
          isRequired: true,
          validator: validator,
          enabled: true,
          flavor: global<FlavorCubit>().state.flavor,
          codigo: CatalogoType.cargosDisponibles.codigo,
          hintText: 'Ingresa Cargo',
          title: 'Tipo de Cargo en el grupo',
          onChanged: onChanged,
        ),
      ConnectionStatus.handleOfflineActivation => SearchDropdownWidget(
          key: const Key('cargoGrupoDropdown'),
          isRequired: true,
          validator: validator,
          enabled: true,
          flavor: global<FlavorCubit>().state.flavor,
          codigo: CatalogoType.cargosDisponibles.codigo,
          hintText: 'Ingresa Cargo',
          title: 'Tipo de Cargo en el grupo',
          onChanged: onChanged,
        ),
      ConnectionStatus.connected => CargosDisponiblesDropdownWidget(
          key: ValueKey('cargo_dropdown_$grupoCodigo'),
          onChanged: onChanged,
          grupoCodigo: grupoCodigo,
          validator: validator,
        ),
      _ => SearchDropdownWidget(
          key: const Key('cargoGrupoDropdown'),
          isRequired: true,
          validator: validator,
          enabled: true,
          flavor: global<FlavorCubit>().state.flavor,
          codigo: CatalogoType.cargosDisponibles.codigo,
          hintText: 'Ingresa Cargo',
          title: 'Tipo de Cargo en el grupo',
          onChanged: onChanged,
        ),
    };
  }
}

class CargosDisponiblesDropdownWidget extends StatelessWidget {
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  final int? grupoCodigo;

  const CargosDisponiblesDropdownWidget({
    super.key,
    required this.onChanged,
    this.validator,
    required this.grupoCodigo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => CargosDisponiblesCubit(
        SolicitudesCreditoHnRepositoryImpl(),
      )..getCargosDisponibles(grupoCodigo: grupoCodigo),
      child: BlocBuilder<CargosDisponiblesCubit, CargosDisponiblesState>(
        builder: (context, state) {
          return switch (state.status) {
            Status.inProgress => const LoadingWidget(),
            Status.done => SheetSearchDropdown(
                items: state.data
                    .map((e) => Item(
                          value: e.valor,
                          name: e.nombre,
                        ))
                    .toList(),
                key: const Key('cargoGrupoDropdown'),
                isRequired: true,
                validator: validator,
                enabled: true,
                hintText: 'Ingresa Cargo',
                title: 'Tipo de Cargo en el grupo',
                onChanged: onChanged,
              ),
            Status.error => SearchDropdownWidget(
                key: const Key('cargoGrupoDropdown'),
                isRequired: true,
                validator: validator,
                enabled: true,
                flavor: global<FlavorCubit>().state.flavor,
                codigo: CatalogoType.cargosDisponibles.codigo,
                hintText: 'Ingresa Cargo',
                title: 'Tipo de Cargo en el grupo',
                onChanged: onChanged,
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
