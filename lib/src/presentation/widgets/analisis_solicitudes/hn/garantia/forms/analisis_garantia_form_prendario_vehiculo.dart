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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisGarantiaFormVehiculo extends StatefulWidget {
  final int dpfsId;
  final int objAnalisisGarantiaID;
  final String? descripcion;
  final int? articuloGarantiaCodigo;

  const AnalisisGarantiaFormVehiculo({
    super.key,
    required this.dpfsId,
    required this.objAnalisisGarantiaID,
    this.articuloGarantiaCodigo,
    this.descripcion,
  });

  @override
  State<AnalisisGarantiaFormVehiculo> createState() =>
      _AnalisisGarantiaFormVehiculoState();
}

class _AnalisisGarantiaFormVehiculoState
    extends State<AnalisisGarantiaFormVehiculo> {
  int? cantidad;
  double? valorComercial;
  String? marca;
  String? modelo;
  String? color;
  String? serie;
  String? anioVehiculo;
  String? numPlaca;
  String? direccion;
  String? numeroEscritura;
  String? numeroEscrituraPublica;
  DateTime? fechaElaboracionEscritura;
  DateTime? fechaDeIngreso;
  DateTime? fechaInscripcion;
  DateTime? fechaVencimiento;
  String? notarioElaboracionEscritura;
  String? descGeneral;
  String? descDetallada;
  String? numEscritura;
  bool inscrito = false;
  String? medidas;
  String? numAsiento;
  String? codValuadorCnbs;
  String? departamento;
  String? municipio;
  String? aldea;
  String? descripcion;
  int? valorAvaluo;
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
                title: 'Marca',
                icon: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  marca = value;
                },
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                title: 'Modelo',
                icon: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  modelo = value;
                },
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                title: 'Color',
                icon: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  color = value;
                },
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                title: 'Ano',
                icon: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  anioVehiculo = value;
                },
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                title: 'Placa',
                icon: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  numPlaca = value;
                },
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
                CatalogoValorNacionalidad(
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
              ],
              if (municipio != null) ...[
                const Gap(20),
                CatalogoValorNacionalidad(
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
              OutlineTextfieldWidget(
                title: 'Evaluador',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  CurrencyInputFormatter(mantissaLength: 0),
                ],
                onChange: (value) {},
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Descripcion',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
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
                textInputType: TextInputType.number,
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
                                departamentoCodigo: departamento!,
                                municipioCodigo: municipio!,
                                aldeaCodigo: aldea!,
                                marca: marca,
                                modelo: modelo,
                                color: color,
                                serie: serie,
                                valorComercial: valorComercial!,
                                objAnalisisGarantiaID:
                                    widget.objAnalisisGarantiaID,
                                anioVehiculo: int.tryParse(anioVehiculo!),
                                numPlaca: numPlaca,
                                articuloGarantiaCodigo:
                                    widget.articuloGarantiaCodigo,
                                descDetallada: descDetallada,
                                descripcion: descripcion,
                                valorAvaluo: valorAvaluo,
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
