import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/informacion_peps/informacion_peps_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class TableDetalleFamiliarPeps extends StatelessWidget {
  final String parentescoCodigo;
  const TableDetalleFamiliarPeps({
    super.key,
    required this.parentescoCodigo,
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
              parentescoCodigo: parentescoCodigo,
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
              'Agregar familiar',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        title: const Text('Familiares'),
      ),
      body: BlocBuilder<InformacionPepsHnCubit, InformacionPepsHnState>(
        builder: (context, state) {
          final familiaresFiltered = state.familiaresPeps
              .where((e) => e.parentescoCodigo == parentescoCodigo)
              .toList();
          if (familiaresFiltered.isEmpty) {
            return const EmptyListWidget(
                message: 'No hay detalle de familiares');
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: familiaresFiltered.length,
                  itemBuilder: (context, index) {
                    final e = familiaresFiltered[index];
                    return AnalisisCardVentasDay(
                      subtitle: '${e.nombre1} ${e.nombre2}',
                      title: '${e.apellido1} ${e.apellido2}',
                      description: e.parentescoCodigo,
                      onTap: () {
                        showHistorialCreditoOptionsBottomSheet(
                          context: context,
                          onEdit: () => {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => _CompraSemanalHN(
                                cubit: context.read<InformacionPepsHnCubit>(),
                                isUpdate: true,
                                parentescoCodigo: parentescoCodigo,
                                familiarPep: e,
                              ),
                            ),
                          },
                          onDelete: () {
                            context
                                .read<InformacionPepsHnCubit>()
                                .deleteFamiliarPep(
                                  e.referenciaTemporal,
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
  final FamiliaresPep? familiarPep;
  final bool isUpdate;
  final String parentescoCodigo;
  const _CompraSemanalHN({
    required this.cubit,
    this.familiarPep,
    this.isUpdate = false,
    required this.parentescoCodigo,
  });

  @override
  State<_CompraSemanalHN> createState() => _CompraSemanalHNState();
}

class _CompraSemanalHNState extends State<_CompraSemanalHN> {
  final formKey = GlobalKey<FormState>();
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? referenciaTemporal;
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      nombre1 = widget.familiarPep?.nombre1;
      nombre2 = widget.familiarPep?.nombre2;
      apellido1 = widget.familiarPep?.apellido1;
      apellido2 = widget.familiarPep?.apellido2;
      referenciaTemporal = widget.familiarPep?.referenciaTemporal;
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
                      initialValue: nombre1,
                      title: 'Nombre 1',
                      icon: const Icon(Icons.wallet),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        nombre1 = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: nombre2,
                      title: 'Nombre 2',
                      icon: const Icon(Icons.wallet),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        nombre2 = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: apellido1,
                      title: 'Apellido 1',
                      icon: const Icon(Icons.wallet),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        apellido1 = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: apellido2,
                      title: 'Apellido 2',
                      icon: const Icon(Icons.wallet),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        apellido2 = value;
                      },
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
                            widget.cubit.updateFamiliarPep(
                              referenciaTemporal!,
                              FamiliaresPep(
                                referenciaTemporal: referenciaTemporal!,
                                parentescoCodigo: widget.parentescoCodigo,
                                nombre1: nombre1!,
                                nombre2: nombre2,
                                apellido1: apellido1!,
                                apellido2: apellido2,
                              ),
                            );
                            context.pop();
                            return;
                          }
                          widget.cubit.addFamiliarPep(FamiliaresPep(
                            referenciaTemporal: const Uuid().v4(),
                            parentescoCodigo: widget.parentescoCodigo,
                            nombre1: nombre1!,
                            nombre2: nombre2,
                            apellido1: apellido1!,
                            apellido2: apellido2,
                          ));
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
