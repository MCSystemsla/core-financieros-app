import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_represtamo/analisis_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisConstanciaPermisosReprestamoHN extends StatefulWidget {
  final PageController pageController;
  const AnalisisConstanciaPermisosReprestamoHN({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisConstanciaPermisosReprestamoHN> createState() =>
      _AnalisisConstanciaPermisosReprestamoHNState();
}

class _AnalisisConstanciaPermisosReprestamoHNState
    extends State<AnalisisConstanciaPermisosReprestamoHN> {
  DateTime? fechaEmisionPermiso;
  DateTime? fechaVencimientoPermiso;
  DateTime? fechaEmisionLicencia;
  DateTime? fechaVencimientoLicencia;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisReprestamoCubit>();
    fechaEmisionPermiso = DateTime.tryParse(cubit.state.fechaEmisionLicencia);
    fechaVencimientoPermiso =
        DateTime.tryParse(cubit.state.fechaVencimientoLicencia);
    fechaEmisionLicencia = DateTime.tryParse(cubit.state.fechaEmisionLicencia);
    fechaVencimientoLicencia =
        DateTime.tryParse(cubit.state.fechaVencimientoLicencia);
  }

  Future<void> selectDateFechaEmision(BuildContext context) async {
    final cubit = context.read<AnalisisReprestamoCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaEmisionPermiso,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmisionPermiso) {
      fechaEmisionPermiso = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          permisoOperacionFechaEmision:
              fechaEmisionPermiso!.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final cubit = context.read<AnalisisReprestamoCubit>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVencimientoPermiso,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimientoPermiso) {
      fechaVencimientoPermiso = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          permisoOperacionFechaVencimiento:
              fechaVencimientoPermiso!.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectDateFechaEmisionLicencia(BuildContext context) async {
    final cubit = context.read<AnalisisReprestamoCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaEmisionLicencia,
      lastDate: DateTime.now(),
      firstDate: DateTime(2000),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmisionLicencia) {
      fechaEmisionLicencia = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaEmisionLicencia: fechaEmisionLicencia!.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimientoLicencia(BuildContext context) async {
    final cubit = context.read<AnalisisReprestamoCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVencimientoLicencia,
      lastDate: DateTime(2101),
      firstDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimientoLicencia) {
      fechaVencimientoLicencia = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVencimientoLicencia:
              fechaVencimientoLicencia!.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisReprestamoCubit>();
    return BlocBuilder<AnalisisReprestamoCubit, AnalisisReprestamoState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Permiso de operación',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                OutlineTextfieldWidget(
                  initialValue: state.permisoOperacionNumero,
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Número de permiso de operación',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        permisoOperacionNumero: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.permisoOperacionNombreInstitucion,
                  title: 'Nombre de institución',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.business),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        permisoOperacionNombreInstitucion: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: fechaEmisionPermiso?.selectorFormat() ?? '',
                  title: 'Fecha de emisión de permiso',
                  validator: (value) => ClassValidator.validateRequired(
                      fechaEmisionPermiso?.selectorFormat()),
                  onTap: () => selectDateFechaEmision(context),
                  icon: const Icon(Icons.calendar_month),
                  readOnly: true,
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  onTap: () => selectDateFechaVencimiento(context),
                  validator: (value) => ClassValidator.validateRequired(
                      fechaVencimientoPermiso?.selectorFormat()),
                  hintText: fechaVencimientoPermiso?.selectorFormat() ?? '',
                  title: 'Fecha de vencimiento de permiso',
                  icon: const Icon(Icons.calendar_month),
                  readOnly: true,
                ),
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Licencia',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.numeroLicencia,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Número de licencia',
                  icon: const Icon(Icons.business),
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        numeroLicencia: value,
                      ),
                    );
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.nombreInstitucionLicencia,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Nombre de institución',
                  icon: const Icon(Icons.business),
                  inputFormatters: [UpperCaseTextFormatter()],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nombreInstitucionLicencia: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  onTap: () => selectDateFechaEmisionLicencia(context),
                  hintText: fechaEmisionLicencia?.selectorFormat() ?? '',
                  validator: (value) => ClassValidator.validateRequired(
                      fechaEmisionLicencia?.selectorFormat()),
                  title: 'Fecha de emisión de licencia',
                  icon: const Icon(Icons.calendar_month),
                  readOnly: true,
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  onTap: () => selectDateFechaVencimientoLicencia(context),
                  hintText: fechaVencimientoLicencia?.selectorFormat() ?? '',
                  title: 'Fecha de vencimiento de licencia',
                  validator: (value) => ClassValidator.validateRequired(
                      fechaVencimientoLicencia?.selectorFormat()),
                  icon: const Icon(Icons.calendar_month),
                  readOnly: true,
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
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
      },
    );
  }
}
