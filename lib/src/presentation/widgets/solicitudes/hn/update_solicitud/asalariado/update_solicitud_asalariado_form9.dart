import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudAsalariadoForm9 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudAsalariadoForm9({
    super.key,
    required this.controller,
  });

  @override
  State<UpdateSolicitudAsalariadoForm9> createState() =>
      _UpdateSolicitudAsalariadoForm9State();
}

class _UpdateSolicitudAsalariadoForm9State
    extends State<UpdateSolicitudAsalariadoForm9> {
  final formKey = GlobalKey<FormState>();
  DateTime? fechaPrimerPago;
  DateTime fechaDesembolso = DateTime.now();
  double? tasaInteres;
  num? montoMinimo;
  double? montoMaximo;
  String? monto;
  String? plazoSolicitud;
  CatalogoFrecuenciaItem? frecuenciaDePago;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
    fechaPrimerPago = DateTime.tryParse(cubit.state.fechaPrimerPagoSolicitud);
    monto = cubit.state.monto.toString();
    plazoSolicitud = cubit.state.plazoSolicitud.toString();
    frecuenciaDePago = CatalogoFrecuenciaItem(
      valor: cubit.state.frecuenciaCodigo,
      nombre: cubit.state.frecuenciaNombre,
      meses: '0',
    );
  }

  final List<DateTime> holidays = [
    DateTime(DateTime.now().year, 1, 1), // Año Nuevo
    DateTime(DateTime.now().year, 4, 14), // Día de las Américas
    DateTime(DateTime.now().year, 5, 1), // Día del Trabajo
    DateTime(DateTime.now().year, 9, 15), // Día de la Independencia
    DateTime(DateTime.now().year, 12, 25), // Navidad
  ];

  bool _isHoliday(DateTime date) {
    return holidays.any((h) =>
        h.year == date.year && h.month == date.month && h.day == date.day);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaPrimerPago,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
      selectableDayPredicate: (day) {
        if (day.weekday == DateTime.sunday) return false;
        if (_isHoliday(day)) return false;
        return true;
      },
    );
    if (picked != null && picked != fechaPrimerPago) {
      if (!context.mounted) return;
      if (picked.isBefore(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      if (picked.isAtSameMomentAs(fechaDesembolso)) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title:
              'La Fecha de primer pago no puede ser igual a la fecha de desembolso',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaPrimerPago = picked;
      context.read<UpdateSolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<UpdateSolicitudNuevaMenorCubit>().state.copyWith(
                  fechaPrimerPagoSolicitud:
                      fechaPrimerPago?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectFechaDesembolso(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaDesembolso,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
      selectableDayPredicate: (day) {
        if (day.weekday == DateTime.sunday) return false;
        if (_isHoliday(day)) return false;
        return true;
      },
    );
    if (picked != null && picked != fechaDesembolso) {
      if (!context.mounted) return;
      if (picked.isBefore(today)) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      if (picked.isAtSameMomentAs(fechaPrimerPago ?? DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title:
              'La Fecha de desembolso no puede ser igual a la fecha de primer pago',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaDesembolso = picked;
      context.read<UpdateSolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<UpdateSolicitudNuevaMenorCubit>().state.copyWith(
                // fechaDesembolso: fechaDesembolso.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 9,
              steps: 9,
            ),
            const Gap(30),
            Column(
              children: [
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.sectorNombre,
                    value: cubit.state.sectorCodigo,
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'SECTORECONOMICO',
                  hintText: 'Sector',
                  title: 'Sector',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        sectorCodigo: value.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.productoNombre,
                    value: cubit.state.productoCodigo,
                  ),
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  hintText: 'Selecciona un Producto',
                  title: 'Producto ',
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'PRODUCTO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tasaInteres = item.interes;
                    montoMaximo = item.montoMaximo;
                    montoMinimo = item.montoMinimo;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        productoCodigo: item.value,
                        // tasaInteres: item.interes,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.monedaNombre,
                    value: cubit.state.monedaCodigo,
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'ingresa Moneda',
                  title: 'Moneda',
                  codigo: 'MONEDA',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        monedaCodigo: value.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.propositoNombre,
                    value: cubit.state.propositoCodigo,
                  ),
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  codigo: 'DESTINOCREDITO',
                  hintText: 'selecciona un Destino',
                  title: 'Destino del Crédito',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        propositoCodigo: value.value,
                      ),
                    );
                  },
                ),
                if (cubit.state.propositoCodigo.isNotEmpty) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.descripcionDestino,
                    key: const ValueKey('DestinoDescripcion'),
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'ingresa descripcion del Destino',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(200),
                    ],
                    icon: Icon(Icons.description_outlined,
                        color: AppColors.getPrimaryColor()),
                    title: 'Descripcion del Destino',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          descripcionDestino: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.monto.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  key: const ValueKey('Monto'),
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Monto',
                  icon: Icon(Icons.wallet, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Monto',
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                    final montoCredito = int.tryParse(newValue) ?? 0;
                    monto = newValue;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        monto: montoCredito,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoFrecuenciaPagoDropdown(
                  selectedItem: CatalogoFrecuenciaItem(
                    valor: cubit.state.frecuenciaCodigo,
                    nombre: cubit.state.frecuenciaNombre,
                    meses: '0',
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'ingresa Frecuencia',
                  title: 'Frecuencia de pago',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        frecuenciaCodigo: item.valor,
                        frecuenciaNombre: item.meses,
                      ),
                    );
                    frecuenciaDePago = CatalogoFrecuenciaItem(
                      valor: item.valor,
                      nombre: item.nombre,
                      meses: item.meses,
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.plazoSolicitud.toString(),
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Plazo de Solicitud (meses)',
                  icon: Icon(
                    Icons.schedule,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Plazo de Solicitud (meses)',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  onChange: (value) {
                    plazoSolicitud = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        plazoSolicitud: int.tryParse(value) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  onTap: () => selectFechaDesembolso(context),
                  validator: (value) => ClassValidator.validateRequired(
                    fechaDesembolso.selectorFormat(),
                  ),
                  hintText: fechaDesembolso.selectorFormat(),
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha de desembolso',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  onTap: () => selectDate(context),
                  validator: (value) => ClassValidator.validateRequired(
                    fechaPrimerPago?.selectorFormat(),
                  ),
                  hintText:
                      fechaPrimerPago?.selectorFormat() ?? 'Fecha Primer Pago',
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha de Primer Pago',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.observacion,
                  hintText: 'Observación',
                  icon: Icon(Icons.note, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  title: 'Observacion',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        observacion: value,
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
                // ignore: deprecated_member_use
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  if (double.tryParse(monto ?? '0') == 0) {
                    CustomAlertDialog(
                      context: context,
                      title: 'El monto no puede ser 0',
                      onDone: () => context.pop(),
                    ).showDialog(context, dialogType: DialogType.warning);
                    return;
                  }
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
}
