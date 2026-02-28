import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComiteUserInfoWidget extends StatelessWidget {
  final ComiteSolicitudData data;
  const ComiteUserInfoWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
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
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Datos del solicitante',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              initialValue: data.actaNumero.toString(),
              readOnly: true,
              title: 'Acta',
              icon: Icon(
                Icons.document_scanner,
                color: AppColors.getPrimaryColor(),
              ),
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              initialValue: data.numeroSolicitud,
              readOnly: true,
              title: 'Solicitud',
              icon: Icon(
                Icons.edit_document,
                color: AppColors.getPrimaryColor(),
              ),
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              initialValue: data.nombreCompletoCliente,
              readOnly: true,
              title: 'Nombre del solicitante',
              icon: Icon(
                Icons.person,
                color: AppColors.getPrimaryColor(),
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
