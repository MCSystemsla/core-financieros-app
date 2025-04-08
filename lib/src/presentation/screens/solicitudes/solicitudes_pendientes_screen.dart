// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitud_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_offline/solicitudes_offline_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/solicitudes_pendientes_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SolicitudesPendientesScreen extends StatelessWidget {
  const SolicitudesPendientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesOfflineCubit(
        global<ObjectBoxService>(),
      )
        ..deleteItemByDeterminateDay()
        ..getSolicitudesOffline(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitudes Pendientes'),
        ),
        body: BlocBuilder<SolicitudesOfflineCubit, SolicitudesOfflineState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudesOfflineSuccess() => SolicitudesCreditoView(
                  solicitudesOffline: state.solicitudesOffline,
                ),
              OnSolicitudesOfflineError() => OnErrorWidget(
                  onPressed: () {
                    context
                        .read<SolicitudesOfflineCubit>()
                        .getSolicitudesOffline();
                  },
                  errorMsg: state.errorMsg,
                  needToGoBack: true,
                ),
              OnSolicitudesOfflineLoading() => const SolicitudLoading(),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class SolicitudesCreditoView extends StatelessWidget {
  final List<ResponseLocalDb> solicitudesOffline;

  const SolicitudesCreditoView({super.key, required this.solicitudesOffline});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return PageView(
      controller: controller,
      children: [
        _SolicitudesPendientesItems(
          solicitudesOffline: solicitudesOffline,
          controller: controller,
        ),
        _SolicitudesPendientesItems(
          solicitudesOffline: solicitudesOffline,
          controller: controller,
        ),
      ],
    );
  }
}

class _SolicitudesPendientesItems extends StatelessWidget {
  final PageController controller;
  final List<ResponseLocalDb> solicitudesOffline;
  const _SolicitudesPendientesItems(
      {required this.solicitudesOffline, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (solicitudesOffline.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              height: 170,
              ImageAsset.noDataBg,
            ),
            const Gap(25),
            Text(
              'No hay solicitudes pendientes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        const Gap(15),
        _SlidePageviewView(controller: controller),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: solicitudesOffline.length,
          itemBuilder: (BuildContext context, int index) {
            return SolicitudesPendientesWidget(
              solicitud: solicitudesOffline[index],
            );
          },
        ),
      ],
    );
  }
}

class _SlidePageviewView extends StatelessWidget {
  const _SlidePageviewView({required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            iconSize: 18,
            onPressed: () {
              controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            'Solicitudes Nuevas',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                ),
          ),
        ),
        Expanded(
          child: IconButton(
            iconSize: 18,
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}
