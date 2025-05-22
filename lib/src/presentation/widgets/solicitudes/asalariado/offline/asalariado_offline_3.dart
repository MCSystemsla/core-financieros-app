// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoOffline3 extends StatefulWidget {
  final PageController controller;
  final AsalariadoResponsesLocalDb? asalariadoResponsesLocalDb;

  const AsalariadoOffline3({
    super.key,
    required this.controller,
    this.asalariadoResponsesLocalDb,
  });

  @override
  State<AsalariadoOffline3> createState() => _AsalariadoOffline3State();
}

class _AsalariadoOffline3State extends State<AsalariadoOffline3> {
  Item? paisCasa;

  Item? depCasa;

  Item? munCasa;

  Item? condicionCasa;

  String? nombreDuenoCasa;

  String? pagoAlquiler;

  String? anosResidir;

  String? direccionDomicilio;

  String? barrio;

  Item? sector;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final solicitud = widget.asalariadoResponsesLocalDb;
    paisCasa = Item(
      name: solicitud?.objPaisCasaIdVer ?? '',
      value: solicitud?.objPaisCasaId,
    );
    depCasa = Item(
      name: solicitud?.objDepartamentoCasaIdVer ?? '',
      value: solicitud?.objDepartamentoCasaId,
    );
    munCasa = Item(
      name: solicitud?.objMunicipioCasaIdVer ?? '',
      value: solicitud?.objMunicipioCasaId,
    );
    condicionCasa = Item(
      name: solicitud?.objCondicionCasaIdVer ?? '',
      value: solicitud?.objCondicionCasaId,
    );
    nombreDuenoCasa = solicitud?.duenoVivienda;
    pagoAlquiler = solicitud?.pagoAlquiler.toString();
    anosResidir = solicitud?.anosResidirCasa.toString();
    direccionDomicilio = solicitud?.direccionCasa;
    barrio = solicitud?.barrioCasa;
    sector = Item(
      name: solicitud?.objSectorIdVer ?? '',
      value: solicitud?.objSectorId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(30),
            CatalogoValorNacionalidad(
              codigo: 'PAIS',
              title: 'País',
              onChanged: (item) {
                paisCasa = Item(name: item?.nombre ?? '', value: item?.valor);
                setState(() {});
              },
              hintText: paisCasa?.name ?? '',
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              codigo: 'DEP',
              title: 'Departamento',
              hintText: depCasa?.name ?? '',
              onChanged: (item) {
                depCasa = Item(
                  name: item?.nombre ?? '',
                  value: item?.valor,
                );
                setState(() {});
              },
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              codigo: 'MUN',
              title: 'Municipio',
              hintText: depCasa?.name ?? '',
              onChanged: (item) {
                munCasa = Item(
                  name: item?.nombre ?? '',
                  value: item?.valor,
                );
                setState(() {});
              },
            ),
            const Gap(30),
            SearchDropdownWidget(
              hintText: condicionCasa?.name ?? '',
              codigo: 'TIPOVIVIENDA',
              title: 'Condicion Casa',
              onChanged: (item) {
                condicionCasa = Item(
                  name: item?.name ?? '',
                  value: item?.value,
                );
                setState(() {});
              },
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: nombreDuenoCasa,
              onChange: (value) {
                nombreDuenoCasa = value;
              },
              title: 'Nombre dueno de casa',
              icon: const Icon(Icons.person),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: pagoAlquiler,
              onChange: (value) {
                pagoAlquiler = value;
              },
              title: 'Pago de alquiler',
              icon: const Icon(Icons.money),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: anosResidir,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              onChange: (value) {
                anosResidir = value;
              },
              title: 'Años de residir',
              icon: const Icon(Icons.house),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: direccionDomicilio,
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                direccionDomicilio = value;
              },
              title: 'Direccion Domicilio',
              icon: const Icon(Icons.house),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: barrio,
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                barrio = value;
              },
              title: 'Barrio',
              icon: const Icon(Icons.house),
            ),
            const Gap(30),
            SearchDropdownWidget(
              hintText: sector?.name ?? '',
              codigo: 'SECTORECONOMICO',
              title: 'Sector',
              onChanged: (item) {
                sector = item;

                setState(() {});
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
                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        objPaisCasaId: paisCasa?.value,
                        objPaisCasaIdVer: paisCasa?.name,
                        objDepartamentoCasaId: depCasa?.value,
                        objDepartamentoCasaIdVer: depCasa?.name,
                        objMunicipioCasaId: munCasa?.value,
                        objMunicipioCasaIdVer: munCasa?.name,
                        objCondicionCasaId: condicionCasa?.value,
                        objCondicionCasaIdVer: condicionCasa?.name,
                        duenoVivienda: nombreDuenoCasa,
                        pagoAlquiler: int.tryParse(pagoAlquiler ?? '0'),
                        anosResidirCasa: int.tryParse(anosResidir ?? '0'),
                        direccionCasa: direccionDomicilio,
                        barrioCasa: barrio,
                        objSectorId: sector?.value,
                        objSectorIdVer: sector?.name,
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
}
