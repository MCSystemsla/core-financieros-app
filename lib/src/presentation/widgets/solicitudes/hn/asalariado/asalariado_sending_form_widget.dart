import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AsalariadoSendingFormWidget extends StatefulWidget {
  final bool isUserSelectUpdateImage;
  final bool tieneFotoCedula;
  const AsalariadoSendingFormWidget({
    super.key,
    this.isUserSelectUpdateImage = false,
    this.tieneFotoCedula = false,
  });

  @override
  State<AsalariadoSendingFormWidget> createState() =>
      _AsalariadoSendingFormWidgetState();
}

class _AsalariadoSendingFormWidgetState
    extends State<AsalariadoSendingFormWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SolicitudAslariadoHnCubit>().createSolicitudAsalariado();
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = global<SolicitudesHnBoxService>();
    final cedula = context.read<SolicitudAslariadoHnCubit>().state.cedula;
    final signatureFile = dbProvider.getSignatureByCedula(
      cedula,
      TypeForm.asalariado,
    );
    final subeCedula =
        widget.isUserSelectUpdateImage || !widget.tieneFotoCedula;

    return BlocConsumer<SolicitudAslariadoHnCubit, SolicitudAslariadoHnState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          if (widget.isUserSelectUpdateImage || !widget.tieneFotoCedula) {
            context.read<SolicitudAslariadoHnCubit>().sendCedulaImages(
                  numeroSolicitud: state.numeroSolicitud,
                );
          }
          context
              .read<SolicitudAslariadoHnCubit>()
              .sendClientSignatureWhenSolicitudCreditoCreated(
                firmaCliente: signatureFile?.imageSignature ?? 'NO PATH',
                numeroSolicitud: state.numeroSolicitud,
                tipoSolicitud: 'ASALARIADO',
                documentoCliente: cedula,
                clientSignatureStatus: state.clientSignatureStatus,
              );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: RedesignColors.background,
          appBar: AppBar(
            backgroundColor: RedesignColors.background,
            surfaceTintColor: RedesignColors.background,
            elevation: 0,
            titleSpacing: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
              child: SendingCloseButton(
                onPressed: () {
                  ExitConfirmationDialog(
                    context: context,
                    title: '¿Estás seguro de que quieres salir?',
                    onYes: () {
                      context.pushReplacement('/');
                    },
                  ).showDialog(context);
                },
              ),
            ),
            title: const Text(
              'ASALARIADO',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: RedesignColors.inkMuted,
              ),
            ),
          ),
          body: switch (state.status) {
            Status.inProgress => SendingStatusView(
                artTint: RedesignColors.tealTint,
                art: const SendingStatusLottie(
                  asset: ImageAsset.nuevaMenorUploading,
                ),
                title: 'Enviando solicitud…',
                message:
                    'No cierres la app. Esto suele tardar menos de un minuto.',
                steps: [
                  const SendingStep(
                    label: 'Creando solicitud en el servidor',
                    state: SendingStepState.active,
                  ),
                  if (subeCedula)
                    const SendingStep(
                      label: 'Subiendo imágenes del documento',
                    ),
                  const SendingStep(label: 'Registrando firma del cliente'),
                ],
                value: state.numeroSolicitud,
              ),
            Status.done => SendingStatusView(
                artTint: RedesignColors.greenTint,
                art: const SendingStatusLottie(
                  asset: ImageAsset.nuevaMenorSuccess,
                  repeat: false,
                ),
                title: 'Solicitud enviada',
                message: subeCedula
                    ? 'Cédula y firma del cliente quedaron registradas correctamente.'
                    : 'La firma del cliente quedó registrada correctamente.',
                steps: [
                  const SendingStep(
                    label: 'Solicitud creada en el servidor',
                    state: SendingStepState.done,
                  ),
                  if (subeCedula)
                    const SendingStep(
                      label: 'Imágenes de cédula subidas',
                      state: SendingStepState.done,
                    ),
                  const SendingStep(
                    label: 'Firma del cliente registrada',
                    state: SendingStepState.done,
                  ),
                ],
                value: state.numeroSolicitud,
                actions: [
                  CustomElevatedButton(
                    text: 'Volver al inicio',
                    color: RedesignColors.green,
                    onPressed: () => context.pushReplacement('/'),
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
                title: 'Solicitud no se pudo enviar',
                message:
                    'Guardamos la solicitud en el dispositivo, puedes reintentar sin perder los datos.',
                errorDetail: state.errorMsg,
                value: state.numeroSolicitud,
                actions: [
                  CustomElevatedButton(
                    text: 'Reintentar envío',
                    color: RedesignColors.green,
                    onPressed: () {
                      context
                          .read<SolicitudAslariadoHnCubit>()
                          .createSolicitudAsalariado();
                    },
                  ),
                  CustomOutLineButton(
                    text: 'Volver',
                    color: RedesignColors.border,
                    textColor: RedesignColors.ink,
                    borderRadius: 12,
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}
