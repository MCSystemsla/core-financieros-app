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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class TableCargosDesempeHnWidget extends StatelessWidget {
  const TableCargosDesempeHnWidget({
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
              'Agregar Cargo Desempeñado',
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
            return const EmptyListWidget(message: 'No hay cargos para mostrar');
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.detallePeps.length,
                  itemBuilder: (context, index) {
                    final e = state.detallePeps[index];
                    return AnalisisCardVentasDay(
                      subtitle: e.cargo,
                      title: e.nombreInstitucion,
                      description: e.periodo.toString(),
                      onTap: () {
                        showHistorialCreditoOptionsBottomSheet(
                          context: context,
                          onEdit: () => {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => _CompraSemanalHN(
                                cubit: context.read<InformacionPepsHnCubit>(),
                                detallePep: e,
                                isUpdate: true,
                              ),
                            ),
                          },
                          onDelete: () {
                            context
                                .read<InformacionPepsHnCubit>()
                                .deleteDetallePep(
                                  e.familiarReferencia ?? '',
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
  final InformacionPepsHnCubit cubit;
  final DetallePep? detallePep;
  final bool isUpdate;
  const _CompraSemanalHN({
    required this.cubit,
    this.detallePep,
    this.isUpdate = false,
  });

  @override
  State<_CompraSemanalHN> createState() => _CompraSemanalHNState();
}

class _CompraSemanalHNState extends State<_CompraSemanalHN> {
  final formKey = GlobalKey<FormState>();
  String? cargo;
  int? periodo;
  String? nombreInstitucion;
  String? referencia;
  String? referenciaNombre;
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      cargo = widget.detallePep?.cargo;
      periodo = widget.detallePep?.periodo;
      nombreInstitucion = widget.detallePep?.nombreInstitucion;
      referencia = widget.detallePep?.familiarReferencia;
      referenciaNombre = widget.detallePep?.nombreFamiliarReferencia;
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
                      initialValue: cargo,
                      title: 'Cargo Desempeñado',
                      icon: const Icon(Icons.wallet),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cargo = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: periodo?.toString(),
                      title: 'Periodo',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        periodo = int.tryParse(value) ?? 0;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: nombreInstitucion,
                      title: 'Nombre Institucion',
                      icon: const Icon(Icons.wallet),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        nombreInstitucion = value;
                      },
                    ),
                    const Gap(10),
                    SheetSearchDropdown(
                      selectedItem: Item(
                        name: referenciaNombre ?? '',
                        value: referencia ?? '',
                      ),
                      title: 'Referencia',
                      isRequired: true,
                      onChanged: (v) {
                        if (v == null) return;
                        referencia = v.value;
                        referenciaNombre = v.name;
                      },
                      hintText: 'Ingresa una referencia',
                      enabled: true,
                      items: [
                        const Item(
                          name: 'Cliente Solicitante',
                          value: '',
                        ),
                        ...widget.cubit.state.familiaresPeps.map(
                          (e) => Item(
                            name: '${e.nombre1} ${e.apellido1}',
                            value: e.referenciaTemporal,
                          ),
                        )
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
                          if (widget.isUpdate) {
                            widget.cubit.updateDetallePep(
                              DetallePep(
                                cargo: cargo!,
                                nombreInstitucion: nombreInstitucion!,
                                periodo: periodo!,
                                familiarReferencia:
                                    (referencia?.isEmpty ?? true)
                                        ? null
                                        : referencia,
                                nombreFamiliarReferencia:
                                    referenciaNombre!.isEmpty
                                        ? null
                                        : referenciaNombre,
                              ),
                            );
                            context.pop();
                            return;
                          }
                          widget.cubit.addDetallePep(
                            DetallePep(
                              cargo: cargo!,
                              nombreInstitucion: nombreInstitucion!,
                              periodo: periodo!,
                              familiarReferencia:
                                  referencia!.isEmpty ? null : referencia,
                              nombreFamiliarReferencia:
                                  referenciaNombre!.isEmpty
                                      ? null
                                      : referenciaNombre,
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
