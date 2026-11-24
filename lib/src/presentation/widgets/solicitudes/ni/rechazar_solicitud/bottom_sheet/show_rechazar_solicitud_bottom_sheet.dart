import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Hoja inferior para capturar el motivo de rechazo de una solicitud de
/// crédito en Nicaragua. Mismo diseño que el de Honduras
/// (`openMotivoRechazoSheet`). Devuelve el motivo escrito o `null` si se
/// cancela. Con [numeroSolicitud] o [nombreCliente] muestra la solicitud
/// seleccionada sobre el campo del motivo.
Future<String?> openMotivoRechazoSolicitudSheetNi(
  BuildContext context, {
  String buttonText = 'Rechazar Solicitud',
  String? numeroSolicitud,
  String? nombreCliente,
}) {
  final nombre = nombreCliente?.trim() ?? '';
  final numero = numeroSolicitud?.trim() ?? '';
  final mostrarSolicitud = nombre.isNotEmpty || numero.isNotEmpty;

  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const Gap(20),

                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color.fromARGB(255, 246, 207, 209),
                      child: Icon(
                        Icons.close_sharp,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),

                    const Gap(16),

                    const Text(
                      'Motivo de rechazo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Gap(6),

                    const Text(
                      'Ingrese el motivo del rechazo',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Gap(20),

                    if (mostrarSolicitud) ...[
                      _SolicitudSeleccionada(nombre: nombre, numero: numero),
                      const Gap(20),
                    ] else
                      const Gap(4),

                    /// Motivo del rechazo
                    OutlineTextfieldWidget(
                      padding: EdgeInsets.zero,
                      textEditingController: controller,
                      title: 'Motivo del rechazo',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: Icon(
                        Icons.comment,
                        color: AppColors.getPrimaryColor(),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                    ),

                    const Gap(24),

                    /// Botón guardar
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        label: Text(
                          buttonText,
                          style: const TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          Navigator.pop(context, controller.text.trim());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// Solicitud que se va a rechazar: nombre del cliente y número.
class _SolicitudSeleccionada extends StatelessWidget {
  final String nombre;
  final String numero;

  const _SolicitudSeleccionada({required this.nombre, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: RedesignColors.background,
        border: Border.all(color: RedesignColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const ModuleIconTile(
            icon: Icons.person_outline_rounded,
            color: RedesignColors.red,
            background: RedesignColors.redTint,
            size: 40,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre.isNotEmpty ? nombre : 'Cliente sin nombre',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: nombre.isNotEmpty
                        ? RedesignColors.ink
                        : RedesignColors.chevron,
                  ),
                ),
                if (numero.isNotEmpty) ...[
                  const Gap(2),
                  Text(
                    'Solicitud N.º $numero',
                    style: const TextStyle(
                      fontSize: 12,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
