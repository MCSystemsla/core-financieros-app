import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorCreditoWidget extends StatefulWidget {
  const NuevaMenorCreditoWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorCreditoWidget> createState() =>
      _NuevaMenorCreditoWidgetState();
}

class _NuevaMenorCreditoWidgetState extends State<NuevaMenorCreditoWidget> {
  String? moneda;
  String? monto;
  String? proposito;
  String? producto;
  String? frecuenciaDePago;
  String? plazoSolicitud;
  String? cuota;
  String? observacion;
  DateTime? fechaPrimerPago;
  final formKey = GlobalKey<FormState>();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaPrimerPago,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaPrimerPago) {
      fechaPrimerPago = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'MONEDA',
              onChanged: (item) {
                if (item == null) return;
                moneda = item.value;
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              title: 'Moneda',
              isRequired: true,
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.price_change,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Monto',
              hintText: 'Ingresa Monto',
              validator: (value) => ClassValidator.validateRequired(value),
              isValid: null,
              onChange: (value) {
                monto = value;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'DESTINOCREDITO',
              title: 'Proposito',
              onChanged: (item) {
                if (item == null) return;
                proposito = item.value;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'PRODUCTO',
              title: 'Producto',
              onChanged: (item) {
                if (item == null) return;
                producto = item.value;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (item) {
                if (item == null) return;
                frecuenciaDePago = item.value;
              },
              codigo: 'FRECUENCIAPAGO',
              title: 'Frecuencia de Pago',
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.price_change,
                color: AppColors.getPrimaryColor(),
              ),
              validator: (value) => ClassValidator.validateRequired(value),
              title: 'Plazo Solicitud',
              hintText: 'Ingresa Plazo Solicitud',
              isValid: null,
              onChange: (value) {
                plazoSolicitud = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              validator: (value) => ClassValidator.validateRequired(
                  fechaPrimerPago?.selectorFormat()),
              readOnly: true,
              onTap: () => selectDate(context),
              icon: Icon(
                Icons.payment,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Fecha de Primer Pago Solicitud',
              hintText: fechaPrimerPago?.selectorFormat() ??
                  'Ingresar fecha primer pago',
              isValid: null,
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.payment,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Cuota',
              hintText: 'Ingresa Cuota',
              isValid: null,
              onChange: (value) {
                cuota = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.remove_red_eye,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Observacion',
              hintText: 'Ingresa Observacion',
              isValid: null,
              onChange: (value) {
                observacion = value;
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
                        objMonedaId: moneda,
                        monto: int.tryParse(monto!),
                        objPropositoId: proposito,
                        objProductoId: producto,
                        objFrecuenciaId: frecuenciaDePago,
                        plazoSolicitud: int.tryParse(plazoSolicitud ?? ''),
                        fechaPrimerPagoSolicitud:
                            fechaPrimerPago?.toUtc().toIso8601String(),
                        cuota: int.tryParse(cuota ?? ''),
                        observacion: observacion,
                      );
                  widget.pageController.nextPage(
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
                  widget.pageController.previousPage(
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
