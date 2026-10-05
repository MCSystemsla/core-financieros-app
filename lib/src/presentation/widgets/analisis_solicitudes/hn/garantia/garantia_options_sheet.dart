import 'package:core_financiero_app/src/presentation/widgets/shared/tiles/option_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<void> showGarantiaOptionsSheet(
  BuildContext context, {
  required VoidCallback onActualizar,
  required VoidCallback onRechazar,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => _GarantiaOptionsSheet(
      onActualizar: () {
        Navigator.pop(sheetContext);
        onActualizar();
      },
      onRechazar: () {
        Navigator.pop(sheetContext);
        onRechazar();
      },
    ),
  );
}

class _GarantiaOptionsSheet extends StatelessWidget {
  final VoidCallback onActualizar;
  final VoidCallback onRechazar;
  const _GarantiaOptionsSheet({
    required this.onActualizar,
    required this.onRechazar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Opciones del bien',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            const Gap(16),
            OptionTile(
              icon: Icons.edit_outlined,
              color: Colors.indigo,
              title: 'Actualizar Bien',
              subtitle: 'Editar la información del bien registrado',
              onTap: onActualizar,
            ),
            const Gap(4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 1),
            ),
            const Gap(4),
            OptionTile(
              icon: Icons.close_rounded,
              color: Colors.red,
              title: 'Rechazar Bien',
              subtitle: 'Descartar este bien de garantía',
              onTap: onRechazar,
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
