// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/represtamo_sending_form_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';

class ReprestamoFormHn5 extends StatefulWidget {
  final PageController controller;
  const ReprestamoFormHn5({
    super.key,
    required this.controller,
  });

  @override
  State<ReprestamoFormHn5> createState() => _ReprestamoFormHn5State();
}

class _ReprestamoFormHn5State extends State<ReprestamoFormHn5>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? actividadEconomicaCiuu1;
  String? actividadEconomicaCiuu2;
  String? actividadEconomicaCiuu3;
  bool isApnfd = false;
  bool isApnfd2 = false;
  bool isApnfd3 = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudReprestamoHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 1,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                CatalogoActividadesCNBSDropdown(
                  isRequired: true,
                  hintText: 'Selecciona una actividad',
                  enabled: true,
                  validator: (value) => ClassValidator.validateRequired(
                    value?.valor,
                  ),
                  title: 'ActividadEconomicaCIUU1',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomicaCiuu1 = value.valor;
                      isApnfd = value.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu1: value.valor,
                      ),
                    );
                  },
                ),
                if (actividadEconomicaCiuu1 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    title: 'ActividadEconomicaRealizaCIUU1',
                    icon: Icon(
                      Icons.description,
                      color: AppColors.getPrimaryColor(),
                    ),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaRealizaCiuu1: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                CatalogoActividadesCNBSDropdown(
                  isRequired: true,
                  hintText: 'Selecciona una actividad',
                  enabled: true,
                  // validator: (value) => ClassValidator.validateRequired(
                  //   value?.valor,
                  // ),
                  title: 'ActividadEconomicaCIUU2',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomicaCiuu2 = value.valor;
                      isApnfd2 = value.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu2: value.valor,
                      ),
                    );
                  },
                ),
                if (actividadEconomicaCiuu2 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    title: 'ActividadEconomicaRealizaCIUU2',
                    icon: Icon(
                      Icons.description,
                      color: AppColors.getPrimaryColor(),
                    ),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaRealizaCiuu2: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                CatalogoActividadesCNBSDropdown(
                  isRequired: true,
                  hintText: 'Selecciona una actividad',
                  enabled: true,
                  title: 'ActividadEconomicaCIUU3',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomicaCiuu3 = value.valor;
                      isApnfd3 = value.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu3: value.valor,
                      ),
                    );
                  },
                ),
                if (actividadEconomicaCiuu3 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    title: 'ActividadEconomicaRealizaCIUU3',
                    icon: Icon(
                      Icons.description,
                      color: AppColors.getPrimaryColor(),
                    ),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaRealizaCiuu3: value,
                        ),
                      );
                    },
                  ),
                ],
                if (isApnfd || isApnfd2 || isApnfd3) ...[
                  SheetSearchDropdown(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    title: 'Ejerce APNFD',
                    isRequired: true,
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          ejerceActividadApfnd: item.value,
                          apnfd: 'input.yes'.tr(),
                        ),
                      );
                    },
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'MEDIDASCONOCIMIENTO',
                  title: 'objMedidasConocimientoID',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        medidasConocimientoCodigo: value.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
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
                        value: context.read<SolicitudReprestamoHnCubit>(),
                        child: const ReprestamoSendingFormWidget(),
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
