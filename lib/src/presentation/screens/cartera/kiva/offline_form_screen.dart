import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/kiva/kiva_solicitud_model.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_offline/solicitudes_offline_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/kiva_intercerptor/kiva_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/solicitudes_kiva_offline/solicitudes_credito_kiva_offline/solicitudes_credito_kiva_offline_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_lista_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_formulario_kiva/tipo_formulario_kiva_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/// Lista sin conexión de las solicitudes con formulario Kiva
/// (Cartera → Kiva sin conexión).
///
/// Arriba van las solicitudes NI creadas offline sin número (SPEC 09) y
/// debajo las `SolicitudesPendientes` descargadas por `KivaFormScreen`.
class OfflineFormKivaScreen extends StatefulWidget {
  const OfflineFormKivaScreen({super.key});

  @override
  State<OfflineFormKivaScreen> createState() => _OfflineFormKivaScreenState();
}

class _OfflineFormKivaScreenState extends State<OfflineFormKivaScreen> {
  /// SPEC 09: solicitudes creadas offline con producto Kiva y sin número.
  late final SolicitudesOfflineCubit _sinNumeroCubit =
      SolicitudesOfflineCubit(global<ObjectBoxService>());

  @override
  void initState() {
    super.initState();
    context.read<SolicitudesPendientesLocalDbCubit>().getSolicitudes();
    _cargarSinNumero();
  }

  @override
  void dispose() {
    _sinNumeroCubit.close();
    super.dispose();
  }

  Future<void> _cargarSinNumero() {
    final kivaDb = context.read<SolicitudesPendientesLocalDbCubit>();
    return _sinNumeroCubit.getSolicitudesKivaSinNumero(
      tieneKiva: (solicitud) => kivaDb.tieneKivaSinNumero(
        uuid: solicitud.uuid,
        nombreFormularioKiva: solicitud.nombreFormularioKiva,
      ),
    );
  }

  void _onSinNumeroTap(KivaSolicitudModel solicitud) {
    if (solicitud.kivaLlenado) {
      _ofrecerRellenarKiva(solicitud);
      return;
    }
    _abrirKivaSinNumero(solicitud);
  }

  /// SPEC 09: el Kiva ya está llenado. Ofrece borrarlo (con confirmación) y
  /// llenarlo de nuevo.
  Future<void> _ofrecerRellenarKiva(KivaSolicitudModel solicitud) async {
    final rellenar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => _KivaDialog(
        icon: Icons.fact_check_outlined,
        color: RedesignColors.green,
        background: RedesignColors.greenTint,
        titulo: 'Este Kiva ya fue llenado',
        mensaje: 'El formulario Kiva de ${solicitud.nombre.capitalizeAll} se '
            'enviará cuando se sincronice la solicitud.',
        cancelar: 'Cerrar',
        confirmar: 'Eliminar y llenar de nuevo',
        confirmarColor: RedesignColors.red,
      ),
    );
    if (rellenar != true || !mounted) return;

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => const _KivaDialog(
        icon: Icons.delete_outline_rounded,
        color: RedesignColors.red,
        background: RedesignColors.redTint,
        titulo: '¿Eliminar el Kiva llenado?',
        mensaje: 'Se borrarán las respuestas y las imágenes guardadas en el '
            'teléfono. Esta acción no se puede deshacer.',
        cancelar: 'Cancelar',
        confirmar: 'Eliminar',
        confirmarColor: RedesignColors.red,
      ),
    );
    if (confirmado != true || !mounted) return;

    try {
      await context
          .read<SolicitudesPendientesLocalDbCubit>()
          .eliminarKivaSinNumero(
            uuid: solicitud.uuid,
            nombreFormularioKiva: solicitud.nombreFormularioKiva,
          );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo eliminar el Kiva llenado.')),
      );
      return;
    }
    if (!mounted) return;
    await _abrirKivaSinNumero(solicitud.copyWith(kivaLlenado: false));
  }

  /// SPEC 09: abre el formulario Kiva de una solicitud sin número con sus
  /// datos reales y recarga la lista al volver.
  Future<void> _abrirKivaSinNumero(KivaSolicitudModel solicitud) async {
    context.read<KivaRouteCubit>().setCurrentRouteProduct(
          nombreFormularioKiva: solicitud.nombreFormularioKiva,
          cantidadHijos: solicitud.cantidadHijos,
          cedula: solicitud.cedula,
          tipoSolicitud: solicitud.tipoSolicitud,
          route: 'N/A',
          solicitudId: solicitud.uuid,
          nombre: solicitud.nombre,
          numero: '',
          motivoAnterior: 'Motivo Anterior no registrado',
          solicitudCreditoId: solicitud.uuid,
        );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SolicitudesCreditoKivaOfflineInterceptor(
          nombreFormularioKiva: solicitud.nombreFormularioKiva,
        ),
      ),
    );
    if (!mounted) return;
    await _cargarSinNumero();
  }

  @override
  Widget build(BuildContext context) {
    // SPEC 09: sin FAB. Las solicitudes sin número salen arriba en la lista.
    return BlocProvider.value(
      value: _sinNumeroCubit,
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeaderWidget(
                title: 'Kiva sin conexión',
                subtitle: 'Llena el formulario Kiva en el teléfono. Se envía '
                    'cuando vuelvas a tener conexión.',
                onBack: () => Navigator.of(context).maybePop(),
              ),
              const Gap(16),
              Expanded(
                child: BlocBuilder<SolicitudesPendientesLocalDbCubit,
                    SolicitudesPendientesLocalDbState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      Status.done => BlocBuilder<SolicitudesOfflineCubit,
                            SolicitudesOfflineState>(
                          builder: (context, sinNumeroState) {
                            final sinNumero = switch (sinNumeroState) {
                              OnSolicitudesKivaSinNumeroSuccess() =>
                                sinNumeroState.solicitudes,
                              _ => const <KivaSolicitudModel>[],
                            };
                            return KivaOfflineContent(
                              solicitudesPendienteResponse: state.solicitudes,
                              solicitudesSinNumero: sinNumero,
                              onSinNumeroTap: _onSinNumeroTap,
                            );
                          },
                        ),
                      Status.error => KivaListaMensaje(
                          icon: Icons.error_outline_rounded,
                          color: RedesignColors.red,
                          background: RedesignColors.redTint,
                          titulo: 'No pudimos leer las solicitudes',
                          mensaje: 'Ocurrió un error al leer las solicitudes '
                              'guardadas en el teléfono.',
                          accion: 'Reintentar',
                          onAccion: () {
                            context
                                .read<SolicitudesPendientesLocalDbCubit>()
                                .getSolicitudes();
                            _cargarSinNumero();
                          },
                        ),
                      _ => const Center(
                          child: CircularProgressIndicator(
                            color: RedesignColors.teal,
                          ),
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KivaOfflineContent extends StatefulWidget {
  final List<SolicitudesPendientes> solicitudesPendienteResponse;

  /// SPEC 09: solicitudes creadas offline con producto Kiva y sin número.
  final List<KivaSolicitudModel> solicitudesSinNumero;

  /// SPEC 09: tap en una solicitud sin número.
  final ValueChanged<KivaSolicitudModel>? onSinNumeroTap;

  const KivaOfflineContent({
    super.key,
    required this.solicitudesPendienteResponse,
    this.solicitudesSinNumero = const [],
    this.onSinNumeroTap,
  });

  @override
  State<KivaOfflineContent> createState() => _KivaOfflineContentState();
}

class _KivaOfflineContentState extends State<KivaOfflineContent> {
  final _searchController = TextEditingController();
  String _query = '';

  /// Ids con formulario guardado en el teléfono, por `nombreFormulario`.
  /// `null` mientras se consulta: las tarjetas no se pueden tocar hasta
  /// saber si el formulario ya existe.
  Map<String, Set<int>>? _llenados;

  @override
  void initState() {
    super.initState();
    _cargarLlenados();
  }

  @override
  void didUpdateWidget(covariant KivaOfflineContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(
      oldWidget.solicitudesPendienteResponse,
      widget.solicitudesPendienteResponse,
    )) {
      _cargarLlenados();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Una consulta por tipo de formulario, no una por tarjeta.
  Future<void> _cargarLlenados() async {
    final localDb = context.read<SolicitudesPendientesLocalDbCubit>();
    final tipos = widget.solicitudesPendienteResponse
        .map((s) => s.nombreFormulario ?? '')
        .where((tipo) => tipo.isNotEmpty)
        .toSet();
    final llenados = <String, Set<int>>{};
    for (final tipo in tipos) {
      final ids = await localDb.getItemsRecurrents(typeProduct: tipo);
      llenados[tipo] = ids.whereType<int>().toSet();
    }
    if (!mounted) return;
    setState(() => _llenados = llenados);
  }

  bool _estaLlenado(SolicitudesPendientes solicitud) =>
      _llenados?[solicitud.nombreFormulario ?? '']
          ?.contains(int.tryParse(solicitud.solicitudId ?? '') ?? 0) ??
      false;

  bool _coincide(String? nombre, [String? numero, String? cedula]) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return true;
    return [nombre, numero, cedula]
        .any((campo) => (campo ?? '').toLowerCase().contains(query));
  }

  Future<void> _abrir(SolicitudesPendientes solicitud) async {
    final formulario = (solicitud.nombreFormulario ?? '').toFormularioKival();
    if (formulario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se reconoce el formulario Kiva de esta solicitud.'),
        ),
      );
      return;
    }

    if (_estaLlenado(solicitud)) {
      await showDialog<bool>(
        context: context,
        builder: (_) => _KivaDialog(
          icon: Icons.fact_check_outlined,
          color: RedesignColors.amber,
          background: RedesignColors.amberTint,
          titulo: 'Este formulario ya fue creado',
          mensaje: 'El Kiva de ${(solicitud.nombre ?? '').capitalizeAll} está '
              'guardado en el teléfono. Envíalo desde Cartera → Kiva cuando '
              'tengas conexión.',
          cancelar: 'Entendido',
        ),
      );
      return;
    }

    context.read<KivaRouteCubit>().setCurrentRouteProduct(
          nombreFormularioKiva: solicitud.nombreFormulario ?? '',
          cantidadHijos: solicitud.cantidadHijos ?? 0,
          cedula: solicitud.cedula ?? '',
          tipoSolicitud: solicitud.tipoSolicitud ?? 'N/A',
          route: solicitud.producto ?? 'N/A',
          solicitudId: solicitud.solicitudId.toString(),
          nombre: solicitud.nombre ?? 'N/A',
          numero: solicitud.numero ?? 'N/A',
          motivoAnterior:
              solicitud.motivoAnterior ?? 'Motivo Anterior no registrado',
        );

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KivaInterceptor(
          currentRoute: solicitud.producto ?? '',
          solicitudId: solicitud.solicitudId ?? '',
          nombre: solicitud.nombre ?? '',
          tipoSolicitud: solicitud.tipoSolicitud ?? '',
          numero: solicitud.numero ?? '',
          cedula: solicitud.cedula ?? '',
          nombreFormularioKiva: formulario,
          solicitudCreditoId: solicitud.solicitudId ?? '',
          motivoAnterior: solicitud.motivoAnterior ?? '',
          cantidadHijos: solicitud.cantidadHijos ?? 0,
        ),
      ),
    );

    // Al volver, el formulario pudo haberse guardado.
    if (mounted) _cargarLlenados();
  }

  @override
  Widget build(BuildContext context) {
    final sinNumero = widget.solicitudesSinNumero
        .where((s) => _coincide(s.nombre, null, s.cedula))
        .toList();
    final descargadas = widget.solicitudesPendienteResponse
        .where((s) => _coincide(s.nombre, s.numero, s.cedula))
        .toList();
    final total = widget.solicitudesSinNumero.length +
        widget.solicitudesPendienteResponse.length;
    final llenados = widget.solicitudesPendienteResponse
            .where(_estaLlenado)
            .length +
        widget.solicitudesSinNumero.where((s) => s.kivaLlenado).length;

    if (total == 0) {
      return const KivaListaMensaje(
        icon: Icons.cloud_download_outlined,
        color: RedesignColors.inkMuted,
        background: RedesignColors.tagBackground,
        titulo: 'Sin solicitudes Kiva en el teléfono',
        mensaje: 'Entra a Cartera → Kiva con conexión para descargarlas, o '
            'crea una solicitud con producto Kiva sin conexión.',
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: KivaBusquedaField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: _llenados == null
                ? const LinearProgressIndicator(
                    minHeight: 2,
                    color: RedesignColors.teal,
                    backgroundColor: RedesignColors.tealTint,
                  )
                : Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      CardTagWidget(
                        label: '${total - llenados} por llenar',
                        color: RedesignColors.green,
                        background: RedesignColors.greenTint,
                      ),
                      CardTagWidget(
                        label: '$llenados llenados en el teléfono',
                        color: RedesignColors.amber,
                        background: RedesignColors.amberTint,
                      ),
                    ],
                  ),
          ),
        ),
        if (sinNumero.isEmpty && descargadas.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: KivaListaMensaje(
              icon: Icons.search_off_rounded,
              color: RedesignColors.inkMuted,
              background: RedesignColors.tagBackground,
              titulo: 'Sin resultados',
              mensaje: 'Busca por nombre, número de solicitud o cédula.',
            ),
          )
        else ...[
          if (sinNumero.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: KivaSeccionTitulo(
                titulo: 'Sin número',
                cantidad: sinNumero.length,
              ),
            ),
            SliverList.builder(
              itemCount: sinNumero.length,
              itemBuilder: (context, index) {
                final solicitud = sinNumero[index];
                return _SinNumeroKivaCard(
                  key: ValueKey(solicitud.uuid),
                  solicitud: solicitud,
                  onTap: widget.onSinNumeroTap == null
                      ? null
                      : () => widget.onSinNumeroTap!(solicitud),
                );
              },
            ),
          ],
          if (descargadas.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: KivaSeccionTitulo(
                titulo: 'Descargadas',
                cantidad: descargadas.length,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 24),
              sliver: SliverList.builder(
                itemCount: descargadas.length,
                itemBuilder: (context, index) {
                  final solicitud = descargadas[index];
                  return _DescargadaKivaCard(
                    key: ValueKey(solicitud.solicitudId),
                    solicitud: solicitud,
                    llenado: _estaLlenado(solicitud),
                    onTap: _llenados == null ? null : () => _abrir(solicitud),
                  );
                },
              ),
            ),
          ] else
            const SliverToBoxAdapter(child: Gap(24)),
        ],
      ],
    );
  }
}

/// SPEC 09: solicitud creada offline con producto Kiva, sin número.
class _SinNumeroKivaCard extends StatelessWidget {
  final KivaSolicitudModel solicitud;
  final VoidCallback? onTap;

  const _SinNumeroKivaCard({super.key, required this.solicitud, this.onTap});

  @override
  Widget build(BuildContext context) {
    final llenado = solicitud.kivaLlenado;
    final formulario = solicitud.nombreFormularioKiva.toFormularioKival();
    return KivaSolicitudTile(
      icon: llenado ? Icons.fact_check_outlined : Icons.edit_note_rounded,
      color: llenado ? RedesignColors.amber : RedesignColors.green,
      background: llenado ? RedesignColors.amberTint : RedesignColors.greenTint,
      titulo: solicitud.nombre.capitalizeAll,
      subtitulo: solicitud.cedula.isEmpty
          ? 'Creada sin conexión'
          : 'Cédula ${solicitud.cedula} · Creada sin conexión',
      onTap: onTap,
      tags: [
        const CardTagWidget(
          label: 'Sin número',
          color: RedesignColors.indigo,
          background: RedesignColors.indigoTint,
        ),
        CardTagWidget(
          label: llenado ? 'Kiva llenado' : 'Kiva pendiente',
          color: llenado ? RedesignColors.amber : RedesignColors.green,
          background:
              llenado ? RedesignColors.amberTint : RedesignColors.greenTint,
        ),
        if (formulario != null)
          CardTagWidget(
            label: formulario.etiqueta,
            color: RedesignColors.indigo,
            background: RedesignColors.indigoTint,
          ),
        if (formulario?.esRecurrente ?? false)
          const CardTagWidget(
            label: 'Recurrente',
            color: RedesignColors.purple,
            background: RedesignColors.purpleTint,
          ),
      ],
    );
  }
}

/// Solicitud descargada por `KivaFormScreen` (`SolicitudesPendientes`).
class _DescargadaKivaCard extends StatelessWidget {
  final SolicitudesPendientes solicitud;
  final bool llenado;
  final VoidCallback? onTap;

  const _DescargadaKivaCard({
    super.key,
    required this.solicitud,
    required this.llenado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formulario = (solicitud.nombreFormulario ?? '').toFormularioKival();
    final producto = formulario?.etiqueta ?? solicitud.producto ?? '';
    final monto = NumberFormat('#,##0.00', 'en_US').format(solicitud.monto ?? 0);
    final fecha = solicitud.fecha?.formatDateV2() ?? '';
    final estado = (solicitud.estado ?? '').trim();

    return KivaSolicitudTile(
      // Los asesores reconocen el amarillo como "llenado offline".
      icon: llenado ? Icons.fact_check_outlined : Icons.edit_note_rounded,
      color: llenado ? RedesignColors.amber : RedesignColors.green,
      background: llenado ? RedesignColors.amberTint : RedesignColors.greenTint,
      titulo: (solicitud.nombre ?? 'N/A').capitalizeAll,
      subtitulo: [
        'Solicitud N. ${solicitud.numero ?? 'N/A'}',
        if (fecha.isNotEmpty) fecha,
      ].join(' · '),
      onTap: onTap,
      tags: [
        CardTagWidget(
          label: llenado ? 'Llenado en el teléfono' : 'Por llenar',
          color: llenado ? RedesignColors.amber : RedesignColors.green,
          background:
              llenado ? RedesignColors.amberTint : RedesignColors.greenTint,
        ),
        CardTagWidget(
          label: '$monto ${solicitud.moneda ?? ''}'.trim(),
          color: RedesignColors.ink,
          background: RedesignColors.tagBackground,
        ),
        if (producto.isNotEmpty)
          CardTagWidget(
            label: producto,
            color: RedesignColors.indigo,
            background: RedesignColors.indigoTint,
          ),
        if (formulario?.esRecurrente ?? false)
          const CardTagWidget(
            label: 'Recurrente',
            color: RedesignColors.purple,
            background: RedesignColors.purpleTint,
          ),
        if (estado.isNotEmpty)
          CardTagWidget(
            label: estado,
            color: RedesignColors.inkMuted,
            background: RedesignColors.tagBackground,
          ),
      ],
    );
  }
}

/// Diálogo con el estilo del rediseño. Devuelve `true` al confirmar.
class _KivaDialog extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final String titulo;
  final String mensaje;
  final String cancelar;
  final String? confirmar;
  final Color? confirmarColor;

  const _KivaDialog({
    required this.icon,
    required this.color,
    required this.background,
    required this.titulo,
    required this.mensaje,
    required this.cancelar,
    this.confirmar,
    this.confirmarColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: RedesignColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      icon: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color, size: 26),
      ),
      title: Text(
        titulo,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: RedesignColors.ink,
        ),
      ),
      content: Text(
        mensaje,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13.5,
          height: 1.45,
          color: RedesignColors.inkMuted,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(foregroundColor: RedesignColors.inkMuted),
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelar),
        ),
        if (confirmar != null)
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: confirmarColor ?? RedesignColors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmar!),
          ),
      ],
    );
  }
}
