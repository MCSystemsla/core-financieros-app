import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/no_images_kivas_on_history/no_images_kivas_on_history_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/confirmation/confirmation_offline_responses_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_lista_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/info_row_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_formulario_kiva/tipo_formulario_kiva_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Lista (rediseño 2026) de las solicitudes Kiva enviadas desde el teléfono,
/// con búsqueda, filtros por estado, tipo de formulario y fecha de envío, y
/// un detalle en hoja inferior para reenviar el formulario o las imágenes.
///
/// Requiere en el árbol [UploadUserFileCubit], [NoImagesKivasOnHistoryCubit],
/// [SolicitudesPendientesLocalDbCubit] y [KivaRouteCubit].
class SolicitudesUploadedWidget extends StatefulWidget {
  final List<SolicitudesPendientes> solicitudes;

  /// Vuelve a leer la lista local sin pasar por el spinner (pull-to-refresh y
  /// al volver del envío del formulario).
  final Future<void> Function() onRecargar;

  const SolicitudesUploadedWidget({
    super.key,
    required this.solicitudes,
    required this.onRecargar,
  });

  @override
  State<SolicitudesUploadedWidget> createState() =>
      _SolicitudesUploadedWidgetState();
}

enum _FiltroEstado {
  todas('Todas'),
  pendientes('Con pendientes'),
  completas('Completas');

  final String etiqueta;
  const _FiltroEstado(this.etiqueta);
}

enum _FiltroFecha {
  siempre('Cualquier fecha', null),
  semana('Últimos 7 días', 7),
  mes('Últimos 30 días', 30);

  final String etiqueta;
  final int? dias;
  const _FiltroFecha(this.etiqueta, this.dias);
}

enum _AccionHistorial { enviarFormulario, enviarImagenes }

/// Nombre del formulario para mostrar y filtrar.
String _etiquetaFormulario(SolicitudesPendientes s) {
  final formulario = (s.nombreFormulario ?? '').toFormularioKival();
  if (formulario != null) return formulario.etiqueta;
  final producto = s.producto?.trim() ?? '';
  return producto.isEmpty ? 'Sin formulario' : producto;
}

bool _esRecurrente(SolicitudesPendientes s) =>
    (s.nombreFormulario ?? '').toFormularioKival()?.esRecurrente ?? false;

DateTime? _fechaEnvio(SolicitudesPendientes s) => s.dateSended ?? s.fecha;

class _SolicitudesUploadedWidgetState extends State<SolicitudesUploadedWidget> {
  final _searchController = TextEditingController();
  String _query = '';
  _FiltroEstado _estado = _FiltroEstado.todas;
  _FiltroFecha _fecha = _FiltroFecha.siempre;

  /// Etiqueta de formulario elegida; `null` = todos.
  String? _tipo;

  /// `solicitudId` de la fila que está enviando imágenes. Solo hay un envío a
  /// la vez: se marca de forma sincrónica antes de buscar las imágenes, cuando
  /// UploadUserFileCubit aún no está inProgress.
  String? _enviandoId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Filtros
  // ---------------------------------------------------------------------------

  List<SolicitudesPendientes> get _ordenadas {
    final lista = [...widget.solicitudes];
    lista.sort((a, b) {
      final fa = _fechaEnvio(a);
      final fb = _fechaEnvio(b);
      if (fa == null && fb == null) return 0;
      if (fa == null) return 1;
      if (fb == null) return -1;
      return fb.compareTo(fa);
    });
    return lista;
  }

  List<String> get _tiposDisponibles {
    final tipos = widget.solicitudes.map(_etiquetaFormulario).toSet().toList()
      ..sort();
    return tipos;
  }

  bool _tienePendientes(SolicitudesPendientes s, Set<String> sinFotos) =>
      s.formSended == false || sinFotos.contains(s.numero);

  List<SolicitudesPendientes> _filtrar(Set<String> sinFotos) {
    final query = _query.trim().toLowerCase();
    final dias = _fecha.dias;
    final desde =
        dias == null ? null : DateTime.now().subtract(Duration(days: dias));

    return _ordenadas.where((s) {
      if (query.isNotEmpty) {
        final coincide = (s.nombre ?? '').toLowerCase().contains(query) ||
            (s.numero ?? '').toLowerCase().contains(query) ||
            (s.cedula ?? '').toLowerCase().contains(query);
        if (!coincide) return false;
      }
      if (_tipo != null && _etiquetaFormulario(s) != _tipo) return false;
      if (desde != null) {
        final fecha = _fechaEnvio(s);
        if (fecha == null || fecha.isBefore(desde)) return false;
      }
      return switch (_estado) {
        _FiltroEstado.todas => true,
        _FiltroEstado.pendientes => _tienePendientes(s, sinFotos),
        _FiltroEstado.completas => !_tienePendientes(s, sinFotos),
      };
    }).toList();
  }

  bool get _hayFiltros =>
      _query.trim().isNotEmpty ||
      _estado != _FiltroEstado.todas ||
      _fecha != _FiltroFecha.siempre ||
      _tipo != null;

  void _limpiarFiltros() {
    _searchController.clear();
    setState(() {
      _query = '';
      _estado = _FiltroEstado.todas;
      _fecha = _FiltroFecha.siempre;
      _tipo = null;
    });
  }

  Future<void> _refrescar() async {
    context.read<NoImagesKivasOnHistoryCubit>().getNoImagesKivasOnHistory();
    await widget.onRecargar();
  }

  // ---------------------------------------------------------------------------
  // Acciones
  // ---------------------------------------------------------------------------

  Future<void> _abrirDetalle(
    SolicitudesPendientes solicitud, {
    required bool imagenesPendientes,
    required bool estadoImagenesConocido,
  }) async {
    final accion = await showModalBottomSheet<_AccionHistorial>(
      context: context,
      isScrollControlled: true,
      backgroundColor: RedesignColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _DetalleSolicitudSheet(
        solicitud: solicitud,
        imagenesPendientes: imagenesPendientes,
        estadoImagenesConocido: estadoImagenesConocido,
        puedeEnviarImagenes: _enviandoId == null,
      ),
    );
    // La acción corre después de cerrar la hoja: la hoja vive fuera del
    // árbol de providers de esta pantalla.
    if (!mounted || accion == null) return;
    switch (accion) {
      case _AccionHistorial.enviarFormulario:
        await _abrirFormulario(solicitud);
      case _AccionHistorial.enviarImagenes:
        await _enviarImagenes(solicitud);
    }
  }

  void _setKivaRoute(SolicitudesPendientes s) {
    context.read<KivaRouteCubit>().setCurrentRouteProduct(
          nombreFormularioKiva: s.nombreFormulario ?? '',
          cantidadHijos: s.cantidadHijos ?? 0,
          cedula: s.cedula ?? '',
          tipoSolicitud: s.tipoSolicitud ?? '0',
          route: s.producto ?? '',
          solicitudId: s.solicitudId ?? '0',
          nombre: s.nombre ?? '',
          numero: s.numero ?? '',
          motivoAnterior: s.motivoAnterior ?? 'Motivo Anterior no registrado',
        );
  }

  Future<void> _abrirFormulario(SolicitudesPendientes s) async {
    _setKivaRoute(s);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmationOfflineResponsesScreen(
          typeProduct: s.nombreFormulario ?? '',
          solicitudId: s.solicitudId ?? '',
          nombre: s.nombre ?? '',
          needGoBack: true,
        ),
      ),
    );
    // Al volver, el formulario pudo haberse enviado (tag "Formulario
    // pendiente").
    if (mounted) await widget.onRecargar();
  }

  void _mostrarAviso(String titulo, {String subtitulo = ''}) {
    CustomAlertDialog(
      context: context,
      title: titulo,
      subtitle: subtitulo,
      onDone: () => context.pop(),
    ).showDialog(context, dialogType: DialogType.warning);
  }

  /// Nombres de las fotos cuya ruta falta o cuyo archivo ya no existe.
  Future<List<String>> _fotosFaltantes(ImageModel imagenes) async {
    final fotos = {
      'Foto 1': imagenes.imagen1,
      'Foto 2': imagenes.imagen2,
      'Foto 3': imagenes.imagen3,
      'Firma': imagenes.imagenFirma,
    };
    final faltantes = <String>[];
    for (final MapEntry(key: nombre, value: ruta) in fotos.entries) {
      if (ruta == null || ruta.isEmpty || !await File(ruta).exists()) {
        faltantes.add(nombre);
      }
    }
    return faltantes;
  }

  Future<void> _enviarImagenes(SolicitudesPendientes s) async {
    // Se marca de inmediato (sincrónico) para bloquear las demás filas.
    if (_enviandoId != null) return;
    setState(() => _enviandoId = s.solicitudId ?? '');

    final localDb = context.read<SolicitudesPendientesLocalDbCubit>();
    final uploadCubit = context.read<UploadUserFileCubit>();
    final noImagesCubit = context.read<NoImagesKivasOnHistoryCubit>();
    final solicitudId = int.tryParse(s.solicitudId ?? '') ?? 0;

    try {
      final imagenes = await localDb.findImagesModel(solicitudId);
      if (!mounted) return;
      if (imagenes == null) {
        _mostrarAviso(
          'Esta solicitud no tiene imágenes guardadas en el teléfono',
        );
        return;
      }

      final faltantes = await _fotosFaltantes(imagenes);
      if (!mounted) return;
      if (faltantes.isNotEmpty) {
        _mostrarAviso(
          'Faltan imágenes en el teléfono',
          subtitulo: 'No se encontraron: ${faltantes.join(', ')}.',
        );
        return;
      }

      final enviadas = await uploadCubit.uploadUserFilesOffline(
        fotoFirma: imagenes.imagenFirma!,
        solicitudId: solicitudId,
        formularioKiva: s.nombreFormulario ?? '',
        tipoSolicitud: s.tipoSolicitud ?? '',
        numero: s.numero ?? '',
        cedula: s.cedula ?? '',
        imagen1: imagenes.imagen1!,
        imagen2: imagenes.imagen2!,
        imagen3: imagenes.imagen3!,
        typeSigner: imagenes.typeSigner ?? '',
      );
      if (enviadas) {
        await localDb.updateIsImagesSendedOnSolicitud(
          solicitudId: s.solicitudId ?? '',
        );
        // Refresca el tag "Faltan fotos".
        noImagesCubit.getNoImagesKivasOnHistory();
      }
    } finally {
      // La fila puede ya no estar montada (salida de la pantalla).
      if (mounted) setState(() => _enviandoId = null);
    }
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadUserFileCubit, UploadUserFileState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Imágenes enviadas exitosamente',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.success);
        }
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: 'Error inesperado, ${state.errorMsg}',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.warning);
        }
      },
      child:
          BlocBuilder<NoImagesKivasOnHistoryCubit, NoImagesKivasOnHistoryState>(
        builder: (context, noImagesState) {
          final estadoImagenesConocido = switch (noImagesState) {
            OnNoImagesKivasOnHistoryHaveRequestPending() ||
            OnNoImagesKivasOnHistoryNoHaveRequestPending() =>
              true,
            _ => false,
          };
          final sinFotos = switch (noImagesState) {
            OnNoImagesKivasOnHistoryHaveRequestPending(:final data) =>
              (data.data ?? [])
                  .map((req) => req.numero)
                  .whereType<String>()
                  .where((numero) => numero.isNotEmpty)
                  .toSet(),
            _ => const <String>{},
          };
          return _buildLista(
            sinFotos: sinFotos,
            estadoImagenesConocido: estadoImagenesConocido,
          );
        },
      ),
    );
  }

  Widget _buildLista({
    required Set<String> sinFotos,
    required bool estadoImagenesConocido,
  }) {
    final todas = widget.solicitudes;
    final filtradas = _filtrar(sinFotos);
    final conFotosPendientes =
        todas.where((s) => sinFotos.contains(s.numero)).length;
    final conFormularioPendiente =
        todas.where((s) => s.formSended == false).length;

    return RefreshIndicator(
      color: RedesignColors.teal,
      onRefresh: _refrescar,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (todas.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: KivaListaMensaje(
                icon: Icons.inbox_rounded,
                color: RedesignColors.teal,
                background: RedesignColors.tealTint,
                titulo: 'Sin solicitudes enviadas',
                mensaje: 'Las solicitudes Kiva que envíes desde este teléfono '
                    'aparecerán aquí. Desliza hacia abajo para actualizar.',
              ),
            )
          else ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: KivaBusquedaField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildFiltros()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 6),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    CardTagWidget(
                      label: '${todas.length} enviadas',
                      color: RedesignColors.ink,
                      background: RedesignColors.tagBackground,
                    ),
                    if (estadoImagenesConocido)
                      CardTagWidget(
                        label: conFotosPendientes == 0
                            ? 'Todas con fotos'
                            : '$conFotosPendientes con fotos pendientes',
                        color: conFotosPendientes == 0
                            ? RedesignColors.green
                            : RedesignColors.red,
                        background: conFotosPendientes == 0
                            ? RedesignColors.greenTint
                            : RedesignColors.redTint,
                      ),
                    if (conFormularioPendiente > 0)
                      CardTagWidget(
                        label: '$conFormularioPendiente con formulario '
                            'pendiente',
                        color: RedesignColors.amber,
                        background: RedesignColors.amberTint,
                      ),
                  ],
                ),
              ),
            ),
            if (filtradas.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: KivaListaMensaje(
                  icon: Icons.search_off_rounded,
                  color: RedesignColors.inkMuted,
                  background: RedesignColors.tagBackground,
                  titulo: 'Sin resultados',
                  mensaje: 'Ninguna solicitud coincide con la búsqueda o los '
                      'filtros.',
                  accion: _hayFiltros ? 'Limpiar filtros' : null,
                  onAccion: _limpiarFiltros,
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.only(top: 4, bottom: 24),
                sliver: SliverList.builder(
                  itemCount: filtradas.length,
                  itemBuilder: (context, index) {
                    final solicitud = filtradas[index];
                    final imagenesPendientes =
                        sinFotos.contains(solicitud.numero);
                    return _SolicitudEnviadaCard(
                      key: ValueKey(solicitud.id),
                      solicitud: solicitud,
                      imagenesPendientes: imagenesPendientes,
                      estadoImagenesConocido: estadoImagenesConocido,
                      enviando: _enviandoId != null &&
                          _enviandoId == (solicitud.solicitudId ?? ''),
                      onTap: () => _abrirDetalle(
                        solicitud,
                        imagenesPendientes: imagenesPendientes,
                        estadoImagenesConocido: estadoImagenesConocido,
                      ),
                    );
                  },
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildFiltros() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          for (final estado in _FiltroEstado.values) ...[
            _FiltroChip(
              label: estado.etiqueta,
              seleccionado: _estado == estado,
              onTap: () => setState(() => _estado = estado),
            ),
            const Gap(6),
          ],
          const Gap(4),
          _MenuChip<String?>(
            label: _tipo ?? 'Tipo de formulario',
            activo: _tipo != null,
            valorActual: _tipo,
            opciones: [
              const _OpcionMenu(valor: null, etiqueta: 'Todos los formularios'),
              for (final tipo in _tiposDisponibles)
                _OpcionMenu(valor: tipo, etiqueta: tipo),
            ],
            onSeleccion: (tipo) => setState(() => _tipo = tipo),
          ),
          const Gap(6),
          _MenuChip<_FiltroFecha>(
            label: _fecha == _FiltroFecha.siempre ? 'Fecha' : _fecha.etiqueta,
            activo: _fecha != _FiltroFecha.siempre,
            valorActual: _fecha,
            opciones: [
              for (final fecha in _FiltroFecha.values)
                _OpcionMenu(valor: fecha, etiqueta: fecha.etiqueta),
            ],
            onSeleccion: (fecha) => setState(() => _fecha = fecha),
          ),
        ],
      ),
    );
  }
}

class _SolicitudEnviadaCard extends StatelessWidget {
  final SolicitudesPendientes solicitud;
  final bool imagenesPendientes;
  final bool estadoImagenesConocido;
  final bool enviando;
  final VoidCallback onTap;

  const _SolicitudEnviadaCard({
    super.key,
    required this.solicitud,
    required this.imagenesPendientes,
    required this.estadoImagenesConocido,
    required this.enviando,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formularioPendiente = solicitud.formSended == false;
    final pendiente = formularioPendiente || imagenesPendientes;
    final fecha = _fechaEnvio(solicitud);
    final numero = solicitud.numero ?? '—';

    final (icon, color, background) = switch ((enviando, pendiente)) {
      (true, _) => (
          Icons.cloud_upload_outlined,
          RedesignColors.teal,
          RedesignColors.tealTint,
        ),
      (_, true) => (
          Icons.error_outline_rounded,
          RedesignColors.red,
          RedesignColors.redTint,
        ),
      _ => (
          Icons.task_alt_rounded,
          RedesignColors.green,
          RedesignColors.greenTint,
        ),
    };

    return KivaSolicitudTile(
      icon: icon,
      color: color,
      background: background,
      titulo: (solicitud.nombre ?? 'Sin nombre').capitalizeAll,
      subtitulo: fecha == null
          ? 'Solicitud N. $numero'
          : 'Solicitud N. $numero · Enviada ${fecha.formatDateV2()}',
      onTap: onTap,
      tags: [
        if (enviando)
          const CardTagWidget(
            label: 'Enviando imágenes…',
            color: RedesignColors.teal,
            background: RedesignColors.tealTint,
          ),
        if (formularioPendiente)
          const CardTagWidget(
            label: 'Formulario pendiente',
            color: RedesignColors.amber,
            background: RedesignColors.amberTint,
          ),
        if (imagenesPendientes && !enviando)
          const CardTagWidget(
            label: 'Faltan fotos',
            color: RedesignColors.red,
            background: RedesignColors.redTint,
          ),
        if (!pendiente && estadoImagenesConocido && !enviando)
          const CardTagWidget(
            label: 'Completa',
            color: RedesignColors.green,
            background: RedesignColors.greenTint,
          ),
        CardTagWidget(
          label: _etiquetaFormulario(solicitud),
          color: RedesignColors.indigo,
          background: RedesignColors.indigoTint,
        ),
        if (_esRecurrente(solicitud))
          const CardTagWidget(
            label: 'Recurrente',
            color: RedesignColors.purple,
            background: RedesignColors.purpleTint,
          ),
      ],
    );
  }
}

/// Detalle de una solicitud enviada. Devuelve la acción elegida al cerrarse.
class _DetalleSolicitudSheet extends StatelessWidget {
  final SolicitudesPendientes solicitud;
  final bool imagenesPendientes;
  final bool estadoImagenesConocido;
  final bool puedeEnviarImagenes;

  const _DetalleSolicitudSheet({
    required this.solicitud,
    required this.imagenesPendientes,
    required this.estadoImagenesConocido,
    required this.puedeEnviarImagenes,
  });

  @override
  Widget build(BuildContext context) {
    // Con el formulario ya aceptado por el backend no se ofrece reenviarlo
    // (evita duplicados). null = fila anterior a formSended: como antes.
    final formularioEnviado = solicitud.formSended == true;
    final fecha = _fechaEnvio(solicitud);
    final alto = MediaQuery.sizeOf(context).height * 0.85;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: alto),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: RedesignColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Gap(18),
              Text(
                (solicitud.nombre ?? 'Sin nombre').capitalizeAll,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  color: RedesignColors.ink,
                ),
              ),
              const Gap(4),
              Text(
                'Solicitud N. ${solicitud.numero ?? '—'}',
                style: const TextStyle(
                  fontSize: 13,
                  color: RedesignColors.inkMuted,
                ),
              ),
              const Gap(16),
              _EstadoPaso(
                titulo: 'Formulario Kiva',
                listo: formularioEnviado,
                textoListo: 'Enviado',
                textoPendiente: solicitud.formSended == false
                    ? 'Pendiente de envío'
                    : 'Sin confirmar',
              ),
              const Gap(8),
              _EstadoPaso(
                titulo: 'Fotos y firma',
                listo: estadoImagenesConocido && !imagenesPendientes,
                textoListo: 'Recibidas',
                textoPendiente: estadoImagenesConocido
                    ? 'Faltan en el sistema'
                    : 'Sin confirmar',
              ),
              const Gap(16),
              InfoRowWidget(
                icon: Icons.description_outlined,
                color: RedesignColors.indigo,
                background: RedesignColors.indigoTint,
                label: 'Formulario',
                value: _etiquetaFormulario(solicitud) +
                    (_esRecurrente(solicitud) ? ' · Recurrente' : ''),
              ),
              const Gap(8),
              InfoRowWidget(
                icon: Icons.badge_outlined,
                color: RedesignColors.teal,
                background: RedesignColors.tealTint,
                label: 'Cédula',
                value: solicitud.cedula ?? '',
              ),
              const Gap(8),
              InfoRowWidget(
                icon: Icons.category_outlined,
                color: RedesignColors.purple,
                background: RedesignColors.purpleTint,
                label: 'Producto · Tipo de solicitud',
                value: [solicitud.producto, solicitud.tipoSolicitud]
                    .whereType<String>()
                    .where((v) => v.trim().isNotEmpty)
                    .join(' · '),
              ),
              const Gap(8),
              InfoRowWidget(
                icon: Icons.event_outlined,
                color: RedesignColors.amber,
                background: RedesignColors.amberTint,
                label: 'Fecha de envío',
                value: fecha?.formatDateV2() ?? '',
              ),
              const Gap(8),
              InfoRowWidget(
                icon: Icons.tag_rounded,
                color: RedesignColors.inkMuted,
                background: RedesignColors.tagBackground,
                label: 'Solicitud ID',
                value: solicitud.solicitudId ?? '',
              ),
              const Gap(20),
              if (!formularioEnviado) ...[
                _BotonAccion(
                  label: 'Enviar formulario Kiva',
                  icon: Icons.send_rounded,
                  principal: true,
                  onPressed: () => Navigator.of(context)
                      .pop(_AccionHistorial.enviarFormulario),
                ),
                const Gap(10),
              ],
              _BotonAccion(
                label: puedeEnviarImagenes
                    ? 'Enviar imágenes Kiva'
                    : 'Hay un envío de imágenes en curso',
                icon: Icons.photo_library_outlined,
                principal: formularioEnviado || imagenesPendientes,
                onPressed: puedeEnviarImagenes
                    ? () => Navigator.of(context)
                        .pop(_AccionHistorial.enviarImagenes)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EstadoPaso extends StatelessWidget {
  final String titulo;
  final bool listo;
  final String textoListo;
  final String textoPendiente;

  const _EstadoPaso({
    required this.titulo,
    required this.listo,
    required this.textoListo,
    required this.textoPendiente,
  });

  @override
  Widget build(BuildContext context) {
    final color = listo ? RedesignColors.green : RedesignColors.amber;
    final background =
        listo ? RedesignColors.greenTint : RedesignColors.amberTint;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: RedesignColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            listo ? Icons.check_circle_rounded : Icons.schedule_rounded,
            color: color,
            size: 20,
          ),
          const Gap(10),
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: RedesignColors.ink,
              ),
            ),
          ),
          CardTagWidget(
            label: listo ? textoListo : textoPendiente,
            color: color,
            background: background,
          ),
        ],
      ),
    );
  }
}

class _BotonAccion extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool principal;
  final VoidCallback? onPressed;

  const _BotonAccion({
    required this.label,
    required this.icon,
    required this.principal,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    const padding = EdgeInsets.symmetric(vertical: 14);
    return SizedBox(
      width: double.infinity,
      child: principal
          ? FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: RedesignColors.teal,
                padding: padding,
                shape: shape,
              ),
              onPressed: onPressed,
              icon: Icon(icon, size: 18),
              label: Text(label),
            )
          : OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: RedesignColors.teal,
                side: const BorderSide(color: RedesignColors.border),
                padding: padding,
                shape: shape,
              ),
              onPressed: onPressed,
              icon: Icon(icon, size: 18),
              label: Text(label),
            ),
    );
  }
}

class _FiltroChip extends StatelessWidget {
  final String label;
  final bool seleccionado;
  final VoidCallback onTap;

  const _FiltroChip({
    required this.label,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: seleccionado ? RedesignColors.teal : RedesignColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: seleccionado ? RedesignColors.teal : RedesignColors.border,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: seleccionado ? Colors.white : RedesignColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _OpcionMenu<T> {
  final T valor;
  final String etiqueta;
  const _OpcionMenu({required this.valor, required this.etiqueta});
}

/// Chip con menú desplegable (tipo de formulario, fecha).
class _MenuChip<T> extends StatelessWidget {
  final String label;
  final bool activo;
  final T valorActual;
  final List<_OpcionMenu<T>> opciones;
  final ValueChanged<T> onSeleccion;

  const _MenuChip({
    required this.label,
    required this.activo,
    required this.valorActual,
    required this.opciones,
    required this.onSeleccion,
  });

  @override
  Widget build(BuildContext context) {
    final color = activo ? RedesignColors.teal : RedesignColors.ink;
    return PopupMenuButton<int>(
      tooltip: '',
      color: RedesignColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      position: PopupMenuPosition.under,
      // Se usa el índice como valor: `PopupMenuButton` no llama a
      // `onSelected` cuando el valor elegido es `null` ("Todos").
      onSelected: (index) => onSeleccion(opciones[index].valor),
      itemBuilder: (_) => [
        for (final (index, opcion) in opciones.indexed)
          PopupMenuItem<int>(
            value: index,
            child: Row(
              children: [
                Expanded(child: Text(opcion.etiqueta)),
                if (opcion.valor == valorActual)
                  const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: RedesignColors.teal,
                  ),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 8, 10, 8),
        decoration: BoxDecoration(
          color: activo ? RedesignColors.tealTint : RedesignColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: activo ? RedesignColors.teal : RedesignColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const Gap(2),
            Icon(Icons.expand_more_rounded, size: 18, color: color),
          ],
        ),
      ),
    );
  }
}
