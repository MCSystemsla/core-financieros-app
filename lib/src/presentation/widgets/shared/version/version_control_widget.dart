import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/autoupdate/autoupdate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionControlWidget extends StatelessWidget {
  const VersionControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 5,
          ),
          child: Text(
            !isProdMode ? 'devNi.$state' : state,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.grey,
            ),
          ),
        );
      },
    );
  }
}
