// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm6 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm6({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm6> createState() => _NuevaMenorForm6State();
}

class _NuevaMenorForm6State extends State<NuevaMenorForm6>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? depWhereClause;
  String? munWhereClause;
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
              currentStep: 6,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                if (cubit.state.paisCasaCodigo == 'HN') ...[
                  CatalogoValorNacionalidad(
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
                          departamentoDestinoCodigoNombre: item.nombre,
                        ),
                      );
                    },
                    title: 'Departamento de Destino',
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
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
                          municipioDestinoCodigoNombre: item.nombre,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: munWhereClause,
                    codigo: 'ALD',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Aldea Destino',
                    title: 'Aldea o Localidad de Destino',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          aldeaDestinoCodigo: value?.valor,
                          aldeaDestinoCodigoNombre: value?.nombre,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
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

  @override
  bool get wantKeepAlive => true;
}
