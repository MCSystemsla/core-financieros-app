import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SolicitudLoading extends StatelessWidget {
  const SolicitudLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final items = List.generate(
      10,
      (index) {
        return Container(
          width: size.width,
          alignment: Alignment.center,
          height: 120,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );

    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...items,
          ],
        ),
      ),
    );
  }
}
