import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/origin/origin.dart';
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

class NuevaMenorOffline2Widget extends StatefulWidget {
  final ResponseLocalDb responseLocalDb;
  final PageController controller;
  const NuevaMenorOffline2Widget(
      {super.key, required this.controller, required this.responseLocalDb});

  @override
  State<NuevaMenorOffline2Widget> createState() =>
      _NuevaMenorOffline2WidgetState();
}

class _NuevaMenorOffline2WidgetState extends State<NuevaMenorOffline2Widget>
    with AutomaticKeepAliveClientMixin {
  String? initialValue;
  String? paisDomicilio;
  String? objPaisCasaIdVer;
  String? departamentoDomicilio;
  String? objDepartamentoCasaIdVer;
  String? municipioDomicilio;
  String? objMunicipioCasaIdVer;
  String? barrioCasa;
  String? condicionCasa;
  String? objCondicionCasaIdVer;
  String? anosResidirCasa;
  String? comunidad;
  String? direccionCasa;
  String? depWhereClause;
  String? munWhereClause;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    paisDomicilio = widget.responseLocalDb.objPaisCasaId;
    objDepartamentoCasaIdVer = widget.responseLocalDb.objDepartamentoCasaIdVer;
    objMunicipioCasaIdVer = widget.responseLocalDb.objMunicipioCasaIdVer;
    objPaisCasaIdVer = widget.responseLocalDb.objPaisCasaIdVer;
    objCondicionCasaIdVer = widget.responseLocalDb.objCondicionCasaIdVer;
    departamentoDomicilio = widget.responseLocalDb.objDepartamentoCasaId;
    municipioDomicilio = widget.responseLocalDb.objMunicipioCasaId;
    direccionCasa = widget.responseLocalDb.direccionCasa;
    barrioCasa = widget.responseLocalDb.barrioCasa;
    condicionCasa = widget.responseLocalDb.objCondicionCasaId;
    anosResidirCasa = widget.responseLocalDb.anosResidirCasa.toString();
    comunidad = widget.responseLocalDb.ubicacion;
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
            const Gap(30),
            CatalogoValorNacionalidad(
              initialValue: ItemNacionalidad(
                id: 0,
                valor: paisDomicilio ?? 'input.select_option'.tr(),
                nombre: objPaisCasaIdVer ?? 'input.select_option'.tr(),
                relacion: '',
              ),
              hintText: objPaisCasaIdVer ?? 'Selecciona Pais de Casa',
              title: 'Pais Domicilio',
              onChanged: (item) {
                if (item == null) return;
                paisDomicilio = item.valor;
                objPaisCasaIdVer = item.nombre;
                depWhereClause = item.valor;

                setState(() {});
              },
              codigo: 'PAIS',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              // initialValue: paisEmisor ?? '',
            ),
            // if (paisDomicilio != null) ...[
            const Gap(30),
            CatalogoValorNacionalidad(
              initialValue: ItemNacionalidad(
                id: 0,
                valor: departamentoDomicilio ?? '',
                nombre: objDepartamentoCasaIdVer ?? '',
                relacion: '',
              ),
              hintText:
                  objDepartamentoCasaIdVer ?? 'Selecciona Departamento de Casa',
              title: 'Departamento Domicilio',
              onChanged: (item) {
                if (item == null) return;
                departamentoDomicilio = item.valor;
                munWhereClause = item.valor;
                objDepartamentoCasaIdVer = item.nombre;
                setState(() {});
              },
              codigo: 'DEP',
              where: depWhereClause,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
            ),
            // ],
            // if (munWhereClause != null) ...[
            const Gap(30),
            CatalogoValorNacionalidad(
              initialValue: ItemNacionalidad(
                id: 0,
                valor: municipioDomicilio ?? '',
                nombre: objMunicipioCasaIdVer ?? '',
                relacion: '',
              ),
              where: munWhereClause,
              hintText: objMunicipioCasaIdVer ?? 'Selecciona Municipio de Casa',
              title: 'Municipio Domicilio',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),

              onChanged: (item) {
                if (item == null) return;
                municipioDomicilio = item.valor;
                objMunicipioCasaIdVer = item.nombre;
              },
              codigo: 'MUN',
              // initialValue: paisEmisor ?? '',
            ),
            // ],
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: direccionCasa,
              maxLength: 50,
              icon: Icon(
                Icons.house,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Direccion Casa',
              hintText: 'Ingresa Direccion Casa',
              onChange: (value) {
                direccionCasa = value;
              },
              isValid: null,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: barrioCasa,
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Barrio Casa',
              maxLength: 50,
              hintText: 'Ingresa Barrio Casa',
              onChange: (value) {
                barrioCasa = value;
              },
              isValid: null,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: objCondicionCasaIdVer ?? 'Selecciona una opcion',
              title: 'Condicion Casa',
              codigo: 'TIPOVIVIENDA',
              onChanged: (item) {
                if (item == null) return;
                condicionCasa = item.value;
                objCondicionCasaIdVer = item.name;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: anosResidirCasa == '0' ? null : anosResidirCasa,
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Años Residir Casa',
              validator: (value) => ClassValidator.validateMaxIntValue(
                value,
                100,
              ),
              textInputType: TextInputType.number,
              hintText: 'Ingresa Años Residir Casa',
              isValid: null,
              onChange: (value) {
                anosResidirCasa = value;
              },
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Ubicacion',
                items: Origin.comunidades,
                onChanged: (item) {
                  if (item == null) return;
                  comunidad = item.valor;
                },
                toStringItem: (item) {
                  return item.nombre;
                },
                hintText: comunidad!.isEmpty
                    ? 'input.select_option'.tr()
                    : comunidad!,
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final geolocationService =
                      GeolocationService(context: context);
                  final currentLocation =
                      await geolocationService.getCurrentLocation();
                  if (!context.mounted) return;
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        objCondicionCasaIdVer: objCondicionCasaIdVer,
                        objMunicipioCasaIdVer: objMunicipioCasaIdVer,
                        objDepartamentoCasaIdVer: objDepartamentoCasaIdVer,
                        objPaisCasaIdVer: objPaisCasaIdVer,
                        barrioCasa: barrioCasa,
                        objPaisCasaId: paisDomicilio,
                        objDepartamentoCasaId: departamentoDomicilio,
                        objMunicipioCasaId: municipioDomicilio,
                        objCondicionCasaId: condicionCasa,
                        anosResidirCasa: int.tryParse(anosResidirCasa ?? ''),
                        ubicacion: comunidad,
                        ubicacionLatitud: currentLocation?.latitude.toString(),
                        ubicacionLongitud:
                            currentLocation?.longitude.toString(),
                        direccionCasa: direccionCasa,
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
