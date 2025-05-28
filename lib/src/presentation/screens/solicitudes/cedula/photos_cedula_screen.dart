import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/photo_user_cedula/photo_user_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/cedula_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CedulaItem {
  final String title;
  final String description;

  CedulaItem({
    required this.title,
    required this.description,
  });
}

class PhotosCedulaScreen extends StatelessWidget {
  final PageController controller;
  const PhotosCedulaScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final photoCedulaProvider = context.watch<PhotoUserCedulaCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Comencemos!'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CedulaItemsWidget(
            onImageTaken: (image) {
              context.read<PhotoUserCedulaCubit>().savePhotosPath(
                    cedulaFrontPath: image,
                  );
            },
            cedulaCaptureTitle: 'Captura de identificacion frontal',
            isCedulaTaken: photoCedulaProvider.cedulaFrontPath.isNotEmpty,
            index: 1,
            cedulaItem: CedulaItem(
              title: 'Captura de cedula frontal',
              description:
                  'Capture su documento de idendificacion del lado donde se encuentra la fotografia y nombre completo',
            ),
          ),
          const Gap(10),
          CedulaItemsWidget(
            onImageTaken: (image) {
              context.read<PhotoUserCedulaCubit>().savePhotosPath(
                    cedulaBackPath: image,
                  );
            },
            isCedulaTaken: photoCedulaProvider.cedulaBackPath.isNotEmpty,
            cedulaCaptureTitle: 'Captura de identificacion por detras',
            index: 2,
            cedulaItem: CedulaItem(
              title: 'Captura de identificacion por detras',
              description:
                  'Capture su documento de identificacion del lado trasero',
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomElevatedButton(
              onPressed: () {
                if (photoCedulaProvider.cedulaBackPath.isEmpty ||
                    photoCedulaProvider.cedulaBackPath.isEmpty) {
                  CustomAlertDialog(
                    context: context,
                    title:
                        'Debes capturar ambas imágenes de la cédula para continuar',
                    onDone: () => context.pop(),
                  ).showDialog(context);
                  return;
                }
                context.pop();
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              text: 'Siguiente',
              color: AppColors.getSecondaryColor(),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

class CedulaItemsWidget extends StatelessWidget {
  final void Function(String image) onImageTaken;
  final CedulaItem cedulaItem;
  final int index;
  final bool isCedulaTaken;
  final String cedulaCaptureTitle;
  const CedulaItemsWidget({
    super.key,
    required this.index,
    required this.cedulaItem,
    required this.isCedulaTaken,
    required this.cedulaCaptureTitle,
    required this.onImageTaken,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CedulaCaptureScreen(
                onImageTaken: onImageTaken,
                title: cedulaCaptureTitle,
              ),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(5),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 32,
          child: isCedulaTaken
              ? const Icon(
                  Icons.check_circle_outline_outlined,
                  color: Colors.green,
                  size: 32,
                )
              : Text(
                  index.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.getPrimaryColor(),
          ),
        ),
        title: Text(cedulaItem.title),
        subtitle: Text(cedulaItem.description),
      ),
    );
  }
}
