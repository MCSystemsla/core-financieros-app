import 'dart:io';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/signature_client/signature_client_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/asalariado_hn_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/verify_client_signature_nueva_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

enum ClientSignatureStatus { yes, noPossible, unknown }

class SolicitudSignatureNueva extends StatelessWidget {
  final PageController pageController;
  const SolicitudSignatureNueva({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            ImageAsset.solicitudSignature,
            height: 180,
          ),
          const Gap(25),
          Text(
            'Validacion de firma de solicitante',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(16),
          Text(
            'Mediante esta firma, el solicitante certifica la veracidad de los datos ingresados y autoriza el trámite correspondiente y autoriza a la busqueda centrales de riesgo',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
          const Gap(30),
          CustomElevatedButton(
            onPressed: () => {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => BlocProvider.value(
                  value: context.read<SolicitudNuevaMenorHnCubit>(),
                  child: VerifyClientSignatureSheet(
                    pageController: pageController,
                  ),
                ),
              ),
            },
            text: 'Verificar',
            color: AppColors.getSecondaryColor(),
          ),
        ],
      ),
    );
  }
}

class ClientSignatureSolicitud extends StatefulWidget {
  final SignatureController signatureController;

  const ClientSignatureSolicitud({
    super.key,
    required this.signatureController,
  });

  @override
  State<ClientSignatureSolicitud> createState() =>
      _ClientSignatureSolicitudState();
}

class _ClientSignatureSolicitudState extends State<ClientSignatureSolicitud> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.boxGrey,
              width: .9,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Signature(
              key: const Key('signature'),
              controller: widget.signatureController,
              height: size.height * .56,
              width: size.width * .9,
              backgroundColor: AppColors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: IconBorder.fromIcon(
            color: AppColors.red,
            icon: Icons.delete_forever,
            onTap: () => widget.signatureController.clear(),
            size: const Size(44, 44),
          ),
        ),
      ],
    );
  }
}

class SolicitudSignatureClientWidget extends StatefulWidget {
  final ClientSignatureStatus clientSignatureStatus;
  final PageController pageController;
  const SolicitudSignatureClientWidget({
    super.key,
    required this.clientSignatureStatus,
    required this.pageController,
  });

  @override
  State<SolicitudSignatureClientWidget> createState() =>
      _SolicitudSignatureClientWidgetState();
}

class _SolicitudSignatureClientWidgetState
    extends State<SolicitudSignatureClientWidget> {
  final formKey = GlobalKey<FormState>();
  final controller = SignatureController();

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<SolicitudesHnBoxService>();
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firma'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.clientSignatureStatus == ClientSignatureStatus.yes
                      ? 'Firma de solicitante de MiCredito'
                      : 'Firma de representante de Micredito',
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'El usuario debe firmar correctamente',
                  style: TextStyle(
                    color: AppColors.greyWithOpacityV4,
                  ),
                ),
                const Gap(10),
                ClientSignatureSolicitud(
                  signatureController: controller,
                ),
                const Gap(30),
                CustomElevatedButton(
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                  positionIcon: PositionIcon.left,
                  text: 'Enviar',
                  color: context.primaryColor(),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (!isValidSignature(controller)) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Ingresa una firma válida',
                        onDone: () => context.pop(),
                      ).showDialog(context);
                      return;
                    }
                    final signatureImage = await controller.toPngBytes();
                    final directory = await getApplicationDocumentsDirectory();
                    final filePath =
                        '${directory.path}/solicitud_signature_${DateTime.now().millisecondsSinceEpoch}.png';

                    // Guarda la imagen en el archivo
                    final file = File(filePath);
                    await file.writeAsBytes(signatureImage!);

                    final clientSignature = SignatureClientDb(
                      typeSolicitud: 'NUEVA',
                      cedula: cubit.state.cedula,
                      imageSignature: filePath,
                    );
                    localDbProvider.saveClientSignature(clientSignature);
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                    if (!context.mounted) return;
                    context.pop();
                  },
                ),
                const Gap(10),
                Expanded(
                  flex: 0,
                  child: CustomElevatedButton(
                    alignment: MainAxisAlignment.center,
                    text: 'Regresar',
                    color: Colors.red,
                    onPressed: () => context.pop(),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
