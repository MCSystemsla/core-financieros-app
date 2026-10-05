import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_imagenes_negocio/analisis_imagenes_negocio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SendingImagenesNegocioView extends StatelessWidget {
  final String numeroSolicitud;
  final bool isOfflineMode;
  const SendingImagenesNegocioView({
    super.key,
    required this.numeroSolicitud,
    this.isOfflineMode = false,
  });

  void _goToAnalisis(BuildContext context) {
    if (isOfflineMode) {
      context.pop();
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AnalisisInterceptorByFlavor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisImagenesNegocioCubit,
        AnalisisImagenesNegocioState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == Status.notStarted) {
          return const SizedBox.shrink();
        }

        return Positioned.fill(
          child: PopScope(
            canPop: state.status != Status.inProgress,
            child: FadeIn(
              duration: const Duration(milliseconds: 200),
              child: Material(
                color: RedesignColors.background,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'IMÁGENES DEL NEGOCIO',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: RedesignColors.inkMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: switch (state.status) {
                          Status.inProgress => SendingStatusView(
                              artTint: RedesignColors.tealTint,
                              art: const SendingStatusLottie(
                                asset: ImageAsset.nuevaMenorUploading,
                              ),
                              title: 'Enviando imágenes…',
                              message:
                                  'No cierres la app. Esto puede tardar unos segundos según tu conexión.',
                              steps: const [
                                SendingStep(
                                  label:
                                      'Subiendo las 3 fotos del negocio al servidor',
                                  state: SendingStepState.active,
                                ),
                                SendingStep(label: 'Imágenes registradas'),
                              ],
                              value: numeroSolicitud,
                            ),
                          Status.done => SendingStatusView(
                              artTint: RedesignColors.greenTint,
                              art: const SendingStatusLottie(
                                asset: ImageAsset.nuevaMenorSuccess,
                                repeat: false,
                              ),
                              title: 'Imágenes enviadas',
                              message:
                                  'Las imágenes del negocio fueron registradas exitosamente.',
                              steps: const [
                                SendingStep(
                                  label: 'Fotos subidas al servidor',
                                  state: SendingStepState.done,
                                ),
                                SendingStep(
                                  label: 'Imágenes registradas',
                                  state: SendingStepState.done,
                                ),
                              ],
                              value: numeroSolicitud,
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
                              title: 'Las imágenes no se pudieron enviar',
                              message:
                                  'Tus fotos siguen seleccionadas, puedes revisarlas y reintentar.',
                              errorDetail: state.errorMsg,
                              value: numeroSolicitud,
                              actions: [
                                CustomElevatedButton(
                                  text: 'Revisar y reintentar',
                                  color: RedesignColors.green,
                                  onPressed: () => context
                                      .read<AnalisisImagenesNegocioCubit>()
                                      .resetStatus(),
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
