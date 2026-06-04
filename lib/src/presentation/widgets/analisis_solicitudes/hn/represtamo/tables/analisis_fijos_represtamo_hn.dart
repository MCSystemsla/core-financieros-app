// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_activo_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_represtamo/analisis_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AnalisisFijosReprestamoHn extends StatelessWidget {
  final int numeroSolicitud;
  const AnalisisFijosReprestamoHn({super.key, required this.numeroSolicitud});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisReprestamoCubit, AnalisisReprestamoState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => _CompraPorArticuloSheetHn(
                  cubit: context.read<AnalisisReprestamoCubit>(),
                  numeroSolicitud: numeroSolicitud,
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
                  'Agregar Activo',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.black,
          ),
          appBar: AppBar(
            title: const Text('Activos fijos'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                _NivelProduccionWidget(
                  cuentasPorCobrar: state.activos,
                  numeroSolicitud: numeroSolicitud,
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
  final List<ActivoHN> cuentasPorCobrar;
  final int numeroSolicitud;
  const _NivelProduccionWidget({
    required this.cuentasPorCobrar,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    if (cuentasPorCobrar.isEmpty) {
      return const EmptyListWidget(message: 'No hay activos para mostrar');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cuentasPorCobrar.length,
      itemBuilder: (context, index) {
        final e = cuentasPorCobrar[index];
        return AnalisisCardVentasDay(
          subtitle: e.nombreActivo,
          description: 'Monto: ${e.monto.toCurrencyString()}',
          title: '',
          onTap: () => {
            showHistorialCreditoOptionsBottomSheet(
              context: context,
              onEdit: () => {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (ctx) => _CompraPorArticuloSheetHn(
                    cubit: context.read<AnalisisReprestamoCubit>(),
                    numeroSolicitud: numeroSolicitud,
                    isUpdate: true,
                    activo: e,
                  ),
                ),
              },
              onDelete: () {
                context.read<AnalisisReprestamoCubit>().deleteActivo(
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
  final AnalisisReprestamoCubit cubit;
  final int numeroSolicitud;
  final ActivoHN? activo;
  final bool isUpdate;
  const _CompraPorArticuloSheetHn({
    required this.cubit,
    required this.numeroSolicitud,
    this.activo,
    this.isUpdate = false,
  });

  @override
  State<_CompraPorArticuloSheetHn> createState() =>
      _CompraPorArticuloSheetHnState();
}

class _CompraPorArticuloSheetHnState extends State<_CompraPorArticuloSheetHn> {
  final formKey = GlobalKey<FormState>();
  String? nombreActivo;
  int? montoActivo;
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      nombreActivo = widget.activo?.nombreActivo;
      montoActivo = widget.activo?.monto;
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
                      initialValue: nombreActivo,
                      title: 'Nombre de activo',
                      icon: const Icon(Icons.comment_bank_sharp),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        nombreActivo = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      textAlign: TextAlign.end,
                      initialValue: montoActivo
                          ?.toCurrencyString(
                            mantissaLength: 0,
                          )
                          .toNullIfEmptyOrZero(),
                      title: 'Monto de activo',
                      icon: const Icon(Icons.comment_bank_sharp),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        montoActivo = int.tryParse(newValue);
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
                            widget.cubit.updateActivosFijos(
                              numeroSolicitud: widget.numeroSolicitud,
                              activo: AnalisisActivoHnLocalDb(
                                uuid: widget.activo!.uuid,
                                nombreActivo: nombreActivo!,
                                monto: montoActivo!,
                              ),
                            );
                            context.pop();
                            return;
                          }
                          widget.cubit.saveActivosFijos(
                            numeroSolicitud: widget.numeroSolicitud,
                            activoFijo: ActivoHN(
                              nombreActivo: nombreActivo!,
                              monto: montoActivo!,
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
