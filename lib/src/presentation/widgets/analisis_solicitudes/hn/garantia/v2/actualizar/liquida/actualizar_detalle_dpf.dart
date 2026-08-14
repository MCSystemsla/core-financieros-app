import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia_obtener_detalle/analisis_garantia_obtener_detalle_dpf_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class ActualizarDetalleDPF extends StatelessWidget {
  final int objAnalisisGarantiaId;
  final int articuloCodigo;
  final String tipoPersonaCodigo;
  const ActualizarDetalleDPF({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.articuloCodigo,
    required this.tipoPersonaCodigo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisGarantiaObtenerDetalleDpfCubit,
        AnalisisGarantiaObtenerDetalleDpfState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const ModernLoadingWidget(),
          Status.error => OnErrorWidget(
              errorMsg: state.errorMsg,
              onPressed: () => context
                  .read<AnalisisGarantiaObtenerDetalleDpfCubit>()
                  .obtenerGarantiaDetalleDPF(
                    objAnalisisGarantiaID: objAnalisisGarantiaId,
                  ),
            ),
          Status.done => _DpfForm(
              objAnalisisGarantiaId: objAnalisisGarantiaId,
              articuloCodigo: articuloCodigo,
              tipoPersonaCodigo: tipoPersonaCodigo,
              detalle: state,
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

class _DpfForm extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final int articuloCodigo;
  final String tipoPersonaCodigo;
  final AnalisisGarantiaObtenerDetalleDpfState detalle;
  const _DpfForm({
    required this.objAnalisisGarantiaId,
    required this.articuloCodigo,
    required this.tipoPersonaCodigo,
    required this.detalle,
  });

  @override
  State<_DpfForm> createState() => _DpfFormState();
}

class _DpfFormState extends State<_DpfForm> {
  final formKey = GlobalKey<FormState>();

  int? objCuentaDpfId;
  double? valorComercial;
  String? observaciones;
  String? tipoValoracionCodigo;

  @override
  void initState() {
    super.initState();
    final detalle = widget.detalle;
    objCuentaDpfId = detalle.dpfId == 0 ? null : detalle.dpfId;
    valorComercial = detalle.valorComercial.toDouble();
    observaciones = detalle.observaciones;
  }

  @override
  Widget build(BuildContext context) {
    final detalle = widget.detalle;
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black87),
                      children: [
                        const TextSpan(
                          text: 'N. Cuenta: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: detalle.numeroCuenta),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: CatalogoType.tipoValoracionGarantia.codigo,
                  title: 'Tipo Valoración de Garantia',
                  hintText: 'Selecciona un tipo de valoración de garantia',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (v) {
                    if (v == null) return;
                    tipoValoracionCodigo = v.value;
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Valor Comercial',
                  initialValue: detalle.valorComercial.toCurrencyString(),
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
                    valorComercial = double.tryParse(newValue) ?? 0;
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Observaciones',
                  initialValue: detalle.observaciones,
                  icon: Icon(
                    Icons.wallet,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    observaciones = value ?? '';
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
                      // TODO: wire this up to the update endpoint for the DPF
                      // asignacion once it exists on AnalisisRepositoryHn.
                      // The edited values live in objCuentaDpfId, montoInicial,
                      // valorComercial, comentario and observaciones.
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
