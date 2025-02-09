import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes-pendientes/solicitudes_pendientes_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/auth/login/login_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_form_spacing.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../datasource/local_db/solicitudes_pendientes.dart';
import '../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';

class KivaFormScreen extends StatefulWidget {
  const KivaFormScreen({super.key});

  @override
  State<KivaFormScreen> createState() => _KivaFormScreenState();
}

class _KivaFormScreenState extends State<KivaFormScreen> {
  @override
  void initState() {
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isCorrectNetwork =
        context.watch<InternetConnectionCubit>().state.isCorrectNetwork;
    if (!isCorrectNetwork) {
      return const VpnNoFound(
        routeIsVpnConnected: '/cartera/formulario-kiva',
      );
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (ctx) => SolicitudesPendientesCubit(
                  SolicitudesPendientesRepositoryImpl(),
                )..getSolicitudesPendientes()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('cartera.title'.tr()),
        ),
        body: BlocConsumer<SolicitudesPendientesCubit,
            SolicitudesPendientesState>(
          listener: (context, state) async {
            final solicitudesProvider =
                context.read<SolicitudesPendientesLocalDbCubit>();
            if (state.status == Status.done) {
              await solicitudesProvider.saveSolicitudesPendientes(
                solicitudes: state.solicitudesPendienteResponse.map(
                  (e) {
                    return SolicitudesPendientes()
                      ..estado = e.estado
                      ..fecha = e.fecha
                      ..moneda = e.moneda
                      ..numero = e.numero
                      ..producto = e.producto
                      ..solicitudId = e.id
                      ..sucursal = LocalStorage().database
                      ..nombre = e.nombre
                      ..monto = double.tryParse(e.monto.toString()) ?? 0.00
                      ..tipoSolicitud = e.tipoSolicitud
                      ..idAsesor = int.tryParse(
                        LocalStorage().userId,
                      )
                      ..motivoAnterior = e.motivoAnterior;
                  },
                ).toList(),
              );
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress =>
                const Center(child: CircularProgressIndicator()),
              Status.error => const Text('Error'),
              Status.done => _KIvaFormContent(
                  solicitudesPendienteResponse:
                      state.solicitudesPendienteResponse,
                ),
              _ => const SizedBox()
            };
          },
        ),
      ),
    );
  }
}

class _KIvaFormContent extends StatefulWidget {
  final List<Solicitud> solicitudesPendienteResponse;
  const _KIvaFormContent({required this.solicitudesPendienteResponse});

  @override
  State<_KIvaFormContent> createState() => _KIvaFormContentState();
}

class _KIvaFormContentState extends State<_KIvaFormContent>
    with WidgetsBindingObserver {
  late List<Solicitud> _filteredSolicitudes;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!mounted) return;
      context.read<SolicitudesPendientesCubit>().getSolicitudesPendientes();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _filteredSolicitudes = List.from(widget.solicitudesPendienteResponse);
    super.initState();
  }

  void _filterSolicitudes(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredSolicitudes = List.from(widget.solicitudesPendienteResponse);

        return;
      }
      _filteredSolicitudes = widget.solicitudesPendienteResponse
          .where((solicitud) =>
              solicitud.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_filteredSolicitudes.isEmpty) {
      return const _OnSolocitudesEmpty();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<SolicitudesPendientesCubit>().getSolicitudesPendientes();
      },
      child: SingleChildScrollView(
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
            const Gap(10),
            BlocBuilder<SolicitudesPendientesLocalDbCubit,
                SolicitudesPendientesLocalDbState>(
              builder: (context, state) {
                return switch (state.status) {
                  Status.inProgress => const LinearProgressIndicator(),
                  _ => const SizedBox(),
                };
              },
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredSolicitudes.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const KivaFormSpacing(),
              itemBuilder: (BuildContext context, int index) {
                return _RequestWidget(
                  solicitud: _filteredSolicitudes[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OnSolocitudesEmpty extends StatelessWidget {
  const _OnSolocitudesEmpty();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wallet_giftcard,
          size: 100,
          color: AppColors.getPrimaryColor(),
        ),
        const Gap(10),
        Center(
          child: Text(
            'No hay solicitudes pendientes',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
      ],
    );
  }
}

class _RequestWidget extends StatefulWidget {
  final Solicitud solicitud;
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
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
    _getNumSolicitud();
    super.initState();
  }

  Future<void> _getNumSolicitud() async {
    final result = await context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getItemsRecurrents(typeProduct: widget.solicitud.producto);

    setState(() {
      isMatching = result.contains(int.tryParse(widget.solicitud.id) ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNetworkConnected =
        context.watch<InternetConnectionCubit>().state.isCorrectNetwork;
    // bool isMatching = numSolicitud == int.tryParse(widget.solicitud.id);

    return ListTile(
      title: Text(
          '${widget.solicitud.id} - ${widget.solicitud.nombre.capitalizeAll}'),
      onTap: () async {
        context.read<InternetConnectionCubit>().getInternetStatusConnection();

        if (!isNetworkConnected) {
          CustomAlertDialog(
            context: context,
            title: 'No estas en el Rango de la VPN',
            onDone: () {
              context.pop();
            },
          ).showDialog(context);
          return;
        }

        context.read<KivaRouteCubit>().setCurrentRouteProduct(
              tipoSolicitud: widget.solicitud.tipoSolicitud,
              route: widget.solicitud.producto,
              solicitudId: widget.solicitud.id,
              nombre: widget.solicitud.nombre,
              motivoAnterior: widget.solicitud.motivoAnterior ??
                  'Motivo Anterior no registrado',
            );
        if (isMatching) {
          context.push('/online/form/offline-confirmation',
              extra: widget.solicitud.id);
          return;
        }

        await context.push('/online', extra: widget.solicitud.producto);
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
