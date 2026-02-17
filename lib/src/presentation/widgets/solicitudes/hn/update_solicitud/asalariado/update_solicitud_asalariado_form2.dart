import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudAsalariadoForm2 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudAsalariadoForm2({super.key, required this.controller});

  @override
  State<UpdateSolicitudAsalariadoForm2> createState() =>
      _UpdateSolicitudAsalariadoForm2State();
}

class _UpdateSolicitudAsalariadoForm2State
    extends State<UpdateSolicitudAsalariadoForm2> {
  final formKey = GlobalKey<FormState>();
  String? depWhereClause;
  String? munWhereClause;
  String? aldeaWhereClause;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 2,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  selectedItem: ItemNacionalidad(
                    id: 0,
                    valor: cubit.state.paisCasaCodigo,
                    nombre: cubit.state.paisCasaNombre,
                    relacion: '',
                  ),
                  hintText: 'País de Casa',
                  title: 'Pais de Casa',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      depWhereClause = item.valor;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        paisCasaCodigo: item.valor,
                        paisCasaNombre: item.nombre,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  selectedItem: ItemNacionalidad(
                    id: 0,
                    valor: cubit.state.departamentoCasaCodigo,
                    nombre: cubit.state.departamentoCasaNombre,
                    relacion: '',
                  ),
                  hintText: 'Departamento de Casa',
                  title: 'Departamento de Casa',
                  codigo: 'DEP',
                  where: cubit.state.paisCasaCodigo,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      munWhereClause = item.valor;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        departamentoCasaCodigo: item.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  selectedItem: ItemNacionalidad(
                    id: 0,
                    valor: cubit.state.municipioCasaCodigo,
                    nombre: cubit.state.municipioCasaNombre,
                    relacion: '',
                  ),
                  codigo: 'MUN',
                  hintText: 'Municipio de Casa',
                  title: 'Municipio de Casa',
                  where: cubit.state.departamentoCasaCodigo,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      aldeaWhereClause = value.valor;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        municipioCasaCodigo: value.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  selectedItem: ItemNacionalidad(
                    id: 0,
                    valor: cubit.state.aldeaCodigo,
                    nombre: cubit.state.aldeaNombre,
                    relacion: '',
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Aldea',
                  title: 'Aldea de Casa',
                  codigo: 'ALD',
                  where: cubit.state.municipioCasaCodigo,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        aldeaCodigo: value.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.caserioCasa,
                  hintText: 'Caserío',
                  icon: Icon(
                    Icons.home_work,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Caserio de Casa',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        caserioCasa: value,
                      ),
                    );
                  },
                ),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  initialValue: cubit.state.direccionCasa,
                  hintText: 'Dirección de Casa',
                  icon: Icon(Icons.home, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Direccion de Casa',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionCasa: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.barrioCasa,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Barrio de Casa',
                  icon: Icon(Icons.location_city,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Barrio de Casa',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        barrioCasa: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.condicionCasaNombre,
                    value: cubit.state.condicionCasaCodigo,
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Condición de Casa',
                  title: 'Condición de Casa',
                  codigo: 'TIPOVIVIENDA',
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        condicionCasaCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.anosResidirCasa.toString(),
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Años de Residencia en Casa',
                  icon:
                      Icon(Icons.timelapse, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Años de Residencia en Casa',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        anosResidirCasa: int.tryParse(value) ?? 0,
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
                // ignore: deprecated_member_use
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
                  widget.controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
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
