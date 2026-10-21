import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Un solo slot de actividad económica con el catálogo NI
/// `ACTIVIDADECONOMICA` (HN usa tres slots con el catálogo CNBS).
class AnalisisFiadoresNiActividadEconomica extends StatefulWidget {
  final PageController pageController;
  const AnalisisFiadoresNiActividadEconomica({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisFiadoresNiActividadEconomica> createState() =>
      _AnalisisFiadoresNiActividadEconomicaState();
}

class _AnalisisFiadoresNiActividadEconomicaState
    extends State<AnalisisFiadoresNiActividadEconomica>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresNiCubit>();
    return BlocBuilder<AnalisisFiadoresNiCubit, AnalisisFiadoresNiState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                FiadorNiSectionCard(
                  label: 'ACTIVIDAD ECONÓMICA',
                  children: [
                    SearchDropdownWidget(
                      codigo: 'ACTIVIDADECONOMICA',
                      title: 'Actividad económica:',
                      hintText: 'Selecciona actividad económica',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            actividadEconomicaCNBS1Codigo: value?.value,
                          ),
                        );
                      },
                    ),
                    if (state.actividadEconomicaCNBS1Codigo.isNotEmpty)
                      OutlineTextfieldWidget(
                        initialValue: state.actividadEconomicaDescripcion1,
                        title: 'Descripción de la actividad económica:',
                        hintText: 'Ingresa la descripción',
                        icon: const Icon(Icons.description_outlined),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadEconomicaDescripcion1: value,
                            ),
                          );
                        },
                      ),
                  ],
                ),
                FiadorNiStepButtons(
                  onSecondary: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  ),
                  onPrimary: () {
                    if (!formKey.currentState!.validate()) return;
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
