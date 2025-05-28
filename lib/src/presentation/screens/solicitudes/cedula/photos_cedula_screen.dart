import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/cedula_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CedulaItem {
  final String title;
  final String description;

  CedulaItem({
    required this.title,
    required this.description,
  });
}

class PhotosCedulaScreen extends StatelessWidget {
  final PageController? controller;
  const PhotosCedulaScreen({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Comencemos!'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CedulaItemsWidget(
            cedulaCaptureTitle: 'Captura de identificacion frontal',
            isCedulaTaken: true,
            index: 1,
            cedulaItem: CedulaItem(
              title: 'Captura de cedula frontal',
              description:
                  'Capture su documento de idendificacion del lado donde se encuentra la fotografia y nombre completo',
            ),
          ),
          const Gap(10),
          CedulaItemsWidget(
            isCedulaTaken: false,
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
                controller?.nextPage(
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
