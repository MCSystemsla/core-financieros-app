import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

void showFilterCreditosByEstado(
  BuildContext context,
  EstadoCredito estadoCredito,
  bool isAsignadaToAsesorCredito,
  SolicitudNuevaByEstadoCubit cubit,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    scrollControlDisabledMaxHeightRatio: 0.8,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.filter_alt_rounded,
                          size: 24,
                          color: Colors.indigo,
                        ),
                        const Gap(8),
                        Text(
                          'Filtrar por Estado',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      'Filtra las solicitudes por estado',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    const Gap(20),
                    SwitchListTile(
                      value: isAsignadaToAsesorCredito,
                      onChanged: (value) async {
                        setState(() {
                          isAsignadaToAsesorCredito = value;
                        });
                        await cubit.getSolicitudesByEstado(
                          estadoCredito: estadoCredito,
                          isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
                        );
                        if (!context.mounted) return;
                        context.pop();
                      },
                      title: const Text('Asignado a un oficial de credito'),
                      subtitle: const Text(
                        'Puedes filtrar las solicitudes que estan asignadas a un oficial de credito',
                      ),
                    ),
                    const Gap(27),
                    Text(
                      'Estados',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Gap(20),
                    ListView.builder(
                      itemCount: creditStatesListData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(creditStatesListData[index].nombre),
                          leading: Icon(creditStatesListData[index].icono),
                          trailing: estadoCredito ==
                                  creditStatesListData[index].estado
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : null,
                          onTap: () {
                            setState(() {
                              estadoCredito =
                                  creditStatesListData[index].estado;
                            });
                            cubit.getSolicitudesByEstado(
                              estadoCredito: estadoCredito,
                              isAsignadaToAsesorCredito:
                                  isAsignadaToAsesorCredito,
                            );
                            context.pop();
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
