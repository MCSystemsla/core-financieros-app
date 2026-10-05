import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_anular_garantia/analisis_anular_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_garantia/fiadores_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/v2_actualizar_garantia_detalle_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/v2_crear_garantia_detalle_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/crear_garantia_moda_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/garantia_item_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/garantia_options_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_garantia/tipo_garantia_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CrearGarantiaScreen extends StatelessWidget {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final String cedulaCliente;
  const CrearGarantiaScreen({
    super.key,
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.cedulaCliente,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RedesignColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<AnalisisGarantiaCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<AnalisisArticuloCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<FiadoresGarantiaCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<AnalisisAnularGarantiaCubit>(),
                ),
              ],
              child: CreateGarantiaModalSheet(
                numeroSolicitud: numeroSolicitud,
                solicitudCodigo: solicitudCodigo,
                cedulaCliente: cedulaCliente,
              ),
            ),
          );
        },
        backgroundColor: RedesignColors.ink,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Crear Garantía',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeaderWidget(
              title: 'Garantías',
              subtitle:
                  'Solicitud #$numeroSolicitud. Asigna un bien a cada garantía pendiente.',
              onBack: () => Navigator.pop(context),
            ),
            const Gap(8),
            Expanded(
              child: _AnularGarantiaHandler(
                numeroSolicitud: numeroSolicitud,
                child:
                    BlocBuilder<AnalisisGarantiaCubit, AnalisisGarantiaState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      Status.inProgress => const ModernLoadingWidget(),
                      Status.error => Text('Error: //${state.errorMsg}'),
                      Status.done => _ListItems(
                          analisisGarantia: state.analisisGarantia,
                        ),
                      _ => const SizedBox.shrink(),
                    };
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnularGarantiaHandler extends StatelessWidget {
  final int numeroSolicitud;
  final Widget child;
  const _AnularGarantiaHandler({
    required this.numeroSolicitud,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnalisisAnularGarantiaCubit,
        AnalisisAnularGarantiaState>(
      listener: (context, state) {
        if (state.status == Status.inProgress) {
          context.showLoading(message: 'Anulando Garantia...');
        }
        if (state.status == Status.done) {
          context.hideLoading();
          showV2CustomSnackbar(
            context,
            title: 'Garantía anulada exitosamente',
            type: SnackbarType.success,
          );
          context.read<AnalisisGarantiaCubit>().getGarantiasByNumero(
                numeroSolicitud: numeroSolicitud,
              );
        }
        if (state.status == Status.error) {
          context.hideLoading();
          showV2CustomSnackbar(
            context,
            title: state.errorMsg,
            type: SnackbarType.error,
          );
        }
      },
      child: child,
    );
  }
}

class _ListItems extends StatelessWidget {
  final List<GarantiaData> analisisGarantia;
  const _ListItems({
    required this.analisisGarantia,
  });
  @override
  Widget build(BuildContext context) {
    if (analisisGarantia.isEmpty) {
      return const EmptyListWidget(
        message: 'No hay garantías para mostrar',
      );
    }
    // Espacio inferior extra para que el FAB no tape la última tarjeta.
    return ListView.builder(
      padding: const EdgeInsets.only(top: 14, bottom: 96),
      itemCount: analisisGarantia.length,
      itemBuilder: (context, index) {
        final e = analisisGarantia[index];
        return GarantiaItemCard(
          index: index,
          garantia: e,
          onTap: () => (e.bienCodigo != null) || e.tieneGarantiaDPF
              ? showGarantiaOptionsSheet(
                  context,
                  onActualizar: () => _navigateToActualizarDetalle(context, e),
                  onRechazar: () => _confirmarRechazo(context, e),
                )
              : _navigateToDetalle(context, e),
        );
      },
    );
  }

  void _navigateToDetalle(BuildContext context, GarantiaData e) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => V2CrearGarantiaDetalleScreen(
          tipoGarantia: e.articuloTipo!.toTipoGarantiaEnumV2!,
          objAnalisisGarantiaId: e.garantiaID!,
          tipoArticulo: e.articuloCodigo!.toTipoArticuloEnum!,
          articuloCodigo: e.articuloCodigo!,
          cedulaCliente: e.cedulaDeudor ?? '',
          tipoPersonaCodigo: e.tipoPersonaCodigo!,
          tipoPersonaCodigoDeudor: e.tipoPersonaCodigoDeudor,
        ),
      ),
    );
  }

  void _navigateToActualizarDetalle(BuildContext context, GarantiaData e) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => V2ActualizarGarantiaDetalleScreen(
          tipoGarantia: e.articuloTipo!.toTipoGarantiaEnumV2!,
          objAnalisisGarantiaId: e.garantiaID!,
          tipoArticulo: e.articuloCodigo!.toTipoArticuloEnum!,
          articuloCodigo: e.articuloCodigo!,
          cedulaCliente: e.cedulaDeudor ?? '',
          tipoPersonaCodigo: e.tipoPersonaCodigo!,
          tipoPersonaCodigoDeudor: e.tipoPersonaCodigoDeudor,
          bienCodigo: e.bienCodigo ?? '',
        ),
      ),
    );
  }

  void _confirmarRechazo(BuildContext context, GarantiaData e) {
    ExitConfirmationDialog(
      context: context,
      title: 'Seguro que quieres rechazar esta garantia?',
      onYes: () {
        context.pop();
        context.read<AnalisisAnularGarantiaCubit>().anularGarantia(
              analisisGarantiaId: e.garantiaID!,
            );
      },
    ).showDialog(
      context,
      dialogType: DialogType.infoReverse,
    );
  }
}
