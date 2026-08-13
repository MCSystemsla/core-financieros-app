import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/select_date/select_date_helper.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_create_garantia_bien/analisis_create_garantia_bien_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/evaluadores_cnbs_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class ActualizarDetalleBienHipotecario extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final String tipoPersonaCodigo;
  const ActualizarDetalleBienHipotecario({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.tipoPersonaCodigo,
  });

  @override
  State<ActualizarDetalleBienHipotecario> createState() =>
      _ActualizarDetalleBienHipotecarioState();
}

class _ActualizarDetalleBienHipotecarioState
    extends State<ActualizarDetalleBienHipotecario> {
  String? departamento;
  String? municipio;
  String? aldea;
  String? numEscritura;
  String? numDeLomo;
  String? folio;
  String? vrs2;
  String? mts2;
  DateTime? fechaInscripcion;
  String? direccion;
  double? valorComercial;
  double? valorAvaluo;
  String? descripcion;
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
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Direccion',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    direccion = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(direccion: direccion),
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
                    });
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(departamentoCodigo: departamento),
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        municipio = v.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(municipioCodigo: municipio),
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        aldea = v.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(aldeaCodigo: aldea),
                      );
                    },
                    codigo: 'ALD',
                  ),
                ],
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Valor de mercado',
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
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
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
                const Gap(12),
                OutlineTextfieldWidget(
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
                    numEscritura = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(numEscritura: numEscritura),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'No. de tomo',
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
                    numDeLomo = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(numTomo: numDeLomo),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Folio',
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    folio = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(folio: folio),
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
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate == null) return;
                    setState(() {
                      fechaInscripcion = pickedDate;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                          fechaInscripcion:
                              fechaInscripcion?.toUtc().toIso8601String()),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Vrs2',
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
                    vrs2 = value;
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(areaVaras2: double.tryParse(vrs2 ?? '0')),
                    );
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Mts2',
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
                    mts2 = value;
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(areaMetros2: double.tryParse(mts2 ?? '0')),
                    );
                  },
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Actualizar',
                    // ignore: deprecated_member_use
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      // TODO: wire this up to the update endpoint for
                      // garantia bien once it exists on AnalisisRepositoryHn.
                      // The edited values are already accumulated in
                      // AnalisisCreateGarantiaBienCubit's state, and the
                      // familia for this form is 'INMUEBLE'.
                    },
                  ),
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
