import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_offline/solicitudes_offline_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/kiva_intercerptor/kiva_interceptor.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/kiva/kiva_solicitud_model.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_form_spacing.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_formulario_kiva/tipo_formulario_kiva_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _sinNumeroCubit,
      child: _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    // SPEC 09: sin FAB. Las solicitudes sin número salen arriba en la lista.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes en Tramite (Offline)'),
      ),
      body: BlocBuilder<SolicitudesPendientesLocalDbCubit,
          SolicitudesPendientesLocalDbState>(
        builder: (context, state) {
          return switch (state.status) {
            Status.inProgress =>
              const Center(child: CircularProgressIndicator()),
            Status.done =>
              BlocBuilder<SolicitudesOfflineCubit, SolicitudesOfflineState>(
                builder: (context, sinNumeroState) {
                  final sinNumero = switch (sinNumeroState) {
                    OnSolicitudesKivaSinNumeroSuccess() =>
                      sinNumeroState.solicitudes,
                    _ => const <KivaSolicitudModel>[],
                  };
                  return KivaOfflineContent(
                    solicitudesPendienteResponse: state.solicitudes,
                    solicitudesSinNumero: sinNumero,
                  );
                },
              ),
            Status.error => const Text('Error inesperado'),
            _ => const SizedBox(),
          };
        },
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
  String _query = '';
  late List<SolicitudesPendientes> _filteredSolicitudes;
  late List<KivaSolicitudModel> _filteredSinNumero;

  @override
  void initState() {
    super.initState();
    _applyFilter();
  }

  @override
  void didUpdateWidget(covariant KivaOfflineContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // La lista se recarga al volver del formulario: reaplicar el filtro.
    _applyFilter();
  }

  bool _matches(String? nombre) =>
      _query.isEmpty || (nombre ?? '').toLowerCase().contains(_query);

  void _applyFilter() {
    _filteredSolicitudes = widget.solicitudesPendienteResponse
        .where((solicitud) => _matches(solicitud.nombre))
        .toList();
    _filteredSinNumero = widget.solicitudesSinNumero
        .where((solicitud) => _matches(solicitud.nombre))
        .toList();
  }

  void _filterSolicitudes(String query) {
    setState(() {
      _query = query.trim().toLowerCase();
      _applyFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: SearchBarCustom(
              onItemSelected: (value) {
                if (value == null) return;
                _filterSolicitudes(value);
              },
              onPressed: () {
                _filterSolicitudes('');
              },
            ),
          ),
          if (_filteredSinNumero.isNotEmpty) ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredSinNumero.length,
              separatorBuilder: (_, __) => const KivaFormSpacing(),
              itemBuilder: (_, index) {
                final solicitud = _filteredSinNumero[index];
                return _SinNumeroKivaTile(
                  solicitud: solicitud,
                  onTap: widget.onSinNumeroTap == null
                      ? null
                      : () => widget.onSinNumeroTap!(solicitud),
                );
              },
            ),
            const KivaFormSpacing(),
          ],
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredSolicitudes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const KivaFormSpacing();
            },
            itemBuilder: (BuildContext context, int index) {
              return _RequestWidget(solicitud: _filteredSolicitudes[index]);
            },
          ),
        ],
      ),
    );
  }
}

/// SPEC 09: solicitud creada offline con producto Kiva, sin número.
class _SinNumeroKivaTile extends StatelessWidget {
  final KivaSolicitudModel solicitud;
  final VoidCallback? onTap;

  const _SinNumeroKivaTile({required this.solicitud, this.onTap});

  @override
  Widget build(BuildContext context) {
    final llenado = solicitud.kivaLlenado;
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor:
            llenado ? RedesignColors.greenTint : RedesignColors.amberTint,
        child: Icon(
          Icons.wallet,
          color: llenado ? RedesignColors.green : RedesignColors.amber,
        ),
      ),
      title: Text(solicitud.nombre.capitalizeAll),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            const CardTagWidget(
              label: 'Sin número',
              color: RedesignColors.indigo,
              background: RedesignColors.indigoTint,
            ),
            llenado
                ? const CardTagWidget(
                    label: 'Kiva llenado',
                    color: RedesignColors.green,
                    background: RedesignColors.greenTint,
                  )
                : const CardTagWidget(
                    label: 'Kiva pendiente',
                    color: RedesignColors.amber,
                    background: RedesignColors.amberTint,
                  ),
          ],
        ),
      ),
    );
  }
}

class _RequestWidget extends StatefulWidget {
  final SolicitudesPendientes solicitud;
  const _RequestWidget({
    required this.solicitud,
  });

  @override
  State<_RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<_RequestWidget> {
  int? numSolicitud;
  bool isMatching = false;
  @override
  void initState() {
    super.initState();
    _getNumSolicitud();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getNumSolicitud() async {
    final result = await context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getItemsRecurrents(typeProduct: widget.solicitud.producto ?? '');
    setState(() {
      isMatching = result
          .contains(int.tryParse(widget.solicitud.solicitudId ?? '') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${widget.solicitud.numero} - ${widget.solicitud.nombre!.capitalizeAll}'),
      onTap: () async {
        context.read<KivaRouteCubit>().setCurrentRouteProduct(
              nombreFormularioKiva: widget.solicitud.nombreFormulario ?? '',
              cantidadHijos: widget.solicitud.cantidadHijos ?? 0,
              cedula: widget.solicitud.cedula ?? '',
              tipoSolicitud: widget.solicitud.tipoSolicitud ?? 'N/A',
              route: widget.solicitud.producto ?? 'N/A',
              solicitudId: widget.solicitud.solicitudId.toString(),
              nombre: widget.solicitud.nombre ?? 'N/A',
              numero: widget.solicitud.numero ?? 'N/A',
              motivoAnterior: widget.solicitud.motivoAnterior ??
                  'Motivo Anterior no registrado',
            );
        if (isMatching) {
          CustomAlertDialog(
            context: context,
            title: 'Este Formulario ya a sido creado.',
            onDone: () {
              context.pop();
            },
          ).showDialog(context);
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KivaInterceptor(
              currentRoute: widget.solicitud.producto ?? '',
              solicitudId: widget.solicitud.solicitudId ?? '',
              nombre: widget.solicitud.nombre ?? '',
              tipoSolicitud: widget.solicitud.tipoSolicitud ?? '',
              numero: widget.solicitud.numero ?? '',
              cedula: widget.solicitud.cedula ?? '',
              nombreFormularioKiva:
                  widget.solicitud.nombreFormulario!.toFormularioKival()!,
              solicitudCreditoId: widget.solicitud.solicitudId ?? '',
              motivoAnterior: widget.solicitud.motivoAnterior ?? '',
              cantidadHijos: widget.solicitud.cantidadHijos ?? 0,
            ),
          ),
        );
      },
      subtitle: Text(
        widget.solicitud.fecha?.formatDateV2() ?? '',
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${NumberFormat('#,##0.00', 'en_US').format(widget.solicitud.monto)} ${widget.solicitud.moneda}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const Gap(5),
          Text(widget.solicitud.estado ?? 'N/A'),
        ],
      ),
      leading: CircleAvatar(
        backgroundColor: isMatching ? Colors.yellow : Colors.green,
        child: const Icon(
          Icons.wallet,
        ),
      ),
    );
  }
}
