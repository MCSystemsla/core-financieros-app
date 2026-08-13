import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_garantia/fiadores_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/v2_actualizar_garantia_detalle_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/v2_crear_garantia_detalle_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/crear_garantia_moda_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/tiles/option_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_garantia/tipo_garantia_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
      appBar: AppBar(
        title: const Text('Crear Garantía'),
      ),
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
              ],
              child: CreateGarantiaModalSheet(
                numeroSolicitud: numeroSolicitud,
                solicitudCodigo: solicitudCodigo,
                cedulaCliente: cedulaCliente,
              ),
            ),
          );
        },
        backgroundColor: Colors.black,
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
      body: BlocBuilder<AnalisisGarantiaCubit, AnalisisGarantiaState>(
        builder: (context, state) {
          return switch (state.status) {
            Status.inProgress => const LoadingWidget(),
            Status.error => Text('Error: //${state.errorMsg}'),
            Status.done => _ListItems(
                analisisGarantia: state.analisisGarantia,
              ),
            _ => const SizedBox(),
          };
        },
      ),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: analisisGarantia.length,
            itemBuilder: (context, index) {
              final e = analisisGarantia[index];
              return AnalisisCardVentasDay(
                color: e.bienCodigo == null ? Colors.indigo.shade600 : null,
                subtitle: e.articuloTipo ?? '',
                title: e.tipoPersonaCodigo ?? '',
                description: e.bienCodigo == null
                    ? 'Pendiente: toca para asignar un bien'
                    : 'Bien asignado: toca para ver opciones',
                onTap: () => e.bienCodigo != null
                    ? _showGarantiaOptionsBottomSheet(context, e)
                    : _navigateToDetalle(context, e),
              );
            },
          ),
          const Gap(20),
        ],
      ),
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
          bienCodigo: e.bienCodigo!,
        ),
      ),
    );
  }

  void _showGarantiaOptionsBottomSheet(BuildContext context, GarantiaData e) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            decoration: BoxDecoration(
              color: Theme.of(sheetContext).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Opciones del bien',
                      style: Theme.of(sheetContext)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                const Gap(16),
                OptionTile(
                  icon: Icons.edit_outlined,
                  color: Colors.indigo,
                  title: 'Actualizar Bien',
                  subtitle: 'Editar la información del bien registrado',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _navigateToActualizarDetalle(context, e);
                  },
                ),
                const Gap(4),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(height: 1),
                ),
                const Gap(4),
                OptionTile(
                  icon: Icons.close_rounded,
                  color: Colors.red,
                  title: 'Rechazar Bien',
                  subtitle: 'Descartar este bien de garantía',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RechazarBienScreen(),
                      ),
                    );
                  },
                ),
                const Gap(16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RechazarBienScreen extends StatelessWidget {
  const RechazarBienScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechazar Bien'),
      ),
      body: const Center(
        child: Text('Pantalla en construcción'),
      ),
    );
  }
}
