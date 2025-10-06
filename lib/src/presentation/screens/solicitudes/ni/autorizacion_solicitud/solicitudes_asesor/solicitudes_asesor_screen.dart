import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_by_asesor/solicitudes_by_asesor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/card_table/card_table.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class SolicitudesAsesorScreen extends StatelessWidget {
  const SolicitudesAsesorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesByAsesorCubit(
        SolicitudCreditoRepositoryImpl(),
      )..getSolicitudesByAsesor(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Solicitudes Asignadas'),
        ),
        body: BlocBuilder<SolicitudesByAsesorCubit, SolicitudesByAsesorState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudesByAsesorLoading() => const LoadingWidget(),
              OnSolicitudesByAsesorError() =>
                Text('Error : ${state.errorMsg} '),
              OnSolicitudesByAsesorSuccess() => ListView.separated(
                  itemCount: state.solicitudes.data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return CardTable(
                      tipoSolicitud:
                          state.solicitudes.data[index].tipoSolicitud,
                      title:
                          'Numero Solicitud: ${state.solicitudes.data[index].numero}',
                      fecha: state.solicitudes.data[index].fechaSolicitud,
                      monto: state.solicitudes.data[index].monto!
                          .toCurrencyString(),
                      estadoCodigo: state.solicitudes.data[index].estado,
                      sucursal: state.solicitudes.data[index].sucursal ?? 'N/A',
                      nombreCliente:
                          state.solicitudes.data[index].nombreCompleto ?? 'N/A',
                      nombrePromotor:
                          state.solicitudes.data[index].nombrePromotor,
                      onTap: () {},
                    );
                  },
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
