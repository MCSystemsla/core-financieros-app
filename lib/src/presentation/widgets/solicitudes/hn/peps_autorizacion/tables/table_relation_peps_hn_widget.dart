import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/informacion_peps/informacion_peps_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class TableRelationPepsHnWidget extends StatelessWidget {
  const TableRelationPepsHnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => _CompraSemanalHN(
              cubit: context.read<InformacionPepsHnCubit>(),
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
              'Agregar Tipo de Relación',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        title: const Text('Cargos Desempeñados'),
      ),
      body: BlocBuilder<InformacionPepsHnCubit, InformacionPepsHnState>(
        builder: (context, state) {
          if (state.detallePeps.isEmpty) {
            return const EmptyListWidget(
                message: 'No hay tipos de relación para mostrar');
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.relacionPeps.length,
                  itemBuilder: (context, index) {
                    final e = state.relacionPeps[index];
                    return AnalisisCardVentasDay(
                      subtitle: e.nombre,
                      title: e.tipoRelacionCodigo,
                      description: '',
                      onTap: () {
                        showHistorialCreditoOptionsBottomSheet(
                          context: context,
                          onEdit: () => {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => _CompraSemanalHN(
                                cubit: context.read<InformacionPepsHnCubit>(),
                                relacionPep: e,
                                isUpdate: true,
                              ),
                            ),
                          },
                          onDelete: () {
                            // context
                            //     .read<InformacionPepsHnCubit>()
                            //     .deleteDetallePep(
                            //       e.familiarReferencia ?? '',
                            //     );
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
  final InformacionPepsHnCubit cubit;
  final RelacionPep? relacionPep;
  final bool isUpdate;
  const _CompraSemanalHN({
    required this.cubit,
    this.relacionPep,
    this.isUpdate = false,
  });

  @override
  State<_CompraSemanalHN> createState() => _CompraSemanalHNState();
}

class _CompraSemanalHNState extends State<_CompraSemanalHN> {
  final formKey = GlobalKey<FormState>();
  String? nombre;
  String? tipoRelacionCodigo;
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      // cargo = widget.detallePep?.cargo;
      // periodo = widget.detallePep?.periodo;
      // nombreInstitucion = widget.detallePep?.nombreInstitucion;
      // referencia = widget.detallePep?.familiarReferencia;
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
                      initialValue: nombre,
                      title: 'Nombre',
                      icon: const Icon(Icons.wallet),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        nombre = value;
                      },
                    ),
                    const Gap(10),
                    SheetSearchDropdown(
                      title: 'Tipo de Relación',
                      isRequired: true,
                      onChanged: (v) {
                        if (v == null) return;
                        tipoRelacionCodigo = v.value;
                      },
                      hintText: 'Ingresa un tipo de relación',
                      enabled: true,
                      items: const [
                        Item(
                          name: 'ONG',
                          value: 'ONG',
                        ),
                        Item(
                          name: 'Clubes sociales o deportivos',
                          value: 'Clubes sociales o deportivos',
                        ),
                        Item(
                          name: 'Federaciones',
                          value: 'Federaciones',
                        ),
                      ],
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled: true,
                        text: 'Crear',
                        // ignore: deprecated_member_use
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          // if (widget.isUpdate) {
                          //   widget.cubit.updateInventario(
                          //     numeroSolicitud: widget.numeroSolicitud,
                          //     inventario: AnalisisInventarioHnLocalDb(
                          //       uuid: widget.inventorio!.uuid,
                          //       cantidad: cantidad!,
                          //       articulo: articulo!,
                          //       costoCompra: costoCompra!,
                          //       precioVenta: precioVenta!.toInt(),
                          //       costoVentaPorcentaje:
                          //           (costoCompra ?? 0) / (precioVenta ?? 0),
                          //       total: ((costoCompra ?? 0) * (cantidad ?? 0))
                          //           .toInt(),
                          //     ),
                          //   );
                          //   context.pop();
                          //   return;
                          // }
                          widget.cubit.addRelacionPep(
                            RelacionPep(
                              nombre: nombre!,
                              tipoRelacionCodigo: tipoRelacionCodigo!,
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
