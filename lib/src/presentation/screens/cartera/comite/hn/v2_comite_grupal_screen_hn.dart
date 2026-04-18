import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_grupal_edit_shared_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_grupal_user_card_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/header/comite_grupal_header_background.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/comite/comite_calculo_datos/comite_calculo_datos_cubit.dart';
import '../../../../bloc/comite/comite_solicitudes_grupales/comite_solicitudes_grupales_cubit.dart';
import '../../../../bloc/comite/fuentes_financiamientos/fuentes_financiamientos_cubit.dart';
import '../../../../bloc/comite/tipos_credito/tipos_credito_cubit.dart';

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
      ],
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15),
          child: CustomElevatedButton(
            color: Colors.green,
            text: 'Aprobar Actas de grupo',
            onPressed: () {},
          ),
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
            ComiteGrupalUsersOnGrupalWidget(grupoActivoData: grupoActivoData),
          ],
        ),
      ),
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
          Status.done => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ComiteGrupalUserCardWidget(
                  name: state.data[index].nombre,
                  amount: state.data[index].monto.toDouble(),
                  onTap: () {},
                ),
                childCount: state.data.length,
              ),
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
