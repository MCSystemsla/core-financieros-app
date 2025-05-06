// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoForm3 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm3({super.key, required this.controller});

  @override
  State<AsalariadoForm3> createState() => _AsalariadoForm3State();
}

class _AsalariadoForm3State extends State<AsalariadoForm3> {
  String? paisCasa;
  String? depCasa;
  String? munCasa;
  String? condicionCasa;
  String? nombreDuenoCasa;
  String? pagoAlquiler;
  String? anosResidir;
  String? direccionDomicilio;
  String? barrio;
  String? sector;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        child: Column(
          children: [
            const Gap(30),
            CatalogoValorNacionalidad(
              codigo: 'PAIS',
              title: 'País',
              onChanged: (item) {
                paisCasa = item?.valor;
                setState(() {});
              },
              hintText: 'Ingresa Pais',
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              codigo: 'DEP',
              title: 'Departamento',
              hintText: 'Ingresa Departamento',
              onChanged: (item) {
                depCasa = item?.valor;
                setState(() {});
              },
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              codigo: 'MUN',
              title: 'Municipio',
              hintText: 'Ingresa Municipio',
              onChanged: (item) {
                munCasa = item?.valor;
                setState(() {});
              },
            ),
            const Gap(30),
            SearchDropdownWidget(
              codigo: 'TIPOVIVIENDA',
              title: 'Condicion Casa',
              onChanged: (item) {
                condicionCasa = item?.value;
                setState(() {});
              },
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                nombreDuenoCasa = value;
              },
              title: 'Nombre dueno de casa',
              icon: const Icon(Icons.person),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                pagoAlquiler = value;
              },
              title: 'Pago de alquiler',
              icon: const Icon(Icons.money),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                anosResidir = value;
              },
              title: 'Anos de residir',
              icon: const Icon(Icons.house),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                direccionDomicilio = value;
              },
              title: 'Direccion Domicilio',
              icon: const Icon(Icons.house),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                barrio = value;
              },
              title: 'Barrio',
              icon: const Icon(Icons.house),
            ),
            const Gap(30),
            SearchDropdownWidget(
              codigo: 'SECTORECONOMICO',
              title: 'Sector',
              onChanged: (item) {
                sector = item?.value;
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
                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        objPaisCasaId: paisCasa,
                        objDepartamentoCasaId: depCasa,
                        objMunicipioCasaId: munCasa,
                        objCondicionCasaId: condicionCasa,
                        duenoVivienda: nombreDuenoCasa,
                        pagoAlquiler: int.tryParse(pagoAlquiler ?? '0'),
                        anosResidirCasa: int.tryParse(anosResidir ?? '0'),
                        direccionCasa: direccionDomicilio,
                        barrioCasa: barrio,
                        objSectorId: sector,
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
