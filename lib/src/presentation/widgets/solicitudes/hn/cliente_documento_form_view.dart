import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Controladores del formulario de búsqueda de cliente por documento (HN).
class ClienteDocumentoControllers {
  final primerNombre = TextEditingController();
  final segundoNombre = TextEditingController();
  final primerApellido = TextEditingController();
  final segundoApellido = TextEditingController();
  final documento = TextEditingController();

  void dispose() {
    primerNombre.dispose();
    segundoNombre.dispose();
    primerApellido.dispose();
    segundoApellido.dispose();
    documento.dispose();
  }
}

class ClienteDocumentoFormView extends StatelessWidget {
  final String tipoCredito;
  final GlobalKey<FormState> formKey;
  final ClienteDocumentoControllers controllers;
  final Item? tipoDocumento;
  final ValueChanged<Item?> onTipoDocumentoChanged;
  final bool isLoading;
  final VoidCallback onSubmit;
  final String? title;
  final String? subtitle;
  const ClienteDocumentoFormView({
    super.key,
    this.title,
    this.subtitle,
    required this.tipoCredito,
    required this.formKey,
    required this.controllers,
    required this.tipoDocumento,
    required this.onTipoDocumentoChanged,
    required this.isLoading,
    required this.onSubmit,
  });

  static TextInputType _documentoInputType(String? tipoDocumento) {
    return switch (tipoDocumento) {
      'CEDULAIDENTIDAD' || 'RTN' || 'DNI' => TextInputType.number,
      _ => TextInputType.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 28),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          ScreenHeaderWidget(
            title: title ?? 'Datos del cliente',
            subtitle: subtitle ??
                'Crédito $tipoCredito. Ingresa los datos del cliente.',
            onBack: () => Navigator.pop(context),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            isRequired: true,
            inputFormatters: [UpperCaseTextFormatter()],
            textEditingController: controllers.primerNombre,
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person, color: RedesignColors.inkMuted),
            title: 'Primer Nombre de cliente',
            hintText: 'Ingresa el nombre de cliente',
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            inputFormatters: [UpperCaseTextFormatter()],
            textEditingController: controllers.segundoNombre,
            icon: const Icon(Icons.person, color: RedesignColors.inkMuted),
            title: 'Segundo Nombre de cliente',
            hintText: 'Opcional',
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            isRequired: true,
            inputFormatters: [UpperCaseTextFormatter()],
            textEditingController: controllers.primerApellido,
            validator: (value) => ClassValidator.validateRequired(value),
            icon: const Icon(Icons.person, color: RedesignColors.inkMuted),
            title: 'Primer Apellido de cliente',
            hintText: 'Ingresa el apellido de cliente',
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            inputFormatters: [UpperCaseTextFormatter()],
            textEditingController: controllers.segundoApellido,
            icon: const Icon(Icons.person, color: RedesignColors.inkMuted),
            title: 'Segundo Apellido de cliente',
            hintText: 'Opcional',
          ),
          const Gap(10),
          SearchDropdownWidget(
            isRequired: true,
            hintText: 'input.select_option'.tr(),
            codigo: 'TIPODOCUMENTOPERSONA',
            onChanged: onTipoDocumentoChanged,
            title: 'Tipo Documento',
            validator: (value) => ClassValidator.validateRequired(value?.value),
          ),
          if (tipoDocumento != null) ...[
            const Gap(10),
            OutlineTextfieldWidget(
              isRequired: true,
              textInputType: _documentoInputType(tipoDocumento?.value),
              inputFormatters: [UpperCaseTextFormatter()],
              textEditingController: controllers.documento,
              validator: (value) => ClassValidator.hondurasDocumentValidator(
                value,
                tipoDocumento?.value,
              ),
              icon: const Icon(
                Icons.credit_card_outlined,
                color: RedesignColors.inkMuted,
              ),
              title: 'Documento',
              hintText: 'Ingresa documento de cliente',
            ),
          ],
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: RedesignColors.ink,
                  foregroundColor: RedesignColors.surface,
                  disabledBackgroundColor: RedesignColors.inkMuted,
                  disabledForegroundColor: RedesignColors.surface,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  isLoading ? 'Cargando...' : 'Continuar',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
