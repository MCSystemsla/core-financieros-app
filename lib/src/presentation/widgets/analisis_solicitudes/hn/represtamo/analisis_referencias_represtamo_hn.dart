import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/add_item_card/add_item_custom_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisReferenciasReprestamoHN extends StatefulWidget {
  final PageController pageController;
  const AnalisisReferenciasReprestamoHN({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisReferenciasReprestamoHN> createState() =>
      _AnalisisReferenciasReprestamoHNState();
}

class _AnalisisReferenciasReprestamoHNState
    extends State<AnalisisReferenciasReprestamoHN> {
  bool isAddReferenciaAditionalClicked = false;
  DateTime fechaVerificacion = DateTime.now();
  DateTime fechaVerificacion2 = DateTime.now();
  late DateTime? fechaVerificacion3 =
      isAddReferenciaAditionalClicked ? DateTime.now() : null;
  final formKey = GlobalKey<FormState>();
  Future<void> selectFechaVerificacion(BuildContext context) async {
    // final cubit = context.read<AnalisisAsalariadoHnCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVerificacion,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVerificacion) {
      fechaVerificacion = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaVerificacion1: fechaVerificacion.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  Future<void> selectFechaVerificacion2(BuildContext context) async {
    // final cubit = context.read<AnalisisAsalariadoHnCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVerificacion2,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVerificacion) {
      fechaVerificacion2 = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaVerificacion2: fechaVerificacion2.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  Future<void> selectFechaVerificacion3(BuildContext context) async {
    // final cubit = context.read<AnalisisAsalariadoHnCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVerificacion3,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVerificacion) {
      fechaVerificacion3 = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaVerificacion3: fechaVerificacion3?.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Referencia 1',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Nombres y apellidos',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            validator: (value) => ClassValidator.validateRequired(value?.value),
            codigo: 'PARENTESCO',
            title: 'Tipo parentesco',
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            validator: (value) => ClassValidator.validateRequired(value),
            title: 'Dirección',
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Centro laboral',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Número de cédula',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            textInputType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Teléfono de referencia',
            icon: const Icon(Icons.person),
            validator: (value) => ClassValidator.validateRequired(value),
            textInputType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Resultado verificación',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Años de conocer al referido',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'EMPLEADOS',
            title: 'Empleado que verifica',
            validator: (value) => ClassValidator.validateRequired(value?.value),
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            hintText: fechaVerificacion.selectorFormat(),
            title: 'Fecha de verificación',
            onTap: () => selectFechaVerificacion(context),
            icon: const Icon(Icons.date_range),
            readOnly: true,
            onChange: (value) {},
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Referencia 2',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Nombres y apellidos:',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'PARENTESCO',
            title: 'Tipo parentesco',
            validator: (value) => ClassValidator.validateRequired(value?.value),
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Dirección:',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Centro laboral:',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            validator: (value) => ClassValidator.validateRequired(value),
            title: 'Número de cédula:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.person),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Teléfono de referencia 2:',
            validator: (value) => ClassValidator.validateRequired(value),
            textInputType: TextInputType.number,
            icon: const Icon(Icons.person),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            validator: (value) => ClassValidator.validateRequired(value),
            title: 'Años de conocer referido 2:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.person),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Resultado verificación 2',
            icon: const Icon(Icons.person),
            validator: (value) => ClassValidator.validateRequired(value),
            textInputType: TextInputType.number,
            onChange: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'EMPLEADOS',
            title: 'Empleado que verifica 2',
            validator: (value) => ClassValidator.validateRequired(value?.value),
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            hintText: fechaVerificacion2.selectorFormat(),
            title: 'Fecha de verificación 2',
            onTap: () => selectFechaVerificacion2(context),
            icon: const Icon(Icons.date_range),
            readOnly: true,
            onChange: (value) {},
          ),
          const Gap(20),
          AddItemCustomCard(
            title: !isAddReferenciaAditionalClicked
                ? 'Añadir Referencia Adicional'
                : 'Quitar referencia adicional',
            onTap: () {
              setState(() {
                isAddReferenciaAditionalClicked =
                    !isAddReferenciaAditionalClicked;
              });
            },
          ),
          if (isAddReferenciaAditionalClicked) ...[
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Referencia 3',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Nombres y apellidos:',
              validator: (value) => ClassValidator.validateRequired(value),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'PARENTESCO',
              title: 'Tipo Parentesco',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Direccion:',
              icon: const Icon(Icons.person),
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Centro laboral:',
              icon: const Icon(Icons.person),
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Número de cédula:',
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              icon: const Icon(Icons.person),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Telefono Referencia 3:',
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              icon: const Icon(Icons.person),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Años de conocer referido 3:',
              validator: (value) => ClassValidator.validateRequired(value),
              textInputType: TextInputType.number,
              icon: const Icon(Icons.person),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Resultado Verificacion 3',
              validator: (value) => ClassValidator.validateRequired(value),
              icon: const Icon(Icons.person),
              textInputType: TextInputType.number,
              onChange: (value) {},
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'EMPLEADOS',
              title: 'Empleado que verifica 3',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              hintText: fechaVerificacion3?.selectorFormat(),
              title: 'Fecha de verificación 3',
              onTap: () => selectFechaVerificacion3(context),
              icon: const Icon(Icons.date_range),
              readOnly: true,
              onChange: (value) {},
            ),
          ],
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomElevatedButton(
                  onPressed: () {},
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
                const Gap(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
