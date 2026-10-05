import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/solicitudes_by_estado_ni/solicitudes_by_estado_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/modal_sheet/show_filter_creditos_by_estado.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/bottom_sheet/show_filter_get_by_cedula_and_numero.dart';
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
    return BlocBuilder<SolicitudesByEstadoNiCubit, SolicitudesByEstadoNiState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudesByEstadoNiCubit>();

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
                      state.isNumeroSolicitudFilter,
                      state.numeroSolicitud,
                      state.isCedulaSolicitudFilter,
                      state.cedulaCliente,
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
                      state.estadoCredito,
                      state.isAsignadaToAsesorCredito,
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
