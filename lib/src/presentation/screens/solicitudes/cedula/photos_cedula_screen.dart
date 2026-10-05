import 'dart:io';

import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/photo_user_cedula/photo_user_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/cedula_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
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
  final void Function(String imagePath) onCedulaFrontTaken;
  final void Function(String imagePath) onCedulaBackTaken;
  const PhotosCedulaScreen({
    super.key,
    required this.controller,
    required this.onCedulaFrontTaken,
    required this.onCedulaBackTaken,
  });

  @override
  Widget build(BuildContext context) {
    final photoCedulaProvider = context.watch<PhotoUserCedulaCubit>().state;
    final isFrontTaken = photoCedulaProvider.cedulaFrontPath.isNotEmpty;
    final isBackTaken = photoCedulaProvider.cedulaBackPath.isNotEmpty;
    final takenCount = [isFrontTaken, isBackTaken].where((e) => e).length;
    final isComplete = takenCount == 2;

    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  ScreenHeaderWidget(
                    title: '¡Comencemos!',
                    subtitle:
                        'Tome una foto clara de ambos lados del documento de identidad del cliente.',
                    onBack: () => context.pop(),
                  ),
                  const Gap(20),
                  _CaptureProgress(takenCount: takenCount, total: 2),
                  const Gap(16),
                  CedulaItemsWidget(
                    onImageTaken: (image) {
                      context.read<PhotoUserCedulaCubit>().savePhotosPath(
                            cedulaFrontPath: image,
                          );
                      onCedulaFrontTaken(image);
                    },
                    cedulaCaptureTitle: 'Captura de identificacion frontal',
                    isCedulaTaken: isFrontTaken,
                    imagePath: photoCedulaProvider.cedulaFrontPath,
                    icon: Icons.badge_outlined,
                    index: 1,
                    cedulaItem: CedulaItem(
                      title: 'Cédula frontal',
                      description:
                          'Lado donde se encuentra la fotografía y el nombre completo.',
                    ),
                  ),
                  const Gap(12),
                  CedulaItemsWidget(
                    onImageTaken: (image) {
                      context.read<PhotoUserCedulaCubit>().savePhotosPath(
                            cedulaBackPath: image,
                          );
                      onCedulaBackTaken(image);
                    },
                    isCedulaTaken: isBackTaken,
                    imagePath: photoCedulaProvider.cedulaBackPath,
                    icon: Icons.flip_outlined,
                    cedulaCaptureTitle: 'Captura de identificacion por detras',
                    index: 2,
                    cedulaItem: CedulaItem(
                      title: 'Cédula trasera',
                      description: 'Lado posterior del documento de identidad.',
                    ),
                  ),
                  const Gap(20),
                  const _CaptureTips(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (photoCedulaProvider.cedulaBackPath.isEmpty ||
                        photoCedulaProvider.cedulaFrontPath.isEmpty) {
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isComplete
                        ? RedesignColors.ink
                        : RedesignColors.ink.withValues(alpha: 0.35),
                    foregroundColor: RedesignColors.surface,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Siguiente',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaptureProgress extends StatelessWidget {
  final int takenCount;
  final int total;
  const _CaptureProgress({required this.takenCount, required this.total});

  @override
  Widget build(BuildContext context) {
    final isComplete = takenCount == total;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Progreso',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: RedesignColors.inkMuted,
                ),
              ),
              const Spacer(),
              Text(
                '$takenCount de $total capturas',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isComplete ? RedesignColors.green : RedesignColors.ink,
                ),
              ),
            ],
          ),
          const Gap(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: takenCount / total),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 6,
                backgroundColor: RedesignColors.border,
                color: RedesignColors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaptureTips extends StatelessWidget {
  const _CaptureTips();

  @override
  Widget build(BuildContext context) {
    const tips = [
      'Use buena iluminación y evite reflejos.',
      'Encuadre el documento completo dentro del marco.',
      'Verifique que los datos se lean con claridad.',
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RedesignColors.amberTint,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 18,
                color: RedesignColors.amber,
              ),
              Gap(8),
              Text(
                'Consejos para una buena foto',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.amber,
                ),
              ),
            ],
          ),
          const Gap(10),
          for (final tip in tips)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 8),
                    child: CircleAvatar(
                      radius: 2.5,
                      backgroundColor: RedesignColors.amber,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.4,
                        color: RedesignColors.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
  final String imagePath;
  final IconData icon;
  const CedulaItemsWidget({
    super.key,
    required this.index,
    required this.cedulaItem,
    required this.isCedulaTaken,
    required this.cedulaCaptureTitle,
    required this.onImageTaken,
    this.imagePath = '',
    this.icon = Icons.badge_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isCedulaTaken
                    ? RedesignColors.green.withValues(alpha: 0.45)
                    : RedesignColors.border,
              ),
            ),
            child: Row(
              children: [
                _CedulaPreview(
                  imagePath: imagePath,
                  isCedulaTaken: isCedulaTaken,
                  icon: icon,
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PASO $index',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        cedulaItem.title,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: RedesignColors.ink,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        cedulaItem.description,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.35,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                      const Gap(8),
                      _StatusLabel(isCedulaTaken: isCedulaTaken),
                    ],
                  ),
                ),
                const Gap(8),
                Icon(
                  isCedulaTaken
                      ? Icons.refresh_rounded
                      : Icons.chevron_right_rounded,
                  color: RedesignColors.chevron,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CedulaPreview extends StatelessWidget {
  final String imagePath;
  final bool isCedulaTaken;
  final IconData icon;
  const _CedulaPreview({
    required this.imagePath,
    required this.isCedulaTaken,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const width = 76.0;
    const height = 54.0;
    final fallback = ModuleIconTile(
      icon: icon,
      color: RedesignColors.indigo,
      background: RedesignColors.indigoTint,
      size: height,
    );

    if (!isCedulaTaken || imagePath.isEmpty) {
      return SizedBox(
          width: width, height: height, child: Center(child: fallback));
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(imagePath),
            width: width,
            height: height,
            fit: BoxFit.cover,
            cacheWidth: 240,
            errorBuilder: (_, __, ___) => SizedBox(
              width: width,
              height: height,
              child: Center(child: fallback),
            ),
          ),
        ),
        Positioned(
          right: -6,
          bottom: -6,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: RedesignColors.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 20,
              color: RedesignColors.green,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusLabel extends StatelessWidget {
  final bool isCedulaTaken;
  const _StatusLabel({required this.isCedulaTaken});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: isCedulaTaken
            ? RedesignColors.greenTint
            : RedesignColors.tagBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCedulaTaken ? Icons.check_rounded : Icons.photo_camera_outlined,
            size: 13,
            color:
                isCedulaTaken ? RedesignColors.green : RedesignColors.inkMuted,
          ),
          const Gap(4),
          Flexible(
            child: Text(
              isCedulaTaken ? 'Capturada' : 'Pendiente',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isCedulaTaken
                    ? RedesignColors.green
                    : RedesignColors.inkMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
