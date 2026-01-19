// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/datasource/solicitudes/hn/user_by_document/user_by_document_represtamo.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_represtamo/user_by_document_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/online/represtamo_form_hn_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/online/represtamo_form_hn_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/online/represtamo_form_hn_3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/online/represtamo_form_hn_5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/online/represtamo_historial_credito_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReprestamoHnForm extends StatelessWidget {
  const ReprestamoHnForm({super.key});

  @override
  Widget build(BuildContext context) {
    final userByDocumentProvider =
        context.read<UserByDocumentReprestamoCubit>().state;
    final pageController = PageController();
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Represtamo',
        ),
        Expanded(
          child: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                AddCedulaPhotosScreen(
                  controller: pageController,
                  onCedulaFrontTaken: (imagePath) {
                    context.read<SolicitudReprestamoHnCubit>().saveCedula(
                          cedulaFrontPath: imagePath,
                        );
                  },
                  onCedulaBackTaken: (imagePath) {
                    context.read<SolicitudReprestamoHnCubit>().saveCedula(
                          cedulaBackPath: imagePath,
                        );
                  },
                ),
                ReprestamoFormHn1(
                  controller: pageController,
                  userByDocumentReprestamoData: UserByDocumentReprestamoData(
                    id: userByDocumentProvider.id,
                    nombreCompleto: userByDocumentProvider.nombreCompleto,
                    cedula: userByDocumentProvider.cedula,
                    tipoDocumento: userByDocumentProvider.tipoDocumento,
                    tipoPersona: userByDocumentProvider.tipoPersona,
                    paisEmisorCedula: userByDocumentProvider.paisEmisorCedula,
                    fechaVencimientoCedula: DateTime.tryParse(
                      userByDocumentProvider.fechaVencimientoCedula,
                    ),
                    fechaEmisionCedula: DateTime.tryParse(
                      userByDocumentProvider.fechaEmisionCedula,
                    ),
                  ),
                ),
                ReprestamoFormHn2(
                  controller: pageController,
                ),
                ReprestamoFormHn3(
                  controller: pageController,
                ),
                // ReprestamoFormHn4(
                //   controller: pageController,
                // ),
                ReprestamoHistorialCreditoHn(
                  controller: pageController,
                ),
                ReprestamoFormHn5(
                  controller: pageController,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
