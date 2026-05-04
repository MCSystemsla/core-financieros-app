import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/v2_comite_configuration_grupal/v2_comite_configuration_grupal_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_grupal_integrante_data_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/status_item_card/status_item_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/comite/comite_solicitud/comite_solicitud_cubit.dart';
import '../../../../bloc/comite/comite_solicitudes_grupales/comite_solicitudes_grupales_cubit.dart';
import '../../../../bloc/comite/fuentes_financiamientos/fuentes_financiamientos_cubit.dart';
import '../../../../bloc/comite/tipos_credito/tipos_credito_cubit.dart';
import '../../../../bloc/comite/v2_comite_calculo_datos_grupal/v2_comite_calculo_datos_grupal_cubit.dart';
import '../../../../bloc/comite/v2_comite_solicitudes_grupales/v2_comite_solicitudes_grupales_cubit.dart';

class V2ComiteGrupalIntegranteData extends StatefulWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  final String nombreCliente;
  final int actaId;
  const V2ComiteGrupalIntegranteData({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.nombreCliente,
    required this.actaId,
  });

  @override
  State<V2ComiteGrupalIntegranteData> createState() =>
      _V2ComiteGrupalIntegranteDataState();
}

class _V2ComiteGrupalIntegranteDataState
    extends State<V2ComiteGrupalIntegranteData> {
  int? currentNumeroSolicitud;
  String? currentTipoSolicitud;
  String? currentNombreCliente;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentNumeroSolicitud = widget.numeroSolicitud;
    currentTipoSolicitud = widget.tipoSolicitud;
    currentNombreCliente = widget.nombreCliente;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToIndex(int index) {
    double itemWidth = 160;

    _scrollController.animateTo(
      index * itemWidth,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final repository = ComiteRepositoryHNImpl();
    final listaVerificados =
        context.watch<V2ComiteSolicitudesGrupalesCubit>().state.groupMembers;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ComiteSolicitudCubit(
            repository,
          )..getComiteSolicitud(
              numeroSolicitud: currentNumeroSolicitud ?? 0,
              tipoSolicitud: currentTipoSolicitud ?? '',
            ),
        ),
        BlocProvider(
          create: (ctx) => V2ComiteCalculoDatosGrupalCubit(
            repository,
          ),
        ),
        BlocProvider(
          create: (ctx) => FuentesFinanciamientosCubit(
            repository,
          )..getFuentesFinanciamientos(),
        ),
        BlocProvider(
          create: (ctx) => TiposCreditoCubit(
            repository,
          )..getTiposCredito(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(currentNombreCliente ?? 'Verificar integrantes'),
        ),
        body: Column(
          children: [
            const Gap(20),
            BlocBuilder<ComiteSolicitudesGrupalesCubit,
                ComiteSolicitudesGrupalesState>(
              builder: (context, state) {
                return SizedBox(
                  height: 180,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final item = state.data[index];
                      final bool estaVerificado = listaVerificados.any(
                        (v) => v.numeroSolicitud == int.parse(item.numero),
                      );

                      return StatusItemCard(
                        key: ValueKey('card_${item.id}'),
                        enabled: state.status != Status.inProgress,
                        isSelected:
                            int.parse(item.numero) == currentNumeroSolicitud,
                        item: StatusItem(
                          name: state.data[index].nombre,
                          status: estaVerificado
                              ? StatusComiteGrupalIntegranteEnum.completo
                              : StatusComiteGrupalIntegranteEnum.pendiente,
                          tipoSolicitud: state.data[index].tipoSolicitud,
                          numeroSolicitud: int.parse(item.numero),
                        ),
                        onTap: () {
                          final isSelected =
                              int.parse(item.numero) == currentNumeroSolicitud;
                          if (isSelected) return;
                          _scrollToIndex(index);
                          context
                              .read<ComiteSolicitudCubit>()
                              .getComiteSolicitud(
                                numeroSolicitud: int.parse(item.numero),
                                tipoSolicitud: item.tipoSolicitud,
                              );
                          setState(() {
                            currentNumeroSolicitud = int.parse(item.numero);
                            currentTipoSolicitud = item.tipoSolicitud;
                            currentNombreCliente = item.nombre;
                          });
                        },
                      );
                    },
                  ),
                );
              },
            ),
            const Gap(20),
            BlocBuilder<V2ComiteCalculoDatosGrupalCubit,
                V2ComiteCalculoDatosGrupalState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.all(10),
                child: CustomSwitch(
                  onChanged: (value) {
                    context
                        .read<V2ComiteCalculoDatosGrupalCubit>()
                        .onFieldChanged(
                          () => state.copyWith(
                            sharedIndividuals: value,
                          ),
                        );
                  },
                  title: 'El integrante tiene campos individuales',
                  subtitle: 'Si el integrante tiene campos individuales',
                  value: state.sharedIndividuals,
                ),
              ),
            ),
            const Gap(20),
            Expanded(
              child: BlocBuilder<ComiteSolicitudCubit, ComiteSolicitudState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const ModernLoadingWidget(
                        message: 'Cargando datos de integrante...',
                      ),
                    Status.error => const Text('Error'),
                    Status.done => SingleChildScrollView(
                        child: IntegranteDataForm(
                          data: state.data,
                          tipoSolicitud: currentTipoSolicitud ?? '',
                          numeroSolicitud: currentNumeroSolicitud ?? 0,
                          actaId: widget.actaId,
                        ),
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
