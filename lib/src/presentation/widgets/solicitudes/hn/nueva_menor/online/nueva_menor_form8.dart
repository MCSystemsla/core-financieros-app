// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/sending_form_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
  bool isApnfd = false;
  bool isApnfd2 = false;
  bool isApnfd3 = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final internetConnectionCubit =
        context.read<InternetConnectionCubit>().state.connectionStatus;
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
                CatalogoActividadesCNBSDropdown(
                  isRequired: true,
                  enabled: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'selecciona actividad economica',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica1 = item.valor;
                      isApnfd = item.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCnbs1Codigo: item.valor,
                      ),
                    );
                  },
                  title: 'Actividad Económica CNBS 1',
                ),
                if (actividadEconomica1 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'ingresa descripcion actividad economica',
                    icon: Icon(Icons.description,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Descripción Actividad Económica 1',
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
                CatalogoActividadesCNBSDropdown(
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica2 = item.valor;
                      isApnfd2 = item.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCnbs2Codigo: item.valor,
                      ),
                    );
                  },
                  hintText: 'selecciona actividad economica',
                  title: 'Actividad Económica CNBS 2',
                  isRequired: true,
                  enabled: true,
                ),
                if (actividadEconomica2 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'ingresa descripcion actividad economica',
                    icon: Icon(Icons.description_outlined,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Descripción Actividad Económica 2',
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
                CatalogoActividadesCNBSDropdown(
                  hintText: 'selecciona actividad economica',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica3 = item.nombre;
                      isApnfd3 = item.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCnbs3Codigo: item.valor,
                      ),
                    );
                  },
                  title: 'Actividad Económica CNBS 3',
                  isRequired: true,
                  enabled: true,
                ),
                if (actividadEconomica3 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'ingresa descripcion actividad economica',
                    icon: Icon(Icons.description_outlined,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Descripción Actividad Económica 3',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividaEconomicaDescipcion3: value,
                        ),
                      );
                    },
                  ),
                ],
                if (isApnfd || isApnfd2 || isApnfd3) ...[
                  const Gap(30),
                  SheetSearchDropdown(
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    hintText: '¿Ejerce APNFD?',
                    title: '¿Ejerce APNFD?',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          ejerceApnfd: value?.value,
                          esApnfd: 'input.yes'.tr(),
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
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      isDone: true,
                    ),
                  );
                  if (internetConnectionCubit ==
                      ConnectionStatus.disconnected) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        isOffline: true,
                        errorMsg:
                            'No tienes conexion a internet, La solicitud se a guardado de manera local',
                      ),
                    );
                    CustomAlertDialog(
                      context: context,
                      title:
                          'No tienes conexion a internet, La solicitud se a guardado de manera local',
                      onDone: () => context.pushReplacement('/solicitudes'),
                    ).showDialog(context, dialogType: DialogType.infoReverse);
                    return;
                  }
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
