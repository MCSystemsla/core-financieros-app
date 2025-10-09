// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/sending_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm8 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm8({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm8> createState() => _NuevaMenorForm8State();
}

class _NuevaMenorForm8State extends State<NuevaMenorForm8>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? actividadEconomica1;
  String? actividadEconomica2;
  String? actividadEconomica3;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 8,
              steps: 8,
            ),
            const Gap(30),
            Column(
              children: [
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Actividad Económica CNBS 1',
                  codigo: 'ACTIVIDADESECONOMICASCNBS',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica1 = item.name;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCnbs1Codigo: item.value,
                      ),
                    );
                  },
                  title: 'Actividad Económica CNBS 1',
                ),
                if (actividadEconomica1 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Descripción Actividad Económica 1',
                    icon: Icon(Icons.description,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Actividad Económica CNBS 1',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividaEconomicaDescipcion1: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  codigo: 'ACTIVIDADESECONOMICASCNBS',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica2 = item.name;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCnbs2Codigo: item.value,
                      ),
                    );
                  },
                  hintText: 'Actividad Económica CNBS 2',
                  title: 'Actividad Económica CNBS 2',
                ),
                if (actividadEconomica2 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Descripción Actividad Económica 2',
                    icon: Icon(Icons.description_outlined,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Actividad Económica CNBS 2',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividaEconomicaDescipcion2: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  hintText: 'Actividad Económica CNBS 3',
                  codigo: 'ACTIVIDADESECONOMICASCNBS',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica3 = item.name;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCnbs2Codigo: item.value,
                      ),
                    );
                  },
                  title: 'Actividad Económica CNBS 3',
                ),
                if (actividadEconomica3 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Descripción Actividad Económica 3',
                    icon: Icon(Icons.description_outlined,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Actividad Económica CNBS 3',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividaEconomicaDescipcion3: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Medidas de Conocimiento',
                  title: 'Medidas de Conocimiento',
                  codigo: 'MEDIDASCONOCIMIENTO',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        medidasConocimientoCodigo: item.value,
                      ),
                    );
                  },
                ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: context.read<SolicitudNuevaMenorHnCubit>(),
                        child: const SendingFormWidgetHN(),
                      ),
                    ),
                  );

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
                  widget.controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                text: 'Anterior',
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

  @override
  bool get wantKeepAlive => true;
}
