import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_screen.dart';
import 'package:flutter/material.dart';

class AnalisisInterceptorByFlavor extends StatelessWidget {
  const AnalisisInterceptorByFlavor({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = global<FlavorCubit>().state.flavor;
    return switch (flavor) {
      Flavor.nicaragua => const AnalisisSolicitudesScreen(),
      Flavor.honduras => const AnalisisSolicitudesHnScreen(),
      Flavor.costaRica => const Text('This is costa rica'),
      _ => const SizedBox(),
    };
  }
}
