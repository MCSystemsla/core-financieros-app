import 'dart:io';

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CedulaCaptureView extends StatelessWidget {
  final void Function(String imagePath) onImageTaken;
  final File cedulaCapturedImage;
  const CedulaCaptureView({
    super.key,
    required this.cedulaCapturedImage,
    required this.onImageTaken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Foto Tomada'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(cedulaCapturedImage),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () => context.pop(),
                      text: 'Repetir',
                      icon: const Icon(Icons.replay),
                      color: AppColors.red,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        onImageTaken(cedulaCapturedImage.path);
                        context.pop();
                        context.pop();
                      },
                      text: 'Aceptar',
                      color: AppColors.getPrimaryColor(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CloseCaptureCedulaWidget extends StatelessWidget {
  const CloseCaptureCedulaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: SafeArea(
        child: IconButton(
          color: Colors.white,
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class CaptureCedulaDescription extends StatelessWidget {
  const CaptureCedulaDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.5),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: const Text(
          'Coloque su identificacion dentro del recuadro, Asegurese de tener buena luz.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CaptureCedulaTitle extends StatelessWidget {
  final String title;
  const CaptureCedulaTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
