import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SupervisionFormHN1 extends StatefulWidget {
  final PageController pageController;
  final SupervisionData data;
  final String nombreCoordinador;

  const SupervisionFormHN1({
    super.key,
    required this.pageController,
    required this.data,
    required this.nombreCoordinador,
  });

  @override
  State<SupervisionFormHN1> createState() => _SupervisionFormHN1State();
}

class _SupervisionFormHN1State extends State<SupervisionFormHN1>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SupervisionCoordinadorCubit>();
    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Supervisiones de coordinadores',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: widget.nombreCoordinador,
              readOnly: true,
              title: 'Nombre del coordinador',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.numeroSolicitud,
              title: 'Numero de solicitud',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    numeroSolicitud: int.tryParse(value) ?? 0,
                  ),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.fecha.selectorFormat(),
              title: 'Fecha de solicitud',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {},
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.nombrePromotor,
              title: 'Asesor integral del cliente',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.nombreCliente,
              title: 'Cliente',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.cedulaCliente,
              title: 'Numero de cedula',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.direccionCasa,
              title: 'Direccion del domicilio',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.direccionNegocio,
              title: 'Direccion del negocio',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.destino,
              title: 'Destino del credito',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.sectorComercialNombre,
              title: 'Actividad economica',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              readOnly: true,
              initialValue: widget.data.sectorComercialNombre,
              title: 'Sector economico',
              icon: const Icon(Icons.food_bank),
              textInputType: TextInputType.number,
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(),
                );
              },
            ),
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: Colors.green,
                  ),
                  const Gap(10),
                  CustomElevatedButton(
                    onPressed: () {
                      widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Anterior',
                    color: Colors.red,
                  ),
                ],
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
