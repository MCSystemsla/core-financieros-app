// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoHnForm7 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm7({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm7> createState() => _AsalariadoHnForm7State();
}

class _AsalariadoHnForm7State extends State<AsalariadoHnForm7>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? depWhereClause;
  String? munWhereClause;
  String? aldeaWhereClause;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudAslariadoHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 5,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'País Destino',
                  title: 'objPaisDestinoID',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      depWhereClause = item.valor;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        paisDestinoCodigo: item.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Departamento Destino',
                  title: 'objDepartamentoDestinoID',
                  where: depWhereClause,
                  codigo: 'DEP',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      munWhereClause = item.valor;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        departamentoDestinoCodigo: item.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Municipio Destino',
                  title: 'objMunicipioDestinoID',
                  where: munWhereClause,
                  codigo: 'MUN',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      aldeaWhereClause = item.valor;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        municipioDestinoId: item.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Aldea Destino',
                  title: 'objAldeaDestinoID',
                  where: aldeaWhereClause,
                  codigo: 'AL',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        aldeaDestinoCodigo: item.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Caserío Destino',
                  icon:
                      Icon(Icons.home_work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'CaserioDestino',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
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
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Barrio Destino',
                  icon: Icon(Icons.house, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'BarrioDestino',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
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
