import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_obtener_bien_by_codigo/analisis_obtener_bien_by_codigo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/evaluadores_cnbs_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class DerechoActualizarGarantiaForm extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final String tipoPersonaCodigo;
  final AnalisisObtenerBienByCodigoState bien;
  const DerechoActualizarGarantiaForm({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.tipoPersonaCodigo,
    required this.bien,
  });

  @override
  State<DerechoActualizarGarantiaForm> createState() =>
      _DerechoActualizarGarantiaFormState();
}

class _DerechoActualizarGarantiaFormState
    extends State<DerechoActualizarGarantiaForm> {
  String? cedulaPropietario;
  String? numeroReferencia;
  String? descripcion;
  String? lugar;
  String? departamento;
  String? municipio;
  String? aldea;
  String? observaciones;
  double? valorComercial;
  double? valorAvaluo;
  String? evaluadorCodigo;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final bien = widget.bien;
    cedulaPropietario = bien.cedulaPropietario;
    numeroReferencia = bien.numeroReferencia;
    lugar = bien.lugar;
    observaciones = bien.observaciones;
    valorComercial = bien.valorComercial.toDouble();
    valorAvaluo = bien.valorAvaluo.toDouble();
    evaluadorCodigo =
        bien.evaluadorId == 0 ? null : bien.evaluadorId.toString();
    departamento =
        bien.departamentoCodigo.isEmpty ? null : bien.departamentoCodigo;
    municipio = bien.municipioCodigo.isEmpty ? null : bien.municipioCodigo;
    aldea = bien.aldeaCodigo.isEmpty ? null : bien.aldeaCodigo;
  }

  @override
  Widget build(BuildContext context) {
    final bien = widget.bien;
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
                      cedulaPropietario = value;
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
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Numero de Referencia',
                  initialValue: bien.numeroReferencia,
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    numeroReferencia = value;
                  },
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Descripcion',
                  icon: Icon(
                    Icons.inventory_2_outlined,
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
                const Gap(12),
                OutlineTextfieldWidget(
                  title: 'Lugar',
                  initialValue: bien.lugar,
                  icon: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    lugar = value;
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
                      aldea = null;
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
                        aldea = null;
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
                    valorComercial = double.tryParse(newValue);
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
                    valorAvaluo = double.tryParse(newValue);
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
                    evaluadorCodigo = value?.value;
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
                    observaciones = value;
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
                      // TODO: wire this up to the update endpoint for garantia
                      // bien once it exists on AnalisisRepositoryHn. The edited
                      // values live in this state's fields, the bien being
                      // edited is widget.bien.bienId and the familia for this
                      // form is 'DERECHO'.
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
