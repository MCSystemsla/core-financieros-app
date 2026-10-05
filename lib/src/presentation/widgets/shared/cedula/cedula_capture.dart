import 'dart:io';

import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
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
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeaderWidget(
              title: 'Revisa la foto',
              subtitle:
                  'Confirma que la identificación se vea completa y legible antes de continuar.',
              onBack: () => context.pop(),
              trailing: const SizedBox.shrink(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: RedesignColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: RedesignColors.border),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          cedulaCapturedImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Gap(16),
                    const _CedulaReviewChecklist(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: const BoxDecoration(
                color: RedesignColors.surface,
                border: Border(
                  top: BorderSide(color: RedesignColors.border),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton.icon(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.replay_rounded, size: 20),
                        label: const Text('Repetir'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: RedesignColors.ink,
                          side: const BorderSide(color: RedesignColors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          onImageTaken(cedulaCapturedImage.path);
                          context.pop();
                          context.pop();
                        },
                        icon: const Icon(Icons.check_rounded, size: 20),
                        label: const Text('Usar foto'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: RedesignColors.ink,
                          foregroundColor: RedesignColors.surface,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CedulaReviewChecklist extends StatelessWidget {
  const _CedulaReviewChecklist();

  static const _items = [
    'Los datos se leen con claridad',
    'No hay reflejos ni sombras sobre el documento',
    'Las cuatro esquinas se ven completas',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RedesignColors.greenTint,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Antes de continuar, verifica que:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: RedesignColors.green,
            ),
          ),
          const Gap(10),
          for (final item in _items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 18,
                    color: RedesignColors.green,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      item,
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

class CloseCaptureCedulaWidget extends StatelessWidget {
  const CloseCaptureCedulaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.55),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Row(
              children: [
                Material(
                  color: Colors.white.withValues(alpha: 0.16),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => context.pop(),
                    child: const SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                const Expanded(
                  child: Text(
                    'Captura de identificación',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
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
      alignment: const Alignment(0, 0.4),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wb_sunny_outlined,
              color: Colors.white70,
              size: 18,
            ),
            Gap(10),
            Flexible(
              child: Text(
                'Coloque su identificación dentro del recuadro. Asegúrese de tener buena luz.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
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
      alignment: const Alignment(0, -0.36),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.badge_outlined,
              color: RedesignColors.green,
              size: 18,
            ),
            const Gap(8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: RedesignColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
