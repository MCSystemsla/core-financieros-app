// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/orientacion/orientacion_pantalla.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_hn_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/select_tipo_supervision_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_ni_offline_screen.dart';
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

/// Ancho del panel lateral (encabezado) en landscape.
const _sidePanelWidth = 300.0;

/// Ancho máximo de la lista de módulos en landscape, para que las filas no
/// se estiren de borde a borde en pantallas anchas.
const _contentMaxWidth = 640.0;

/// Menú de Cartera.
///
/// Permite landscape ([PermiteLandscapeMixin]). Los módulos que abre no están
/// adaptados, así que se abren con [OrientacionPantalla.abrirEnPortrait].
class CarteraScreen extends StatefulWidget {
  const CarteraScreen({super.key});

  @override
  State<CarteraScreen> createState() => _CarteraScreenState();
}

class _CarteraScreenState extends State<CarteraScreen>
    with PermiteLandscapeMixin {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.push('/');
        }
      },
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: isLandscape
              ? const _CarteraLandscapeLayout()
              : const _CarteraPortraitLayout(),
        ),
      ),
    );
  }
}

class _CarteraHeader extends StatelessWidget {
  const _CarteraHeader();

  @override
  Widget build(BuildContext context) {
    return ScreenHeaderWidget(
      title: 'home.item5'.tr(),
      subtitle: 'cartera.description'.tr(),
      onBack: () => context.push('/'),
    );
  }
}

class _CarteraSections extends StatelessWidget {
  const _CarteraSections();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SolicitudesAnalisisSection(),
        _KivaSection(),
        _SeguimientoSection(),
      ],
    );
  }
}

class _CarteraPortraitLayout extends StatelessWidget {
  const _CarteraPortraitLayout();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CarteraHeader(),
          Gap(24),
          _CarteraSections(),
          Gap(28),
        ],
      ),
    );
  }
}

/// Landscape: encabezado en un panel a la izquierda y los módulos a la
/// derecha, cada lado con su propio scroll.
class _CarteraLandscapeLayout extends StatelessWidget {
  const _CarteraLandscapeLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          width: _sidePanelWidth,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 16),
            child: _CarteraHeader(),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, bottom: 28),
            child: Align(
              alignment: Alignment.topLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
                child: const _CarteraSections(),
              ),
            ),
          ),
        ),
      ],
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
            // if (actions.contains(TypeAction.llenarSolicitudes.codigo))
            ModuleTileWidget(
              icon: Icons.description_outlined,
              iconColor: RedesignColors.green,
              iconBackground: RedesignColors.greenTint,
              title: 'Solicitudes',
              subtitle: 'Comercial, asalariado, grupal y asignaciones',
              onPressed: () {
                OrientacionPantalla.abrirEnPortrait(
                  () => context.push('/solicitudes'),
                );
              },
            ),
            // if (flavor == Flavor.honduras)
            ModuleTileWidget(
              icon: Icons.bar_chart_rounded,
              iconColor: RedesignColors.teal,
              iconBackground: RedesignColors.tealTint,
              title: 'Análisis',
              subtitle: 'Capacidad de pago, fiadores y garantías',
              onPressed: () {
                final isConnected =
                    state.connectionStatus == ConnectionStatus.connected;
                OrientacionPantalla.abrirEnPortrait(
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => isConnected
                          ? const AnalisisInterceptorByFlavor()
                          : switch (flavor) {
                              Flavor.nicaragua =>
                                const AnalisisSolicitudesNiOfflineScreen(),
                              Flavor.honduras =>
                                const AnalisisSolicitudesHnOfflineScreen(),
                              _ => const SizedBox(),
                            },
                    ),
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
                  OrientacionPantalla.abrirEnPortrait(
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SelectTipoSupervisionHnScreen(),
                      ),
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
                  final ruta =
                      state.connectionStatus == ConnectionStatus.connected
                          ? '/cartera/formulario-kiva'
                          : '/cartera/kiva-offline';
                  OrientacionPantalla.abrirEnPortrait(() => context.push(ruta));
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
                  OrientacionPantalla.abrirEnPortrait(
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const KivaHistoryRequestScreen(),
                      ),
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
                  OrientacionPantalla.abrirEnPortrait(
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ComiteScreenHn(),
                      ),
                    ),
                  );
                },
              ),
            // if (flavor == Flavor.honduras &&
            //     state.connectionStatus == ConnectionStatus.connected)
            //   ModuleTileWidget(
            //     icon: Icons.groups_outlined,
            //     iconColor: RedesignColors.amber,
            //     iconBackground: RedesignColors.amberTint,
            //     title: 'Formalización',
            //     subtitle: 'Resoluciones individuales y grupales',
            //     tag: 'Solo en línea',
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => const ComiteScreenHn(),
            //         ),
            //       );
            //     },
            //   ),
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
                  OrientacionPantalla.abrirEnPortrait(
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReportesScreenHn(),
                      ),
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
