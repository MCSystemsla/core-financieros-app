import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/select_date/select_date_helper.dart';
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
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ActualizarDetalleBienHipotecario extends StatelessWidget {
  final int objAnalisisGarantiaId;
  final String tipoPersonaCodigo;
  const ActualizarDetalleBienHipotecario({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.tipoPersonaCodigo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisObtenerBienByCodigoCubit,
        AnalisisObtenerBienByCodigoState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const LoadingWidget(),
          Status.error => OnErrorWidget(
              errorMsg: state.errorMsg,
              onPressed: () {},
            ),
          Status.done => _HipotecarioForm(
              objAnalisisGarantiaId: objAnalisisGarantiaId,
              tipoPersonaCodigo: tipoPersonaCodigo,
              bien: state,
            ),
          _ => const SizedBox(),
        };
      },
    );
  }
}

class _HipotecarioForm extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final String tipoPersonaCodigo;
  final AnalisisObtenerBienByCodigoState bien;
  const _HipotecarioForm({
    required this.objAnalisisGarantiaId,
    required this.tipoPersonaCodigo,
    required this.bien,
  });

  @override
  State<_HipotecarioForm> createState() => _HipotecarioFormState();
}

class _HipotecarioFormState extends State<_HipotecarioForm> {
  String? departamento;
  String? municipio;
  DateTime? fechaInscripcion;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final bien = widget.bien;
    departamento =
        bien.departamentoCodigo.isEmpty ? null : bien.departamentoCodigo;
    municipio = bien.municipioCodigo.isEmpty ? null : bien.municipioCodigo;
    fechaInscripcion = DateTime.tryParse(bien.fechaInscripcion);
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
        numEscritura: bien.asiento,
        numTomo: bien.numTomo,
        folio: bien.folio,
        fechaInscripcion: bien.fechaInscripcion,
        areaVarasCuadradas: bien.areaVarasCuadradas.toDouble(),
        areaMetrosCuadrados: bien.areaMetrosCuadrados.toDouble(),
        direccion: bien.direccion,
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
                  title: 'Direccion',
                  initialValue: bien.direccion,
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
                      () => cubit.state.copyWith(direccion: value),
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
                  title: 'Valor de mercado',
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
                    final newValue = toNumericString(value, allowPeriod: true);
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
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
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
                const Gap(12),
                OutlineTextfieldWidget(
                  initialValue: bien.asiento,
                  title: 'No. de escritura',
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(numEscritura: value),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'No. de tomo',
                  initialValue: bien.numTomo,
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(numTomo: value),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Folio',
                  initialValue: bien.folio,
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
                      () => cubit.state.copyWith(folio: value),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Fecha de inscripcion',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.number,
                  validator: (value) => ClassValidator.validateRequired(
                      fechaInscripcion?.selectorFormat()),
                  hintText: fechaInscripcion?.selectorFormat(),
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await pickDate(
                      context,
                      initialDate: fechaInscripcion ?? DateTime.now(),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate == null) return;
                    setState(() {
                      fechaInscripcion = pickedDate;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        fechaInscripcion: pickedDate.toIso8601String(),
                      ),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Vrs2',
                  initialValue: bien.areaVarasCuadradas.toString(),
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        areaVarasCuadradas: double.tryParse(value ?? ''),
                      ),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Mts2',
                  initialValue: bien.areaMetrosCuadrados.toString(),
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        areaMetrosCuadrados: double.tryParse(value ?? ''),
                      ),
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
                            familia: 'INMUEBLE',
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
