// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asign_solicitud_asesor/bottom_sheet/show_asignar_solicitud_bottom_sheet.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreditProductItem extends StatelessWidget {
  final String title;
  final DateTime fecha;
  final String monto;
  final String estadoCodigo;
  final String solicitudId;
  final String sucursal;
  final String? nombreCliente;
  final String? nombrePromotor;
  final String? tipoSolicitud;

  const CreditProductItem({
    super.key,
    required this.title,
    required this.fecha,
    required this.monto,
    required this.estadoCodigo,
    required this.sucursal,
    required this.solicitudId,
    this.nombreCliente,
    this.nombrePromotor,
    this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudNuevaByEstadoCubit>();
    final typeForm = determineTypeForm(tipoSolicitud!);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {
          if (estadoCodigo != 'REG') {
            CustomAlertDialog(
              context: context,
              title:
                  'Solo se puede asignar una solicitud cuando el estado es REG',
              onDone: () => context.pop(),
            ).showDialog(context);
            return;
          }
          showAsignarSolicitudBottomSheet(
            context,
            int.tryParse(solicitudId) ?? 0,
            title,
            nombreCliente ?? 'N/A',
            typeForm,
            cubit,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _InfoTag(
                  icon: Icons.date_range_outlined,
                  label: 'Fecha',
                  value: fecha.selectorFormat(),
                ),
                _InfoTag(
                    icon: Icons.monetization_on, label: 'Monto', value: monto),
                _InfoTag(
                  icon: Icons.star_outline,
                  label: 'Estado',
                  value: estadoCodigo,
                ),
              ],
            ),
            const Gap(12),
            _TagInfoPerson(
              nombre: nombreCliente ?? 'N/A',
              haveLocation: true,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              typeForm: tipoSolicitud,
            ),
            const Gap(8),
            _TagInfoPerson(
              nombre: 'Asesor: ${nombrePromotor ?? 'N/A'}',
              haveLocation: false,
              icon: Icons.person_4_outlined,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TypeForm determineTypeForm(String typeForm) {
    return switch (typeForm) {
      'NUEVAMENOR' => TypeForm.nueva,
      'ASALARIADO' => TypeForm.asalariado,
      'REPRESTAMO' => TypeForm.represtamo,
      _ => throw Exception('Tipo Solicitud no reconocido'),
    };
  }
}

class _TagInfoPerson extends StatelessWidget {
  final String nombre;
  final bool haveLocation;
  final TextStyle? style;
  final String? typeForm;
  final IconData icon;
  const _TagInfoPerson({
    required this.nombre,
    this.haveLocation = false,
    required this.style,
    this.typeForm,
    this.icon = Icons.person_2_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Text(nombre,
              maxLines: 3, overflow: TextOverflow.ellipsis, style: style),
        ),
        if (haveLocation) ...[
          const Spacer(),
          const Icon(
            Icons.difference_outlined,
            size: 18,
            color: Colors.grey,
          ),
          const SizedBox(width: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 70),
            child: Text(
              typeForm ?? 'N/A',
              maxLines: 2,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTag({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
