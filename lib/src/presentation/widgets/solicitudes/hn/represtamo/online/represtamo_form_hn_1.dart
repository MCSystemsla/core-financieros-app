// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoFormHn1 extends StatefulWidget {
  final PageController controller;
  const ReprestamoFormHn1({
    super.key,
    required this.controller,
  });

  @override
  State<ReprestamoFormHn1> createState() => _ReprestamoFormHn1State();
}

class _ReprestamoFormHn1State extends State<ReprestamoFormHn1>
    with AutomaticKeepAliveClientMixin {
  bool tieneVinculoEstadosUnidos = false;
  final formKey = GlobalKey<FormState>();
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
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  key: const ValueKey('tipoPersona'),
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'TIPOSPERSONACREDITO',
                  title: 'Tipo Persona',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersonaCodigo: value.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  key: const ValueKey('tipoDocumento'),
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'TIPODOCUMENTOPERSONA',
                  title: 'Tipo Docuemnto Persona',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoDocumentoCodigo: value.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  key: const ValueKey('cedula'),
                  hintText: 'Cedula',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputType: TextInputType.number,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Cedula',
                  onChange: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedula: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  key: const ValueKey('celular'),
                  hintText: 'Celular Represtamo',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputType: TextInputType.phone,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Celular Represtamo',
                  onChange: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celularReprestamo: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SheetSearchDropdown(
                  key: const ValueKey('ubicacion'),
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  title: 'Ubicacion',
                  isRequired: true,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ubicacion: value.value,
                      ),
                    );
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'Urbano'.tr(), value: 'URB'),
                    Item(name: 'Rural'.tr(), value: 'RUR'),
                  ],
                ),
                const Gap(30),
                SheetSearchDropdown(
                  key: const ValueKey('tieneVinculo'),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: 'Tiene vinculos con USA?',
                  isRequired: true,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      tieneVinculoEstadosUnidos =
                          value.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tieneVinculoEstadosUnidos: value.value,
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
                if (tieneVinculoEstadosUnidos) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    key: const ValueKey('vinculo'),
                    hintText: 'Vinculo Descripcion',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Vinculo Descripcion',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          vinculoEstadosUnidosDescripcion: value,
                        ),
                      );
                    },
                  ),
                  OutlineTextfieldWidget(
                    key: const ValueKey('codigoUSA'),
                    hintText: 'Codigo USA',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Codigo USA',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          codigoUsa: value,
                        ),
                      );
                    },
                  ),
                  SheetSearchDropdown(
                    key: const ValueKey('tieneIdentificacion'),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    title: 'Tiene identificacion de Estados unidos?',
                    isRequired: true,
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tieneIdentificacionEstadosUnidos: value.value,
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

  @override
  bool get wantKeepAlive => true;
}
