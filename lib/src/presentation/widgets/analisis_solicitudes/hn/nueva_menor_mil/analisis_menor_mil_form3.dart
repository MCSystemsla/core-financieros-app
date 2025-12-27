import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_menor_mil/analisis_menor_mil_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisMenorMilForm3 extends StatefulWidget {
  final PageController pageController;
  const AnalisisMenorMilForm3({super.key, required this.pageController});

  @override
  State<AnalisisMenorMilForm3> createState() => _AnalisisMenorMilForm3State();
}

class _AnalisisMenorMilForm3State extends State<AnalisisMenorMilForm3> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
}

class _LicenciaForm extends StatefulWidget {
  @override
  State<_LicenciaForm> createState() => _LicenciaFormState();
}

class _LicenciaFormState extends State<_LicenciaForm> {
  DateTime? fechaEmision;
  DateTime? fechaVencimiento;

  Future<void> selectDateFechaEmision(BuildContext context) async {
    final cubit = context.read<AnalisisMenorMilCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmision) {
      fechaEmision = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaEmisionLicencia: fechaEmision?.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final cubit = context.read<AnalisisMenorMilCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimiento) {
      fechaVencimiento = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVencimientoLicencia: fechaVencimiento?.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisMenorMilCubit>();

    return BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
      builder: (context, state) {
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
                initialValue: state.numeroLicencia,
                title: 'Licencia',
                icon: const Icon(Icons.add_box),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      numeroLicencia: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.nombreInstitucionLicencia,
                title: 'Nombre de institución',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.account_balance),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      nombreInstitucionLicencia: value,
                    ),
                  );
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
      },
    );
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
    final cubit = context.read<AnalisisMenorMilCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmision) {
      fechaEmision = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaEmisionMatricula: fechaEmision?.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final cubit = context.read<AnalisisMenorMilCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimiento) {
      fechaVencimiento = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVencimientoMatricula:
              fechaVencimiento?.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisMenorMilCubit>();
    return BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
      builder: (context, state) {
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
                initialValue: state.numeroMatricula,
                title: 'Matricula',
                icon: const Icon(Icons.add_box),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      numeroMatricula: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.nombreInstitucionMatricula,
                title: 'Nombre de institución',
                textInputType: TextInputType.number,
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      nombreInstitucionMatricula: value,
                    ),
                  );
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
      },
    );
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
    final cubit = context.read<AnalisisMenorMilCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmision) {
      fechaEmision = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaEmisionRuc: fechaEmision?.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final cubit = context.read<AnalisisMenorMilCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimiento) {
      fechaVencimiento = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVencimientoRuc: fechaVencimiento?.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisMenorMilCubit>();
    return BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
      builder: (context, state) {
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
                  'RUC',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                initialValue: state.numeroRuc,
                title: 'Numero de RUC',
                icon: const Icon(Icons.add_box),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      numeroRuc: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.nombreInstitucionRuc,
                title: 'Nombre de institución',
                textInputType: TextInputType.number,
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      nombreInstitucionRuc: value,
                    ),
                  );
                },
                icon: const Icon(Icons.account_balance),
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: fechaEmision?.selectorFormat(),
                readOnly: true,
                title: 'Fecha de emisión de RUC',
                onTap: () => selectDateFechaEmision(context),
                icon: const Icon(Icons.wallet),
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: fechaVencimiento?.selectorFormat(),
                readOnly: true,
                title: 'Fecha de vencimiento de RUC',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onTap: () => selectDateFechaVencimiento(context),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}
