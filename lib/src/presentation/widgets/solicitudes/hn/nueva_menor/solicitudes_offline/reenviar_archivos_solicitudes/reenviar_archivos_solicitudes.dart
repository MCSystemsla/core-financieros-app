import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/cedula/cedula_client_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/signature_client/signature_client_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/solicitud_nueva_signature_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../bloc/solicitudes/hn/cubit/enviar_cedula_solicitud_hn/enviar_cedula_solicitud_hn_cubit.dart';
import '../../../../../../bloc/solicitudes/hn/cubit/enviar_firma_digital_hn/enviar_firma_digital_solicitud_hn_cubit.dart';
import '../../../../../../bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import '../../../../../../bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';

class SendFilesSolicitudNuevaContainers extends StatelessWidget {
  const SendFilesSolicitudNuevaContainers({
    super.key,
    required this.imagesCedula,
    required this.signatureFile,
    required this.tipoSolicitud,
    required this.numeroSolicitud,
    required this.cedulaCliente,
  });

  final CedulaClientDb? imagesCedula;
  final SignatureClientDb? signatureFile;
  final String tipoSolicitud;
  final String? numeroSolicitud;
  final String? cedulaCliente;

  @override
  Widget build(BuildContext context) {
    final hasSolicitudSended =
        numeroSolicitud != null && numeroSolicitud!.isNotEmpty;

    if (!hasSolicitudSended) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Gap(10),
        SendImagesContainer(
          imagesCedula: imagesCedula,
          numeroSolicitud: numeroSolicitud ?? '',
          cedulaCliente: cedulaCliente ?? '',
        ),
        const Gap(10),
        SendFirmaDigitalContainer(
          cedulaCliente: cedulaCliente ?? '',
          numeroSolicitud: numeroSolicitud ?? '',
          imagesCedula: imagesCedula,
          firmaCliente: signatureFile?.imageSignature ?? '',
          tipoSolicitud: tipoSolicitud,
          clientSignatureStatus: context
              .read<SolicitudNuevaMenorHnCubit>()
              .state
              .clientSignatureStatus,
        ),
      ],
    );
  }
}

class SendFilesSolicitudAsalariadoContainers extends StatelessWidget {
  const SendFilesSolicitudAsalariadoContainers({
    super.key,
    required this.imagesCedula,
    required this.signatureFile,
    required this.tipoSolicitud,
    required this.numeroSolicitud,
    required this.cedulaCliente,
  });

  final CedulaClientDb? imagesCedula;
  final SignatureClientDb? signatureFile;
  final String tipoSolicitud;
  final String? numeroSolicitud;
  final String? cedulaCliente;

  @override
  Widget build(BuildContext context) {
    final hasSolicitudSended =
        numeroSolicitud != null && numeroSolicitud!.isNotEmpty;

    if (!hasSolicitudSended) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Gap(10),
        SendImagesContainer(
          imagesCedula: imagesCedula,
          numeroSolicitud: numeroSolicitud ?? '',
          cedulaCliente: cedulaCliente ?? '',
        ),
        const Gap(10),
        SendFirmaDigitalContainer(
          cedulaCliente: cedulaCliente ?? '',
          numeroSolicitud: numeroSolicitud ?? '',
          imagesCedula: imagesCedula,
          firmaCliente: signatureFile?.imageSignature ?? '',
          tipoSolicitud: tipoSolicitud,
          clientSignatureStatus: context
              .read<SolicitudAslariadoHnCubit>()
              .state
              .clientSignatureStatus,
        ),
      ],
    );
  }
}

class SendImagesContainer extends StatelessWidget {
  const SendImagesContainer({
    super.key,
    required this.imagesCedula,
    required this.numeroSolicitud,
    required this.cedulaCliente,
  });

  final String numeroSolicitud;
  final String cedulaCliente;

  final CedulaClientDb? imagesCedula;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnviarCedulaSolicitudHnCubit,
        EnviarCedulaSolicitudHnState>(
      listener: (context, state) {
        if (state.status == Status.inProgress) {
          context.showLoading(message: 'Enviando Cedula...');
        }
        if (state.status == Status.done) {
          context.hideLoading();
          showV2CustomSnackbar(
            context,
            title: 'Las fotos de la cedula fueron enviadas exitosamente',
            type: SnackbarType.success,
          );
        }
        if (state.status == Status.error) {
          context.hideLoading();
          showV2CustomSnackbar(
            context,
            title: state.errorMsg,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          width: double.infinity,
          child: CustomElevatedButton(
            text: 'Reenviar Fotos Cedula',
            // ignore: deprecated_member_use
            color: Colors.black,
            onPressed: () {
              final solicitudCubit =
                  context.read<EnviarCedulaSolicitudHnCubit>();
              solicitudCubit.enviarCedulaSolicitud(
                numeroSolicitud: numeroSolicitud,
                cedulaCliente: cedulaCliente,
                imagenFrontal: imagesCedula?.imageFrontCedula ?? '',
                imagenTrasera: imagesCedula?.imageBackCedula ?? '',
              );
            },
          ),
        );
      },
    );
  }
}

class SendFirmaDigitalContainer extends StatelessWidget {
  const SendFirmaDigitalContainer({
    super.key,
    required this.imagesCedula,
    required this.firmaCliente,
    required this.tipoSolicitud,
    required this.numeroSolicitud,
    required this.cedulaCliente,
    required this.clientSignatureStatus,
  });

  final CedulaClientDb? imagesCedula;
  final String firmaCliente;
  final String tipoSolicitud;
  final String numeroSolicitud;
  final String cedulaCliente;
  final ClientSignatureStatus clientSignatureStatus;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnviarFirmaDigitalSolicitudHnCubit,
        EnviarFirmaDigitalSolicitudHnState>(
      listener: (context, state) {
        if (state.status == Status.inProgress) {
          context.showLoading(message: 'Enviando Firma digital...');
        }
        if (state.status == Status.done) {
          context.hideLoading();
          showV2CustomSnackbar(
            context,
            title: 'Firma digital enviada exitosamente',
            type: SnackbarType.success,
          );
        }
        if (state.status == Status.error) {
          context.hideLoading();
          showV2CustomSnackbar(
            context,
            title: state.errorMsg,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          width: double.infinity,
          child: CustomElevatedButton(
            text: 'Reenviar Firma Digital',
            // ignore: deprecated_member_use
            color: Colors.black,
            onPressed: () {
              final solicitudCubit =
                  context.read<EnviarFirmaDigitalSolicitudHnCubit>();
              solicitudCubit.enviarFirmaDigital(
                numeroSolicitud: numeroSolicitud,
                cedulaCliente: cedulaCliente,
                tipoSolicitud: tipoSolicitud,
                firmaCliente: firmaCliente,
                clientSignatureStatus: clientSignatureStatus,
              );
            },
          ),
        );
      },
    );
  }
}

class PhootoSignatureWidget extends StatelessWidget {
  final XFile? fotoSignature;
  final VoidCallback onPhotoSignaturePressed;

  final VoidCallback onNextPressed;
  const PhootoSignatureWidget({
    super.key,
    required this.controller,
    this.fotoSignature,
    required this.onPhotoSignaturePressed,
    required this.onNextPressed,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(30),
          UploadImageWidget(
            selectedImage: fotoSignature,
            onPressed: onPhotoSignaturePressed,
            title: 'Foto de firma digital',
          ),
          const Gap(30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'Siguiente',
              // ignore: deprecated_member_use
              color: AppColors.greenLatern.withOpacity(0.4),
              onPressed: onNextPressed,
            ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomOutLineButton(
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              text: 'Cancelar',
              textColor: AppColors.red,
              color: AppColors.red,
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
