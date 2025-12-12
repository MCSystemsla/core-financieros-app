import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiador_aval/analisis_fiador_aval_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_search_by_document_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FiadoresHnScreen extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  const FiadoresHnScreen({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AnalisisFiadorAvalCubit(
        AnalisisRepositoryHNImpl(),
      )..checkFiadorAval(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fiadores'),
        ),
        body: BlocBuilder<AnalisisFiadorAvalCubit, AnalisisFiadorAvalState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Gap(20),
                  SelectableCardItem(
                    isLoading: state.status == Status.inProgress,
                    userHaveDataAlready: state.tieneConyugue,
                    color: AppColors.getPrimaryColor(),
                    icon: Icons.person_pin_sharp,
                    title: 'Cónyuge',
                    subtitle: 'Crear Fiador cónyuge',
                    onTap: () {
                      if (state.tieneConyugue) {
                        CustomAlertDialog(
                          onDone: () => context.pop(),
                          context: context,
                          title: 'No se puede crear mas de un fiador cónyuge',
                        ).showDialog(
                          context,
                          dialogType: DialogType.infoReverse,
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => FiadoresSearchByDocumentScreen(
                            typeForm: FiadoresHnFormType.conyugue,
                            numeroSolicitud: numeroSolicitud,
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SelectableCardItem(
                    isLoading: state.status == Status.inProgress,
                    userHaveDataAlready: state.tieneAval,
                    color: const Color(0xFF1E88E5),
                    icon: Icons.verified_user,
                    title: 'Aval',
                    subtitle: 'Crear Fiador aval',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => FiadoresSearchByDocumentScreen(
                            typeForm: FiadoresHnFormType.aval,
                            numeroSolicitud: numeroSolicitud,
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SelectableCardItem(
                    isLoading: state.status == Status.inProgress,
                    userHaveDataAlready: state.tieneFiador,
                    color: const Color(0xFF26A69A),
                    icon: Icons.group_add,
                    title: 'Codeudor',
                    subtitle: 'Crear Fiador codeudor',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => FiadoresSearchByDocumentScreen(
                            typeForm: FiadoresHnFormType.codeudor,
                            numeroSolicitud: numeroSolicitud,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
