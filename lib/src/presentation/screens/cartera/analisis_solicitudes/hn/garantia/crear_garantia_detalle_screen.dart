import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia_detalle/analisis_garantia_detalle_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CrearGarantiaDetalleScreen extends StatelessWidget {
  final int numeroSolicitud;
  final List<GarantiaData> garantias;
  const CrearGarantiaDetalleScreen({
    super.key,
    required this.numeroSolicitud,
    required this.garantias,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AnalisisGarantiaDetalleCubit(
        AnalisisRepositoryHNImpl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Detalle de Garantía'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: context.read<AnalisisArticuloCubit>(),
                child: CreateArticuloModalSheet(
                  numeroSolicitud: numeroSolicitud,
                ),
              ),
            );
          },
          backgroundColor: Colors.black,
          label: const Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Gap(5),
              Text(
                'Crear Articulo',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: _ArticuloForm(
          garantias: garantias,
        ),
      ),
    );
  }
}

class _ArticuloForm extends StatefulWidget {
  final List<GarantiaData> garantias;
  const _ArticuloForm({required this.garantias});
  @override
  State<_ArticuloForm> createState() => _ArticuloFormState();
}

class _ArticuloFormState extends State<_ArticuloForm> {
  final formKey = GlobalKey<FormState>();

  String? objAnalisisGarantiaID;
  int? articuloGarantiaCodigo;
  int? cantidad;
  double? valorComercial;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SheetSearchDropdown(
              title: 'Garantia',
              isRequired: true,
              onChanged: (v) {
                objAnalisisGarantiaID = v?.value;
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              hintText: 'Selecciona una garantia',
              enabled: true,
              items: widget.garantias
                  .map((e) => Item(name: e.tipoGarantia, value: e.id))
                  .toList(),
            ),
            const Gap(20),
            BlocBuilder<AnalisisArticuloCubit, AnalisisArticuloState>(
              builder: (context, state) {
                return SheetSearchDropdown(
                  title: 'Articulo',
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value.toString()),
                  onChanged: (v) {
                    articuloGarantiaCodigo = v?.value;
                  },
                  hintText: 'Selecciona un articulo',
                  enabled: true,
                  items: state.analisisGarantiaArticuloHn
                      .map((e) => Item(name: e.nombre, value: e.valor))
                      .toList(),
                );
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Cantidad',
              icon: const Icon(Icons.wallet),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChange: (value) {
                final newValue = toNumericString(value);

                cantidad = int.tryParse(newValue) ?? 0;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Valor Comercial',
              icon: const Icon(Icons.wallet),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {
                final newValue = toNumericString(value);
                valorComercial = double.tryParse(newValue);
              },
            ),
            const Gap(20),
            BlocConsumer<AnalisisGarantiaDetalleCubit,
                AnalisisGarantiaDetalleState>(
              listenWhen: (prev, curr) => prev.status != curr.status,
              listener: (context, state) {
                if (state.status == Status.done) {
                  CustomAlertDialog(
                    context: context,
                    title: 'Detalle de Garantia creado exitosamente',
                    onDone: () => {
                      context.pop(),
                      formKey.currentState?.reset(),
                    },
                  ).showDialog(
                    context,
                    dialogType: DialogType.success,
                  );
                }
                if (state.status == Status.error) {
                  CustomAlertDialog(
                    context: context,
                    title: state.errorMsg,
                    onDone: () => {
                      context.pop(),
                    },
                  ).showDialog(
                    context,
                    dialogType: DialogType.error,
                  );
                }
              },
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    enabled: state.status != Status.inProgress,
                    text: state.status == Status.inProgress
                        ? 'Creando...'
                        : 'Crear',
                    // ignore: deprecated_member_use
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      context
                          .read<AnalisisGarantiaDetalleCubit>()
                          .createAnalisisDetalle(
                            analisisGarantiaDetalle: AnalisisGarantiaDetalle(
                              cantidad: cantidad!,
                              articuloGarantiaCodigo: articuloGarantiaCodigo!,
                              valorComercial: valorComercial!,
                              objAnalisisGarantiaID:
                                  int.tryParse(objAnalisisGarantiaID ?? '0') ??
                                      0,
                            ),
                          );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CreateArticuloModalSheet extends StatefulWidget {
  final int numeroSolicitud;
  const CreateArticuloModalSheet({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  State<CreateArticuloModalSheet> createState() =>
      _CreateArticuloModalSheetState();
}

class _CreateArticuloModalSheetState extends State<CreateArticuloModalSheet> {
  final formKey = GlobalKey<FormState>();
  String? tipo;
  String? descripcion;
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
                      title: 'Tipo',
                      icon: const Icon(Icons.comment_bank_sharp),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        tipo = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      title: 'Descripcion',
                      icon: const Icon(Icons.comment_bank_sharp),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        descripcion = value;
                      },
                    ),
                    const Gap(20),
                    BlocConsumer<AnalisisArticuloCubit, AnalisisArticuloState>(
                      listenWhen: (prev, curr) =>
                          prev.statusCreate != curr.statusCreate,
                      listener: (context, state) {
                        if (state.statusCreate == Status.done) {
                          CustomAlertDialog(
                            context: context,
                            title: 'Articulo creado exitosamente',
                            onDone: () => {
                              context
                                  .read<AnalisisArticuloCubit>()
                                  .getAnalisisGarantiasArticulos(),
                              context.pop(),
                              context.pop(),
                            },
                          ).showDialog(
                            context,
                            dialogType: DialogType.success,
                          );
                        }
                        if (state.statusCreate == Status.error) {
                          CustomAlertDialog(
                            context: context,
                            title: state.errorMsg,
                            onDone: () => context.pop(),
                          ).showDialog(
                            context,
                            dialogType: DialogType.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: CustomElevatedButton(
                            enabled: state.statusCreate != Status.inProgress,
                            text: state.statusCreate == Status.inProgress
                                ? 'Creando...'
                                : 'Crear',
                            // ignore: deprecated_member_use
                            color: AppColors.greenLatern.withOpacity(0.4),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              context
                                  .read<AnalisisArticuloCubit>()
                                  .createAnalisisGarantiasArticulos(
                                    descripcion: descripcion!,
                                    tipo: tipo!,
                                  );
                            },
                          ),
                        );
                      },
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
