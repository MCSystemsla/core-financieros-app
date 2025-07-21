import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/modal_sheet/show_filter_creditos_by_estado.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asign_solicitud_asesor/bottom_sheet/show_filter_get_by_cedula_and_numero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FilterContent extends StatefulWidget {
  const FilterContent({super.key});

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudNuevaByEstadoCubit>();
    return BlocBuilder<SolicitudNuevaByEstadoCubit,
        SolicitudNuevaByEstadoState>(
      builder: (context, state) {
        final estadoCredito = state is OnSolicitudNuevaByEstadoSuccess
            ? state.estadoCredito
            : EstadoCredito.registrada;
        final isAsignadaToAsesorCredito =
            state is OnSolicitudNuevaByEstadoSuccess
                ? state.isAsignadaToAsesorCredito
                : false;
        final isNumeroSolicitudFilter = state is OnSolicitudNuevaByEstadoSuccess
            ? state.isNumeroSolicitudFilter
            : false;
        final isCedulaSolicitudFilter = state is OnSolicitudNuevaByEstadoSuccess
            ? state.isCedulaSolicitudFilter
            : false;
        final numeroSolicitud = state is OnSolicitudNuevaByEstadoSuccess
            ? state.numeroSolicitud
            : null;
        final cedulaCliente = state is OnSolicitudNuevaByEstadoSuccess
            ? state.cedulaCliente
            : null;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: SearchBarCustom(
                  onItemSelected: (s) {},
                  onPressed: () {},
                  onTap: () {
                    showFilterGetByCedualAndNumeroSolicitud(
                      context,
                      isNumeroSolicitudFilter,
                      numeroSolicitud,
                      isCedulaSolicitudFilter,
                      cedulaCliente,
                      cubit,
                    );
                  },
                ),
              ),
              const Gap(10),
              Expanded(
                child: FilterView(
                  onTap: () {
                    showFilterCreditosByEstado(
                      context,
                      estadoCredito,
                      isAsignadaToAsesorCredito,
                      cubit,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
