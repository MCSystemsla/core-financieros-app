import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/analisis/hn/get_analisis_menor_mil_data/get_analisis_menor_mil_data_cubit.dart';

class ActualizarAnalisisMenorMilForm3 extends StatelessWidget {
  final PageController pageController;
  const ActualizarAnalisisMenorMilForm3({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
            _RucForm(),
            const Gap(10),
            _MatriculaForm(),
            const Gap(10),
            _LicenciaForm(),
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

class _LicenciaForm extends StatefulWidget {
  @override
  State<_LicenciaForm> createState() => _LicenciaFormState();
}

class _LicenciaFormState extends State<_LicenciaForm> {
  DateTime? fechaEmision;
  DateTime? fechaVencimiento;

  Future<void> selectDateFechaEmision(BuildContext context) async {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();

    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.tryParse(cubit.state.fechaEmisionLicencia),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmision) {
      fechaEmision = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaEmisionLicencia: fechaEmision?.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();

    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.tryParse(cubit.state.fechaVencimientoLicencia),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimiento) {
      fechaVencimiento = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaVencimientoLicencia: fechaVencimiento?.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();

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
              'Licencia',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.numeroLicencia,
            title: 'Licencia',
            icon: const Icon(Icons.add_box),
            onChange: (value) {
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     numeroLicencia: value,
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: cubit.state.nombreInstitucionLicencia,
            title: 'Nombre de institución',
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            icon: const Icon(Icons.account_balance),
            onChange: (value) {
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     nombreInstitucionLicencia: value,
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de emisión',
            icon: const Icon(Icons.wallet),
            hintText: fechaEmision?.selectorFormat(),
            readOnly: true,
            onTap: () => selectDateFechaEmision(context),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Fecha de vencimiento',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            readOnly: true,
            onTap: () => selectDateFechaVencimiento(context),
            hintText: fechaVencimiento?.selectorFormat(),
          ),
          const Gap(20),
        ],
      ),
    );
    // },
    // );
  }
}

class _MatriculaForm extends StatefulWidget {
  @override
  State<_MatriculaForm> createState() => _MatriculaFormState();
}

class _MatriculaFormState extends State<_MatriculaForm> {
  DateTime? fechaEmision;
  DateTime? fechaVencimiento;

  Future<void> selectDateFechaEmision(BuildContext context) async {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();

    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.tryParse(cubit.state.fechaEmisionMatricula),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmision) {
      fechaEmision = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaEmisionMatricula: fechaEmision?.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();

    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.tryParse(cubit.state.fechaVencimientoMatricula),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimiento) {
      fechaVencimiento = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaVencimientoMatricula:
      //         fechaVencimiento?.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();
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
              'Matricula',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.numeroMatricula,
            title: 'Matricula',
            icon: const Icon(Icons.add_box),
            onChange: (value) {
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     numeroMatricula: value,
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: cubit.state.nombreInstitucionMatricula,
            title: 'Nombre de institución',
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     nombreInstitucionMatricula: value,
              //   ),
              // );
            },
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: fechaEmision?.selectorFormat(),
            readOnly: true,
            title: 'Fecha de emisión',
            icon: const Icon(Icons.wallet),
            onTap: () => selectDateFechaEmision(context),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: fechaVencimiento?.selectorFormat(),
            readOnly: true,
            title: 'Fecha de vencimiento',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onTap: () => selectDateFechaVencimiento(context),
          ),
          const Gap(20),
        ],
      ),
    );
    // },
    // );
  }
}

class _RucForm extends StatefulWidget {
  @override
  State<_RucForm> createState() => _RucFormState();
}

class _RucFormState extends State<_RucForm> {
  DateTime? fechaEmision;
  DateTime? fechaVencimiento;

  Future<void> selectDateFechaEmision(BuildContext context) async {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();

    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.tryParse(cubit.state.fechaEmisionRuc),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmision) {
      fechaEmision = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaEmisionRuc: fechaEmision?.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();

    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.tryParse(cubit.state.fechaVencimientoRuc),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimiento) {
      fechaVencimiento = picked;
      // cubit.onFieldChanged(
      //   () => cubit.state.copyWith(
      //     fechaVencimientoRuc: fechaVencimiento?.toUtc().toIso8601String(),
      //   ),
      // );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetAnalisisMenorMilDataCubit>();
    // return BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
    // builder: (context, state) {
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
              'RTN',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.numeroRuc,
            title: 'Numero de RTN',
            icon: const Icon(Icons.add_box),
            onChange: (value) {
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     numeroRuc: value,
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: cubit.state.nombreInstitucionRuc,
            title: 'Nombre de institución',
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     nombreInstitucionRuc: value,
              //   ),
              // );
            },
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: fechaEmision?.selectorFormat(),
            readOnly: true,
            title: 'Fecha de emisión de RTN',
            onTap: () => selectDateFechaEmision(context),
            icon: const Icon(Icons.wallet),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: fechaVencimiento?.selectorFormat(),
            readOnly: true,
            title: 'Fecha de vencimiento de RTN',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onTap: () => selectDateFechaVencimiento(context),
          ),
          const Gap(20),
        ],
      ),
    );
    // },
    // );
  }
}
