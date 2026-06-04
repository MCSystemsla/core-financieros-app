import 'package:flutter/material.dart';

enum StatusComiteGrupalIntegranteEnum {
  completo,
  pendiente,
}

class StatusItem {
  final String name;
  final StatusComiteGrupalIntegranteEnum status;
  final String tipoSolicitud;
  final int numeroSolicitud;

  StatusItem({
    required this.name,
    required this.status,
    required this.tipoSolicitud,
    required this.numeroSolicitud,
  });
}

class StatusItemCard extends StatelessWidget {
  final StatusItem item;
  final VoidCallback onTap;
  final bool isSelected;
  final bool enabled;

  const StatusItemCard({
    super.key,
    required this.item,
    required this.onTap,
    this.isSelected = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      splashColor: Colors.transparent,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 0.95,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0.5,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.elasticOut,
            width: 160,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: item.status == StatusComiteGrupalIntegranteEnum.completo
                  ? const Color(0xFFE8F8F5)
                  : const Color(0xFFFFF9E6),
              borderRadius: BorderRadius.circular(20),
              // ignore: deprecated_member_use
              border: Border.all(
                color: item.status == StatusComiteGrupalIntegranteEnum.completo
                    ? Colors.green.shade100
                    : Colors.yellow.shade300,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.status == StatusComiteGrupalIntegranteEnum.completo
                        ? Icons.check_circle_outline
                        : Icons.access_time,
                    color:
                        item.status == StatusComiteGrupalIntegranteEnum.completo
                            ? Colors.green
                            : Colors.yellow,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2D3436),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.status == StatusComiteGrupalIntegranteEnum.pendiente
                      ? 'Pendiente'
                      : 'Completo',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 0.5,
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
