import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia_actualizar/analisis_garantia_actualizar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_obtener_bien_by_codigo/analisis_obtener_bien_by_codigo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/evaluadores_cnbs_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MaquinariaActualizarGarantiaForm extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final String tipoPersonaCodigo;
  final AnalisisObtenerBienByCodigoState bien;
  const MaquinariaActualizarGarantiaForm({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.tipoPersonaCodigo,
    required this.bien,
  });

  @override
  State<MaquinariaActualizarGarantiaForm> createState() =>
      _MaquinariaActualizarGarantiaFormState();
}

class _MaquinariaActualizarGarantiaFormState
    extends State<MaquinariaActualizarGarantiaForm> {
  String? departamento;
  String? municipio;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final bien = widget.bien;
    departamento =
        bien.departamentoCodigo.isEmpty ? null : bien.departamentoCodigo;
    municipio = bien.municipioCodigo.isEmpty ? null : bien.municipioCodigo;
    final cubit = context.read<AnalisisGarantiaActualizarCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        codigoBien: bien.bienCodigo,
        objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
        cedulaPropietario: bien.cedulaPropietario,
        observaciones: bien.observaciones,
        departamentoCodigo: bien.departamentoCodigo,
        municipioCodigo: bien.municipioCodigo,
        aldeaCodigo: bien.aldeaCodigo,
        valorComercial: bien.valorComercial.toDouble(),
        valorAvaluo: bien.valorAvaluo.toDouble(),
        tipoValoracionCodigo: bien.tipoValoracionCodigo,
        objValuadorId: bien.evaluadorId,
        tipo: bien.tipo,
        marca: bien.marca,
        modelo: bien.modelo,
        color: bien.color,
        serie: bien.serie,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bien = widget.bien;
    final cubit = context.read<AnalisisGarantiaActualizarCubit>();
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
                    'Actualiza los datos requeridos',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (widget.tipoPersonaCodigo != 'DEUDOR') ...[
                  const Gap(12),
                  OutlineTextfieldWidget(
                    title: 'Cedula del Propietario',
                    initialValue: bien.cedulaPropietario,
                    icon: Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.getPrimaryColor(),
                    ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(cedulaPropietario: value),
                      );
                    },
                  ),
                ],
                SearchDropdownWidget(
                  codigo: CatalogoType.tipoValoracionGarantia.codigo,
                  title: 'Tipo Valoración de Garantia',
                  hintText: 'Selecciona un tipo de valoración de garantia',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (v) {
                    if (v == null) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoValoracionCodigo: v.value,
                      ),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Tipo',
                  initialValue: bien.tipo,
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
                  initialValue: bien.marca,
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
                      () => cubit.state.copyWith(marca: value),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Modelo',
                  initialValue: bien.modelo,
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
                      () => cubit.state.copyWith(modelo: value),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Color',
                  initialValue: bien.color,
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
                      () => cubit.state.copyWith(color: value),
                    );
                  },
                ),
                OutlineTextfieldWidget(
                  title: 'Serie',
                  initialValue: bien.serie,
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
                  selectedItem: bien.departamentoCodigo.isEmpty
                      ? null
                      : ItemNacionalidad(
                          id: 0,
                          valor: bien.departamentoCodigo,
                          nombre: bien.departamentoNombre,
                          relacion: '',
                        ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  where: 'HN',
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      departamento = v.valor;
                      municipio = null;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        departamentoCodigo: v.valor,
                        municipioCodigo: '',
                        aldeaCodigo: '',
                      ),
                    );
                  },
                  codigo: 'DEP',
                ),
                if (departamento != null) ...[
                  const Gap(20),
                  CatalogoValorNacionalidad(
                    where: departamento,
                    hintText: 'Ingresa Municipio',
                    title: 'Municipio',
                    selectedItem: bien.municipioCodigo.isEmpty
                        ? null
                        : ItemNacionalidad(
                            id: 0,
                            valor: bien.municipioCodigo,
                            nombre: bien.municipioNombre,
                            relacion: '',
                          ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        municipio = v.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          municipioCodigo: v.valor,
                          aldeaCodigo: '',
                        ),
                      );
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
                    selectedItem: bien.aldeaCodigo.isEmpty
                        ? null
                        : ItemNacionalidad(
                            id: 0,
                            valor: bien.aldeaCodigo,
                            nombre: bien.aldeaNombre,
                            relacion: '',
                          ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(aldeaCodigo: v.valor),
                      );
                    },
                    codigo: 'ALD',
                  ),
                ],
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Valor Comercial',
                  initialValue: bien.valorComercial == 0
                      ? null
                      : bien.valorComercial.toString(),
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        valorComercial: double.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Valor de avaluo',
                  initialValue: bien.valorAvaluo == 0
                      ? null
                      : bien.valorAvaluo.toString(),
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        valorAvaluo: double.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                EvaluadoresCnbsDropdownWidget(
                  selectedItem: bien.evaluadorId == 0
                      ? null
                      : Item(
                          name: bien.evaluadorNombre,
                          value: bien.evaluadorId.toString(),
                        ),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objValuadorId: int.tryParse(value?.value ?? ''),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Observaciones',
                  initialValue: bien.observaciones,
                  icon: Icon(
                    Icons.wallet,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(observaciones: value),
                    );
                  },
                ),
                const Gap(20),
                BlocConsumer<AnalisisGarantiaActualizarCubit,
                    AnalisisGarantiaActualizarState>(
                  listenWhen: (prev, curr) => prev.status != curr.status,
                  listener: (ctx, state) {
                    if (state.status == Status.inProgress) {
                      context.showLoading(
                          message: 'Actualizando Detalle garantia');
                    }
                    if (state.status == Status.done) {
                      context.hideLoading();
                      showV2CustomSnackbar(
                        context,
                        title: 'Garantia actualizada exitosamente',
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
                        title: state.errorMsg,
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
                            ? 'Actualizando...'
                            : 'Actualizar',
                        // ignore: deprecated_member_use
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          cubit.actualizarGarantia(
                            familia: 'EQUIPO',
                            objAnalisisGarantiaId: widget.objAnalisisGarantiaId,
                            codigoBien: widget.bien.bienCodigo,
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
