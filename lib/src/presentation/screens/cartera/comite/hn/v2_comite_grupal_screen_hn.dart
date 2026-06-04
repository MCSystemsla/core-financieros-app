import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/comite/hn/v2_comite_grupal_integrante_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_grupal_edit_shared_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_grupal_user_card_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/header/comite_grupal_header_background.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/comite/comite_approved_success_transaction_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../bloc/comite/comite_calculo_datos/comite_calculo_datos_cubit.dart';
import '../../../../bloc/comite/comite_solicitudes_grupales/comite_solicitudes_grupales_cubit.dart';
import '../../../../bloc/comite/fuentes_financiamientos/fuentes_financiamientos_cubit.dart';
import '../../../../bloc/comite/tipos_credito/tipos_credito_cubit.dart';
import '../../../../bloc/comite/v2_comite_configuration_grupal/v2_comite_configuration_grupal_cubit.dart';
import '../../../../bloc/comite/v2_comite_solicitudes_grupales/v2_comite_solicitudes_grupales_cubit.dart';

class V2ComiteGrupalScreenHn extends StatelessWidget {
  final GrupoActivoData grupoActivoData;

  const V2ComiteGrupalScreenHn({
    super.key,
    required this.grupoActivoData,
  });

  @override
  Widget build(BuildContext context) {
    final repository = ComiteRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ComiteSolicitudesGrupalesCubit(repository)
            ..getSolicitudesGrupalesOnComite(
              grupoId: grupoActivoData.id,
            ),
        ),
        BlocProvider(
          create: (ctx) => ComiteCalculoDatosCubit(
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
        BlocProvider(
          create: (ctx) => V2ComiteSolicitudesGrupalesCubit(
            repository,
          ),
        ),
        BlocProvider(
          create: (ctx) => V2ComiteConfigurationGrupalCubit(
            repository,
          ),
        ),
      ],
      child: BlocConsumer<ComiteSolicitudesGrupalesCubit,
          ComiteSolicitudesGrupalesState>(
        listener: (context, state) {
          if (state.status == Status.done && state.data.isNotEmpty) {
            context
                .read<V2ComiteConfigurationGrupalCubit>()
                .getConfigurationGrupal(
                  cicloGrupoId: state.data.first.cicloGrupoId,
                );
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _ApprovedActasGrupal(
              grupoID: grupoActivoData.id,
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: const Text(
                    'Comité Grupal',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  expandedHeight: 170,
                  pinned: true,
                  flexibleSpace: ComiteGrupalHeaderBackground(
                    child: ComiteGrupalHeaderContent(
                      grupoActivoData: grupoActivoData,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Gap(20)),
                const SliverToBoxAdapter(child: ComiteGrupalEditSharedData()),
                const SliverToBoxAdapter(child: Gap(10)),
                ComiteGrupalUsersOnGrupalWidget(
                  grupoActivoData: grupoActivoData,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ApprovedActasGrupal extends StatelessWidget {
  final int grupoID;
  const _ApprovedActasGrupal({
    required this.grupoID,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<V2ComiteSolicitudesGrupalesCubit,
        V2ComiteSolicitudesGrupalesState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.inProgress) {
          context.showLoading(message: 'Aprobando actas...');
        }

        if (state.status == Status.done) {
          context.hideLoading();
          context.pushTransparentRoute(
            ComiteApprovedSuccessTransactionCard(
              monto: state.groupMembers.fold(
                0.00,
                (sum, element) => sum + element.modificaActa.monto,
              ),
              mensajeExito: state.successMsg,
              responsables: state.responsables,
            ),
            backgroundColor: const Color(0xffF1F1F1),
          );
        }
        if (state.status == Status.error) {
          context.hideLoading();
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context);
        }
      },
      builder: (context, state) {
        if (state.groupMembers.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.all(15),
          child: CustomElevatedButton(
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            color: Colors.green,
            enabled: state.status != Status.inProgress,
            text: state.status == Status.inProgress
                ? 'Aprobando actas...'
                : 'Aprobar Actas de grupo',
            onPressed: () {
              context
                  .read<V2ComiteSolicitudesGrupalesCubit>()
                  .aprobarActasGrupal(
                    grupoID: grupoID,
                  );
            },
          ),
        );
      },
    );
  }
}

class ComiteGrupalUsersOnGrupalWidget extends StatelessWidget {
  final GrupoActivoData grupoActivoData;

  const ComiteGrupalUsersOnGrupalWidget({
    super.key,
    required this.grupoActivoData,
  });

  @override
  Widget build(BuildContext context) {
    final listaVerificados =
        context.watch<V2ComiteSolicitudesGrupalesCubit>().state.groupMembers;
    return BlocBuilder<ComiteSolicitudesGrupalesCubit,
        ComiteSolicitudesGrupalesState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const SliverFillRemaining(
              child: Center(
                child: ModernLoadingWidget(
                  message: 'Cargando actas de integrantes...',
                ),
              ),
            ),
          Status.error => SliverFillRemaining(
              child: OnErrorWidget(
                errorMsg: state.errorMsg,
                onPressed: () {
                  context
                      .read<ComiteSolicitudesGrupalesCubit>()
                      .getSolicitudesGrupalesOnComite(
                        grupoId: grupoActivoData.id,
                      );
                },
              ),
            ),
          Status.done when state.data.isEmpty => const SliverFillRemaining(
              child: EmptyListWidget(
                message: 'No hay actas de integrantes',
              ),
            ),
          Status.done => SliverPadding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 10,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = state.data[index];
                    final bool estaVerificado = listaVerificados.any(
                      (v) => v.numeroSolicitud == int.parse(item.numero),
                    );
                    return ComiteGrupalUserCardWidget(
                      isVerified: estaVerificado,
                      name: state.data[index].nombre,
                      amount: state.data[index].monto.toDouble(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: context
                                      .read<V2ComiteSolicitudesGrupalesCubit>(),
                                ),
                                BlocProvider.value(
                                  value: context
                                      .read<V2ComiteConfigurationGrupalCubit>(),
                                ),
                                BlocProvider.value(
                                  value: context
                                      .read<ComiteSolicitudesGrupalesCubit>(),
                                ),
                              ],
                              child: V2ComiteGrupalIntegranteData(
                                key: ValueKey(state.data[index].id),
                                numeroSolicitud:
                                    int.parse(state.data[index].numero),
                                tipoSolicitud: state.data[index].tipoSolicitud,
                                nombreCliente: state.data[index].nombre,
                                actaId: state.data[index].id,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: state.data.length,
                ),
              ),
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
