import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/solicitudes/hn/cubit/grupos_activos/grupos_activos_cubit.dart';

class FilterGruposActivosWidget extends StatelessWidget {
  const FilterGruposActivosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GruposActivosCubit, GruposActivosState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.done => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SearchBarCustom(
                      onItemSelected: (s) {},
                      onPressed: () {},
                      onTap: () => showFilterGetByCedualAndNumeroSolicitud(
                        context,
                        context.read<GruposActivosCubit>(),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: FilterView(
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

void showFilterGetByCedualAndNumeroSolicitud(
  BuildContext context,
  GruposActivosCubit cubit,
) {
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: SafeArea(
            child: StatefulBuilder(
              builder: (context, setState) {
                return BlocBuilder<GruposActivosCubit, GruposActivosState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Form(
                        key: formKey,
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
                                const Gap(15),
                                Text(
                                  'Filtrar por tipo de grupo',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Text(
                              'Filtra los grupos con las siguientes opciones:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                            const Gap(20),
                            SwitchListTile(
                              value: state.isGrupoNombreFilter,
                              onChanged: (value) {
                                cubit.onFieldChanged(
                                  () => state.copyWith(
                                    isGrupoNombreFilter: value,
                                  ),
                                );
                              },
                              title: const Text('Nombre del Grupo'),
                              subtitle: const Text(
                                'Filtra los grupos por nombre',
                              ),
                            ),
                            if (state.isGrupoNombreFilter)
                              FadeIn(
                                child: OutlineTextfieldWidget(
                                  initialValue: state.grupoNombre
                                      .toString()
                                      .toNullIfEmptyOrZero(),
                                  onChange: (value) {
                                    cubit.onFieldChanged(
                                      () => state.copyWith(grupoNombre: value),
                                    );
                                  },
                                  validator: (value) =>
                                      ClassValidator.validateRequired(value),
                                  title: 'Ingresa el nombre del grupo',
                                  hintText: 'Ej: Grupo 1',
                                  icon: const Icon(Icons.request_page),
                                  inputFormatters: [
                                    UpperCaseTextFormatter(),
                                  ],
                                ),
                              ),
                            const Gap(20),
                            SwitchListTile(
                              value: state.isGrupoCodigoFilter,
                              onChanged: (value) {
                                cubit.onFieldChanged(
                                  () => state.copyWith(
                                    isGrupoCodigoFilter: value,
                                  ),
                                );
                              },
                              title: const Text('Codigo del Grupo'),
                              subtitle: const Text(
                                'Filtra los grupos por codigo',
                              ),
                            ),
                            if (state.isGrupoCodigoFilter)
                              FadeIn(
                                child: OutlineTextfieldWidget(
                                  initialValue:
                                      state.grupoCodigo.toNullIfEmptyOrZero(),
                                  validator: (value) =>
                                      ClassValidator.validateRequired(value),
                                  title: 'Ingresa codigo del Grupo',
                                  hintText: 'Ej: 31',
                                  icon: const Icon(Icons.person),
                                  onChange: (value) {
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        grupoCodigo: value,
                                      ),
                                    );
                                  },
                                  inputFormatters: [
                                    UpperCaseTextFormatter(),
                                  ],
                                ),
                              ),
                            const Gap(20),
                            CustomElevatedButton(
                              onPressed: () {
                                cubit.cleanState();
                                cubit.getGruposActivos();
                                context.pop();
                              },
                              text: 'Limpiar Filtros',
                              color: AppColors.red,
                              icon: const Icon(
                                Icons.filter_alt_off_rounded,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(20),
                            CustomElevatedButton(
                              enabled: state.isGrupoCodigoFilter ||
                                  state.isGrupoNombreFilter,
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                if (!state.isGrupoNombreFilter) {
                                  cubit.onFieldChanged(
                                    () => state.copyWith(
                                      isGrupoCodigoFilter: null,
                                    ),
                                  );
                                }
                                if (!state.isGrupoCodigoFilter) {
                                  cubit.onFieldChanged(
                                    () => state.copyWith(
                                      isGrupoNombreFilter: null,
                                    ),
                                  );
                                }

                                cubit.getGruposActivos();
                                context.pop();
                              },
                              text: 'Guardar Cambios',
                              color: AppColors.getSecondaryColor(),
                              icon: const Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
