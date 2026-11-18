import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/presentation/bloc/autoupdate/autoupdate_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionControlWidget extends StatelessWidget {
  const VersionControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentFlavor = global<FlavorCubit>().state;
    return BlocSelector<AutoupdateCubit, AutoupdateState, String>(
      selector: (state) {
        return switch (state) {
          AutoupdateFoundVersion() => state.versionName,
          AutoupdateLoading() => 'Cargando...',
          _ => '-.-.-',
        };
      },
      builder: (context, state) {
        const isProdMode = bool.fromEnvironment('isProdMode');
        final version =
            !isProdMode ? 'dev${currentFlavor.flavor.name}.$state' : state;
        return Text(
          'auth.version'.tr(args: {'version': version}),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xff0F2724),
          ),
        );
      },
    );
  }
}
