import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_aproved_response.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ComiteApprovedSuccessTransactionCard extends StatelessWidget {
  final double monto;
  final List<ComiteAprovedResponsable> responsables;
  final String mensajeExito;

  const ComiteApprovedSuccessTransactionCard({
    super.key,
    required this.monto,
    required this.responsables,
    this.mensajeExito = '¡Enviado exitosamente!',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER DE ÉXITO
            Center(
              child: Column(
                children: [
                  Lottie.asset(
                    ImageAsset.nuevaMenorSuccess,
                    width: 160,
                    height: 160,
                    repeat: false,
                  ),
                  const Gap(16),
                  Text(
                    mensajeExito,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const Gap(24),
                  const Text(
                    'Monto aprobado:',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'L ${monto.toCurrencyString()}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1),
            ),

            if (responsables.isNotEmpty) ...[
              const Gap(24),
              Text(
                '${responsables.length > 1 ? 'Responsables' : 'Responsable'} de siguiente nivel de aprobación:',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Gap(12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: responsables
                    .map((r) => Chip(
                          avatar: const Icon(Icons.person_outline, size: 21),
                          label: Text(r.nombre),
                          backgroundColor: Colors.grey[100],
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ))
                    .toList(),
              ),
            ],
            const Gap(20),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                color: AppColors.getPrimaryColor(),
                text: 'OK',
                onPressed: () => context.push('/'),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
