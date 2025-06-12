// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReprestamoOfflineForm2 extends StatefulWidget {
  final ReprestamoResponsesLocalDb solicitudReprestamoOffline;
  final PageController controller;
  const ReprestamoOfflineForm2({
    super.key,
    required this.controller,
    required this.solicitudReprestamoOffline,
  });

  @override
  State<ReprestamoOfflineForm2> createState() => _ReprestamoOfflineForm2State();
}

class _ReprestamoOfflineForm2State extends State<ReprestamoOfflineForm2>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? familiarEmpleado;
  String? familiarEntidad;
  String? tieneFamiliarPeps;
  String? nombreEmpleado;
  String? cedulaEmpleado;
  String? espeps;
  String? nombreDeEntidadPeps;
  Item? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? nombreFamiliarPeps2;
  Item? parentescoFamiliarPeps2;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  Item? paisPeps2;

  @override
  void initState() {
    super.initState();
    final solicitud = widget.solicitudReprestamoOffline;
    familiarEmpleado = solicitud.esFamiliarEmpleado == true
        ? 'input.yes'.tr()
        : 'input.no'.tr();
    tieneFamiliarPeps = solicitud.tieneFamiliarPeps == true
        ? 'input.yes'.tr()
        : 'input.no'.tr();
    nombreFamiliarPeps2 = solicitud.nombreFamiliarPeps2;
    nombreEmpleado = solicitud.nombreFamiliar;
    cedulaEmpleado = solicitud.cedulaFamiliar;
    espeps = solicitud.esPeps == true ? 'input.yes'.tr() : 'input.no'.tr();
    nombreDeEntidadPeps = solicitud.nombreDeEntidadPeps;
    paisPeps = Item(name: solicitud.paisPeps!, value: solicitud.paisPeps);
    periodoPeps = solicitud.periodoPeps;
    cargoOficialPeps = solicitud.cargoOficialPeps;
    nombreFamiliarPeps2 = solicitud.nombreFamiliarPeps2;
    parentescoFamiliarPeps2 = Item(
      name: solicitud.parentescoFamiliarPeps2!,
      value: solicitud.parentescoFamiliarPeps2,
    );
    cargoFamiliarPeps2 = solicitud.cargoFamiliarPeps2;
    nombreEntidadPeps2 = solicitud.nombreEntidadPeps2;
    periodoPeps2 = solicitud.periodoPeps2;
    paisPeps2 = Item(name: solicitud.paisPeps2!, value: solicitud.paisPeps2);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                initialValue: familiarEmpleado,
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Es familiar de un empleado?'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  familiarEmpleado = item;
                  setState(() {});
                },
                validator: (value) {
                  if (value == null) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (familiarEmpleado == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: nombreEmpleado,
                icon: Icon(
                  Icons.person,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre del empleado',
                hintText: 'Ingresa Nombre del empleado',
                isValid: null,
                onChange: (value) {
                  nombreEmpleado = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: cedulaEmpleado,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cedula',
                hintText: 'Ingresa Cedula del empleado',
                isValid: null,
                onChange: (value) {
                  cedulaEmpleado = value;
                },
              ),
            ],
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                initialValue: espeps,
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    'Has desempeñado un cargo publico y/o figura publica de alto nivel en los ultimos 10 años?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  espeps = item;
                  setState(() {});
                },
                validator: (value) {
                  if (value == null) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (espeps == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: nombreDeEntidadPeps,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de la entidad',
                hintText: 'Ingresa Nombre de la entidad',
                isValid: null,
                onChange: (value) {
                  nombreDeEntidadPeps = value;
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                initialValue: ItemNacionalidad(
                  id: 0,
                  valor: paisPeps?.value,
                  nombre: paisPeps?.value,
                  relacion: '',
                ),
                hintText: paisPeps?.value ?? 'Ingresa Pais',
                title: 'Pais',
                onChanged: (item) {
                  if (item == null) return;
                  paisPeps = Item(name: item.nombre, value: item.valor);
                  // paisDomicilio = Item(name: item.nombre, value: item.valor);
                  // depWhereClause = item.valor;

                  setState(() {});
                },
                codigo: 'PAIS',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                // initialValue: paisEmisor ?? '',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: periodoPeps,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Periodo',
                hintText: 'Ingrese periodo',
                isValid: null,
                onChange: (value) {
                  periodoPeps = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: cargoOficialPeps,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cargo oficial',
                hintText: 'Ingrese Cargo oficial',
                isValid: null,
                onChange: (value) {
                  cargoOficialPeps = value;
                },
              ),
            ],
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                initialValue: tieneFamiliarPeps,
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    'Eres familia de una persona que a desempeñado un cargo publico o figura publica de alto nivel?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  tieneFamiliarPeps = item;
                  setState(() {});
                },
                validator: (value) {
                  if (value == null) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (tieneFamiliarPeps == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: nombreFamiliarPeps2,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre del familiar',
                hintText: 'Ingrese Nombre del familiar',
                isValid: null,
                onChange: (value) {
                  nombreFamiliarPeps2 = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: cargoFamiliarPeps2,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cargo Familiar',
                hintText: 'Ingrese Cargo Familiar',
                isValid: null,
                onChange: (value) {
                  cargoFamiliarPeps2 = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: nombreEntidadPeps2,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de la entidad',
                hintText: 'Ingrese Nombre de la entidad',
                isValid: null,
                onChange: (value) {
                  nombreEntidadPeps2 = value;
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                onChanged: (item) {
                  if (item == null) return;
                  parentescoFamiliarPeps2 =
                      Item(name: item.name, value: item.value);
                  setState(() {});
                },
                codigo: 'PARENTESCO',
                title: 'Parentesco',
                hintText: parentescoFamiliarPeps2?.name ?? 'Ingrese Parentesco',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: periodoPeps2,
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Periodo',
                hintText: 'Ingrese Periodo',
                isValid: null,
                onChange: (value) {
                  periodoPeps2 = value;
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                hintText: paisPeps2?.name ?? 'Ingresa Pais',
                title: 'Pais',
                onChanged: (item) {
                  if (item == null) return;
                  paisPeps2 = Item(name: item.nombre, value: item.valor);
                  // paisDomicilio = Item(name: item.nombre, value: item.valor);
                  // depWhereClause = item.valor;

                  setState(() {});
                },
                codigo: 'PAIS',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                // initialValue: paisEmisor ?? '',
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
                  context.read<SolicitudReprestamoCubit>().saveAnswers(
                        esFamiliarEmpleado:
                            familiarEmpleado == 'input.yes'.tr(),
                        nombreFamiliar: nombreEmpleado?.trim(),
                        cedulaFamiliar: cedulaEmpleado?.trim(),
                        esPeps: espeps == 'input.yes'.tr(),
                        nombreDeEntidadPeps: nombreDeEntidadPeps,
                        paisPeps: paisPeps?.value,
                        periodoPeps: periodoPeps,
                        cargoOficialPeps: cargoOficialPeps,
                        tieneFamiliarPeps:
                            tieneFamiliarPeps == 'input.yes'.tr(),
                        nombreFamiliarPeps2: nombreFamiliarPeps2,
                        parentescoFamiliarPeps2: parentescoFamiliarPeps2?.value,
                        cargoFamiliarPeps2: cargoFamiliarPeps2,
                        nombreEntidadPeps2: nombreEntidadPeps2,
                        periodoPeps2: periodoPeps2,
                        paisPeps2: paisPeps2?.value,
                      );

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
  }

  @override
  bool get wantKeepAlive => true;
}
