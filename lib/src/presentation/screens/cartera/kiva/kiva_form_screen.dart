import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/comunidades/comunidades_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/departamentos/departamentos_db_local.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/comunidad/comunidad_repository.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comunidades/comunidades_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes-pendientes/solicitudes_pendientes_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_form_spacing.dart';
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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesPendientesCubit(
            SolicitudesPendientesRepositoryImpl(),
          )..getSolicitudesPendientes(),
        ),
        BlocProvider(
          lazy: false,
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          lazy: false,
          create: (ctx) =>
              ComunidadesCubit(ComunidadRepositoryImpl())..getComunidades(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('cartera.title'.tr()),
        ),
        body: BlocConsumer<SolicitudesPendientesCubit,
            SolicitudesPendientesState>(
          listener: (context, state) {
            final comunidadesProvider = context.read<ComunidadesCubit>();
            final solicitudesProvider =
                context.read<SolicitudesPendientesLocalDbCubit>();
            final departments =
                context.read<DepartamentosCubit>().state.departamentos;
            final departmentsList = departments.map(
              (e) {
                return DepartamentosDbLocal()
                  ..nombre = e.nombre
                  ..valor = e.valor;
              },
            ).toList();
            if (state.status == Status.done) {
              solicitudesProvider.saveComunidades(
                  comunidades: comunidadesProvider.state.comunidades.map(
                (e) {
                  return ComunidadesLocalDb()
                    ..nombre = e.nombre
                    ..valor = e.valor;
                },
              ).toList());
              solicitudesProvider.saveDepartaments(
                  departaments: departmentsList);
              solicitudesProvider.saveSolicitudesPendientes(
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

class _KIvaFormContentState extends State<_KIvaFormContent> {
  @override
  void initState() {
    super.initState();
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    solicitudesProvider.getComunidades();
    solicitudesProvider.getDepartamentos();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SolicitudesPendientesCubit>().getSolicitudesPendientes();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<SolicitudesPendientesLocalDbCubit,
                SolicitudesPendientesLocalDbState>(
              listener: (context, state) {
                if (state.status == Status.done) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      showCloseIcon: true,
                      content: Text(
                          'Solicitudes Guardadas Localmente exitosamente!!'),
                    ),
                  );
                }
              },
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
              itemCount: widget.solicitudesPendienteResponse.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const KivaFormSpacing(),
              itemBuilder: (BuildContext context, int index) {
                return _RequestWidget(
                  solicitud: widget.solicitudesPendienteResponse[index],
                );
              },
            ),
          ],
        ),
      ),
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
    // bool isMatching = numSolicitud == int.tryParse(widget.solicitud.id);

    return ListTile(
      title: Text(
          '${widget.solicitud.id} - ${widget.solicitud.nombre.capitalizeAll}'),
      onTap: () async {
        context.read<KivaRouteCubit>().setCurrentRouteProduct(
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
