import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia_detalle/analisis_garantia_detalle_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/evaluadores_cnbs_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisGarantiaFormLiquida extends StatefulWidget {
  final int dpfsId;
  final int objAnalisisGarantiaID;
  final String? descripcion;
  final int? articuloGarantiaCodigo;
  const AnalisisGarantiaFormLiquida({
    super.key,
    required this.dpfsId,
    required this.objAnalisisGarantiaID,
    this.descripcion,
    this.articuloGarantiaCodigo,
  });

  @override
  State<AnalisisGarantiaFormLiquida> createState() =>
      _AnalisisGarantiaFormLiquidaState();
}

class _AnalisisGarantiaFormLiquidaState
    extends State<AnalisisGarantiaFormLiquida> {
  String? departamento;
  String? municipio;
  String? aldea;
  double? valorComercial;
  int? valorAvaluo;
  String? descripcion;
  String? descDetallada;
  String? noCertificado;
  String? noDpf;
  String? montoCertificado;
  String? titularCertificado;
  String? evaluadorCodigo;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: FadeIn(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Text(
                  'Ingresa los datos requeridos',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                title: 'No. de Certificado',
                icon: Icon(
                  Icons.receipt_long,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  noCertificado = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'No. de DPF',
                icon: Icon(
                  Icons.folder_copy,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  noDpf = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Monto del DPF',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  montoCertificado = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Titular del DPF',
                icon: Icon(
                  Icons.person,
                  color: AppColors.getPrimaryColor(),
                ),
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  titularCertificado = value;
                },
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Text(
                  'Ubicación',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                hintText: 'Ingresa Departamento',
                title: 'Departamento',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                where: 'HN',
                onChanged: (v) {
                  if (v == null) return;
                  setState(() {
                    departamento = v.valor;
                  });
                },
                codigo: 'DEP',
              ),
              if (departamento != null) ...[
                const Gap(20),
                FadeIn(
                  child: CatalogoValorNacionalidad(
                    where: departamento,
                    hintText: 'Ingresa Municipio',
                    title: 'Municipio',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        municipio = v.valor;
                      });
                    },
                    codigo: 'MUN',
                  ),
                ),
              ],
              if (municipio != null) ...[
                const Gap(20),
                FadeIn(
                  child: CatalogoValorNacionalidad(
                    where: municipio,
                    hintText: 'Ingresa Aldea',
                    title: 'Aldea',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        aldea = v.valor;
                      });
                    },
                    codigo: 'ALD',
                  ),
                ),
              ],
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Valor Comercial',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  CurrencyInputFormatter(mantissaLength: 0),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  valorComercial = double.tryParse(newValue);
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Valor de avaluo',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  CurrencyInputFormatter(mantissaLength: 0),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  valorAvaluo = int.tryParse(newValue);
                },
              ),
              const Gap(20),
              EvaluadoresCnbsDropdownWidget(
                onChanged: (value) {
                  evaluadorCodigo = value?.value;
                },
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Descripcion',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  descripcion = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Descripcion Detallada',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  descDetallada = value;
                },
              ),
              const Gap(20),
              BlocConsumer<AnalisisGarantiaDetalleCubit,
                  AnalisisGarantiaDetalleState>(
                listenWhen: (prev, curr) => prev.status != curr.status,
                listener: (context, state) {
                  if (state.status == Status.done) {
                    CustomAlertDialog(
                      context: context,
                      title: 'Detalle de Garantia creado exitosamente',
                      onDone: () => {
                        context.pop(),
                        formKey.currentState?.reset(),
                      },
                    ).showDialog(
                      context,
                      dialogType: DialogType.success,
                    );
                  }
                  if (state.status == Status.error) {
                    CustomAlertDialog(
                      context: context,
                      title: state.errorMsg,
                      onDone: () => {
                        context.pop(),
                      },
                    ).showDialog(
                      context,
                      dialogType: DialogType.error,
                    );
                  }
                },
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: CustomElevatedButton(
                      enabled: state.status != Status.inProgress,
                      text: state.status == Status.inProgress
                          ? 'Creando...'
                          : 'Crear',
                      // ignore: deprecated_member_use
                      color: AppColors.greenLatern.withOpacity(0.4),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        context
                            .read<AnalisisGarantiaDetalleCubit>()
                            .createAnalisisDetalle(
                              analisisGarantiaDetalle: AnalisisGarantiaDetalle(
                                objCuentaDPFID: widget.dpfsId,
                                valorComercial: valorComercial!,
                                valorAvaluo: valorAvaluo!,
                                descripcion: descripcion,
                                descDetallada: descDetallada,
                                departamentoCodigo: departamento!,
                                municipioCodigo: municipio!,
                                aldeaCodigo: aldea!,
                                objAnalisisGarantiaID:
                                    widget.objAnalisisGarantiaID,
                                articuloGarantiaCodigo:
                                    widget.articuloGarantiaCodigo,
                                codValuadorCnbs: evaluadorCodigo,
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
