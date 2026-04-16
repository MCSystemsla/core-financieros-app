import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ModernLoadingWidget extends StatelessWidget {
  final String message;

  const ModernLoadingWidget({
    super.key,
    this.message = 'Cargando...',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: colorScheme.primaryContainer.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: CircularProgressIndicator(
              strokeWidth: 5,
              strokeCap: StrokeCap.round,
              // ignore: deprecated_member_use
              backgroundColor: colorScheme.primary.withOpacity(0.1),
            ),
          ),
          const Gap(20),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
