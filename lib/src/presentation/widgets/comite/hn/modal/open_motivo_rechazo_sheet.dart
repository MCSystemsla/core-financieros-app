import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<String?> openMotivoRechazoSheet(BuildContext context) {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const Gap(20),

                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color.fromARGB(255, 246, 207, 209),
                      child: Icon(
                        Icons.close_sharp,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),

                    const Gap(16),

                    const Text(
                      'Motivo de rechazo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Gap(6),

                    const Text(
                      'Ingrese el el motivo del rechazo',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Gap(24),

                    /// Campo monto
                    OutlineTextfieldWidget(
                      padding: EdgeInsets.zero,
                      textEditingController: controller,
                      title: 'Motivo del rechazo',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: Icon(
                        Icons.comment,
                        color: AppColors.getPrimaryColor(),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                    ),

                    const Gap(24),

                    /// Botón guardar
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'Rechazar acta',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          Navigator.pop(context, controller.text.trim());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
