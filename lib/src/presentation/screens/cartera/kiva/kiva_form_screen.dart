import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/departamentos/departamentos_db_local.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
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
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('cartera.title'.tr()),
        ),
        body: BlocConsumer<SolicitudesPendientesCubit,
            SolicitudesPendientesState>(
          listener: (context, state) {
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
                      ..idAsesor = int.tryParse(LocalStorage().userId);
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
    context.read<SolicitudesPendientesLocalDbCubit>().getDepartamentos();
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

class _RequestWidget extends StatelessWidget {
  final Solicitud solicitud;
  const _RequestWidget({
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${solicitud.numero} - ${solicitud.nombre.capitalizeAll}'),
      onTap: () async {
        context.read<KivaRouteCubit>().setCurrentRouteProduct(
              route: solicitud.producto,
              solicitudId: solicitud.id,
              nombre: solicitud.nombre,
            );
        await context.push('/online', extra: solicitud.producto);
      },
      subtitle: Text(
        solicitud.fecha.formatDateV2(),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${NumberFormat('#,##0.00', 'en_US').format(solicitud.monto)} ${solicitud.moneda}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const Gap(5),
          Text(solicitud.estado),
        ],
      ),
      leading: const CircleAvatar(
        child: Icon(Icons.wallet),
      ),
    );
  }
}
