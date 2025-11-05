// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class NuevaMenorHistorialCrediticio extends StatefulWidget {
  final PageController controller;
  const NuevaMenorHistorialCrediticio({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorHistorialCrediticio> createState() =>
      _NuevaMenorHistorialCrediticioState();
}

class _NuevaMenorHistorialCrediticioState
    extends State<NuevaMenorHistorialCrediticio> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SolicitudNuevaMenorCubit>().state;
    final localDbProvider = global<ObjectBoxService>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MiCreditoProgress(
            currentStep: 2,
            steps: 7,
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
          ...cubit.historialCredito.map(
            (e) => AnalisisCardVentasDay(
              title: e.monto.toCurrencyString(),
              subtitle: e.entidad,
              description: e.saldo.toCurrencyString(),
              onTap: () => showHistorialCreditoOptionsBottomSheet(
                context: context,
                onEdit: () {
                  _createCreditoModalBottomSheet(
                    context,
                    cubit: context.read<SolicitudNuevaMenorCubit>(),
                    isUpdate: true,
                    cuota: e.cuota,
                    saldo: e.saldo,
                    estadoCodigo: e.estadoCodigo,
                    fechaDesembolso: e.fechaDesembolso,
                    entidad: e.entidad,
                    tipoFrecuenciaCodigo: e.tipoFrecuenciaCodigo,
                    monto: e.monto,
                    tipoMonedaCodigo: e.tipoMonedaCodigo,
                    uuid: e.uuid,
                  );
                },
                onDelete: () {
                  context
                      .read<SolicitudNuevaMenorCubit>()
                      .deleteHistorialCredito(uuid: e.uuid);
                  localDbProvider.deleteHistorialByUuid(e.uuid);
                },
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _createCreditoModalBottomSheet(
                  context,
                  cubit: context.read<SolicitudNuevaMenorCubit>(),
                );
              },
              splashColor: AppColors.getPrimaryColor().withOpacity(0.2),
              highlightColor: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 42,
                  ),
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
              enabled: true,
              text: 'Siguiente',
              color: AppColors.greenLatern.withOpacity(0.4),
              onPressed: () async {
                widget.controller.nextPage(
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
                widget.controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              text: 'Atras',
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

_createCreditoModalBottomSheet(
  BuildContext context, {
  required SolicitudNuevaMenorCubit cubit,
  bool isUpdate = false,
  String? entidad,
  int? monto,
  String? tipoMonedaCodigo,
  String? tipoFrecuenciaCodigo,
  int? cuota,
  int? saldo,
  String? estadoCodigo,
  DateTime? fechaDesembolso,
  String? uuid,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => CreateCreditoContainerForm(
      cubit: cubit,
      isUpdate: isUpdate,
      entidad: entidad ?? '',
      monto: monto ?? 0,
      tipoMonedaCodigo: tipoMonedaCodigo ?? '',
      tipoFrecuenciaCodigo: tipoFrecuenciaCodigo ?? '',
      cuota: cuota ?? 0,
      saldo: saldo ?? 0,
      estadoCodigo: estadoCodigo ?? '',
      fechaDesembolso: fechaDesembolso,
      uuid: uuid,
    ),
  );
}

class CreateCreditoContainerForm extends StatefulWidget {
  final bool isUpdate;
  final SolicitudNuevaMenorCubit cubit;
  final String entidad;
  final int monto;
  final String tipoMonedaCodigo;
  final String tipoFrecuenciaCodigo;
  final int cuota;
  final int saldo;
  final String estadoCodigo;
  final DateTime? fechaDesembolso;
  final String? uuid;
  const CreateCreditoContainerForm({
    super.key,
    required this.cubit,
    this.isUpdate = false,
    this.entidad = '',
    this.monto = 0,
    this.tipoMonedaCodigo = '',
    this.tipoFrecuenciaCodigo = '',
    this.cuota = 0,
    this.saldo = 0,
    this.estadoCodigo = '',
    this.fechaDesembolso,
    this.uuid,
  });

  @override
  State<CreateCreditoContainerForm> createState() =>
      _CreateCreditoContainerFormState();
}

class _CreateCreditoContainerFormState
    extends State<CreateCreditoContainerForm> {
  String entidad = '';
  int monto = 0;
  String tipoMonedaCodigo = '';
  String tipoFrecuenciaCodigo = '';
  int cuota = 0;
  int saldo = 0;
  String estadoCodigo = '';
  DateTime? fechaDesembolso;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    entidad = widget.entidad;
    monto = widget.monto;
    tipoMonedaCodigo = widget.tipoMonedaCodigo;
    tipoFrecuenciaCodigo = widget.tipoFrecuenciaCodigo;
    cuota = widget.cuota;
    saldo = widget.saldo;
    estadoCodigo = widget.estadoCodigo;
    fechaDesembolso = widget.fechaDesembolso;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );

    if (picked == null) return;

    final today = DateTime.now();

    if (!context.mounted) return;
    if (picked.isAfter(today)) {
      CustomAlertDialog(
        context: context,
        title: 'La Fecha de desembolso no puede ser despues de la fecha actual',
        onDone: () => context.pop(),
      ).showDialog(context);
      return;
    }

    if (picked != fechaDesembolso) {
      setState(() {
        fechaDesembolso = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    return DraggableScrollableSheet(
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
                    onChange: (value) {
                      entidad = value;
                    },
                  ),
                  const Gap(20),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: tipoMonedaCodigo,
                      value: tipoMonedaCodigo,
                    ),
                    codigo: 'MONEDA',
                    title: 'Tipo Moneda',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      tipoMonedaCodigo = value.value;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    initialValue: monto.toCurrencyString(),
                    title: 'Monto',
                    icon: const Icon(Icons.wallet),
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      CurrencyInputFormatter(
                        mantissaLength: 0,
                      ),
                    ],
                    onChange: (value) {
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      monto = int.tryParse(newValue) ?? 0;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    initialValue: cuota.toCurrencyString(),
                    title: 'Cuota',
                    icon: const Icon(Icons.wallet),
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      CurrencyInputFormatter(
                        mantissaLength: 0,
                      ),
                    ],
                    onChange: (value) {
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                      cuota = int.tryParse(newValue) ?? 0;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    initialValue: saldo.toCurrencyString(),
                    title: 'Saldo',
                    icon: const Icon(Icons.wallet),
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      CurrencyInputFormatter(
                        mantissaLength: 0,
                      ),
                    ],
                    onChange: (value) {
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      saldo = int.tryParse(newValue) ?? 0;
                    },
                  ),
                  const Gap(20),
                  CatalogoFrecuenciaPagoDropdown(
                    selectedItem: CatalogoFrecuenciaItem(
                      valor: tipoFrecuenciaCodigo,
                      nombre: tipoFrecuenciaCodigo,
                      meses: 0.toString(),
                    ),
                    title: 'Tipo Frecuencia Pago',
                    validator: (value) => ClassValidator.validateRequired(
                      value?.valor,
                    ),
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      tipoFrecuenciaCodigo = value.valor;
                    },
                  ),
                  const Gap(20),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: estadoCodigo,
                      value: estadoCodigo,
                    ),
                    codigo: 'ESTADOPRESTAMO',
                    title: 'Estado de Credito',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      estadoCodigo = value.value;
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
                      text: 'Crear Credito',
                      color: AppColors.greenLatern.withOpacity(0.4),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        if (widget.isUpdate) {
                          widget.cubit.updateHistorialCredito(
                            updated: HistorialCredito(
                              uuid: widget.uuid ?? '',
                              entidad: entidad,
                              monto: monto,
                              tipoMonedaCodigo: tipoMonedaCodigo,
                              tipoFrecuenciaCodigo: tipoFrecuenciaCodigo,
                              cuota: cuota,
                              saldo: saldo,
                              estadoCodigo: estadoCodigo,
                              fechaDesembolso: fechaDesembolso!,
                            ),
                          );
                          context.pop();
                          return;
                        }
                        widget.cubit.saveHistorialCredito(
                          historialCredito: HistorialCredito(
                            uuid: const Uuid().v4(),
                            entidad: entidad,
                            monto: monto,
                            tipoMonedaCodigo: tipoMonedaCodigo,
                            tipoFrecuenciaCodigo: tipoFrecuenciaCodigo,
                            cuota: cuota,
                            saldo: saldo,
                            estadoCodigo: estadoCodigo,
                            fechaDesembolso: fechaDesembolso!,
                          ),
                        );
                        localDbProvider.saveHistorialCredito(
                          historialCreditoLocalDb: HistorialCrediticioLocalDb(
                            uuid: widget.cubit.state.uuid!,
                            cuota: cuota,
                            entidad: entidad,
                            estadoCodigo: estadoCodigo,
                            monto: monto,
                            saldo: saldo,
                            tipoFrecuenciaCodigo: tipoFrecuenciaCodigo,
                            tipoMonedaCodigo: tipoMonedaCodigo,
                            fechaDesembolso: fechaDesembolso,
                          ),
                        );

                        context.pop();
                      },
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
