import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Línea superior
            Container(
              height: 18,
              width: 180,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),

            // Línea media
            Container(
              height: 16,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),

            Container(
              height: 16,
              width: 140,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 18),

            // Botón / Acción simulada
            Container(
              height: 36,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
