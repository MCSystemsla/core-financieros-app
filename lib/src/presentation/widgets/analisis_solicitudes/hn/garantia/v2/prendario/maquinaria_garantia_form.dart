import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/evaluadores_cnbs_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../bloc/analisis/hn/analisis_create_garantia_bien/analisis_create_garantia_bien_cubit.dart';
import 'package:flutter/material.dart';

class MaquinariaGarantiaForm extends StatefulWidget {
  final int objAnalisisGarantiaId;
  const MaquinariaGarantiaForm({
    super.key,
    required this.objAnalisisGarantiaId,
  });

  @override
  State<MaquinariaGarantiaForm> createState() => _MaquinariaGarantiaFormState();
}

class _MaquinariaGarantiaFormState extends State<MaquinariaGarantiaForm> {
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
  double? valorAvaluo;
  String? evaluadorCodigo;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisCreateGarantiaBienCubit>();
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
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  title: 'Tipo',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(tipo: value),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Marca',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    marca = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(marca: marca),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Modelo',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    modelo = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(modelo: modelo),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Color',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    color = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(color: color),
                    );
                  },
                ),
                // const Gap(12),
                // OutlineTextfieldWidget(
                //   title: 'Ano',
                //   icon: Icon(
                //     Icons.inventory_2_outlined,
                //     color: AppColors.getPrimaryColor(),
                //   ),
                //   textInputType: TextInputType.number,
                //   validator: (value) => ClassValidator.validateRequired(value),
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //     LengthLimitingTextInputFormatter(4),
                //   ],
                //   onChange: (value) {
                //     anioVehiculo = value;
                //     cubit.onFieldChanged(
                //       () => cubit.state
                //           .copyWith(anio: int.tryParse(anioVehiculo ?? '0')),
                //     );
                //   },
                // ),
                // const Gap(12),
                // OutlineTextfieldWidget(
                //   title: 'Placa',
                //   icon: Icon(
                //     Icons.inventory_2_outlined,
                //     color: AppColors.getPrimaryColor(),
                //   ),
                //   validator: (value) => ClassValidator.validateRequired(value),
                //   inputFormatters: [
                //     UpperCaseTextFormatter(),
                //   ],
                //   onChange: (value) {
                //     numPlaca = value;
                //     cubit.onFieldChanged(
                //       () => cubit.state.copyWith(placa: numPlaca),
                //     );
                //   },
                // ),
                OutlineTextfieldWidget(
                  title: 'Serie',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(serie: value),
                    );
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
                      cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(departamentoCodigo: departamento),
                      );
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
                        cubit.onFieldChanged(
                          () =>
                              cubit.state.copyWith(municipioCodigo: municipio),
                        );
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
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(aldeaCodigo: aldea),
                        );
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
                    cubit.onFieldChanged(
                      () =>
                          cubit.state.copyWith(valorComercial: valorComercial),
                    );
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
                    valorAvaluo = double.tryParse(newValue);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(valorAvaluo: valorAvaluo),
                    );
                  },
                ),
                const Gap(20),
                EvaluadoresCnbsDropdownWidget(
                  onChanged: (value) {
                    evaluadorCodigo = value?.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                          objValuadorID: int.tryParse(evaluadorCodigo ?? '0')),
                    );
                  },
                  // validator: (value) =>
                  // ClassValidator.validateRequired(value?.value),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Observaciones',
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(observaciones: descripcion),
                    );
                  },
                ),
                // const Gap(20),
                // OutlineTextfieldWidget(
                //   title: 'Descripcion Detallada',
                //   icon: Icon(
                //     Icons.wallet,
                //     color: AppColors.getPrimaryColor(),
                //   ),
                //   validator: (value) => ClassValidator.validateRequired(value),
                //   inputFormatters: [
                //     UpperCaseTextFormatter(),
                //   ],
                //   onChange: (value) {
                //     descDetallada = value;
                //   },
                // ),
                const Gap(20),
                BlocConsumer<AnalisisCreateGarantiaBienCubit,
                    AnalisisCreateGarantiaBienState>(
                  listenWhen: (prev, curr) => prev.status != curr.status,
                  listener: (ctx, state) {
                    if (state.status == Status.inProgress) {
                      context.showLoading(message: 'Creando Detalle garantia');
                    }
                    if (state.status == Status.done) {
                      context.hideLoading();
                      formKey.currentState?.reset();

                      showV2CustomSnackbar(
                        context,
                        title: state.succesMsg,
                        type: SnackbarType.success,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AnalisisInterceptorByFlavor(),
                        ),
                      );
                    }
                    if (state.status == Status.error) {
                      context.hideLoading();
                      CustomAlertDialog(
                        context: context,
                        title: state.erroMsg,
                        onDone: () => {
                          context.pop(),
                        },
                      ).showDialog(
                        context,
                        dialogType: DialogType.warning,
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
                              .read<AnalisisCreateGarantiaBienCubit>()
                              .createGarantiaBien(
                                familia: 'EQUIPO',
                                objAnalisisGarantiaId:
                                    widget.objAnalisisGarantiaId,
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
      ),
    );
  }
}
