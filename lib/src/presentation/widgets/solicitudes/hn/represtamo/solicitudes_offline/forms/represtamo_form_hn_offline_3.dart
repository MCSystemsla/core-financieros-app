// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/cuota_data_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoFormHnOffline3 extends StatefulWidget {
  final PageController controller;
  const ReprestamoFormHnOffline3({
    super.key,
    required this.controller,
  });

  @override
  State<ReprestamoFormHnOffline3> createState() =>
      _ReprestamoFormHnOffline3State();
}

class _ReprestamoFormHnOffline3State extends State<ReprestamoFormHnOffline3>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  DateTime? fechaPrimerPago;
  DateTime fechaDesembolso = DateTime.now();
  String? monto;
  String? plazoSolicitud;
  CatalogoFrecuenciaItem? frecuenciaDePago;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SolicitudReprestamoHnCubit>();
    frecuenciaDePago = CatalogoFrecuenciaItem(
      valor: cubit.state.frecuenciaCodigo,
      nombre: cubit.state.frecuenciaCodigo,
      meses: cubit.state.frecuenciaPagoMeses,
    );
    monto = cubit.state.monto.toString();
    plazoSolicitud = cubit.state.plazoSolicitud.toString();
    fechaPrimerPago = DateTime.tryParse(cubit.state.fechaPrimerPagoSolicitud);
    fechaDesembolso =
        DateTime.tryParse(cubit.state.fechaDesembolso) ?? DateTime.now();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        monedaCodigo: 'CORDOBA',
      ),
    );
  }

  final List<DateTime> holidays = [
    DateTime(DateTime.now().year, 1, 1), // Año Nuevo
    DateTime(DateTime.now().year, 4, 14), // Día de las Américas
    DateTime(DateTime.now().year, 4, 17), // Jueves Santo
    DateTime(DateTime.now().year, 4, 18), // Viernes Santo
    DateTime(DateTime.now().year, 4, 19), // Sábado Santo
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
      context.read<SolicitudReprestamoHnCubit>().onFieldChanged(
            () => context.read<SolicitudReprestamoHnCubit>().state.copyWith(
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
      context.read<SolicitudReprestamoHnCubit>().onFieldChanged(
            () => context.read<SolicitudReprestamoHnCubit>().state.copyWith(
                  fechaDesembolso: fechaDesembolso.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudReprestamoHnCubit>();
    final calcularCuotaProvider = context.read<CalculoCuotaCubit>();

    return BlocBuilder<SolicitudReprestamoHnCubit, SolicitudReprestamoHnState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const MiCreditoProgress(
                  currentStep: 7,
                  steps: 7,
                ),
                const Gap(30),
                Column(
                  children: [
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.propositoCodigo,
                        value: cubit.state.propositoCodigo,
                      ),
                      key: const ValueKey('Destino'),
                      isRequired: true,
                      validator: (value) => ClassValidator.validateRequired(
                        value?.value,
                      ),
                      hintText: 'Destino',
                      title: 'Destino del crédito',
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            propositoCodigo: value?.value,
                          ),
                        );
                      },
                      flavor: global<FlavorCubit>().state.flavor,
                      codigo: 'DESTINOCREDITO',
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
                        icon: Icon(Icons.description_outlined,
                            color: AppColors.getPrimaryColor()),
                        title: 'Descripcion del Destino',
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(200),
                        ],
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
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: state.monedaCodigo,
                        value: state.monedaCodigo,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      codigo: 'MONEDA',
                      flavor: global<FlavorCubit>().state.flavor,
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            monedaCodigo: item.value,
                          ),
                        );
                      },
                      hintText: 'ingresa moneda',
                      title: 'Moneda',
                    ),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      readOnly: true,
                      onTap: () => selectFechaDesembolso(context),
                      validator: (value) => ClassValidator.validateRequired(
                          fechaDesembolso.selectorFormat()),
                      hintText: state.fechaDesembolso,
                      icon: Icon(Icons.date_range,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      title: 'Fecha de desembolso',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.monto.toCurrencyString(),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'ingresa monto',
                      icon: Icon(Icons.wallet,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      textCapitalization: TextCapitalization.none,
                      title: 'Monto',
                      onChange: (value) {
                        final newValue =
                            value.replaceAll(RegExp(r'[^0-9]'), '');
                        final montoTotal = double.tryParse(newValue) ?? 0;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            monto: montoTotal,
                          ),
                        );
                        monto = newValue;
                      },
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: state.productoCodigo,
                        value: state.productoCodigo,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      hintText: 'Producto',
                      codigo: 'PRODUCTO',
                      flavor: global<FlavorCubit>().state.flavor,
                      onChanged: (item) {
                        if (item == null) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            productoCodigo: item.value,
                            tasaInteres: item.interes,
                            montoMaximo: item.montoMaximo,
                            montoMinimo: item.montoMinimo?.toDouble(),
                          ),
                        );
                      },
                      title: 'Producto',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.plazoSolicitud.toString(),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      hintText: 'Plazo de la solicitud (meses)',
                      icon: Icon(Icons.schedule,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      title: 'Plazo de la solicitud (meses)',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                              plazoSolicitud: int.tryParse(value) ?? 0),
                        );
                        plazoSolicitud = value;
                        setState(() {});
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      readOnly: true,
                      onTap: () => selectDate(context),
                      validator: (value) => ClassValidator.validateRequired(
                          state.fechaPrimerPagoSolicitud),
                      hintText: state.fechaPrimerPagoSolicitud,
                      icon: Icon(Icons.calendar_today,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.datetime,
                      textCapitalization: TextCapitalization.none,
                      title: 'Fecha de primer pago',
                    ),
                    const Gap(30),
                    CatalogoFrecuenciaPagoDropdown(
                      selectedItem: CatalogoFrecuenciaItem(
                        valor: state.frecuenciaCodigo,
                        nombre: state.frecuenciaCodigo,
                        meses: state.frecuenciaPagoMeses,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            frecuenciaCodigo: item.valor,
                            frecuenciaPagoMeses: item.meses,
                          ),
                        );
                        frecuenciaDePago = CatalogoFrecuenciaItem(
                          valor: item.valor,
                          nombre: item.nombre,
                          meses: item.meses,
                        );
                      },
                      hintText: 'Frecuencia',
                      title: 'Frecuencia de pago',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: state.observacion,
                      hintText: 'Observación',
                      icon:
                          Icon(Icons.note, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      inputFormatters: [UpperCaseTextFormatter()],
                      textCapitalization: TextCapitalization.sentences,
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
                      if ((double.tryParse(monto ?? '0') ?? 0) <
                          state.montoMinimo.toDouble()) {
                        CustomAlertDialog(
                          context: context,
                          title:
                              'El monto minimo debe ser mayor a ${state.montoMinimo.toCurrencyString()} L.',
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                        return;
                      }
                      if (double.tryParse(monto ?? '0')! >
                          state.montoMaximo.toDouble()) {
                        CustomAlertDialog(
                          context: context,
                          title:
                              'El monto maximo debe ser menor o igual a ${state.montoMaximo.toCurrencyString()} L.',
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                        return;
                      }
                      final plazoSolicitudMount =
                          (int.tryParse(plazoSolicitud ?? '0') ?? 0);
                      final frecuenciaPagoMeses =
                          (double.tryParse(frecuenciaDePago?.meses ?? '0') ??
                              0);
                      if (plazoSolicitudMount < frecuenciaPagoMeses) {
                        CustomAlertDialog(
                          context: context,
                          title:
                              'El plazo solicitud debe ser mayor o igual a la frecuencia de pago',
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                        return;
                      }

                      calcularCuotaProvider.calcularCantidadCuotas(
                        fechaDesembolso: fechaDesembolso,
                        fechaPrimeraCuota: fechaPrimerPago!,
                        plazoSolicitud: int.parse(plazoSolicitud ?? '0'),
                        frecuenciaPago: frecuenciaDePago?.meses ?? '0',
                        saldoPrincipal: double.parse(monto ?? '0'),
                        tasaInteresMensual: state.tasaInteres,
                      );
                      CuotaDataDialog(
                        context: context,
                        title:
                            'Estimación de la cuota según los datos ingresados\n${calcularCuotaProvider.state.montoPrimeraCuota.toCurrencyFormat} L.',
                        onDone: () {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              cuota: calcularCuotaProvider
                                  .state.montoPrimeraCuota
                                  .toDouble(),
                            ),
                          );
                          widget.controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          context.pop();
                        },
                      ).showDialog(context);
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
                    text: 'Anterior',
                    textColor: AppColors.red,
                    color: AppColors.red,
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
