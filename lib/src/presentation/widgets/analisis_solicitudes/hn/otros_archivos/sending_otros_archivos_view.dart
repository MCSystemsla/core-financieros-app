import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/subir_otros_archivos/subir_otros_archivos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendingOtrosArchivosView extends StatelessWidget {
  final String numeroSolicitud;

  final String documentName;
  const SendingOtrosArchivosView({
    super.key,
    required this.numeroSolicitud,
    required this.documentName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubirOtrosArchivosCubit, SubirOtrosArchivosState>(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          documentName.toUpperCase(),
                          style: const TextStyle(
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
                              title: 'Enviando $documentName…',
                              message:
                                  'No cierres la app. Esto puede tardar unos segundos según tu conexión.',
                              steps: [
                                const SendingStep(
                                  label:
                                      'Generando el PDF y subiéndolo al expediente',
                                  state: SendingStepState.active,
                                ),
                                SendingStep(label: '$documentName registrado'),
                              ],
                              value: numeroSolicitud,
                            ),
                          Status.done => SendingStatusView(
                              artTint: RedesignColors.greenTint,
                              art: const SendingStatusLottie(
                                asset: ImageAsset.nuevaMenorSuccess,
                                repeat: false,
                              ),
                              title: '$documentName enviado',
                              message:
                                  'El $documentName se agregó al expediente digital.',
                              steps: [
                                const SendingStep(
                                  label: 'PDF subido al expediente',
                                  state: SendingStepState.done,
                                ),
                                SendingStep(
                                  label: '$documentName registrado',
                                  state: SendingStepState.done,
                                ),
                              ],
                              value: numeroSolicitud,
                              actions: [
                                CustomElevatedButton(
                                  text: 'Volver a otros archivos',
                                  color: RedesignColors.green,
                                  onPressed: () => Navigator.pop(context),
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
                              title: 'El $documentName no se pudo enviar',
                              message:
                                  'Tus fotos siguen seleccionadas, puedes revisarlas y reintentar.',
                              errorDetail: state.errorMsg,
                              value: numeroSolicitud,
                              actions: [
                                CustomElevatedButton(
                                  text: 'Revisar y reintentar',
                                  color: RedesignColors.green,
                                  onPressed: () => context
                                      .read<SubirOtrosArchivosCubit>()
                                      .resetStatus(),
                                ),
                                CustomOutLineButton(
                                  text: 'Volver a otros archivos',
                                  color: RedesignColors.border,
                                  textColor: RedesignColors.ink,
                                  borderRadius: 12,
                                  onPressed: () => Navigator.pop(context),
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
