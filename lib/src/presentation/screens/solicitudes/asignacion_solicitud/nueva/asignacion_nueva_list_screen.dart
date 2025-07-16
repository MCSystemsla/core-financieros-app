// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/credit_producto/credit_product_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class AsignacionListScreen extends StatelessWidget {
  final TypeForm typeForm;
  const AsignacionListScreen({super.key, required this.typeForm});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudNuevaByEstadoCubit(
            SolicitudCreditoRepositoryImpl(),
          )..getSolicitudNuevaByEstado(typeForm: typeForm),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Asignar Credito a Asesor'),
        ),
        body: BlocBuilder<SolicitudNuevaByEstadoCubit,
            SolicitudNuevaByEstadoState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudNuevaByEstadoLoading() => const LoadingWidget(),
              OnSolicitudNuevaByEstadoSuccess() => _AsignacionNuevaListView(
                  solicitudByEstado: state.solicitudByEstado,
                ),
              OnSolicitudNuevaByEstadoError() => Text(state.errorMsg),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class _AsignacionNuevaListView extends StatelessWidget {
  final SolicitudByEstado solicitudByEstado;
  const _AsignacionNuevaListView({
    required this.solicitudByEstado,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          const _HeaderContent(),
          const Gap(20),
          const _FilterContent(),
          const Gap(20),
          solicitudByEstado.data.isEmpty
              ? const Text('No hay Solicitudes Pendientes')
              : ListView.builder(
                  itemCount: solicitudByEstado.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return CreditProductItem(
                      nombre:
                          'Numero Solicitud: ${solicitudByEstado.data[index].numero}',
                      cuota: solicitudByEstado.data[index].cuota
                          .toCurrencyString(),
                      monto: solicitudByEstado.data[index].monto
                          .toCurrencyString(),
                      estadoCodigo: solicitudByEstado.data[index].codigo,
                      sucursal: solicitudByEstado.data[index].sucursal,
                      nombreCliente:
                          solicitudByEstado.data[index].nombreCompleto,
                    );
                  },
                ),
          const Gap(20),
        ],
      ),
    );
  }
}

class _FilterContent extends StatelessWidget {
  const _FilterContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: SearchBarCustom(
              onItemSelected: (s) {},
              onPressed: () {},
            ),
          ),
          const Gap(10),
          Expanded(
            child: Filter(
              itemsPopUp: EstadoCredito.values.map((e) {
                return PopupMenuItem<EstadoCredito>(
                  value: e,
                  child: Text(e.name.capitalize),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Designar Asesor para el Crédito',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          child: Text(
            'Seleccioná al asesor que estará a cargo del crédito. Esta acción es clave para garantizar una correcta gestión y seguimiento del proceso crediticio.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
