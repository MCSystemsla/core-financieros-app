// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_compras_proveedor_articulo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class TableComprasPorProveedorOArticulosHnWidget extends StatelessWidget {
  const TableComprasPorProveedorOArticulosHnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => _CompraPorArticuloSheetHn(
                  cubit: context.read<AnalisisNuevaMayorMilHnCubit>(),
                  numeroSolicitud: state.numeroSolicitud,
                ),
              );
            },
            label: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Gap(8),
                Text(
                  'Agregar Compra',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.black,
          ),
          appBar: AppBar(
            title: const Text('Compras por proveedor o articulo'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                _NivelProduccionWidget(
                  cuentasPorCobrar: state.comprasProveedorArticulo,
                  numeroSolicitud: state.numeroSolicitud,
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NivelProduccionWidget extends StatelessWidget {
  final List<ComprasProveedorArticuloHN> cuentasPorCobrar;
  final int numeroSolicitud;
  const _NivelProduccionWidget({
    required this.cuentasPorCobrar,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    if (cuentasPorCobrar.isEmpty) {
      return const EmptyListWidget(message: 'No hay compras para mostrar');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cuentasPorCobrar.length,
      itemBuilder: (context, index) {
        final e = cuentasPorCobrar[index];
        return AnalisisCardVentasDay(
          subtitle: e.proveedorArticulo,
          title:
              'Monto Compra crédito: ${e.montoCompraCredito.toCurrencyString()}',
          description:
              'Total compra mensual: ${e.totalCompraMensual.toCurrencyString()}',
          onTap: () => {
            showHistorialCreditoOptionsBottomSheet(
              context: context,
              onEdit: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (ctx) => _CompraPorArticuloSheetHn(
                    cubit: context.read<AnalisisNuevaMayorMilHnCubit>(),
                    numeroSolicitud: numeroSolicitud,
                    isUpdate: true,
                    proveedorArticulo: e,
                  ),
                );
              },
              onDelete: () {
                context
                    .read<AnalisisNuevaMayorMilHnCubit>()
                    .deleteComprasPorProveedor(
                      numeroSolicitud: numeroSolicitud,
                      uuid: e.uuid,
                    );
              },
            ),
          },
        );
      },
    );
  }
}

class _CompraPorArticuloSheetHn extends StatefulWidget {
  final AnalisisNuevaMayorMilHnCubit cubit;
  final int numeroSolicitud;
  final bool isUpdate;

  final ComprasProveedorArticuloHN? proveedorArticulo;
  const _CompraPorArticuloSheetHn({
    required this.cubit,
    required this.numeroSolicitud,
    this.isUpdate = false,
    this.proveedorArticulo,
  });

  @override
  State<_CompraPorArticuloSheetHn> createState() =>
      _CompraPorArticuloSheetHnState();
}

class _CompraPorArticuloSheetHnState extends State<_CompraPorArticuloSheetHn> {
  final formKey = GlobalKey<FormState>();
  String? proveedorArticulo;
  String? frecuenciaCompraContado;
  String? frecuenciaCompraCredito;
  int? montoCompraContado;
  int? montoCompraCredito;
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      proveedorArticulo = widget.proveedorArticulo?.proveedorArticulo;
      frecuenciaCompraContado =
          widget.proveedorArticulo?.frecuenciaCompraContadoCodigo;
      frecuenciaCompraCredito =
          widget.proveedorArticulo?.frecuenciaCompraCreditoCodigo;
      montoCompraContado = widget.proveedorArticulo?.montoCompraContado;
      montoCompraCredito = widget.proveedorArticulo?.montoCompraCredito;
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
        initialChildSize: 0.55,
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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                controller: scrollController,
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
                      initialValue: proveedorArticulo,
                      title: 'Proveedor de articulo',
                      icon: const Icon(Icons.comment_bank_sharp),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        proveedorArticulo = value;
                      },
                    ),
                    const Gap(20),
                    CatalogoFrecuenciaPagoDropdown(
                      selectedItem: CatalogoFrecuenciaItem(
                        valor: frecuenciaCompraContado ?? '',
                        nombre: frecuenciaCompraContado ?? '',
                        meses: '0',
                      ),
                      title: 'Frecuencia de contado',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      onChanged: (value) {
                        frecuenciaCompraContado = value?.valor;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      textAlign: TextAlign.end,
                      initialValue: montoCompraContado
                          ?.toCurrencyString(mantissaLength: 0)
                          .toNullIfEmptyOrZero(),
                      title: 'Monto de contado',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,\.]')),
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        montoCompraContado = int.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    CatalogoFrecuenciaPagoDropdown(
                      selectedItem: CatalogoFrecuenciaItem(
                        valor: frecuenciaCompraCredito ?? '',
                        nombre: frecuenciaCompraCredito ?? '',
                        meses: '0',
                      ),
                      enabled: true,
                      hintText: 'Selecciona una opcion',
                      isRequired: true,
                      title: 'Frecuencia de Credito',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        frecuenciaCompraCredito = value.valor;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: montoCompraCredito
                          ?.toCurrencyString(mantissaLength: 0)
                          .toNullIfEmptyOrZero(),
                      textAlign: TextAlign.end,
                      title: 'Monto de crédito',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,\.]')),
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        montoCompraCredito = int.tryParse(newValue);
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
                            widget.cubit.updateComprasPorProveedor(
                              numeroSolicitud: widget.numeroSolicitud,
                              comprasPorProveedor:
                                  AnalisisComprasProveedorArticuloHnLocalDb(
                                uuid: widget.proveedorArticulo!.uuid,
                                frecuenciaCompraContadoCodigo:
                                    frecuenciaCompraContado!,
                                frecuenciaCompraCreditoCodigo:
                                    frecuenciaCompraCredito!,
                                montoCompraContado: montoCompraContado!,
                                montoCompraCredito: montoCompraCredito!,
                                proveedorArticulo: proveedorArticulo!,
                                totalCompraMensual: (montoCompraContado ?? 0) +
                                    (montoCompraCredito ?? 0),
                              ),
                            );
                            context.pop();
                            return;
                          }
                          widget.cubit.saveComprasPorProveedor(
                            numeroSolicitud: widget.numeroSolicitud,
                            comprasPorProveedor: ComprasProveedorArticuloHN(
                              uuid: const Uuid().v4(),
                              frecuenciaCompraContadoCodigo:
                                  frecuenciaCompraContado!,
                              frecuenciaCompraCreditoCodigo:
                                  frecuenciaCompraCredito!,
                              montoCompraContado: montoCompraContado!,
                              montoCompraCredito: montoCompraCredito!,
                              proveedorArticulo: proveedorArticulo!,
                              totalCompraMensual: (montoCompraContado ?? 0) +
                                  (montoCompraCredito ?? 0),
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
