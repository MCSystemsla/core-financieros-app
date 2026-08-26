// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_hn_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/select_tipo_supervision_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/comite/hn/comite_screen_hn.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/reportes/hn/reportes_screen_hn.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/kiva_history_request.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CarteraScreen extends StatefulWidget {
  const CarteraScreen({super.key});

  @override
  State<CarteraScreen> createState() => _CarteraScreenState();
}

class _CarteraScreenState extends State<CarteraScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.push('/');
        }
      },
      child: const Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _CarteraContentWidget(),
        ),
      ),
    );
  }
}

class _CarteraContentWidget extends StatelessWidget {
  const _CarteraContentWidget();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeaderWidget(
            title: 'home.item5'.tr(),
            subtitle: 'cartera.description'.tr(),
            onBack: () => context.push('/'),
          ),
          const Gap(24),
          const _SolicitudesAnalisisSection(),
          const _KivaSection(),
          const _SeguimientoSection(),
          const Gap(28),
        ],
      ),
    );
  }
}

class _SolicitudesAnalisisSection extends StatelessWidget {
  const _SolicitudesAnalisisSection();

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;
    final flavor = global<FlavorCubit>().state.flavor;

    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return SectionBlockWidget(
          label: 'SOLICITUDES Y ANÁLISIS',
          children: [
            if (actions.contains(TypeAction.llenarSolicitudes.codigo))
              ModuleTileWidget(
                icon: Icons.description_outlined,
                iconColor: RedesignColors.green,
                iconBackground: RedesignColors.greenTint,
                title: 'Solicitudes',
                subtitle: 'Comercial, asalariado, grupal y asignaciones',
                onPressed: () {
                  context.push('/solicitudes');
                },
              ),
            if (flavor == Flavor.honduras)
              ModuleTileWidget(
                icon: Icons.bar_chart_rounded,
                iconColor: RedesignColors.teal,
                iconBackground: RedesignColors.tealTint,
                title: 'Análisis',
                subtitle: 'Capacidad de pago, fiadores y garantías',
                onPressed: () {
                  state.connectionStatus == ConnectionStatus.connected
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AnalisisInterceptorByFlavor(),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AnalisisSolicitudesHnOfflineScreen(),
                          ),
                        );
                },
              ),
            if (flavor == Flavor.honduras &&
                state.connectionStatus == ConnectionStatus.connected &&
                actions.contains(TypeAction.supervisionDeCredito.codigo))
              ModuleTileWidget(
                icon: Icons.shield_outlined,
                iconColor: RedesignColors.indigo,
                iconBackground: RedesignColors.indigoTint,
                title: 'Supervisiones',
                subtitle: 'Crédito, riesgo y regional',
                tag: 'Solo en línea',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SelectTipoSupervisionHnScreen(),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _KivaSection extends StatelessWidget {
  const _KivaSection();

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;
    final flavor = global<FlavorCubit>().state.flavor;
    final isKivaFlavor =
        flavor == Flavor.nicaragua || flavor == Flavor.costaRica;

    if (!isKivaFlavor) return const SizedBox.shrink();

    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return SectionBlockWidget(
          label: 'FORMULARIOS KIVA',
          children: [
            if (actions.contains(TypeAction.llenarKiva.codigo))
              ModuleTileWidget(
                icon: Icons.dynamic_form_outlined,
                iconColor: RedesignColors.green,
                iconBackground: RedesignColors.greenTint,
                title: 'cartera.kiva'.tr(),
                subtitle: 'cartera.kiva_description'.tr(),
                onPressed: () {
                  state.connectionStatus == ConnectionStatus.connected
                      ? context.push('/cartera/formulario-kiva')
                      : context.push('/cartera/kiva-offline');
                },
              ),
            if (state.connectionStatus == ConnectionStatus.connected &&
                actions.contains(TypeAction.llenarKiva.codigo))
              ModuleTileWidget(
                icon: Icons.history_rounded,
                iconColor: RedesignColors.teal,
                iconBackground: RedesignColors.tealTint,
                title: 'KIVA Histórico',
                subtitle: 'Solicitudes Kiva ya enviadas',
                tag: 'Solo en línea',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const KivaHistoryRequestScreen(),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _SeguimientoSection extends StatelessWidget {
  const _SeguimientoSection();

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;
    final flavor = global<FlavorCubit>().state.flavor;

    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return SectionBlockWidget(
          label: 'SEGUIMIENTO',
          children: [
            if (flavor == Flavor.honduras &&
                state.connectionStatus == ConnectionStatus.connected &&
                actions.contains(TypeAction.comite.codigo))
              ModuleTileWidget(
                icon: Icons.groups_outlined,
                iconColor: RedesignColors.indigo,
                iconBackground: RedesignColors.indigoTint,
                title: 'Comité',
                subtitle: 'Resoluciones individuales y grupales',
                tag: 'Solo en línea',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ComiteScreenHn(),
                    ),
                  );
                },
              ),
            if (flavor == Flavor.honduras &&
                state.connectionStatus == ConnectionStatus.connected)
              ModuleTileWidget(
                icon: Icons.insert_chart_outlined_rounded,
                iconColor: RedesignColors.purple,
                iconBackground: RedesignColors.purpleTint,
                title: 'Reporteria',
                subtitle: 'Reportes de cartera y colocación',
                tag: 'Solo en línea',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ReportesScreenHn(),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  final Color firstColor;
  final Color secondColor;
  final VoidCallback onTap;
  final bool visible;
  const ModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.firstColor,
    required this.secondColor,
    required this.onTap,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (!visible) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(14),
      width: size.width,
      height: 200,
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          shadowColor: AppColors.primaryColorWithOpacity(),
          foregroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: firstColor,
                  ),
                ),
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(130),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: secondColor,
                  ),
                ),
                SizedBox(
                  height: height,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        icon,
                        const Gap(7),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          width: size.width * 0.95,
                          child: Text(
                            subtitle,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
