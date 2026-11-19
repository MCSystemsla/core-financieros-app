import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Piezas del rediseño 2026 para los formularios Kiva online (estándar,
/// saneamiento, mujer emprende, migrantes, estudio, energía limpia y mejora
/// de vivienda). La firma usa `kiva_firma_widgets.dart`; en la página de fotos
/// los recuadros siguen siendo `UploadImageWidget`.

/// Contenedor de un formulario Kiva: encabezado con pasos
/// ([FormStepHeaderWidget]) y el `PageView` de las páginas.
///
/// Es dueño del [PageController] (lo crea una vez y lo libera), así no se
/// recrea si la pantalla se reconstruye. [steps] debe tener el mismo orden y
/// la misma cantidad que las páginas que devuelve [pagesBuilder].
///
/// También controla la salida: el botón atrás del encabezado, el gesto/botón
/// atrás del sistema y [KivaFormScaffold.salir] piden confirmación si el
/// formulario ya tiene datos (pasó del primer paso o se marcó con
/// [KivaFormScaffold.marcarCambios]), y no dejan salir mientras se envía
/// ([KivaFormScaffold.marcarEnviando]). Los `pop` del código (al terminar el
/// envío) no pasan por aquí.
class KivaFormScaffold extends StatefulWidget {
  final String title;
  final bool isRecurrentForm;
  final List<String> steps;
  final List<Widget> Function(PageController controller) pagesBuilder;
  const KivaFormScaffold({
    super.key,
    required this.title,
    required this.isRecurrentForm,
    required this.steps,
    required this.pagesBuilder,
  });

  static _KivaFormScaffoldState? _of(BuildContext context) =>
      context.findAncestorStateOfType<_KivaFormScaffoldState>();

  /// Marca que el formulario ya tiene datos que se perderían al salir (por
  /// ejemplo, una foto tomada en el primer paso).
  static void marcarCambios(BuildContext context) =>
      _of(context)?._tieneCambios = true;

  /// Indica si hay un envío en curso. Mientras dure no se puede salir.
  static void marcarEnviando(BuildContext context, bool enviando) =>
      _of(context)?._enviando = enviando;

  /// Sale del formulario, pidiendo confirmación si hay datos sin guardar.
  static Future<void> salir(BuildContext context) async {
    final state = _of(context);
    if (state == null) {
      await Navigator.of(context).maybePop();
      return;
    }
    await state._intentarSalir();
  }

  @override
  State<KivaFormScaffold> createState() => _KivaFormScaffoldState();
}

class _KivaFormScaffoldState extends State<KivaFormScaffold> {
  final _controller = PageController();

  // Campos simples (sin setState): solo se leen al intentar salir.
  bool _tieneCambios = false;
  bool _enviando = false;
  bool _confirmando = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onPaginaCambio);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPaginaCambio);
    _controller.dispose();
    super.dispose();
  }

  void _onPaginaCambio() {
    if ((_controller.page ?? 0) > 0.5) _tieneCambios = true;
  }

  Future<void> _intentarSalir() async {
    if (_confirmando) return;
    if (_enviando) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Espera a que termine el envío del formulario.'),
          ),
        );
      return;
    }
    if (!_tieneCambios) {
      Navigator.of(context).pop();
      return;
    }

    _confirmando = true;
    final salir = await _confirmarSalidaKiva(context);
    _confirmando = false;
    if (salir == true && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final pages = widget.pagesBuilder(_controller);
    assert(
      pages.length == widget.steps.length,
      'KivaFormScaffold: hay ${pages.length} páginas y '
      '${widget.steps.length} pasos.',
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _intentarSalir();
      },
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          child: Column(
            children: [
              FormStepHeaderWidget(
                title: widget.title,
                tag: widget.isRecurrentForm
                    ? 'Kiva · Recurrente'
                    : 'Kiva · Nuevo',
                subtitle: 'Completa las preguntas junto al cliente',
                controller: _controller,
                steps: widget.steps,
                onBack: _intentarSalir,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: pages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pregunta si se sale del formulario Kiva perdiendo lo llenado. Devuelve
/// `true` solo si el asesor elige "Salir sin guardar".
Future<bool?> _confirmarSalidaKiva(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: RedesignColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: RedesignColors.amberTint,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: RedesignColors.amber,
                size: 28,
              ),
            ),
            const Gap(16),
            const Text(
              '¿Salir del formulario?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: RedesignColors.ink,
              ),
            ),
            const Gap(8),
            const Text(
              'Las fotos y respuestas de este formulario Kiva se perderán. '
              'Para conservarlas, termínalo y envíalo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: RedesignColors.inkMuted,
              ),
            ),
            const Gap(22),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: RedesignColors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Seguir llenando'),
              ),
            ),
            const Gap(6),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  foregroundColor: RedesignColors.red,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Salir sin guardar'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Tarjeta de una pregunta: superficie blanca con borde, ancho completo.
class KivaPreguntaCard extends StatelessWidget {
  final Widget child;
  final double? marginTop;
  const KivaPreguntaCard({
    super.key,
    required this.child,
    this.marginTop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: marginTop ?? 0),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RedesignColors.border),
      ),
      child: child,
    );
  }
}

/// Texto de la pregunta dentro de una [KivaPreguntaCard].
class KivaPreguntaTitulo extends StatelessWidget {
  final String text;
  final bool enabled;
  const KivaPreguntaTitulo(this.text, {super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: enabled ? RedesignColors.ink : RedesignColors.chevron,
      ),
    );
  }
}

/// Decoración de los campos de los formularios Kiva.
InputDecoration kivaInputDecoration({
  String? hintText,
  bool readOnly = false,
  bool showCounter = false,
}) {
  OutlineInputBorder borde(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor:
        readOnly ? RedesignColors.tagBackground : RedesignColors.background,
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: RedesignColors.chevron,
    ),
    counter: showCounter ? null : const SizedBox.shrink(),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    border: borde(RedesignColors.border),
    enabledBorder: borde(RedesignColors.border),
    disabledBorder: borde(RedesignColors.border),
    focusedBorder: readOnly
        ? borde(RedesignColors.border)
        : borde(RedesignColors.teal, 1.5),
    errorBorder: borde(RedesignColors.red),
    focusedErrorBorder: borde(RedesignColors.red, 1.5),
    errorStyle: const TextStyle(fontSize: 12, color: RedesignColors.red),
  );
}

/// Selector de una opción con la misma API que [JLuxDropdown].
///
/// Con 2 o 3 opciones cortas (por ejemplo Sí/No) muestra botones para
/// tocar directamente; con más opciones, un dropdown. Ambos son campos del
/// `Form`, así que [validator] funciona igual.
class KivaDropdown<T> extends StatelessWidget {
  final String title;
  final String hintText;
  final T? initialValue;
  final ItemCallback<T> onChanged;
  final StringCallback<T> toStringItem;
  final ValidatorCallback<T> validator;
  final bool isEnabled;
  final bool isLoading;
  final bool isContainIcon;
  final List<T> items;
  const KivaDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    required this.toStringItem,
    required this.hintText,
    this.initialValue,
    this.validator,
    this.isEnabled = true,
    this.isLoading = false,
    this.isContainIcon = true,
  });

  static const _maxOpcionesBotones = 3;
  static const _maxLargoBoton = 16;

  bool get _usaBotones =>
      items.length >= 2 &&
      items.length <= _maxOpcionesBotones &&
      items.every((item) => toStringItem(item).length <= _maxLargoBoton);

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled && items.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KivaPreguntaTitulo(title, enabled: isEnabled),
        const Gap(10),
        if (isLoading)
          const Center(
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: RedesignColors.teal,
              ),
            ),
          )
        else if (_usaBotones)
          _OpcionesField<T>(
            items: items,
            initialValue: initialValue,
            validator: validator,
            enabled: enabled,
            toStringItem: toStringItem,
            onChanged: onChanged,
          )
        else
          _dropdown(enabled),
      ],
    );
  }

  Widget _dropdown(bool enabled) {
    return DropdownButtonFormField<T>(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      isExpanded: true,
      menuMaxHeight: 380,
      borderRadius: BorderRadius.circular(14),
      dropdownColor: RedesignColors.surface,
      validator: validator,
      onChanged: enabled ? onChanged : null,
      decoration: kivaInputDecoration(),
      icon: isContainIcon
          ? const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: RedesignColors.inkMuted,
            )
          : const SizedBox.shrink(),
      hint: _hint(),
      disabledHint: _hint(),
      selectedItemBuilder: (_) => [
        for (final item in items)
          Text(
            toStringItem(item),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: RedesignColors.ink,
            ),
          ),
      ],
      items: [
        for (final item in items)
          DropdownMenuItem<T>(
            value: item,
            child: Text(
              toStringItem(item),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.5,
                color: RedesignColors.ink,
              ),
            ),
          ),
      ],
    );
  }

  Widget _hint() {
    return Text(
      hintText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        color: RedesignColors.chevron,
      ),
    );
  }
}

/// Fila de botones (una opción por botón) que se comporta como un campo del
/// `Form`: valida con [validator] y muestra el error debajo.
class _OpcionesField<T> extends StatelessWidget {
  final List<T> items;
  final T? initialValue;
  final ValidatorCallback<T> validator;
  final bool enabled;
  final StringCallback<T> toStringItem;
  final ItemCallback<T> onChanged;
  const _OpcionesField({
    required this.items,
    required this.initialValue,
    required this.validator,
    required this.enabled,
    required this.toStringItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: initialValue,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  if (i > 0) const Gap(8),
                  Expanded(
                    child: _OpcionBoton(
                      label: toStringItem(items[i]),
                      selected: field.value == items[i],
                      hasError: field.hasError,
                      onTap: enabled
                          ? () {
                              field.didChange(items[i]);
                              onChanged(items[i]);
                            }
                          : null,
                    ),
                  ),
                ],
              ],
            ),
            if (field.hasError) ...[
              const Gap(6),
              Text(
                field.errorText!,
                style: const TextStyle(
                  fontSize: 12,
                  color: RedesignColors.red,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _OpcionBoton extends StatelessWidget {
  final String label;
  final bool selected;
  final bool hasError;
  final VoidCallback? onTap;
  const _OpcionBoton({
    required this.label,
    required this.selected,
    required this.hasError,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borde = selected
        ? RedesignColors.teal
        : hasError
            ? RedesignColors.red
            : RedesignColors.border;

    return Material(
      color: selected ? RedesignColors.tealTint : RedesignColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borde, width: selected ? 1.5 : 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 46,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selected) ...[
                const Icon(
                  Icons.check_rounded,
                  size: 18,
                  color: RedesignColors.teal,
                ),
                const Gap(6),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? RedesignColors.teal
                        : onTap == null
                            ? RedesignColors.chevron
                            : RedesignColors.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Botones "Anterior" / "Siguiente" al pie de cada página, con la misma API
/// que `ButtonActionsWidget`. Con [disabled] en `true` o `null` el botón
/// principal muestra un spinner y no se puede tocar.
class KivaFormNavegacion extends StatelessWidget {
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final String previousTitle;
  final String nextTitle;
  final bool? disabled;
  const KivaFormNavegacion({
    super.key,
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.previousTitle,
    required this.nextTitle,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final cargando = disabled ?? true;
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
                onPressed: onPreviousPressed,
                child: Text(previousTitle),
              ),
            ),
            const Gap(12),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: RedesignColors.teal,
                  disabledBackgroundColor: RedesignColors.tagBackground,
                  shape: shape,
                ),
                onPressed: cargando ? null : onNextPressed,
                child: cargando
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: RedesignColors.teal,
                        ),
                      )
                    : Text(nextTitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
