import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/hn/bottom_sheet/show_filter_creditos_by_estados_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FilterContentWidgetHn extends StatefulWidget {
  const FilterContentWidgetHn({super.key});

  @override
  State<FilterContentWidgetHn> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContentWidgetHn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesByEstadoHnCubit, SolicitudesByEstadoHnState>(
      builder: (context, state) {
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
                    // showFilterGetByCedualAndNumeroSolicitud(
                    //   context,
                    //   isNumeroSolicitudFilter,
                    //   numeroSolicitud,
                    //   isCedulaSolicitudFilter,
                    //   cedulaCliente,
                    //   cubit,
                    // );
                  },
                ),
              ),
              const Gap(10),
              Expanded(
                child: FilterView(
                  onTap: () {
                    showFilterCreditosByEstadoHN(
                      context,
                      EstadoCredito.registrada,
                      state.isAsignadaToAsesorCredito,
                      context.read<SolicitudesByEstadoHnCubit>(),
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
