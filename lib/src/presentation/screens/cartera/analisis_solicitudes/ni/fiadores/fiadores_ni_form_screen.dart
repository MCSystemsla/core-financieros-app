import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tipos de fiador de Nicaragua.
///
/// Códigos PROVISIONALES: solo `FIA` viene confirmado por backend. Se
/// reemplazan por los reales de NI cuando backend los defina.
enum FiadoresNiFormType {
  fiador('FIA'),
  conyuge('CON'),
  codeudor('COD');

  final String codigo;
  const FiadoresNiFormType(this.codigo);
}

/// Mismo orden que los hijos del `PageView`.
const fiadoresNiSteps = [
  'Datos generales',
  'Datos personales',
  'Actividad económica',
  'Datos de actividad',
  'Datos de ingresos',
];

class FiadoresNiFormScreen extends StatefulWidget {
  final FiadoresNiFormType typeForm;
  final int numeroSolicitud;
  const FiadoresNiFormScreen({
    super.key,
    required this.typeForm,
    required this.numeroSolicitud,
  });

  @override
  State<FiadoresNiFormScreen> createState() => _FiadoresNiFormScreenState();
}

class _FiadoresNiFormScreenState extends State<FiadoresNiFormScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onBack() {
    final page = pageController.page?.round() ?? 0;
    if (page == 0) {
      Navigator.pop(context);
      return;
    }
    pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AnalisisFiadoresNiCubit(AnalisisFormsRepositoryNiImpl())
        ..setTipoFiador(widget.typeForm),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _onBack();
        },
        child: Scaffold(
          backgroundColor: RedesignColors.background,
          body: SafeArea(
            child: Column(
              children: [
                FormStepHeaderWidget(
                  title: 'Crear Fiador',
                  subtitle:
                      'Registra los datos del fiador de la solicitud #${widget.numeroSolicitud}',
                  tag: 'Análisis de crédito',
                  controller: pageController,
                  steps: fiadoresNiSteps,
                  onBack: _onBack,
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      for (final step in fiadoresNiSteps)
                        _StepPlaceholder(label: step),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Se reemplaza paso a paso por los widgets de cada sección (pasos 6 a 10).
class _StepPlaceholder extends StatelessWidget {
  final String label;
  const _StepPlaceholder({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(color: RedesignColors.inkMuted),
      ),
    );
  }
}
