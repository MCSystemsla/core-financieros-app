// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SuccessClayWidget extends StatelessWidget {
  final String lottieAsset;
  final String text;
  final bool? repeat;
  final bool? isSucess;
  final bool isUploadingForms;
  final VoidCallback? onDownloadComplete;
  final List<String> unsyncedCatalogos;
  final List<String> solicitudesSent;

  const SuccessClayWidget({
    super.key,
    required this.lottieAsset,
    required this.text,
    this.repeat = true,
    this.isSucess = false,
    this.isUploadingForms = false,
    this.onDownloadComplete,
    this.unsyncedCatalogos = const [],
    this.solicitudesSent = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animación Lottie
                Lottie.asset(
                  lottieAsset,
                  repeat: repeat,
                  height: 180,
                ),
                const Gap(16),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),

                if (solicitudesSent.isNotEmpty) ...[
                  const Gap(20),
                  ...solicitudesSent.map(
                    (solicitud) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _buildClayItemTile(solicitud),
                    ),
                  ),
                ],

                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),

                if (unsyncedCatalogos.isNotEmpty) ...[
                  const Gap(20),
                  Text(
                    unsyncedCatalogos.length > 1
                        ? 'Algunos catálogos no se pudieron sincronizar:'
                        : 'No se pudo sincronizar el catálogo:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5A6E85),
                        ),
                  ),
                  const Gap(12),
                  ...unsyncedCatalogos.map(
                    (error) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildClayErrorTile(context, error),
                    ),
                  ),
                ],

                if (isSucess ?? false) ...[
                  const Gap(24),
                  _buildClayButton(
                    context,
                    text: 'OK',
                    onPressed: onDownloadComplete ??
                        () {
                          if (isUploadingForms) {
                            return context.pushReplacement('/');
                          }
                          if (context.canPop()) return context.pop();
                          context.push('/');
                        },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClayErrorTile(BuildContext context, String error) {
    const Color tileColor = Color(0xFFE6EDF4);
    final HSLColor tileHsl = HSLColor.fromColor(tileColor);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tileHsl
                .withLightness((tileHsl.lightness + 0.04).clamp(0.0, 1.0))
                .toColor(),
            tileColor,
            tileHsl
                .withLightness((tileHsl.lightness - 0.04).clamp(0.0, 1.0))
                .toColor(),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(3, 5),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        title: Text(
          error,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A5C70),
              ),
        ),
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color(0xFFFFE5E9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error_rounded,
            color: Color(0xFFFF4D6A),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildClayButton(BuildContext context,
      {required String text, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 180,
        height: 52,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildClayItemTile(String itemText) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          color: Color(0xFF2E7D32),
          size: 18,
        ),
        const Gap(10),
        Expanded(
          child: Text(
            itemText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
      ],
    ),
  );
}
