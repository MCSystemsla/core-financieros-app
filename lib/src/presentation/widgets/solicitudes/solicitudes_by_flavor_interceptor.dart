import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/select_solicitud/hn/select_solicitud_hn_screen.dart';
import 'package:flutter/material.dart';

class SolicitudesByFlavorInterceptor extends StatelessWidget {
  const SolicitudesByFlavorInterceptor({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = global<FlavorCubit>().state.flavor;
    return switch (flavor) {
      Flavor.nicaragua => const SelectSolicitudScreenNi(),
      Flavor.honduras => const SelectSolicitudScreenHN(),
      Flavor.costaRica => const Text('This is costa rica'),
      _ => const SizedBox(),
    };
  }
}
