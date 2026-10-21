import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FiadoresNiScreen extends StatelessWidget {
  final int numeroSolicitud;
  const FiadoresNiScreen({
    super.key,
    required this.numeroSolicitud,
  });

  void _goToForm(BuildContext context, FiadoresNiFormType typeForm) {
    if (!context.read<InternetConnectionCubit>().state.isConnected) {
      showV2CustomSnackbar(
        context,
        title: 'Necesitas conexión a internet para crear fiadores',
        type: SnackbarType.warning,
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FiadoresNiFormScreen(
          typeForm: typeForm,
          numeroSolicitud: numeroSolicitud,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            ScreenHeaderWidget(
              title: 'Fiadores',
              subtitle:
                  'Elige el tipo de fiador para la solicitud #$numeroSolicitud.',
              onBack: () => Navigator.pop(context),
            ),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ModuleTileWidget(
                    icon: Icons.verified_user_outlined,
                    iconColor: RedesignColors.indigo,
                    iconBackground: RedesignColors.indigoTint,
                    title: 'Fiador',
                    subtitle: 'Crear fiador',
                    onPressed: () =>
                        _goToForm(context, FiadoresNiFormType.fiador),
                  ),
                  const Gap(10),
                  ModuleTileWidget(
                    icon: Icons.favorite_border_rounded,
                    iconColor: RedesignColors.purple,
                    iconBackground: RedesignColors.purpleTint,
                    title: 'Cónyuge',
                    subtitle: 'Crear fiador cónyuge',
                    onPressed: () =>
                        _goToForm(context, FiadoresNiFormType.conyuge),
                  ),
                  const Gap(10),
                  ModuleTileWidget(
                    icon: Icons.group_add_outlined,
                    iconColor: RedesignColors.teal,
                    iconBackground: RedesignColors.tealTint,
                    title: 'Codeudor',
                    subtitle: 'Crear fiador codeudor',
                    onPressed: () =>
                        _goToForm(context, FiadoresNiFormType.codeudor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
