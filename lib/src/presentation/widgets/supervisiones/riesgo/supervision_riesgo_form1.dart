import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/info_row_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_cliente_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SupervisionRiesgoForm1 extends StatelessWidget {
  const SupervisionRiesgoForm1({
    super.key,
    required this.data,
    required this.pagecontroller,
  });

  final SupervisionData data;
  final PageController pagecontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SolicitudClienteHeader(data: data),
            const Divider(height: 1, color: RedesignColors.border),
            const Gap(20),
            SectionBlockWidget(
              label: 'EQUIPO',
              children: [
                InfoRowWidget(
                  icon: Icons.badge_outlined,
                  color: RedesignColors.indigo,
                  background: RedesignColors.indigoTint,
                  label: 'Oficial de crédito',
                  value: data.nombrePromotor,
                ),
              ],
            ),
            SectionBlockWidget(
              label: 'CRÉDITO',
              children: [
                InfoRowWidget(
                  icon: Icons.flag_outlined,
                  color: RedesignColors.purple,
                  background: RedesignColors.purpleTint,
                  label: 'Destino del crédito',
                  value: data.destino,
                ),
                InfoRowWidget(
                  icon: Icons.work_outline,
                  color: RedesignColors.purple,
                  background: RedesignColors.purpleTint,
                  label: 'Actividad económica',
                  value: data.sectorComercialNombre,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: CustomElevatedButton(
                onPressed: () {
                  pagecontroller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                text: 'Siguiente',
                color: RedesignColors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
