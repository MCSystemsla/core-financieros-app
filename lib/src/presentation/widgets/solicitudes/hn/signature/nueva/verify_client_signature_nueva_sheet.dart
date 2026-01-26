import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/camera_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/sending_form_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/client_signature_list_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/solicitud_nueva_signature_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class VerifyClientSignatureSheet extends StatelessWidget {
  final PageController pageController;
  const VerifyClientSignatureSheet({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.30,
      maxChildSize: 0.50,
      expand: false,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xfff9fafb),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.12),
                blurRadius: 25,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Gap(18),
              ClientSignatureListData(
                onClientNoPossibleSignatureTap: () {
                  context.pop();
                  context.pushTransparentRoute(BlocProvider.value(
                    value: context.read<SolicitudNuevaMenorHnCubit>(),
                    child: const VerifyClientIfNotPossibleToSignWidget(),
                  ));
                },
                onClientPossibleSignatureTap: () {
                  context.pop();
                  context.pushTransparentRoute(
                    BlocProvider.value(
                      value: context.read<SolicitudNuevaMenorHnCubit>(),
                      child: const SolicitudSignatureClientWidget(
                        clientSignatureStatus: ClientSignatureStatus.yes,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class VerifyClientIfNotPossibleToSignWidget extends StatefulWidget {
  const VerifyClientIfNotPossibleToSignWidget({super.key});

  @override
  State<VerifyClientIfNotPossibleToSignWidget> createState() =>
      _VerifyClientIfNotPossibleToSignWidgetState();
}

class _VerifyClientIfNotPossibleToSignWidgetState
    extends State<VerifyClientIfNotPossibleToSignWidget> {
  XFile? selectedImage;
  String? selectedImage1Path;
  @override
  Widget build(BuildContext context) {
    final internetConnectionCubit =
        context.read<InternetConnectionCubit>().state.connectionStatus;
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar Boleta de autorizacion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(25),
            UploadImageWidget(
              selectedImage: selectedImage,
              title: '1- ${'Foto de autorizacion firmada'.tr()}',
              onPressed: () => context.pushTransparentRoute(
                CameraCaptureScreen(
                  numeroSoicitud: '0',
                  onImageSelected: (image, path) {
                    setState(() {
                      selectedImage = image;
                      selectedImage1Path = path;
                    });
                  },
                ),
              ),
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

                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    isDone: true,
                  ),
                );
                if (internetConnectionCubit == ConnectionStatus.disconnected) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      isOffline: true,
                      errorMsg:
                          'No tienes conexión a internet, La solicitud se a guardado de manera local',
                      isDone: true,
                    ),
                  );
                  CustomAlertDialog(
                    context: context,
                    title:
                        'No tienes conexión a internet, La solicitud se a guardado de manera local',
                    onDone: () => context.pushReplacement('/solicitudes'),
                  ).showDialog(context, dialogType: DialogType.infoReverse);
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: context.read<SolicitudNuevaMenorHnCubit>(),
                      child: const SendingFormWidgetHN(),
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }
}
