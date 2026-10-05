import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiador_aval/analisis_fiador_aval_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_search_by_document_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
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

  void _goToSearch(BuildContext context, FiadoresHnFormType typeForm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FiadoresSearchByDocumentScreen(
          typeForm: typeForm,
          numeroSolicitud: numeroSolicitud,
        ),
      ),
    );
  }

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
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<AnalisisFiadorAvalCubit, AnalisisFiadorAvalState>(
            builder: (context, state) {
              final isLoading = state.status == Status.inProgress;
              String? registradoTag(bool tieneFiador) =>
                  !isLoading && tieneFiador ? 'Registrado' : null;

              return ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  ScreenHeaderWidget(
                    title: 'Fiadores',
                    subtitle:
                        'Elige el tipo de fiador para la solicitud #$numeroSolicitud. Luego buscarás a la persona por su documento.',
                    onBack: () => Navigator.pop(context),
                  ),
                  const Gap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        if (isLoading) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: const LinearProgressIndicator(
                              minHeight: 3,
                              color: RedesignColors.green,
                              backgroundColor: RedesignColors.greenTint,
                            ),
                          ),
                          const Gap(14),
                        ],
                        ModuleTileWidget(
                          icon: Icons.favorite_border_rounded,
                          iconColor: RedesignColors.purple,
                          iconBackground: RedesignColors.purpleTint,
                          title: 'Cónyuge',
                          subtitle: 'Crear fiador cónyuge. Solo se permite uno',
                          tag: registradoTag(state.tieneConyugue),
                          onPressed: () {
                            if (state.tieneConyugue) {
                              CustomAlertDialog(
                                onDone: () => context.pop(),
                                context: context,
                                title:
                                    'No se puede crear mas de un fiador cónyuge',
                              ).showDialog(
                                context,
                                dialogType: DialogType.infoReverse,
                              );
                              return;
                            }
                            _goToSearch(context, FiadoresHnFormType.conyugue);
                          },
                        ),
                        const Gap(10),
                        ModuleTileWidget(
                          icon: Icons.verified_user_outlined,
                          iconColor: RedesignColors.indigo,
                          iconBackground: RedesignColors.indigoTint,
                          title: 'Aval',
                          subtitle: 'Crear fiador aval',
                          tag: registradoTag(state.tieneAval),
                          onPressed: () =>
                              _goToSearch(context, FiadoresHnFormType.aval),
                        ),
                        const Gap(10),
                        ModuleTileWidget(
                          icon: Icons.group_add_outlined,
                          iconColor: RedesignColors.teal,
                          iconBackground: RedesignColors.tealTint,
                          title: 'Codeudor',
                          subtitle: 'Crear fiador codeudor',
                          tag: registradoTag(state.tieneCodeudor),
                          onPressed: () =>
                              _goToSearch(context, FiadoresHnFormType.codeudor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
