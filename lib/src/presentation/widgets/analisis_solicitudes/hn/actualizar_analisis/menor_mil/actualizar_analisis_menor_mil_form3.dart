import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/analisis/hn/actualizar_analisis_menor_mil/actualizar_analisis_menor_mil_cubit.dart';

class ActualizarAnalisisMenorMilForm3 extends StatelessWidget {
  final PageController pageController;
  const ActualizarAnalisisMenorMilForm3({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<ActualizarAnalisisMenorMilCubit>();
    final state = cubit.state;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Constancias, licencias y permisos',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _DocumentoForm(
              title: 'RTN',
              numeroTitle: 'Numero de RTN',
              fechaEmisionTitle: 'Fecha de emisión de RTN',
              fechaVencimientoTitle: 'Fecha de vencimiento de RTN',
              numero: state.numeroRuc,
              nombreInstitucion: state.nombreInstitucionRuc,
              fechaEmision: state.fechaEmisionRuc,
              fechaVencimiento: state.fechaVencimientoRuc,
              onNumeroChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(numeroRuc: value),
              ),
              onNombreInstitucionChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(nombreInstitucionRuc: value),
              ),
              onFechaEmisionChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(fechaEmisionRuc: value),
              ),
              onFechaVencimientoChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(fechaVencimientoRuc: value),
              ),
            ),
            const Gap(10),
            _DocumentoForm(
              title: 'Matricula',
              numeroTitle: 'Matricula',
              fechaEmisionTitle: 'Fecha de emisión',
              fechaVencimientoTitle: 'Fecha de vencimiento',
              numero: state.numeroMatricula,
              nombreInstitucion: state.nombreInstitucionMatricula,
              fechaEmision: state.fechaEmisionMatricula,
              fechaVencimiento: state.fechaVencimientoMatricula,
              onNumeroChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(numeroMatricula: value),
              ),
              onNombreInstitucionChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(nombreInstitucionMatricula: value),
              ),
              onFechaEmisionChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(fechaEmisionMatricula: value),
              ),
              onFechaVencimientoChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(fechaVencimientoMatricula: value),
              ),
            ),
            const Gap(10),
            _DocumentoForm(
              title: 'Licencia',
              numeroTitle: 'Licencia',
              fechaEmisionTitle: 'Fecha de emisión',
              fechaVencimientoTitle: 'Fecha de vencimiento',
              numero: state.numeroLicencia,
              nombreInstitucion: state.nombreInstitucionLicencia,
              fechaEmision: state.fechaEmisionLicencia,
              fechaVencimiento: state.fechaVencimientoLicencia,
              onNumeroChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(numeroLicencia: value),
              ),
              onNombreInstitucionChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(nombreInstitucionLicencia: value),
              ),
              onFechaEmisionChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(fechaEmisionLicencia: value),
              ),
              onFechaVencimientoChanged: (value) => cubit.onFieldChanged(
                () => cubit.state.copyWith(fechaVencimientoLicencia: value),
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      pageController.nextPage(
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
                      pageController.previousPage(
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
}

class _DocumentoForm extends StatefulWidget {
  final String title;
  final String numeroTitle;
  final String fechaEmisionTitle;
  final String fechaVencimientoTitle;
  final String numero;
  final String nombreInstitucion;
  final String fechaEmision;
  final String fechaVencimiento;
  final ValueChanged<String> onNumeroChanged;
  final ValueChanged<String> onNombreInstitucionChanged;
  final ValueChanged<String> onFechaEmisionChanged;
  final ValueChanged<String> onFechaVencimientoChanged;

  const _DocumentoForm({
    required this.title,
    required this.numeroTitle,
    required this.fechaEmisionTitle,
    required this.fechaVencimientoTitle,
    required this.numero,
    required this.nombreInstitucion,
    required this.fechaEmision,
    required this.fechaVencimiento,
    required this.onNumeroChanged,
    required this.onNombreInstitucionChanged,
    required this.onFechaEmisionChanged,
    required this.onFechaVencimientoChanged,
  });

  @override
  State<_DocumentoForm> createState() => _DocumentoFormState();
}

class _DocumentoFormState extends State<_DocumentoForm> {
  late DateTime? fechaEmision = DateTime.tryParse(widget.fechaEmision);
  late DateTime? fechaVencimiento = DateTime.tryParse(widget.fechaVencimiento);

  Future<DateTime?> _pickDate(DateTime? initialDate) => showDatePicker(
        initialDate: initialDate,
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale:
            Locale(context.read<LangCubit>().state.currentLang.languageCode),
      );

  Future<void> selectDateFechaEmision() async {
    final picked = await _pickDate(fechaEmision);
    if (picked != null && picked != fechaEmision) {
      fechaEmision = picked;
      widget.onFechaEmisionChanged(picked.toUtc().toIso8601String());
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento() async {
    final picked = await _pickDate(fechaVencimiento);
    if (picked != null && picked != fechaVencimiento) {
      fechaVencimiento = picked;
      widget.onFechaVencimientoChanged(picked.toUtc().toIso8601String());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              widget.title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: widget.numero,
            title: widget.numeroTitle,
            icon: const Icon(Icons.add_box),
            onChange: (value) => widget.onNumeroChanged(value ?? ''),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: widget.nombreInstitucion,
            title: 'Nombre de institución',
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            icon: const Icon(Icons.account_balance),
            onChange: (value) =>
                widget.onNombreInstitucionChanged(value ?? ''),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: fechaEmision?.selectorFormat(),
            readOnly: true,
            title: widget.fechaEmisionTitle,
            icon: const Icon(Icons.wallet),
            onTap: selectDateFechaEmision,
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: fechaVencimiento?.selectorFormat(),
            readOnly: true,
            title: widget.fechaVencimientoTitle,
            icon: const Icon(Icons.wallet),
            onTap: selectDateFechaVencimiento,
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
