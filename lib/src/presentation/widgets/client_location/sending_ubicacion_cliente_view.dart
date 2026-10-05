import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_user_location/analisis_user_location_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Vista de envío de la ubicación del cliente. Se monta sobre el mapa (no en
/// otra ruta) para que el `GoogleMap` siga vivo mientras se toma el snapshot.
class SendingUbicacionClienteView extends StatelessWidget {
  final int numeroSolicitud;
  const SendingUbicacionClienteView({
    super.key,
    required this.numeroSolicitud,
  });

  void _goToAnalisis(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AnalisisInterceptorByFlavor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisUserLocationCubit, AnalisisUserLocationState>(
      buildWhen: (previous, current) =>
          previous.statusCreation != current.statusCreation,
      builder: (context, state) {
        if (state.statusCreation == Status.notStarted) {
          return const SizedBox.shrink();
        }

        final numero = numeroSolicitud.toString();

        return Positioned.fill(
          child: PopScope(
            canPop: state.statusCreation != Status.inProgress,
            child: FadeIn(
              duration: const Duration(milliseconds: 200),
              child: ColoredBox(
                color: RedesignColors.background,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'UBICACIÓN DEL CLIENTE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: RedesignColors.inkMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: switch (state.statusCreation) {
                          Status.inProgress => SendingStatusView(
                              artTint: RedesignColors.tealTint,
                              art: const SendingStatusLottie(
                                asset: ImageAsset.nuevaMenorUploading,
                              ),
                              title: 'Enviando ubicación…',
                              message:
                                  'No cierres la app. Esto suele tardar unos segundos.',
                              steps: const [
                                SendingStep(
                                  label:
                                      'Capturando mapa y enviando ubicación al servidor',
                                  state: SendingStepState.active,
                                ),
                                SendingStep(label: 'Ubicación registrada'),
                              ],
                              value: numero,
                            ),
                          Status.done => SendingStatusView(
                              artTint: RedesignColors.greenTint,
                              art: const SendingStatusLottie(
                                asset: ImageAsset.nuevaMenorSuccess,
                                repeat: false,
                              ),
                              title: 'Ubicación enviada',
                              message:
                                  'La ubicación del cliente fue registrada exitosamente.',
                              steps: const [
                                SendingStep(
                                  label: 'Ubicación enviada al servidor',
                                  state: SendingStepState.done,
                                ),
                                SendingStep(
                                  label: 'Ubicación registrada',
                                  state: SendingStepState.done,
                                ),
                              ],
                              value: numero,
                              actions: [
                                CustomElevatedButton(
                                  text: 'Volver a análisis',
                                  color: RedesignColors.green,
                                  onPressed: () => _goToAnalisis(context),
                                ),
                              ],
                            ),
                          Status.error => SendingStatusView(
                              artTint: RedesignColors.indigoTint,
                              art: const Icon(
                                Icons.warning_amber_rounded,
                                size: 58,
                                color: RedesignColors.indigo,
                              ),
                              title: 'La ubicación no se pudo enviar',
                              message:
                                  'Tus datos siguen en el formulario, puedes revisarlos y reintentar.',
                              errorDetail: state.errorMsg,
                              value: numero,
                              actions: [
                                CustomElevatedButton(
                                  text: 'Revisar y reintentar',
                                  color: RedesignColors.green,
                                  onPressed: () => context
                                      .read<AnalisisUserLocationCubit>()
                                      .resetCreationStatus(),
                                ),
                                CustomOutLineButton(
                                  text: 'Volver a análisis',
                                  color: RedesignColors.border,
                                  textColor: RedesignColors.ink,
                                  borderRadius: 12,
                                  onPressed: () => _goToAnalisis(context),
                                ),
                              ],
                            ),
                          _ => const SizedBox.shrink(),
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
