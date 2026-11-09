import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:signature/signature.dart';

/// Piezas visuales (rediseño 2026) de la página de firma de los formularios
/// Kiva. Solo dibujan: la lógica de guardado y envío sigue en cada
/// `*_signature_widget.dart`.

/// Título y explicación sobre el lienzo. [firmaCliente] decide si firma el
/// cliente o el representante de MiCrédito.
class KivaFirmaEncabezado extends StatelessWidget {
  final bool firmaCliente;
  const KivaFirmaEncabezado({super.key, required this.firmaCliente});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firmaCliente
              ? 'forms.firmar.title'.tr()
              : 'Firma de Representante de Micrédito',
          style: const TextStyle(
            fontSize: 18,
            height: 1.25,
            fontWeight: FontWeight.w700,
            color: RedesignColors.ink,
          ),
        ),
        const Gap(6),
        Text(
          'forms.firmar.description'.tr(),
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.4,
            color: RedesignColors.inkMuted,
          ),
        ),
      ],
    );
  }
}

/// Lienzo de firma dentro de una tarjeta, con "Limpiar" arriba a la derecha.
class KivaFirmaLienzo extends StatelessWidget {
  final SignatureController controller;
  const KivaFirmaLienzo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final alto = (MediaQuery.sizeOf(context).height * 0.45).clamp(260.0, 460.0);

    return KivaPreguntaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.draw_outlined,
                size: 18,
                color: RedesignColors.inkMuted,
              ),
              const Gap(8),
              const Expanded(
                child: Text(
                  'Firma dentro del recuadro',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.inkMuted,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: controller.clear,
                style: TextButton.styleFrom(
                  foregroundColor: RedesignColors.red,
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Icons.restart_alt_rounded, size: 18),
                label: const Text('Limpiar'),
              ),
            ],
          ),
          const Gap(8),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: RedesignColors.border,
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LayoutBuilder(
                builder: (context, constraints) => Signature(
                  key: const Key('signature'),
                  controller: controller,
                  width: constraints.maxWidth,
                  height: alto,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Botones "Regresar" / "Enviar" de la firma. Con [enviando] "Enviar"
/// muestra un spinner y no se puede tocar; "Regresar" sigue activo, como
/// antes del rediseño.
class KivaFirmaAcciones extends StatelessWidget {
  final bool enviando;
  final VoidCallback onEnviar;
  final VoidCallback onRegresar;
  const KivaFirmaAcciones({
    super.key,
    required this.enviando,
    required this.onEnviar,
    required this.onRegresar,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  foregroundColor: RedesignColors.ink,
                  side: const BorderSide(color: RedesignColors.border),
                  shape: shape,
                ),
                onPressed: onRegresar,
                child: const Text('Regresar'),
              ),
            ),
            const Gap(12),
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: RedesignColors.teal,
                  disabledBackgroundColor: RedesignColors.tagBackground,
                  shape: shape,
                ),
                onPressed: enviando ? null : onEnviar,
                icon: enviando
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: RedesignColors.teal,
                        ),
                      )
                    : const Icon(Icons.send_rounded, size: 18),
                label: Text(enviando ? 'Enviando...' : 'button.send'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
