import 'dart:math' as math;

import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_items.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Selector con buscador de un catálogo local (rediseño 2026).
///
/// Tiene la misma API que `SearchDropdownWidget`, así que para migrar un
/// campo basta con cambiar el nombre de la clase. Úsalo solo en pantallas
/// migradas; las demás siguen con `SearchDropdownWidget`.
///
/// Campo: etiqueta arriba, valor en una caja rellena, borde rojo y mensaje
/// con el error del [validator], candado cuando está deshabilitado. Al
/// tocarlo abre [mostrarSearchDropdownSheet].
class SearchDropdownV2 extends StatefulWidget {
  final String codigo;
  final String title;
  final bool isRequired;
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  final String hintText;
  final bool enabled;
  final Item? selectedItem;

  /// Sin uso: el país se lee de `FlavorCubit`. Se mantiene por
  /// compatibilidad con `SearchDropdownWidget`.
  final Flavor flavor;

  /// Texto cuando el campo está deshabilitado y vacío, por ejemplo
  /// "Elige primero el departamento". Sin él se usa [hintText].
  final String? disabledHintText;

  /// Muestra "Quitar selección" en la hoja; al tocarlo llama a [onChanged]
  /// con `null`. Desactivado por defecto porque muchos `onChanged` no
  /// esperan `null`.
  final bool permitirQuitar;

  final EdgeInsetsGeometry padding;

  const SearchDropdownV2({
    super.key,
    required this.codigo,
    required this.title,
    this.isRequired = false,
    required this.onChanged,
    this.validator,
    this.hintText = 'Selecciona una opción',
    this.enabled = true,
    this.selectedItem,
    this.flavor = Flavor.nicaragua,
    this.disabledHintText,
    this.permitirQuitar = false,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<SearchDropdownV2> createState() => _SearchDropdownV2State();
}

class _SearchDropdownV2State extends State<SearchDropdownV2> {
  final _fieldKey = GlobalKey<FormFieldState<Item>>();
  Item? _seleccionado;

  @override
  void initState() {
    super.initState();
    _seleccionado = widget.selectedItem;
  }

  @override
  void didUpdateWidget(covariant SearchDropdownV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItem != oldWidget.selectedItem) {
      _seleccionado = widget.selectedItem;
    }
  }

  bool get _tieneValor => _seleccionado?.name.isNotEmpty ?? false;

  Future<void> _abrir() async {
    FocusScope.of(context).unfocus();
    final actual = _tieneValor ? _seleccionado : null;

    final resultado = await mostrarSearchDropdownSheet<Item>(
      context: context,
      titulo: widget.title,
      items: itemsDeCatalogo(widget.codigo),
      toStringItem: (item) => item.name,
      esSeleccionado: actual == null
          ? null
          : (item) => actual.value != null
              ? item.value == actual.value
              : item.name == actual.name,
      permitirQuitar: widget.permitirQuitar && actual != null,
    );

    if (resultado == null || !mounted) return;
    setState(() => _seleccionado = resultado.item);
    _fieldKey.currentState?.didChange(resultado.item);
    widget.onChanged(resultado.item);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: FormField<Item>(
        key: _fieldKey,
        initialValue: _seleccionado,
        validator: (_) => widget.validator?.call(_seleccionado),
        builder: (field) => _campo(field.errorText),
      ),
    );
  }

  Widget _campo(String? error) {
    final habilitado = widget.enabled;
    final conError = error != null;

    final texto = _tieneValor
        ? _seleccionado!.name
        : habilitado
            ? widget.hintText
            : widget.disabledHintText ?? widget.hintText;

    final estiloTexto = _tieneValor
        ? TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: habilitado ? RedesignColors.ink : RedesignColors.inkMuted,
          )
        : const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: RedesignColors.inkSubtle,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text.rich(
          TextSpan(
            text: widget.title,
            children: [
              if (widget.isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: habilitado
                        ? RedesignColors.red
                        : RedesignColors.inkSubtle,
                  ),
                ),
            ],
          ),
          style: TextStyle(
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w600,
            color: habilitado ? RedesignColors.ink : RedesignColors.inkSubtle,
          ),
        ),
        const Gap(8),
        Semantics(
          button: true,
          enabled: habilitado,
          label: widget.title,
          child: Material(
            color: !habilitado
                ? RedesignColors.tagBackground
                : conError
                    ? RedesignColors.surface
                    : RedesignColors.background,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: conError ? RedesignColors.red : RedesignColors.border,
                width: conError ? 1.5 : 1,
              ),
            ),
            child: InkWell(
              onTap: habilitado ? _abrir : null,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          texto,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: estiloTexto,
                        ),
                      ),
                      const Gap(10),
                      Icon(
                        habilitado
                            ? Icons.search_rounded
                            : Icons.lock_outline_rounded,
                        size: habilitado ? 20 : 18,
                        color: habilitado
                            ? RedesignColors.inkMuted
                            : RedesignColors.inkSubtle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (conError) ...[
          const Gap(6),
          Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 14,
                color: RedesignColors.red,
              ),
              const Gap(6),
              Expanded(
                child: Text(
                  error,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: RedesignColors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Resultado de [mostrarSearchDropdownSheet]: `item == null` es "Quitar
/// selección". Cerrar la hoja sin elegir devuelve `null` en lugar de un
/// [SearchDropdownSeleccion].
class SearchDropdownSeleccion<T> {
  final T? item;
  const SearchDropdownSeleccion(this.item);
}

/// Hoja inferior del rediseño para elegir una opción de [items].
///
/// Ocupa el 92 % del alto de la pantalla y siempre muestra un buscador que
/// ignora tildes y mayúsculas. Marca en teal la opción para la que
/// [esSeleccionado] devuelve `true`.
/// [textoSinOpciones] se muestra cuando [items] está vacío.
Future<SearchDropdownSeleccion<T>?> mostrarSearchDropdownSheet<T>({
  required BuildContext context,
  required String titulo,
  required List<T> items,
  required String Function(T item) toStringItem,
  bool Function(T item)? esSeleccionado,
  bool permitirQuitar = false,
  String textoSinOpciones =
      'No hay opciones descargadas. Sincroniza los catálogos e intenta de nuevo.',
}) {
  return showModalBottomSheet<SearchDropdownSeleccion<T>>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: RedesignColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _SearchDropdownSheet<T>(
      titulo: titulo,
      items: items,
      toStringItem: toStringItem,
      esSeleccionado: esSeleccionado,
      permitirQuitar: permitirQuitar,
      textoSinOpciones: textoSinOpciones,
    ),
  );
}

class _SearchDropdownSheet<T> extends StatefulWidget {
  final String titulo;
  final List<T> items;
  final String Function(T item) toStringItem;
  final bool Function(T item)? esSeleccionado;
  final bool permitirQuitar;
  final String textoSinOpciones;

  const _SearchDropdownSheet({
    required this.titulo,
    required this.items,
    required this.toStringItem,
    required this.esSeleccionado,
    required this.permitirQuitar,
    required this.textoSinOpciones,
  });

  @override
  State<_SearchDropdownSheet<T>> createState() =>
      _SearchDropdownSheetState<T>();
}

class _SearchDropdownSheetState<T> extends State<_SearchDropdownSheet<T>> {
  /// Fracción del alto de la pantalla que ocupa la hoja.
  static const _fraccionAlto = 0.92;

  final _controller = TextEditingController();
  late final List<String> _nombres = widget.items
      .map((item) => _normalizar(widget.toStringItem(item)))
      .toList();
  String _query = '';

  List<T> get _filtrados {
    if (_query.isEmpty) return widget.items;
    final q = _normalizar(_query);
    return [
      for (var i = 0; i < widget.items.length; i++)
        if (_nombres[i].contains(q)) widget.items[i],
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alto = MediaQuery.sizeOf(context).height * _fraccionAlto;
    final teclado = MediaQuery.viewInsetsOf(context).bottom;
    final filtrados = _filtrados;

    return Padding(
      padding: EdgeInsets.only(bottom: teclado),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: math.min(alto, constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: RedesignColors.border,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                _encabezado(),
                _buscador(),
                Expanded(
                  child:
                      filtrados.isEmpty ? _sinResultados() : _lista(filtrados),
                ),
                _pie(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _encabezado() {
    final total = widget.items.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titulo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
                const Gap(4),
                Text(
                  total == 1 ? '1 opción' : '$total opciones',
                  style: const TextStyle(
                    fontSize: 13,
                    color: RedesignColors.inkMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Cerrar',
            onPressed: () => Navigator.of(context).pop(),
            style: IconButton.styleFrom(
              backgroundColor: RedesignColors.tagBackground,
              fixedSize: const Size(44, 44),
            ),
            icon: const Icon(
              Icons.close_rounded,
              size: 20,
              color: RedesignColors.ink,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buscador() {
    OutlineInputBorder borde(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: width),
        );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: TextField(
        controller: _controller,
        textCapitalization: TextCapitalization.none,
        onChanged: (value) => setState(() => _query = value.trim()),
        style: const TextStyle(fontSize: 15, color: RedesignColors.ink),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: RedesignColors.background,
          hintText: 'Buscar ${widget.titulo.toLowerCase()}',
          hintStyle: const TextStyle(
            fontSize: 15,
            color: RedesignColors.inkSubtle,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 20,
            color: RedesignColors.inkMuted,
          ),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Borrar búsqueda',
                  onPressed: () {
                    _controller.clear();
                    setState(() => _query = '');
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: RedesignColors.inkMuted,
                  ),
                ),
          border: borde(RedesignColors.border),
          enabledBorder: borde(RedesignColors.border),
          focusedBorder: borde(RedesignColors.teal, 1.5),
        ),
      ),
    );
  }

  Widget _lista(List<T> filtrados) {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: filtrados.length,
      separatorBuilder: (_, __) => const Divider(
        height: 9,
        thickness: 1,
        indent: 16,
        endIndent: 16,
        color: RedesignColors.border,
      ),
      itemBuilder: (context, index) {
        final item = filtrados[index];
        final seleccionado = widget.esSeleccionado?.call(item) ?? false;

        return Material(
          color: seleccionado ? RedesignColors.tealTint : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
                Navigator.of(context).pop(SearchDropdownSeleccion<T>(item)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 60),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.toStringItem(item),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              seleccionado ? FontWeight.w700 : FontWeight.w500,
                          color: seleccionado
                              ? RedesignColors.teal
                              : RedesignColors.ink,
                        ),
                      ),
                    ),
                    const Gap(12),
                    seleccionado
                        ? const Icon(
                            Icons.check_rounded,
                            size: 22,
                            color: RedesignColors.teal,
                          )
                        : const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: RedesignColors.chevron,
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sinResultados() {
    final mensaje = _query.isEmpty
        ? widget.textoSinOpciones
        : 'Sin resultados para «$_query»';

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 32,
            color: RedesignColors.inkSubtle,
          ),
          const Gap(10),
          Text(
            mensaje,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: RedesignColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pie(BuildContext context) {
    final inferior = MediaQuery.paddingOf(context).bottom;
    if (!widget.permitirQuitar) return Gap(8 + inferior);

    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + inferior),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: RedesignColors.border)),
      ),
      child: SizedBox(
        height: 48,
        child: OutlinedButton(
          onPressed: () =>
              Navigator.of(context).pop(SearchDropdownSeleccion<T>(null)),
          style: OutlinedButton.styleFrom(
            foregroundColor: RedesignColors.inkMuted,
            side: const BorderSide(color: RedesignColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Quitar selección',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

/// Minúsculas y sin tildes, para que "moraza" encuentre "Morazán".
String _normalizar(String texto) {
  const conTilde = 'áéíóúüñ';
  const sinTilde = 'aeiouun';
  final buffer = StringBuffer();
  for (final letra in texto.toLowerCase().split('')) {
    final i = conTilde.indexOf(letra);
    buffer.write(i >= 0 ? sinTilde[i] : letra);
  }
  return buffer.toString();
}
