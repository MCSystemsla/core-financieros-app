import 'dart:io';

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/asalariado_hn_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../../../bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';

class FiadorSignatureWidget extends StatefulWidget {
  final PageController pageController;
  const FiadorSignatureWidget({
    super.key,
    required this.pageController,
  });

  @override
  State<FiadorSignatureWidget> createState() => _FiadorSignatureWidgetState();
}

class _FiadorSignatureWidgetState extends State<FiadorSignatureWidget> {
  final formKey = GlobalKey<FormState>();
  final controller = SignatureController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisFiadoresCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Firma de fiador',
                style: TextStyle(
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
                  if (signatureImage == null) return;
                  final tempDir = await getTemporaryDirectory();

                  final timestamp = DateTime.now().millisecondsSinceEpoch;
                  final file =
                      File('${tempDir.path}/firma_fiador_$timestamp.png');

                  await file.writeAsBytes(signatureImage);
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(firmaFiador: file.path),
                  );

                  if (!context.mounted) return;
                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
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
    );
  }
}
