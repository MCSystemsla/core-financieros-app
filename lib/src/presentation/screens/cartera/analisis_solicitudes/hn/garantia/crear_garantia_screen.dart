import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_garantia/fiadores_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/v2_crear_garantia_detalle_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/crear_garantia_moda_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
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
                color: e.asignacionID == null ? Colors.indigo.shade600 : null,
                subtitle: e.articuloTipo ?? '',
                title: e.tipoPersonaCodigo ?? '',
                description: e.asignacionID == null
                    ? 'Agregar Bien de garantia'
                    : 'Bien de garantia asignado',
                onTap: () {
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
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
