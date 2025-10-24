import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/add_user_cedula_asalariado_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/add_user_cedula_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/add_user_cedula_represtamo_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/asignacion_solicitud/asignacion_list_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/solicitudes_pendientes/solicitudes_pendientes_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitud_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectSolicitudScreenHN extends StatelessWidget {
  const SelectSolicitudScreenHN({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pushReplacement('/cartera'),
        ),
      ),
      body: const _SelectSolicitud(),
    );
  }
}

class _SelectSolicitud extends StatelessWidget {
  const _SelectSolicitud();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Seleccionar un tipo de Credito',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 19,
                    ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Por favor, elige una de las siguientes opciones:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ),
            const Gap(20),
            const _SolicitudCardsRow1(),
            const Gap(20),
            const _SolicitudesCardsRow2(),
            const Gap(20),
            // const _MySolicitudesAsignmentsCard(),
            // const Gap(20),
            const _SolicitudesCardsRow3(),
            const Gap(20),
            // const _SolicitudesCardsRow4(),
            // const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _SolicitudesCardsRow3 extends StatelessWidget {
  const _SolicitudesCardsRow3();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            svgPath: ImageAsset.nuevaMenorBg5,
            title: 'Asignacion de Solicitudes Crédito',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const AsignacionListHnScreen()),
                ),
              );
            },
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

// class _MySolicitudesAsignmentsCard extends StatelessWidget {
//   const _MySolicitudesAsignmentsCard();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Gap(10),
//         Expanded(
//           child: SolicitudCard(
//             svgPath: ImageAsset.mySolicitudesAssignments,
//             title: 'Mi Solicitudes Asignadas',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: ((_) => const SolicitudesAsesorScreen()),
//                 ),
//               );
//             },
//           ),
//         ),
//         const Gap(10),
//       ],
//     );
//   }
// }

// class _SolicitudesCardsRow4 extends StatelessWidget {
//   const _SolicitudesCardsRow4();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Gap(10),
//         Expanded(
//           child: SolicitudCard(
//             svgPath: ImageAsset.nuevaMenorBg6,
//             title: 'Autorizacion de Solicitudes Crédito',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: ((_) => const AutorizacionSolcitudScreen()),
//                 ),
//               );
//             },
//           ),
//         ),
//         const Gap(10),
//       ],
//     );
//   }
// }

class _SolicitudesCardsRow2 extends StatelessWidget {
  const _SolicitudesCardsRow2();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        Expanded(
          child: SolicitudCard(
              svgPath: ImageAsset.nuevaMenorBg3,
              title: 'Represtamo',
              onPressed: () {
                // if (isConnected != ConnectionStatus.connected) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((_) => const AddUserCedulaReprestamoHnScreen(
                          typeForm: TypeForm.represtamo,
                        )),
                  ),
                );
                return;
              }
              // context.pushTransparentRoute(
              //   const ReprestamoAddUserCedulaScreen(
              //     typeForm: TypeForm.represtamo,
              //   ),
              // );
              // },
              ),
        ),
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const SolicitudesPendientesScreenHN()),
                ),
              );
            },
            svgPath: ImageAsset.nuevaMenorBg4,
            title: 'Solicitudes en proceso offline',
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

class _SolicitudCardsRow1 extends StatelessWidget {
  const _SolicitudCardsRow1();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            onPressed: () {
              // context.pushTransparentRoute(const AddUserCedulaScreen(
              //   typeForm: TypeForm.nueva,
              // ));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const AddUserCedulaHnScreen(
                        typeForm: TypeForm.nueva,
                      )),
                ),
              );
            },
            svgPath: ImageAsset.nuevaMenorBg,
            title: 'Nueva',
          ),
        ),
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            onPressed: () {
              // context.pushTransparentRoute(const AddUserCedulaScreen(
              //   typeForm: TypeForm.asalariado,
              // ));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const AddUserCedulaAsalariadoScreen(
                        typeForm: TypeForm.asalariado,
                      )),
                ),
              );
            },
            svgPath: ImageAsset.nuevaMenorBg2,
            title: 'Asalariado',
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
