import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes-pendientes/solicitudes_pendientes_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/kiva_intercerptor/kiva_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/confirmation/confirmation_offline_responses_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_lista_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_formulario_kiva/tipo_formulario_kiva_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../datasource/local_db/solicitudes_pendientes.dart';
import '../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';

/// Lista en línea de las solicitudes con formulario Kiva pendiente
/// (Cartera → Kiva con conexión).
///
/// Cada solicitud se descarga también a `SolicitudesPendientes` (Isar) para
/// la lista sin conexión. Si el formulario ya está guardado en el teléfono,
/// la tarjeta dice "Lista para enviar" y abre
/// `ConfirmationOfflineResponsesScreen`; si no, abre el formulario.
class KivaFormScreen extends StatelessWidget {
  const KivaFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SolicitudesPendientesCubit(
        SolicitudesPendientesRepositoryImpl(),
      )..getSolicitudesPendientes(),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: BlocConsumer<SolicitudesPendientesCubit,
              SolicitudesPendientesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == Status.done,
            listener: (context, state) => _guardarEnTelefono(context, state),
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenHeaderWidget(
                    title: 'Kiva',
                    subtitle:
                        'Solicitudes con formulario Kiva pendiente. Llénalo o '
                        'envía el que ya guardaste en el teléfono.',
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                  const Gap(16),
                  Expanded(
                    child: switch (state.status) {
                      // Al refrescar se mantiene la lista ya cargada (y la
                      // búsqueda) en vez de volver al spinner.
                      Status.done ||
                      Status.inProgress
                          when state.solicitudesPendienteResponse.isNotEmpty ||
                              state.status == Status.done =>
                        _KivaFormContent(
                          solicitudes: state.solicitudesPendienteResponse,
                        ),
                      Status.error => KivaListaMensaje(
                          icon: Icons.cloud_off_rounded,
                          color: RedesignColors.red,
                          background: RedesignColors.redTint,
                          titulo: 'No pudimos cargar las solicitudes',
                          mensaje: state.errorMsg,
                          accion: 'Reintentar',
                          onAccion: () => context
                              .read<SolicitudesPendientesCubit>()
                              .getSolicitudesPendientes(),
                        ),
                      _ => const Center(
                          child: CircularProgressIndicator(
                            color: RedesignColors.teal,
                          ),
                        ),
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _guardarEnTelefono(
    BuildContext context,
    SolicitudesPendientesState state,
  ) {
    return context
        .read<SolicitudesPendientesLocalDbCubit>()
        .saveSolicitudesPendientes(
          solicitudes: state.solicitudesPendienteResponse
              .map(
                (e) => SolicitudesPendientes()
                  ..estado = e.estado
                  ..fecha = e.fecha
                  ..moneda = e.moneda
                  ..numero = e.numero
                  ..producto = e.producto
                  ..nombreFormulario = e.nombreFormulario
                  ..solicitudId = e.id
                  ..cedula = e.cedula
                  ..sucursal = LocalStorage().database
                  ..nombre = e.nombre
                  ..monto = double.tryParse(e.monto.toString()) ?? 0.00
                  ..tipoSolicitud = e.tipoSolicitud
                  ..idAsesor = int.tryParse(LocalStorage().userId)
                  ..motivoAnterior = e.motivoAnterior,
              )
              .toList(),
        );
  }
}

class _KivaFormContent extends StatefulWidget {
  final List<Solicitud> solicitudes;
  const _KivaFormContent({required this.solicitudes});

  @override
  State<_KivaFormContent> createState() => _KivaFormContentState();
}

class _KivaFormContentState extends State<_KivaFormContent> {
  final _searchController = TextEditingController();
  String _query = '';

  /// Ids con formulario guardado en el teléfono, por `nombreFormulario`.
  /// `null` mientras se consulta: las tarjetas no se pueden tocar hasta
  /// saber si abren el formulario o la confirmación.
  Map<String, Set<int>>? _llenados;

  @override
  void initState() {
    super.initState();
    _cargarLlenados();
  }

  @override
  void didUpdateWidget(covariant _KivaFormContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.solicitudes, widget.solicitudes)) {
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
    final tipos = widget.solicitudes.map((s) => s.nombreFormulario).toSet();
    final llenados = <String, Set<int>>{};
    for (final tipo in tipos) {
      final ids = await localDb.getItemsRecurrents(typeProduct: tipo);
      llenados[tipo] = ids.whereType<int>().toSet();
    }
    if (!mounted) return;
    setState(() => _llenados = llenados);
  }

  bool _estaLlenado(Solicitud solicitud) =>
      _llenados?[solicitud.nombreFormulario]
          ?.contains(int.tryParse(solicitud.id) ?? 0) ??
      false;

  List<Solicitud> get _filtradas {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return widget.solicitudes;
    return widget.solicitudes.where((s) {
      return s.nombre.toLowerCase().contains(query) ||
          s.numero.toLowerCase().contains(query) ||
          (s.cedula ?? '').toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _refrescar() {
    return context
        .read<SolicitudesPendientesCubit>()
        .getSolicitudesPendientes();
  }

  Future<void> _abrir(Solicitud solicitud) async {
    final formulario = solicitud.nombreFormulario.toFormularioKival();
    if (formulario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'El formulario "${solicitud.nombreFormulario}" no está disponible '
            'en la app.',
          ),
        ),
      );
      return;
    }

    context.read<KivaRouteCubit>().setCurrentRouteProduct(
          nombreFormularioKiva: solicitud.nombreFormulario,
          cantidadHijos: solicitud.cantidadHijos ?? 0,
          cedula: solicitud.cedula ?? '',
          tipoSolicitud: solicitud.tipoSolicitud,
          route: solicitud.producto,
          solicitudId: solicitud.id,
          nombre: solicitud.nombre,
          numero: solicitud.numero,
          motivoAnterior:
              solicitud.motivoAnterior ?? 'Motivo Anterior no registrado',
        );

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _estaLlenado(solicitud)
            ? ConfirmationOfflineResponsesScreen(
                typeProduct: solicitud.nombreFormulario,
                solicitudId: solicitud.id,
                nombre: solicitud.nombre,
              )
            : KivaInterceptor(
                currentRoute: solicitud.producto,
                solicitudId: solicitud.id,
                nombre: solicitud.nombre,
                tipoSolicitud: solicitud.tipoSolicitud,
                numero: solicitud.numero,
                cedula: solicitud.cedula ?? '',
                nombreFormularioKiva: formulario,
                solicitudCreditoId: solicitud.id,
                motivoAnterior: solicitud.motivoAnterior ?? '',
                cantidadHijos: solicitud.cantidadHijos ?? 0,
              ),
      ),
    );

    // Al volver, el formulario pudo haberse guardado o enviado.
    if (mounted) _cargarLlenados();
  }

  @override
  Widget build(BuildContext context) {
    final filtradas = _filtradas;
    final llenados = widget.solicitudes.where(_estaLlenado).length;
    final porLlenar = widget.solicitudes.length - llenados;

    return RefreshIndicator(
      color: RedesignColors.teal,
      onRefresh: _refrescar,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (widget.solicitudes.isNotEmpty) ...[
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
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
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
                            label: '$porLlenar por llenar',
                            color: RedesignColors.green,
                            background: RedesignColors.greenTint,
                          ),
                          CardTagWidget(
                            label: '$llenados listas para enviar',
                            color: RedesignColors.amber,
                            background: RedesignColors.amberTint,
                          ),
                        ],
                      ),
              ),
            ),
          ],
          if (widget.solicitudes.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: KivaListaMensaje(
                icon: Icons.task_alt_rounded,
                color: RedesignColors.green,
                background: RedesignColors.greenTint,
                titulo: 'Sin formularios Kiva pendientes',
                mensaje: 'Desliza hacia abajo para actualizar.',
              ),
            )
          else if (filtradas.isEmpty)
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
          else
            SliverPadding(
              padding: const EdgeInsets.only(top: 4, bottom: 24),
              sliver: SliverList.builder(
                itemCount: filtradas.length,
                itemBuilder: (context, index) {
                  final solicitud = filtradas[index];
                  return _KivaSolicitudCard(
                    key: ValueKey(solicitud.id),
                    solicitud: solicitud,
                    llenado: _estaLlenado(solicitud),
                    onTap: _llenados == null ? null : () => _abrir(solicitud),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _KivaSolicitudCard extends StatelessWidget {
  final Solicitud solicitud;
  final bool llenado;
  final VoidCallback? onTap;
  const _KivaSolicitudCard({
    super.key,
    required this.solicitud,
    required this.llenado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formulario = solicitud.nombreFormulario.toFormularioKival();
    final producto = formulario?.etiqueta ?? solicitud.producto;
    final monto = solicitud.monto.toString().toCurrencyString();

    return KivaSolicitudTile(
      icon: llenado ? Icons.fact_check_outlined : Icons.edit_note_rounded,
      // Los asesores reconocen el amarillo como "llenado offline".
      color: llenado ? RedesignColors.amber : RedesignColors.green,
      background: llenado ? RedesignColors.amberTint : RedesignColors.greenTint,
      titulo: solicitud.nombre.capitalizeAll,
      subtitulo:
          'Solicitud N. ${solicitud.numero} · ${solicitud.fecha.formatDateV2()}',
      onTap: onTap,
      tags: [
        CardTagWidget(
          label: llenado ? 'Lista para enviar' : 'Por llenar',
          color: llenado ? RedesignColors.amber : RedesignColors.green,
          background:
              llenado ? RedesignColors.amberTint : RedesignColors.greenTint,
        ),
        CardTagWidget(
          label: '$monto ${solicitud.moneda}'.trim(),
          color: RedesignColors.ink,
          background: RedesignColors.tagBackground,
        ),
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
        if (solicitud.estado.trim().isNotEmpty)
          CardTagWidget(
            label: solicitud.estado,
            color: RedesignColors.inkMuted,
            background: RedesignColors.tagBackground,
          ),
      ],
    );
  }
}
