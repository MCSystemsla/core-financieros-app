import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

/// Easter egg: explorador de solo lectura de los catálogos guardados en la BD
/// local (`CatalogoLocalDb`). Se abre con 7 toques rápidos sobre el nombre
/// del país en el banner del Home (`ExploradorCatalogosTrigger`).
///
/// HN lee `SolicitudesHnBoxService.catalogoLocalBox`; NI y CR leen
/// `ObjectBoxService.catalogoBox`, que es donde guarda cada sync.
class ExploradorCatalogosScreen extends StatefulWidget {
  const ExploradorCatalogosScreen({super.key});

  @override
  State<ExploradorCatalogosScreen> createState() =>
      _ExploradorCatalogosScreenState();
}

class _ExploradorCatalogosScreenState extends State<ExploradorCatalogosScreen> {
  late final Map<String, List<CatalogoLocalDb>> _porCodigo;
  late final List<String> _codigos;
  String? _codigo;
  String _busqueda = '';

  @override
  void initState() {
    super.initState();
    _porCodigo = _cargarCatalogos();
    _codigos = _porCodigo.keys.toList()..sort();
    _codigo = _codigos.isEmpty ? null : _codigos.first;
  }

  static Map<String, List<CatalogoLocalDb>> _cargarCatalogos() {
    final items = switch (global<FlavorCubit>().state.flavor) {
      Flavor.honduras => global<SolicitudesHnBoxService>().catalogoLocalBox,
      _ => global<ObjectBoxService>().catalogoBox,
    }
        .getAll();

    final porCodigo = <String, List<CatalogoLocalDb>>{};
    for (final item in items) {
      porCodigo.putIfAbsent(item.type, () => []).add(item);
    }
    for (final lista in porCodigo.values) {
      lista.sort((a, b) => a.nombre.compareTo(b.nombre));
    }
    return porCodigo;
  }

  List<CatalogoLocalDb> get _valoresFiltrados {
    final valores = _porCodigo[_codigo] ?? const <CatalogoLocalDb>[];
    final q = _busqueda.trim().toLowerCase();
    if (q.isEmpty) return valores;
    return valores
        .where((e) =>
            e.nombre.toLowerCase().contains(q) ||
            e.valor.toLowerCase().contains(q))
        .toList();
  }

  void _copiar(CatalogoLocalDb item) {
    Clipboard.setData(ClipboardData(text: '${item.valor} - ${item.nombre}'));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Copiado al portapapeles')));
  }

  @override
  Widget build(BuildContext context) {
    final valores = _valoresFiltrados;
    final total = _porCodigo[_codigo]?.length ?? 0;

    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeaderWidget(
              title: 'Catálogos',
              subtitle: 'Lo que hay guardado en el teléfono, por código.',
              onBack: () => Navigator.pop(context),
            ),
            const Gap(16),
            if (_codigos.isEmpty)
              const Expanded(
                child: _Mensaje(
                  icono: Icons.inventory_2_outlined,
                  texto: 'No hay catálogos guardados.\n'
                      'Sincroniza los catálogos e inténtalo de nuevo.',
                ),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _codigo,
                      isExpanded: true,
                      dropdownColor: RedesignColors.surface,
                      menuMaxHeight: 420,
                      decoration: _decoracion('Código del catálogo'),
                      items: _codigos
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                '$c (${_porCodigo[c]!.length})',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (c) => setState(() => _codigo = c),
                    ),
                    const Gap(10),
                    TextField(
                      onChanged: (v) => setState(() => _busqueda = v),
                      decoration: _decoracion('Buscar por valor o nombre')
                          .copyWith(
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _busqueda.trim().isEmpty
                            ? '$total valores'
                            : '${valores.length} de $total valores',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Expanded(
                child: valores.isEmpty
                    ? const _Mensaje(
                        icono: Icons.search_off_rounded,
                        texto: 'Ningún valor coincide con la búsqueda.',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                        itemCount: valores.length,
                        separatorBuilder: (_, __) => const Gap(8),
                        itemBuilder: (_, i) => _ValorCard(
                          item: valores[i],
                          onLongPress: () => _copiar(valores[i]),
                        ),
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  InputDecoration _decoracion(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: RedesignColors.surface,
        labelStyle: const TextStyle(color: RedesignColors.inkMuted),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: RedesignColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: RedesignColors.teal),
        ),
      );
}

class _ValorCard extends StatelessWidget {
  final CatalogoLocalDb item;
  final VoidCallback onLongPress;
  const _ValorCard({required this.item, required this.onLongPress});

  List<String> get _extras => [
        if (item.interes != null && item.interes != 0)
          'Interés: ${item.interes}',
        if (item.montoMinimo != null && item.montoMinimo != 0)
          'Mín: ${item.montoMinimo}',
        if (item.montoMaximo != null && item.montoMaximo != 0)
          'Máx: ${item.montoMaximo}',
        if (item.isRecurrente) 'Recurrente',
        if (item.esNuevo) 'Nuevo',
        if (item.isAPNFD) 'APNFD',
      ];

  @override
  Widget build(BuildContext context) {
    final extras = _extras;

    return Material(
      color: RedesignColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: RedesignColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 56),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: RedesignColors.tealTint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.valor.isEmpty ? '—' : item.valor,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.teal,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nombre,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: RedesignColors.ink,
                      ),
                    ),
                    if (extras.isNotEmpty) ...[
                      const Gap(4),
                      Text(
                        extras.join(' · '),
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Mensaje extends StatelessWidget {
  final IconData icono;
  final String texto;
  const _Mensaje({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 40, color: RedesignColors.chevron),
            const Gap(12),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: RedesignColors.inkMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
