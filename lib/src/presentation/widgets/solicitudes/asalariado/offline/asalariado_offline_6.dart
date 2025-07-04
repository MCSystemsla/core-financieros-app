// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoOffline6 extends StatefulWidget {
  final PageController controller;
  final AsalariadoResponsesLocalDb? asalariadoResponsesLocalDb;

  const AsalariadoOffline6({
    super.key,
    required this.controller,
    this.asalariadoResponsesLocalDb,
  });

  @override
  State<AsalariadoOffline6> createState() => _AsalariadoOffline6State();
}

class _AsalariadoOffline6State extends State<AsalariadoOffline6>
    with AutomaticKeepAliveClientMixin {
  String? nombreFamiliarCercano;
  String? telefonoFamiliarCercano;
  String? parentescoFamiliarCercano;
  String? direccionDomicilioFamiiiar;
  String? nombreConyuge;
  String? nacionalidadConyuge;
  String? profesionConyuge;
  String? trabajaConyuge;
  String? salarioNetoMensualConyuge;
  String? otrosIngresosConyuge;
  String? fuenteOtrosIngresosConyuge;
  String? totalIngresosMesConyuge;
  String? observaciones;
  String? nombreDelaEmpresaConyuge;
  String? telefonoOficinaConyuge;
  String? direccionTrabajoConyugue;
  String? tiempoLaborarConyugue;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final solicitud = widget.asalariadoResponsesLocalDb;
    nombreFamiliarCercano = solicitud?.nombreFamiliarCercano;
    telefonoFamiliarCercano = solicitud?.telefonoFamiliarCercano;
    parentescoFamiliarCercano = solicitud?.objParentescoFamiliarCercanoId;
    direccionDomicilioFamiiiar = solicitud?.direccionFamiliarCercano;
    nombreConyuge = solicitud?.nombreConyugue;
    nacionalidadConyuge = solicitud?.nacionalidadConyugue;
    profesionConyuge = solicitud?.profesionConyugue;
    trabajaConyuge = (solicitud?.trabajaConyugue ?? false)
        ? 'input.yes'.tr()
        : 'input.no'.tr();
    salarioNetoMensualConyuge = solicitud?.sueldoMesConyugue.toString();
    otrosIngresosConyuge = solicitud?.otrosIngresosConyugue.toString();
    fuenteOtrosIngresosConyuge = solicitud?.fuenteOtrosIngresosConyugue;
    totalIngresosMesConyuge = solicitud?.totalIngresoMesConyugue.toString();
    observaciones = solicitud?.observacion;
    nombreDelaEmpresaConyuge = solicitud?.trabajoConyugue;
    telefonoOficinaConyuge = solicitud?.telefonoTrabajoConyugue;
    direccionTrabajoConyugue = solicitud?.direccionTrabajoConyugue;
    tiempoLaborarConyugue = solicitud?.tiempoLaborarConyugue;
    nombreFamiliarCercano = solicitud?.nombreFamiliar;

    context.read<SolicitudAsalariadoCubit>().onFieldChanged(
          () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                nombreFamiliarCercano: nombreFamiliarCercano,
                telefonoFamiliarCercano: telefonoFamiliarCercano,
                objParentescoFamiliarCercanoId: parentescoFamiliarCercano,
                direccionFamiliarCercano: direccionDomicilioFamiiiar,
                nombreConyugue: nombreConyuge,
                nacionalidadConyugue: nacionalidadConyuge,
                profesionConyugue: profesionConyuge,
                trabajaConyugue: trabajaConyuge == 'input.yes'.tr(),
                sueldoMesConyugue:
                    double.tryParse(salarioNetoMensualConyuge ?? '0'),
                otrosIngresosConyugue:
                    double.tryParse(otrosIngresosConyuge ?? '0'),
                fuenteOtrosIngresosConyugue: fuenteOtrosIngresosConyuge,
                totalIngresoMesConyugue:
                    double.tryParse(totalIngresosMesConyuge ?? '0'),
                observacion: observaciones,
                trabajoConyugue: nombreDelaEmpresaConyuge,
                telefonoTrabajoConyugue: telefonoOficinaConyuge,
                tiempoLaborarConyugue: tiempoLaborarConyugue,
                nombreFamiliar: nombreFamiliarCercano,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudAsalariadoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Datos familiar no cercano que no viva con usted',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: nombreFamiliarCercano,
                  onChange: (value) {
                    nombreFamiliarCercano = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombreFamiliar: nombreFamiliarCercano,
                      ),
                    );
                  },
                  title: 'Nombre',
                  icon: const Icon(Icons.person_outline),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: telefonoFamiliarCercano,
                  onChange: (value) {
                    telefonoFamiliarCercano = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefonoFamiliarCercano: telefonoFamiliarCercano,
                      ),
                    );
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    DashFormatter(),
                  ],
                  maxLength: 9,
                  isRequired: false,
                  hintText: 'Ingresa Telefono',
                  title: 'Telefono',
                  icon: const Icon(Icons.phone_outlined),
                  textInputType: TextInputType.phone,
                ),
                const Gap(30),
                SearchDropdownWidget(
                  hintText: parentescoFamiliarCercano ?? '',
                  codigo: 'PARENTESCO',
                  onChanged: (item) {
                    parentescoFamiliarCercano = item?.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objParentescoFamiliarCercanoId: item?.value,
                        objParentescoFamiliarCercanoIdVer: item?.name,
                      ),
                    );
                    setState(() {});
                  },
                  title: 'Parentesco',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: direccionDomicilioFamiiiar,
                  onChange: (value) {
                    direccionDomicilioFamiiiar = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionFamiliarCercano: direccionDomicilioFamiiiar,
                      ),
                    );
                  },
                  title: 'Dirección Domicilio',
                  icon: const Icon(Icons.location_on_outlined),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Datos de conyugue',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: nombreConyuge,
                  onChange: (value) {
                    nombreConyuge = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombreConyugue: nombreConyuge,
                      ),
                    );
                  },
                  title: 'Nombre y Apellido',
                  icon: const Icon(Icons.badge_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: nacionalidadConyuge,
                  onChange: (value) {
                    nacionalidadConyuge = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacionalidadConyugue: nacionalidadConyuge,
                      ),
                    );
                  },
                  title: 'Nacionalidad del conyugue',
                  icon: const Icon(Icons.flag_outlined),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: profesionConyuge,
                  onChange: (value) {
                    profesionConyuge = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        profesionConyugue: profesionConyuge,
                      ),
                    );
                  },
                  title: 'Profesión',
                  icon: const Icon(Icons.work_outline),
                ),
                const Gap(30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    initialValue: trabajaConyuge,
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title: '¿Trabaja?:',
                    items: ['input.yes'.tr(), 'input.no'.tr()],
                    onChanged: (item) {
                      trabajaConyuge = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          trabajaConyugue: trabajaConyuge == 'input.yes'.tr(),
                        ),
                      );
                      setState(() {});
                    },
                    // validator: (value) {},
                    toStringItem: (item) => item,
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                if (trabajaConyuge == 'input.yes'.tr()) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: direccionTrabajoConyugue,
                    onChange: (value) {
                      direccionTrabajoConyugue = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          direccionTrabajoConyugue: direccionTrabajoConyugue,
                        ),
                      );
                    },
                    title: 'Direccion de la Empresa',
                    icon: const Icon(Icons.badge_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: tiempoLaborarConyugue,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    onChange: (value) {
                      tiempoLaborarConyugue = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tiempoLaborarConyugue: tiempoLaborarConyugue,
                        ),
                      );
                    },
                    title: 'Tiempo de laborar',
                    icon: const Icon(Icons.badge_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: salarioNetoMensualConyuge,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      CurrencyInputFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    onChange: (value) {
                      salarioNetoMensualConyuge = value.replaceAll(',', '');
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          salarioNetoCordoba:
                              double.tryParse(salarioNetoMensualConyuge ?? '0'),
                        ),
                      );
                    },
                    title: 'Salario Neto Mensual (C\$)',
                    icon: const Icon(Icons.attach_money_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: otrosIngresosConyuge,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      CurrencyInputFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    onChange: (value) {
                      otrosIngresosConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          otrosIngresosCordoba:
                              double.tryParse(otrosIngresosConyuge ?? '0'),
                        ),
                      );
                    },
                    title: 'Otros ingresos (C\$)',
                    icon: const Icon(Icons.money_off_csred_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: fuenteOtrosIngresosConyuge,
                    onChange: (value) {
                      fuenteOtrosIngresosConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          fuenteOtrosIngresos: fuenteOtrosIngresosConyuge,
                        ),
                      );
                    },
                    title: 'Fuentes otros ingresos',
                    icon: const Icon(Icons.source_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: totalIngresosMesConyuge,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      CurrencyInputFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    onChange: (value) {
                      totalIngresosMesConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          totalIngresoMes:
                              double.tryParse(totalIngresosMesConyuge ?? '0'),
                        ),
                      );
                    },
                    title: 'Total ingresos mes (C\$)',
                    icon: const Icon(Icons.calculate_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: observaciones,
                    onChange: (value) {
                      observaciones = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          observacion: observaciones,
                        ),
                      );
                    },
                    title: 'Observaciones',
                    icon: const Icon(Icons.note_alt_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: nombreDelaEmpresaConyuge,
                    onChange: (value) {
                      nombreDelaEmpresaConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreTrabajo: nombreDelaEmpresaConyuge,
                        ),
                      );
                    },
                    title: 'Nombres de la empresa',
                    icon: const Icon(Icons.business_outlined),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: telefonoOficinaConyuge,
                    textInputType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                      DashFormatter(),
                    ],
                    onChange: (value) {
                      telefonoOficinaConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          telefonoTrabajo: telefonoOficinaConyuge,
                        ),
                      );
                    },
                    maxLength: 9,
                    isRequired: false,
                    title: 'Teléfono Oficina',
                    icon: const Icon(Icons.phone_iphone_outlined),
                  ),
                ],
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Siguiente',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

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
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
