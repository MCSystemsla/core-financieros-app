import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/grupal/grupal_sending_analisis_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_asalariado_hn_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_nueva_menor_mil_hn_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_represtamo_hn_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_solicitud_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/analisis/hn/analisis_grupal/analisis_grupal_cubit.dart';

class AnalisisSolicitudesInterceptorHN extends StatelessWidget {
  final AnalisisSolicitudesInterceptorType type;
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  final String tipoSolicitudString;
  const AnalisisSolicitudesInterceptorHN({
    super.key,
    required this.type,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
    required this.tipoSolicitudString,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AnalisisSolicitudesInterceptorType.nueva => AnalisisNuevaMenorMilHnForm(
          index: index,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: int.parse(numeroSolicitud),
          tipoSolicitud: type,
        ),
      AnalisisSolicitudesInterceptorType.represtamo =>
        AnalisisNuevaMenorMilHnForm(
          index: index,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: int.parse(numeroSolicitud),
          tipoSolicitud: type,
        ),
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        AnalisisSolicitudNuevaMayorAMilHn(
          title: title,
          subtitle: subtitle,
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
        ),
      AnalisisSolicitudesInterceptorType.represtamoMayorAMil =>
        AnalisisReprestamoHnForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
        ),
      AnalisisSolicitudesInterceptorType.asalariado => AnalisisAsalariadoHnForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
        ),
      AnalisisSolicitudesInterceptorType.grupal => AnalisisGrupaHnForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
          tipoSolicitudString: tipoSolicitudString,
        ),
    };
  }
}

class AnalisisGrupaHnForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  final String tipoSolicitudString;
  const AnalisisGrupaHnForm({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
    required this.tipoSolicitudString,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final solicitud = localDbProvider.getAnalisisGrupalByNumeroSolicitud(
      numeroSolicitud: numeroSolicitud,
    );

    return BlocProvider(
      create: (ctx) => AnalisisGrupalCubit(
        AnalisisRepositoryHNImpl(),
      )
        ..initAutoSave(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitudString,
        )
        ..loadFromLocalDb(solicitud),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analisis Grupal'),
        ),
        body: Column(
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
                    AnalisisGrupalForm1(pageController: pageController)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnalisisGrupalForm1 extends StatelessWidget {
  final PageController pageController;
  const AnalisisGrupalForm1({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AnalisisGrupalCubit>();

    return FadeIn(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: BlocBuilder<AnalisisGrupalCubit, AnalisisGrupalState>(
              builder: (context, state) {
                final totalIngresos = state.ingresosNegociosSalarios +
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(18),
                      child: Text(
                        'Ingresos',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            ingresosNegociosSalarios: double.tryParse(newValue),
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
                            ingresosRemesas: double.tryParse(newValue),
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
                            ingresosOtraActividad: double.tryParse(newValue),
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
                            ingresosConyuge: double.tryParse(newValue),
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
                            totalIngresos: double.tryParse(newValue),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.all(18),
                      child: Text(
                        'Gastos',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      title: 'Pago de cuotas de otras instituciones:',
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
                            pagoCuotasOtrasInst: double.tryParse(newValue),
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
                            gastosFamiliares: double.tryParse(newValue),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          CustomElevatedButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<AnalisisGrupalCubit>(),
                                    child: const GrupalSendingAnalisisHn(),
                                  ),
                                ),
                              );
                            },
                            text: 'Enviar Analisis',
                            color: Colors.green,
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
    );
  }
}
