// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorOffline3Widget extends StatefulWidget {
  final PageController controller;
  final ResponseLocalDb responseLocalDb;
  const NuevaMenorOffline3Widget({
    super.key,
    required this.controller,
    required this.responseLocalDb,
  });

  @override
  State<NuevaMenorOffline3Widget> createState() =>
      _NuevaMenorOffline3WidgetState();
}

class _NuevaMenorOffline3WidgetState extends State<NuevaMenorOffline3Widget>
    with AutomaticKeepAliveClientMixin {
  String? estadoCivil;
  String? objEstadoCivilIdVer;
  String? nacionalidadConyuge;
  String? nombreConyuge;
  String? trabajaConyuge;
  String? trabajoConyuge;
  String? direccionTrabajoConyuge;
  String? telefonoTrabajoConyuge;
  String? cantidadHijos;
  String? esFamiliarEmpleado;
  String? nombreFamiliarEmpleado;
  String? cedulaFamiliarEmpleado;
  String? personasACargo;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    estadoCivil = widget.responseLocalDb.objEstadoCivilId;
    objEstadoCivilIdVer = widget.responseLocalDb.objEstadoCivilIdVer;
    esFamiliarEmpleado = widget.responseLocalDb.esFamiliarEmpleado!
        ? 'input.yes'.tr()
        : 'input.no'.tr();
    nombreConyuge = widget.responseLocalDb.nombreConyugue;
    personasACargo = widget.responseLocalDb.personasACargo.toString();
    nacionalidadConyuge = widget.responseLocalDb.nacionalidadConyugue;
    nombreConyuge = widget.responseLocalDb.nombreConyugue;
    trabajaConyuge = (widget.responseLocalDb.trabajaConyugue!)
        ? 'input.yes'.tr()
        : 'input.no'.tr();
    trabajoConyuge = widget.responseLocalDb.trabajoConyugue;
    direccionTrabajoConyuge = widget.responseLocalDb.direccionTrabajoConyugue;
    telefonoTrabajoConyuge = widget.responseLocalDb.telefonoTrabajoConyugue;
    cantidadHijos = widget.responseLocalDb.cantidadHijos.toString();
    nombreFamiliarEmpleado = widget.responseLocalDb.nombreFamiliar;
    cedulaFamiliarEmpleado = widget.responseLocalDb.cedulaFamiliar;
    super.initState();
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
            SearchDropdownWidget(
              hintText: objEstadoCivilIdVer ?? 'Selecciona una Opcion',
              title: 'Estado Civil',
              codigo: 'ESTADOCIVIL',
              onChanged: (item) {
                if (item == null) return;
                estadoCivil = item.value;
                objEstadoCivilIdVer = item.name;
                setState(() {});
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
            ),
            if (estadoCivil == 'UNI' || estadoCivil == 'CAS') ...[
              const Gap(20),
              CatalogoValorNacionalidad(
                initialValue: ItemNacionalidad(
                  id: 0,
                  valor: nacionalidadConyuge ?? '',
                  nombre: nacionalidadConyuge ?? '',
                  relacion: '',
                ),
                codigo: 'PAIS',
                onChanged: (item) {
                  if (item == null) return;
                  nacionalidadConyuge = item.valor;
                },
                hintText: 'Ingresa Nacionalidad Conyuge',
                title: nacionalidadConyuge ?? 'Nacionalidad Conyuge',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: nombreConyuge,
                maxLength: 50,
                icon: Icon(
                  Icons.woman,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre Conyuge',
                hintText: 'Ingresa nombre conyuge',
                onChange: (value) {
                  nombreConyuge = value;
                },
                isValid: null,
              ),
              const Gap(20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: JLuxDropdown(
                  dropdownColor: Colors.white,
                  isContainIcon: true,
                  title: 'Trabaja su conyuge',
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    trabajaConyuge = item;
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: trabajaConyuge ?? 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: trabajoConyuge,
                maxLength: 50,
                icon: Icon(
                  Icons.woman_2,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Trabajo de Conyuge',
                hintText: 'Ingresa el Trabajo de Conyuge',
                isValid: null,
                onChange: (value) {
                  trabajoConyuge = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: direccionTrabajoConyuge,
                maxLength: 50,
                icon: Icon(
                  Icons.woman_2,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Direccion Trabajo Conyuge',
                hintText: 'Ingresa el Trabajo de Conyuge',
                isValid: null,
                onChange: (value) {
                  direccionTrabajoConyuge = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: telefonoTrabajoConyuge,
                maxLength: 15,
                icon: Icon(
                  Icons.phone,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Telefono Trabajo Conyuge',
                hintText: 'Ingresa el Telefono de Conyuge',
                textInputType: TextInputType.phone,
                isValid: null,
                onChange: (value) {
                  telefonoTrabajoConyuge = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: cantidadHijos ?? '0',
                icon: Icon(
                  Icons.phone,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cantidad Hijos',
                hintText: 'Ingresa Cantida de Hijos',
                textInputType: TextInputType.number,
                isValid: null,
                onChange: (value) {
                  cantidadHijos = value;
                },
              ),
            ],
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                initialValue: esFamiliarEmpleado,
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Es familiar empleado',
                validator: (value) => ClassValidator.validateRequired(value),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  esFamiliarEmpleado = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (esFamiliarEmpleado == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: nombreFamiliarEmpleado,
                icon: Icon(
                  Icons.family_restroom,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre familiar de empleado',
                hintText: 'Ingresa el nombre de empleado',
                isValid: null,
                onChange: (value) {
                  nombreFamiliarEmpleado = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: cedulaFamiliarEmpleado,
                icon: Icon(
                  Icons.add_card_sharp,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cedula familiar de empleado',
                hintText: 'Ingresa la cedula de empleado',
                isValid: null,
                onChange: (value) {
                  cedulaFamiliarEmpleado = value;
                },
              ),
            ],
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: personasACargo == '0' ? null : personasACargo,
              icon: Icon(
                Icons.add_card_sharp,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Persona a cargo',
              hintText: 'Ingresa la persona a cargo',
              textInputType: TextInputType.number,
              isValid: null,
              onChange: (value) {
                personasACargo = value;
              },
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        objEstadoCivilIdVer: objEstadoCivilIdVer,
                        objEstadoCivilId: estadoCivil,
                        nacionalidadConyugue: nacionalidadConyuge,
                        nombreConyugue: nombreConyuge,
                        trabajaConyugue: trabajaConyuge == 'input.yes'.tr(),
                        trabajoConyugue: trabajoConyuge,
                        direccionTrabajoConyugue: direccionTrabajoConyuge,
                        telefonoTrabajoConyugue: telefonoTrabajoConyuge,
                        cantidadHijos: int.tryParse(cantidadHijos ?? ''),
                        esFamiliarEmpleado:
                            esFamiliarEmpleado == 'input.yes'.tr(),
                        nombreFamiliar: nombreFamiliarEmpleado,
                        cedulaFamiliar: cedulaFamiliarEmpleado,
                        personasACargo: int.tryParse(personasACargo ?? ''),
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
