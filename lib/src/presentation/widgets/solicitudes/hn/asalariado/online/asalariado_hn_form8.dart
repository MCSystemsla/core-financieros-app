// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoHnForm8 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm8({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm8> createState() => _AsalariadoHnForm8State();
}

class _AsalariadoHnForm8State extends State<AsalariadoHnForm8> {
  final formKey = GlobalKey<FormState>();
  String? actividadEconomica1;
  String? actividadEconomica2;
  String? actividadEconomica3;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudAslariadoHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 8,
              steps: 9,
            ),
            const Gap(30),
            Column(
              children: [
                SearchDropdownWidget(
                  hintText: 'Actividad Económica CIUU 1',
                  title: 'ObjActividadEconomicaCIUU1',
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'ACTIVIDADECONOMICA',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomica1 = value.name;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu1Codigo: value.value,
                      ),
                    );
                  },
                ),
                if (actividadEconomica1 != null) ...[
                  const Gap(30),
                  SearchDropdownWidget(
                    hintText: 'Descripción Actividad Económica 1',
                    title: 'actividadEconomicaDescripcion1',
                    codigo: 'ACTIVIDADECONOMICA',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaDescripcion1: value.name,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  hintText: 'Actividad Económica CIUU 2',
                  title: 'ObjActividadEconomicaCIUU2',
                  codigo: 'ACTIVIDADECONOMICA',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomica2 = value.name;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu2Codigo: value.value,
                      ),
                    );
                  },
                ),
                if (actividadEconomica2 != null) ...[
                  const Gap(30),
                  SearchDropdownWidget(
                    hintText: 'Descripción Actividad Económica 2',
                    title: 'actividadEconomicaDescripcion2',
                    codigo: 'ACTIVIDADECONOMICA',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaDescripcion2: value.name,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  hintText: 'Actividad Económica CIUU 3',
                  title: 'ObjActividadEconomicaCIUU3',
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'ACTIVIDADECONOMICA',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomica3 = value.name;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu3Codigo: value.value,
                      ),
                    );
                  },
                ),
                if (actividadEconomica3 != null) ...[
                  const Gap(30),
                  SearchDropdownWidget(
                    hintText: 'Descripción Actividad Económica 3',
                    title: 'actividadEconomicaDescripcion3',
                    codigo: 'ACTIVIDADECONOMICA',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaDescripcion3: value.name,
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutLineButton(
                onPressed: () {
                  context.pushReplacement('/solicitudes');
                },
                text: 'Cancelar',
                textColor: AppColors.red,
                color: AppColors.red,
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
