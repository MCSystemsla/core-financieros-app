import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudNuevaMenorForm6 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudNuevaMenorForm6({
    super.key,
    required this.controller,
  });

  @override
  State<UpdateSolicitudNuevaMenorForm6> createState() =>
      _UpdateSolicitudNuevaMenorForm6State();
}

class _UpdateSolicitudNuevaMenorForm6State
    extends State<UpdateSolicitudNuevaMenorForm6> {
  final formKey = GlobalKey<FormState>();
  String? depWhereClause;
  String? munWhereClause;
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
              currentStep: 6,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                if (cubit.state.paisCasaCodigo == 'HN') ...[
                  CatalogoValorNacionalidad(
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.paisCasaCodigo,
                      nombre: cubit.state.paisCasaNombre,
                      relacion: '',
                    ),
                    where: cubit.state.paisCasaCodigo,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Departamento de Destino',
                    codigo: 'DEP',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        depWhereClause = item.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          departamentoDestinoCodigo: item.valor,
                          departamentoDestinoNombre: item.nombre,
                        ),
                      );
                    },
                    title: 'Departamento de Destino',
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.municipioDestinoCodigo,
                      nombre: cubit.state.municipioDestinoNombre,
                      relacion: '',
                    ),
                    where: depWhereClause,
                    validator: (value) => ClassValidator.validateRequired(
                      value?.valor,
                    ),
                    hintText: 'Municipio Destino',
                    title: 'Municipio de Destino',
                    codigo: 'MUN',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        munWhereClause = item.valor;
                      });

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          municipioDestinoCodigo: item.valor,
                          municipioDestinoNombre: item.nombre,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.aldeaDestinoCodigo,
                      nombre: cubit.state.aldeaDestinoNombre,
                      relacion: '',
                    ),
                    where: cubit.state.municipioDestinoCodigo,
                    codigo: 'ALD',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Aldea Destino',
                    title: 'Aldea o Localidad de Destino',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          aldeaDestinoCodigo: value?.valor,
                          aldeaDestinoNombre: value?.nombre,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.caserioDestino,
                  isRequired: true,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  hintText: 'Caserío Destino',
                  title: 'Caserío de Destino',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        caserioDestino: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.barrioDestino,
                  isRequired: true,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  hintText: 'Barrio Destino',
                  title: 'Barrio o Colonia de Destino',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        barrioDestino: value,
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
}
