import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectLocationWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SelectLocationWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 35,
      left: 10,
      right: 10,
      child: Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ubicación del cliente',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(6),
            Text(
              'Mueve el mapa hasta que el pin quede en la dirección correcta.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                    height: 1.3,
                  ),
            ),
            const Gap(12),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: FilledButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Confirmar ubicación'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
