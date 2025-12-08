// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisFiadoresActividades extends StatefulWidget {
  const AnalisisFiadoresActividades({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisFiadoresActividades> createState() =>
      _AnalisisFiadoresActividadesState();
}

class _AnalisisFiadoresActividadesState
    extends State<AnalisisFiadoresActividades>
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
    final cubit = context.read<AnalisisFiadoresCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(30),
            CatalogoActividadesCNBSDropdown(
              isRequired: true,
              enabled: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              hintText: 'selecciona actividad económica',
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
              title: 'Actividad Económica CNBS',
            ),
            if (actividadEconomica1 != null) ...[
              const Gap(30),
              OutlineTextfieldWidget(
                isRequired: true,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                hintText: 'ingresa descripcion actividad económica',
                icon:
                    Icon(Icons.description, color: AppColors.getPrimaryColor()),
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                title: 'Descripción de la Actividad Económica',
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      actividadEconomicaDescripcion1: value,
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
              hintText: 'selecciona actividad económica',
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
                validator: (value) => ClassValidator.validateRequired(value),
                hintText: 'ingresa descripcion actividad económica',
                icon: Icon(Icons.description_outlined,
                    color: AppColors.getPrimaryColor()),
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                title: 'Descripción de la Actividad Económica',
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      actividadEconomicaDescripcion2: value,
                    ),
                  );
                },
              ),
            ],
            const Gap(30),
            CatalogoActividadesCNBSDropdown(
              hintText: 'selecciona actividad económica',
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
                validator: (value) => ClassValidator.validateRequired(value),
                hintText: 'ingresa descripcion actividad económica',
                icon: Icon(Icons.description_outlined,
                    color: AppColors.getPrimaryColor()),
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                title: 'Descripción de la Actividad Económica',
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      actividadEconomicaDescripcion3: value,
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
                    ),
                  );
                },
              ),
            ],
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  widget.pageController.nextPage(
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
                  widget.pageController.previousPage(
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
