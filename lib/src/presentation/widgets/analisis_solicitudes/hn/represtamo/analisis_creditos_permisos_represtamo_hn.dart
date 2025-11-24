import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_represtamo/analisis_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisCreditosPermisosReprestamoHN extends StatelessWidget {
  const AnalisisCreditosPermisosReprestamoHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisReprestamoCubit>();
    return BlocBuilder<AnalisisReprestamoCubit, AnalisisReprestamoState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Detalle del crédito',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                initialValue:
                    state.ingresoAnual.toCurrencyString().toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Ingreso anual y/o volumen de venta',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      ingresoAnual: int.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Nombre de sus principales clientes',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cliente1,
                validator: (value) => ClassValidator.validateRequired(value),
                title: 'Cliente 1',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      cliente1: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cliente2,
                title: 'Cliente 2',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      cliente2: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cliente3,
                title: 'Cliente 3',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      cliente3: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Nombre de sus proveedores',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.proveedor1,
                validator: (value) => ClassValidator.validateRequired(value),
                title: 'Proveedor 1',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      proveedor1: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.proveedor2,
                title: 'Proveedor 2',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      proveedor2: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.proveedor3,
                title: 'Proveedor 3',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      proveedor3: value,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
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
                    const Gap(20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
