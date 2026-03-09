import 'package:core_financiero_app/src/utils/extensions/order_type/order_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/comite/comite_solicitudes/comite_solicitudes_cubit.dart';

void showFilterTypeModalSheet(
  BuildContext context,
  ComiteSolicitudesCubit cubit,
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
        child: SafeArea(
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
                            'Filtrar por tipo de orden',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Text(
                        'Filtra las solicitudes por tipo de orden',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const Gap(27),
                      Text(
                        'Opciones',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Gap(20),
                      ListView.builder(
                        itemCount: orderTypeInfoList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(orderTypeInfoList[index].nombre),
                            leading: Icon(orderTypeInfoList[index].icono),
                            trailing: cubit.state.ordenType ==
                                    orderTypeInfoList[index].orderType
                                ? const Icon(Icons.check_circle,
                                    color: Colors.green)
                                : null,
                            onTap: () {
                              if (cubit.state.ordenType ==
                                  orderTypeInfoList[index].orderType) {
                                return;
                              }
                              cubit.onFieldChanged(
                                () => cubit.state.copyWith(
                                  ordenType: orderTypeInfoList[index].orderType,
                                ),
                              );
                              cubit.getComiteSolicitudes();
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
        ),
      );
    },
  );
}
