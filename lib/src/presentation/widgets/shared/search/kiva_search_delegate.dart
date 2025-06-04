import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/kiva_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_form_spacing.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class KivaSearchDelegate extends SearchDelegate<Solicitud?> {
  final List<Solicitud> solicitudes;

  KivaSearchDelegate({
    super.searchFieldLabel = 'Buscar solicitud...',
    super.searchFieldStyle =
        const TextStyle(fontSize: 15, color: Colors.black87),
    super.searchFieldDecorationTheme,
    super.keyboardType,
    super.textInputAction,
    super.autocorrect,
    super.enableSuggestions,
    required this.solicitudes,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.black87),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
      TextButton(
        onPressed: () => close(context, null),
        child: const Text(
          'Cancelar',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredSolicitudes = solicitudes
        .where(
          (solicitud) =>
              solicitud.nombre.toLowerCase().contains(query.toLowerCase()) ||
              solicitud.producto.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    if (filteredSolicitudes.isEmpty) {
      return const OnSolocitudesEmpty();
    }
    return ListView.separated(
      separatorBuilder: (context, index) => const KivaFormSpacing(),
      itemCount: filteredSolicitudes.length,
      itemBuilder: (BuildContext context, int index) {
        return _RequestKivaWidget(
          solicitud: filteredSolicitudes[index],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredSolicitudes = solicitudes
        .where(
          (solicitud) =>
              solicitud.nombre.toLowerCase().contains(query.toLowerCase()) ||
              solicitud.producto.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    if (filteredSolicitudes.isEmpty) {
      return const OnSolocitudesEmpty();
    }
    return ListView.separated(
      separatorBuilder: (context, index) => const KivaFormSpacing(),
      itemCount: filteredSolicitudes.length,
      itemBuilder: (BuildContext context, int index) {
        return _RequestKivaWidget(
          solicitud: filteredSolicitudes[index],
        );
      },
    );
  }
}

class _RequestKivaWidget extends StatefulWidget {
  final Solicitud solicitud;
  const _RequestKivaWidget({
    required this.solicitud,
  });

  @override
  State<_RequestKivaWidget> createState() => _RequestKivaWidgetState();
}

class _RequestKivaWidgetState extends State<_RequestKivaWidget> {
  int? numSolicitud;
  bool isMatching = false;
  @override
  void initState() {
    super.initState();
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
    _getNumSolicitud();
  }

  Future<void> _getNumSolicitud() async {
    if (!mounted) return;
    final provider = context.read<SolicitudesPendientesLocalDbCubit>();
    final result = await provider.getItemsRecurrents(
        typeProduct: widget.solicitud.nombreFormulario);
    if (!mounted) return;
    if (!context.mounted) return;
    setState(() {
      isMatching = result.contains(int.tryParse(widget.solicitud.id) ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${widget.solicitud.id} - ${widget.solicitud.nombre.capitalizeAll}'),
      onTap: () async {
        context.read<InternetConnectionCubit>().getInternetStatusConnection();

        context.read<KivaRouteCubit>().setCurrentRouteProduct(
              nombreFormularioKiva: widget.solicitud.nombreFormulario,
              cantidadHijos: widget.solicitud.cantidadHijos ?? 0,
              cedula: widget.solicitud.cedula ?? '',
              tipoSolicitud: widget.solicitud.tipoSolicitud,
              route: widget.solicitud.producto,
              solicitudId: widget.solicitud.id,
              nombre: widget.solicitud.nombre,
              numero: widget.solicitud.numero,
              motivoAnterior: widget.solicitud.motivoAnterior ??
                  'Motivo Anterior no registrado',
            );
        if (isMatching) {
          context.push('/online/form/offline-confirmation',
              extra: widget.solicitud.id);
          return;
        }

        context.pushReplacement(
          '/online',
          extra: widget.solicitud.nombreFormulario,
        );
      },
      subtitle: Text(
        widget.solicitud.fecha.formatDateV2(),
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
          Text(widget.solicitud.estado),
        ],
      ),
      leading: CircleAvatar(
        backgroundColor: isMatching ? Colors.yellow : Colors.green,
        child: const Icon(Icons.wallet),
      ),
    );
  }
}
