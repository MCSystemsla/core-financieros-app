import 'package:core_financiero_app/src/datasource/solicitudes/hn/user_by_document/user_by_document.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form8.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_historial_crediticio_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/solicitud_nueva_signature_hn.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NuevaMenorHnForm extends StatefulWidget {
  const NuevaMenorHnForm({super.key});

  @override
  State<NuevaMenorHnForm> createState() => _NuevaMenorHnFormState();
}

class _NuevaMenorHnFormState extends State<NuevaMenorHnForm> {
  @override
  Widget build(BuildContext context) {
    final userByDocumentProvider = context.read<UserByDocumentCubit>().state;

    final pageController = PageController();
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Nueva Menor',
        ),
        Expanded(
          child: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                SolicitudSignatureNueva(
                  pageController: pageController,
                  cedula: userByDocumentProvider.cedula,
                ),
                AddCedulaPhotosScreen(
                  controller: pageController,
                  onCedulaFrontTaken: (imagePath) {
                    context.read<SolicitudNuevaMenorHnCubit>().saveCedula(
                          cedulaFrontPath: imagePath,
                        );
                  },
                  onCedulaBackTaken: (imagePath) {
                    context.read<SolicitudNuevaMenorHnCubit>().saveCedula(
                          cedulaBackPath: imagePath,
                        );
                  },
                ),
                // RiskControlScreen(
                //   nombre1: userByDocumentProvider.primerNombre,
                //   nombre2: userByDocumentProvider.segundoNombre,
                //   apellido1: userByDocumentProvider.primerApellido,
                //   apellido2: userByDocumentProvider.segundoApellido,
                //   tipoIdentificacion: userByDocumentProvider.tipoDocumento,
                //   identificacion: userByDocumentProvider.cedula,
                //   tipoOrganizacion: 'PERSONANATURAL',
                //   pageController: pageController,
                // ),
                NuevaMenorForm1(
                  controller: pageController,
                  userByDocumentHn: UserDocumentDataHN(
                    cedula: userByDocumentProvider.cedula,
                    primerNombre: userByDocumentProvider.primerNombre,
                    segundoNombre: userByDocumentProvider.segundoNombre,
                    primerApellido: userByDocumentProvider.primerApellido,
                    segundoApellido: userByDocumentProvider.segundoApellido,
                    fechaNacimiento: DateTime.tryParse(
                        userByDocumentProvider.fechaNacimiento),
                    sexo: userByDocumentProvider.sexo,
                    direccion: userByDocumentProvider.direccion,
                    fechaEmision:
                        DateTime.tryParse(userByDocumentProvider.fechaEmision),
                    fechaExpira:
                        DateTime.tryParse(userByDocumentProvider.fechaExpira),
                    tipoDocumento: userByDocumentProvider.tipoDocumento,
                  ),
                ),
                NuevaMenorForm2(
                  controller: pageController,
                  userByDocumentHn: UserDocumentDataHN(
                    cedula: userByDocumentProvider.cedula,
                    primerNombre: userByDocumentProvider.primerNombre,
                    segundoNombre: userByDocumentProvider.segundoNombre,
                    primerApellido: userByDocumentProvider.primerApellido,
                    segundoApellido: userByDocumentProvider.segundoApellido,
                    fechaNacimiento: DateTime.tryParse(
                        userByDocumentProvider.fechaNacimiento),
                    sexo: userByDocumentProvider.sexo,
                    direccion: userByDocumentProvider.direccion,
                    fechaEmision:
                        DateTime.tryParse(userByDocumentProvider.fechaEmision),
                    fechaExpira:
                        DateTime.tryParse(userByDocumentProvider.fechaExpira),
                    tipoDocumento: userByDocumentProvider.tipoDocumento,
                  ),
                ),
                NuevaMenorForm3(
                  controller: pageController,
                ),
                NuevaMenorForm4(
                  controller: pageController,
                ),
                NuevaMenorForm5(
                  controller: pageController,
                ),
                NuevaMenorForm6(
                  controller: pageController,
                ),
                NuevaMenorForm7(
                  controller: pageController,
                ),
                NuevaMenorHistorialCrediticioHn(
                  controller: pageController,
                ),
                NuevaMenorForm8(
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
