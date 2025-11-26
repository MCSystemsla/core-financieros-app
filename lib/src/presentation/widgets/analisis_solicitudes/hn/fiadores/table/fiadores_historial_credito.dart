// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class FiadoresHistorialCredito extends StatelessWidget {
  const FiadoresHistorialCredito({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => _CompraSemanalHN(
              cubit: context.read<AnalisisFiadoresCubit>(),
              // numeroSolicitud: numeroSolicitud,
            ),
          );
        },
        label: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              'Agregar Inventario',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        title: const Text('Inventario'),
      ),
      body: BlocBuilder<AnalisisFiadoresCubit, AnalisisFiadoresState>(
        builder: (context, state) {
          if (state.historialCredito.isEmpty) {
            return const EmptyListWidget(
                message: 'No hay inventario para mostrar');
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.historialCredito.length,
                  itemBuilder: (context, index) {
                    final e = state.historialCredito[index];
                    return AnalisisCardVentasDay(
                      description: e.monto.toCurrencyString(),
                      subtitle: e.entidad,
                      title: e.cuota.toCurrencyString(),
                      onTap: () {
                        showHistorialCreditoOptionsBottomSheet(
                          context: context,
                          onEdit: () => {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => _CompraSemanalHN(
                                cubit: context.read<AnalisisFiadoresCubit>(),
                                // numeroSolicitud: numeroSolicitud,
                                historial: e,
                                isUpdate: true,
                              ),
                            ),
                          },
                          onDelete: () {
                            context
                                .read<AnalisisFiadoresCubit>()
                                .deleteHistorialCredito(
                                  uuid: e.uuid,
                                  // numeroSolicitud: numeroSolicitud,
                                );
                          },
                        );
                      },
                    );
                  },
                ),
                const Gap(20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CompraSemanalHN extends StatefulWidget {
  final AnalisisFiadoresCubit cubit;
  // final int numeroSolicitud;
  final HistorialCredito? historial;
  final bool isUpdate;
  const _CompraSemanalHN({
    required this.cubit,
    // required this.numeroSolicitud,
    this.historial,
    this.isUpdate = false,
  });

  @override
  State<_CompraSemanalHN> createState() => _CompraSemanalHNState();
}

class _CompraSemanalHNState extends State<_CompraSemanalHN> {
  final formKey = GlobalKey<FormState>();

  String? entidad;
  int? monto;
  String? tipoMonedaCodigo;
  String? tipoFrecuenciaCodigo;
  int? cuota;
  int? saldo;
  String? estadoCodigo;
  DateTime? fechaDesembolso;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      entidad = widget.historial?.entidad;
      monto = widget.historial?.monto;
      tipoMonedaCodigo = widget.historial?.tipoMonedaCodigo;
      tipoFrecuenciaCodigo = widget.historial?.tipoFrecuenciaCodigo;
      cuota = widget.historial?.cuota;
      saldo = widget.historial?.saldo;
      estadoCodigo = widget.historial?.estadoCodigo;
      fechaDesembolso = widget.historial?.fechaDesembolso;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaDesembolso,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaDesembolso) {
      if (!context.mounted) return;

      fechaDesembolso = picked;
      setState(() {});
    }
  }

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
        initialChildSize: 0.44,
        maxChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const Gap(15),
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: entidad,
                      title: 'Nombre de la Entidad',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
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
                    OutlineTextfieldWidget(
                      initialValue:
                          monto?.toCurrencyString().toNullIfEmptyOrZero(),
                      title: 'Monto',
                      icon: const Icon(Icons.wallet),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        monto = int.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue:
                          cuota?.toCurrencyString().toNullIfEmptyOrZero(),
                      title: 'Cuota',
                      icon: const Icon(Icons.wallet),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        cuota = int.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue:
                          saldo?.toCurrencyString().toNullIfEmptyOrZero(),
                      title: 'Saldo',
                      icon: const Icon(Icons.wallet),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        saldo = int.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: tipoMonedaCodigo ?? '',
                        value: tipoMonedaCodigo ?? '',
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      title: 'Tipo de Moneda',
                      codigo: 'MONEDA',
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        tipoMonedaCodigo = item.value;
                      },
                    ),
                    const Gap(20),
                    CatalogoFrecuenciaPagoDropdown(
                      selectedItem: CatalogoFrecuenciaItem(
                        valor: tipoFrecuenciaCodigo ?? '',
                        nombre: tipoFrecuenciaCodigo ?? '',
                        meses: '0',
                      ),
                      title: 'Frecuencia de pago',
                      onChanged: (v) {
                        tipoFrecuenciaCodigo = v?.valor;
                      },
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      hintText: fechaDesembolso?.selectorFormat(),
                      title: 'Fecha desembolso',
                      icon: const Icon(Icons.wallet),
                      validator: (value) => ClassValidator.validateRequired(
                          fechaDesembolso?.selectorFormat()),
                      onTap: () => selectDate(context),
                      readOnly: true,
                      onChange: (value) {},
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: estadoCodigo ?? '',
                        value: estadoCodigo ?? '',
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      title: 'Estatus de credito',
                      codigo: 'ESTADOPRESTAMO',
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        estadoCodigo = item.value;
                      },
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled: true,
                        text: 'Crear',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          if (widget.isUpdate) {
                            widget.cubit.editHistorialCredito(
                              historialCredito: HistorialCredito(
                                uuid: widget.historial!.uuid,
                                entidad: entidad!,
                                monto: monto!,
                                tipoMonedaCodigo: tipoMonedaCodigo!,
                                tipoFrecuenciaCodigo: tipoFrecuenciaCodigo!,
                                cuota: cuota!,
                                saldo: saldo!,
                                estadoCodigo: estadoCodigo!,
                                fechaDesembolso: fechaDesembolso!,
                              ),
                            );
                            context.pop();
                            return;
                          }
                          widget.cubit.createHistorialCredito(
                            historialCredito: HistorialCredito(
                              entidad: entidad!,
                              monto: monto!,
                              tipoMonedaCodigo: tipoMonedaCodigo!,
                              tipoFrecuenciaCodigo: tipoFrecuenciaCodigo!,
                              cuota: cuota!,
                              saldo: saldo!,
                              estadoCodigo: estadoCodigo!,
                              fechaDesembolso: fechaDesembolso!,
                              uuid: const Uuid().v4(),
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
      ),
    );
  }
}
