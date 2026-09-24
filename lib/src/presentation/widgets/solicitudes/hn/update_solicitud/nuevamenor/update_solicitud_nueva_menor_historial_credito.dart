// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudNuevaMenorHistorialCredito extends StatelessWidget {
  final PageController controller;
  final int currentStep;
  final int steps;
  const UpdateSolicitudNuevaMenorHistorialCredito({
    super.key,
    required this.controller,
    this.currentStep = 8,
    this.steps = 9,
  });

  @override
  Widget build(BuildContext context) {
    final historialCredito = context.select(
      (UpdateSolicitudNuevaMenorCubit cubit) => cubit.state.historialCredito,
    );
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MiCreditoProgress(
            currentStep: currentStep,
            steps: steps,
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Historial de créditos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Gap(20),
          if (historialCredito.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Esta solicitud no tiene créditos registrados.'),
            ),
          ...historialCredito.map(
            (e) => AnalisisCardVentasDay(
              title: e.monto.toCurrencyString(),
              subtitle: e.entidad,
              description: e.saldo.toCurrencyString(),
              onTap: () => showHistorialCreditoOptionsBottomSheet(
                context: context,
                onEdit: () => _showHistorialCreditoForm(
                  context,
                  initial: e,
                  onSave: (updated) =>
                      cubit.updateHistorialCredito(updated: updated),
                ),
                onDelete: () => cubit.deleteHistorialCredito(uuid: e.uuid),
              ),
            ),
          ),
          const Gap(20),
          Container(
            width: double.infinity,
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.getPrimaryColor().withOpacity(0.08),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.getPrimaryColor().withOpacity(0.4),
                width: 1.2,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => _showHistorialCreditoForm(
                context,
                onSave: (created) =>
                    cubit.saveHistorialCredito(historialCredito: created),
              ),
              splashColor: AppColors.getPrimaryColor().withOpacity(0.2),
              highlightColor: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 42),
                  Gap(8),
                  Text(
                    'Añadir crédito',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'Siguiente',
              color: AppColors.greenLatern.withOpacity(0.4),
              onPressed: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomOutLineButton(
              onPressed: () {
                controller.previousPage(
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
    );
  }
}

void _showHistorialCreditoForm(
  BuildContext context, {
  HistorialCredito? initial,
  required ValueChanged<HistorialCredito> onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => _HistorialCreditoForm(
      initial: initial,
      onSave: onSave,
    ),
  );
}

class _HistorialCreditoForm extends StatefulWidget {
  final HistorialCredito? initial;
  final ValueChanged<HistorialCredito> onSave;
  const _HistorialCreditoForm({
    this.initial,
    required this.onSave,
  });

  @override
  State<_HistorialCreditoForm> createState() => _HistorialCreditoFormState();
}

class _HistorialCreditoFormState extends State<_HistorialCreditoForm> {
  final formKey = GlobalKey<FormState>();
  late String entidad = widget.initial?.entidad ?? '';
  late int monto = widget.initial?.monto ?? 0;
  late String tipoMonedaCodigo = widget.initial?.tipoMonedaCodigo ?? '';
  late String tipoFrecuenciaCodigo = widget.initial?.tipoFrecuenciaCodigo ?? '';
  late int cuota = widget.initial?.cuota ?? 0;
  late int saldo = widget.initial?.saldo ?? 0;
  late String estadoCodigo = widget.initial?.estadoCodigo ?? '';
  late String monedaNombre = widget.initial?.monedaNombre ?? '';
  late String frecuenciaNombre = widget.initial?.frecuenciaNombre ?? '';
  late String estadoNombre = widget.initial?.estadoNombre ?? '';
  late DateTime? fechaDesembolso = widget.initial?.fechaDesembolso;

  String _nombreOrCodigo(String nombre, String codigo) =>
      nombre.isNotEmpty ? nombre : codigo;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaDesembolso,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked == null || picked == fechaDesembolso) return;
    setState(() {
      fechaDesembolso = picked;
    });
  }

  void _showWarning(String title) {
    CustomAlertDialog(
      context: context,
      title: title,
      onDone: () => context.pop(),
    ).showDialog(context);
  }

  void _onSubmit() {
    if (!formKey.currentState!.validate()) return;
    if (cuota > monto) {
      _showWarning('Cuota no puede ser mayor al monto');
      return;
    }
    if (saldo > monto) {
      _showWarning('Saldo no puede ser mayor al monto');
      return;
    }
    widget.onSave(
      HistorialCredito(
        id: widget.initial?.id,
        uuid: widget.initial?.uuid ?? const Uuid().v4(),
        entidad: entidad,
        monto: monto,
        tipoMonedaCodigo: tipoMonedaCodigo,
        tipoFrecuenciaCodigo: tipoFrecuenciaCodigo,
        cuota: cuota,
        saldo: saldo,
        estadoCodigo: estadoCodigo,
        monedaNombre: monedaNombre,
        frecuenciaNombre: frecuenciaNombre,
        estadoNombre: estadoNombre,
        fechaDesembolso: fechaDesembolso!,
      ),
    );
    context.pop();
  }

  int _parseCurrency(String value) =>
      int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Gap(15),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: entidad,
                      title: 'Nombre de Entidad',
                      icon: const Icon(Icons.business),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => entidad = value,
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: _nombreOrCodigo(monedaNombre, tipoMonedaCodigo),
                        value: tipoMonedaCodigo,
                      ),
                      codigo: 'MONEDA',
                      title: 'Tipo Moneda',
                      validator: (value) {
                        // Respaldo: el dropdown guarda su propia selección.
                        tipoMonedaCodigo =
                            value?.value?.toString() ?? tipoMonedaCodigo;
                        return ClassValidator.validateRequired(value?.value);
                      },
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        tipoMonedaCodigo = value.value;
                        monedaNombre = value.name;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue:
                          monto.toCurrencyString().toNullIfEmptyOrZero(),
                      title: 'Monto',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(mantissaLength: 0),
                      ],
                      onChange: (value) => monto = _parseCurrency(value),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue:
                          cuota.toCurrencyString().toNullIfEmptyOrZero(),
                      title: 'Cuota',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(mantissaLength: 0),
                      ],
                      onChange: (value) => cuota = _parseCurrency(value),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue:
                          saldo.toCurrencyString().toNullIfEmptyOrZero(),
                      title: 'Saldo',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(mantissaLength: 0),
                      ],
                      onChange: (value) => saldo = _parseCurrency(value),
                    ),
                    const Gap(20),
                    CatalogoFrecuenciaPagoDropdown(
                      selectedItem: CatalogoFrecuenciaItem(
                        valor: tipoFrecuenciaCodigo,
                        nombre: _nombreOrCodigo(
                          frecuenciaNombre,
                          tipoFrecuenciaCodigo,
                        ),
                        meses: 0.toString(),
                      ),
                      title: 'Tipo Frecuencia Pago',
                      validator: (value) {
                        tipoFrecuenciaCodigo =
                            value?.valor ?? tipoFrecuenciaCodigo;
                        return ClassValidator.validateRequired(value?.valor);
                      },
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        tipoFrecuenciaCodigo = value.valor;
                        frecuenciaNombre = value.nombre;
                      },
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: _nombreOrCodigo(estadoNombre, estadoCodigo),
                        value: estadoCodigo,
                      ),
                      codigo: 'ESTADOPRESTAMO',
                      title: 'Estado de Crédito',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        estadoCodigo = value.value;
                        estadoNombre = value.name;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      readOnly: true,
                      title: 'Fecha de desembolso',
                      icon: const Icon(Icons.calendar_month),
                      validator: (value) => ClassValidator.validateRequired(
                          fechaDesembolso?.selectorFormat()),
                      hintText: fechaDesembolso?.selectorFormat() ?? '',
                      onTap: () => selectDate(context),
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled: true,
                        text: widget.initial == null
                            ? 'Crear Crédito'
                            : 'Actualizar Crédito',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: _onSubmit,
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
