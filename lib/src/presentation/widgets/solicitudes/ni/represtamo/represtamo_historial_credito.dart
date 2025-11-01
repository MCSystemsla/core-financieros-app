// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class ReprestamoHistorialCredito extends StatefulWidget {
  final PageController controller;
  const ReprestamoHistorialCredito({
    super.key,
    required this.controller,
  });

  @override
  State<ReprestamoHistorialCredito> createState() =>
      _ReprestamoHistorialCreditoState();
}

class _ReprestamoHistorialCreditoState
    extends State<ReprestamoHistorialCredito> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SolicitudReprestamoCubit>().state;

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
                  // cubit.editHistorialCredito(e);
                },
                onDelete: () {
                  context
                      .read<SolicitudReprestamoCubit>()
                      .deleteHistorialCredito(uuid: e.uuid);
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
                  cubit: context.read<SolicitudReprestamoCubit>(),
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
  required SolicitudReprestamoCubit cubit,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => CreateCreditoContainerForm(
      cubit: cubit,
    ),
  );
}

class CreateCreditoContainerForm extends StatefulWidget {
  final SolicitudReprestamoCubit cubit;
  const CreateCreditoContainerForm({
    super.key,
    required this.cubit,
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
  final formKey = GlobalKey<FormState>();
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
                  OutlineTextfieldWidget(
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
                  SearchDropdownWidget(
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
                  CatalogoFrecuenciaPagoDropdown(
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: CustomElevatedButton(
                      enabled: true,
                      text: 'Crear Credito',
                      color: AppColors.greenLatern.withOpacity(0.4),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
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
    );
  }
}
