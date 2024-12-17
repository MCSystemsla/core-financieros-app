import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_form_spacing.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<SolicitudesPendientesLocalDbCubit>().getSolicitudes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes en Tramite (Offline)'),
      ),
      body: BlocConsumer<SolicitudesPendientesLocalDbCubit,
          SolicitudesPendientesLocalDbState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
              content: Text('Te encuentras en Modo Offline'),
            ),
          );
        },
        builder: (context, state) {
          return switch (state.status) {
            Status.inProgress =>
              const Center(child: CircularProgressIndicator()),
            Status.done => KivaOfflineContent(
                solicitudesPendienteResponse: state.solicitudes,
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

  const KivaOfflineContent({
    super.key,
    required this.solicitudesPendienteResponse,
  });

  @override
  State<KivaOfflineContent> createState() => _KivaOfflineContentState();
}

class _KivaOfflineContentState extends State<KivaOfflineContent> {
  late List<SolicitudesPendientes> _filteredSolicitudes;

  @override
  void initState() {
    super.initState();
    _filteredSolicitudes = List.from(widget.solicitudesPendienteResponse);
  }

  void _filterSolicitudes(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredSolicitudes = List.from(widget.solicitudesPendienteResponse);

        return;
      }
      _filteredSolicitudes = widget.solicitudesPendienteResponse
          .where((solicitud) =>
              solicitud.nombre!.toLowerCase().contains(query.toLowerCase()))
          .toList();
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

class _RequestWidget extends StatefulWidget {
  final SolicitudesPendientes solicitud;
  const _RequestWidget({
    required this.solicitud,
  });

  @override
  State<_RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<_RequestWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${widget.solicitud.numero} - ${widget.solicitud.nombre!.capitalizeAll}'),
      onTap: () async {
        context.read<KivaRouteCubit>().setCurrentRouteProduct(
              route: widget.solicitud.producto ?? 'N/A',
              solicitudId: widget.solicitud.solicitudId.toString(),
              nombre: widget.solicitud.nombre ?? 'N/A',
              motivoAnterior: widget.solicitud.motivoAnterior ??
                  'Motivo Anterior no registrado',
            );
        await context.push('/online', extra: widget.solicitud.producto);
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
      leading: const CircleAvatar(
        child: Icon(Icons.wallet),
      ),
    );
  }
}
