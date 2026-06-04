import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../bloc/analisis/hn/actualizar_analisis_grupal/actualizar_analisis_grupal_cubit.dart';
import '../../../../../../bloc/analisis/hn/get_analisis_data/get_analisis_data_cubit.dart';

class ActualizarAnalisisGrupalHnScreen extends StatelessWidget {
  final String numeroSolicitud;
  final String tipoSolicitud;
  final String title;
  final String subtitle;
  final String description;
  final int index;
  const ActualizarAnalisisGrupalHnScreen({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final repository = AnalisisRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => GetAnalisisDataCubit(
            repository,
          )..getAnalisisData(
              numeroSolicitud: numeroSolicitud,
              tipoSolicitud: tipoSolicitud,
            ),
        ),
        BlocProvider(
          create: (ctx) => ActualizarAnalisisGrupalCubit(
            repository,
          )..setNumerSolicitudAndTipoSolicitud(
              numeroSolicitud: int.parse(numeroSolicitud),
              tipoSolicitud: tipoSolicitud,
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Actualizar Analisis Grupal'),
        ),
        body: BlocConsumer<GetAnalisisDataCubit, GetAnalisisDataState>(
          listener: (context, state) {
            if (state.status == Status.done) {
              context
                  .read<ActualizarAnalisisGrupalCubit>()
                  .cargarDatosIniciales(
                    ingresosNegociosSalarios: state.ingresosNegociosSalarios,
                    ingresosRemesas: state.ingresosRemesas,
                    ingresosOtraActividad: state.ingresosOtraActividad,
                    ingresosConyuge: state.ingresosConyuge,
                    totalIngresos: state.totalIngresos,
                    compras: state.compras,
                    pagoCuotasOtrasInst: state.pagoCuotasOtrasInst,
                    gastosFamiliares: state.gastosFamiliares,
                    otrosGastos: state.otrosGastos,
                    totalGastos: state.totalGastos,
                    flujoNeto: state.flujoNeto,
                    comentarios: state.comentarios,
                  );
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMessage,
                  onPressed: () {
                    context.read<GetAnalisisDataCubit>().getAnalisisData(
                          numeroSolicitud: numeroSolicitud,
                          tipoSolicitud: tipoSolicitud,
                        );
                  },
                ),
              Status.done => UpdateAnalisisGrupalForm(
                  index: index,
                  title: title,
                  subtitle: subtitle,
                  description: description,
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class UpdateAnalisisGrupalForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  const UpdateAnalisisGrupalForm({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<ActualizarAnalisisGrupalCubit>();
    return Column(
      children: [
        AnalisisCreditCardHn(
          enabled: false,
          index: index,
          animate: false,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: '',
        ),
        Expanded(
          flex: 3,
          child: SafeArea(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FadeIn(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Form(
                        key: formKey,
                        child: BlocConsumer<ActualizarAnalisisGrupalCubit,
                            ActualizarAnalisisGrupalState>(
                          listenWhen: (previous, current) =>
                              previous.status != current.status,
                          listener: (context, state) {
                            if (state.status == Status.done) {
                              CustomAlertDialog(
                                context: context,
                                title: 'Analisis actualizado exitosamente',
                                onDone: () => context.pop(),
                              ).showDialog(
                                context,
                                dialogType: DialogType.success,
                              );
                            }
                            if (state.status == Status.error) {
                              CustomAlertDialog(
                                context: context,
                                title: state.errorMessage,
                                onDone: () => context.pop(),
                              ).showDialog(
                                context,
                                dialogType: DialogType.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            final totalIngresos =
                                state.ingresosNegociosSalarios +
                                    state.ingresosRemesas +
                                    state.ingresosOtraActividad +
                                    state.ingresosConyuge;

                            final totalGastos = state.compras +
                                state.pagoCuotasOtrasInst +
                                state.gastosFamiliares +
                                state.otrosGastos;

                            final flujoNeto = totalIngresos - totalGastos;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(18),
                                  child: Text(
                                    'Ingresa datos de solicitante',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(18),
                                  child: Text(
                                    'Ingresos',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.ingresosNegociosSalarios
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title: 'Ingresos del negocio salarios:',
                                  icon: const Icon(
                                    Icons.trending_up,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        ingresosNegociosSalarios:
                                            double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.ingresosRemesas
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title: 'Ingresos de remesas:',
                                  icon: const Icon(
                                    Icons.trending_up,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        ingresosRemesas:
                                            double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.ingresosOtraActividad
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title: 'Ingresos de otras actividades:',
                                  icon: const Icon(
                                    Icons.trending_up,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        ingresosOtraActividad:
                                            double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.ingresosConyuge
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title: 'Ingresos del conyuge:',
                                  icon: const Icon(
                                    Icons.trending_up,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        ingresosConyuge:
                                            double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  readOnly: true,
                                  hintText: totalIngresos.toCurrencyString(),
                                  textAlign: TextAlign.end,
                                  title: 'Total de ingresos:',
                                  icon: const Icon(
                                    Icons.trending_up,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        totalIngresos:
                                            double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.all(18),
                                  child: Text(
                                    'Gastos',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.compras
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title: 'Compras:',
                                  icon: const Icon(
                                    Icons.trending_down,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        compras: double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.pagoCuotasOtrasInst
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title:
                                      'Pago de cuotas de otras instituciones:',
                                  textInputType: TextInputType.number,
                                  icon: const Icon(
                                    Icons.trending_down,
                                    color: Colors.green,
                                  ),
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        pagoCuotasOtrasInst:
                                            double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.gastosFamiliares
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title: 'Gastos familiares:',
                                  icon: const Icon(
                                    Icons.trending_down,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        gastosFamiliares:
                                            double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.otrosGastos
                                      .toCurrencyString()
                                      .toNullIfEmptyOrZero(),
                                  textAlign: TextAlign.end,
                                  title: 'Otros gastos:',
                                  icon: const Icon(
                                    Icons.trending_down,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        otrosGastos: double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  readOnly: true,
                                  hintText: totalGastos.toCurrencyString(),
                                  textAlign: TextAlign.end,
                                  title: 'Total de gastos:',
                                  icon: const Icon(
                                    Icons.trending_down,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        totalGastos: double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  readOnly: true,
                                  hintText: flujoNeto.toCurrencyString(),
                                  textAlign: TextAlign.end,
                                  title: 'Flujo neto:',
                                  icon: const Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.green,
                                  ),
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    CurrencyInputFormatter(
                                      mantissaLength: 0,
                                    ),
                                  ],
                                  onChange: (value) {
                                    final newValue = toNumericString(value);
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        flujoNeto: double.tryParse(newValue),
                                      ),
                                    );
                                  },
                                ),
                                OutlineTextfieldWidget(
                                  initialValue: state.comentarios,
                                  textAlign: TextAlign.start,
                                  title: 'Comentarios:',
                                  icon: const Icon(
                                    Icons.comment,
                                    color: Colors.green,
                                  ),
                                  inputFormatters: [
                                    UpperCaseTextFormatter(),
                                  ],
                                  onChange: (value) {
                                    cubit.onFieldChanged(
                                      () => state.copyWith(
                                        comentarios: value,
                                      ),
                                    );
                                  },
                                ),
                                const Gap(20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      CustomElevatedButton(
                                        onPressed: () {
                                          if (!formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          context
                                              .read<
                                                  ActualizarAnalisisGrupalCubit>()
                                              .actualizarAnalisisGrupal();
                                        },
                                        text: state.status == Status.inProgress
                                            ? 'Actualizando...'
                                            : 'Actualizar Analisis',
                                        color: Colors.green,
                                        enabled:
                                            state.status != Status.inProgress,
                                      ),
                                      const Gap(10),
                                      CustomElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: 'Cancelar',
                                        color: Colors.red,
                                      ),
                                      const Gap(20),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
