import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/home/home_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/lang/change_lang_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/connection_pill_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({
    super.key,
  });

  String _countryName(Flavor flavor) => switch (flavor) {
        Flavor.honduras => 'Honduras',
        Flavor.costaRica => 'Costa Rica',
        _ => 'Nicaragua',
      };

  @override
  Widget build(BuildContext context) {
    final flavor = global<FlavorCubit>().state.flavor;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: RedesignColors.tealTint,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChangeLangWidget.withCustomColor(
                    color: RedesignColors.surface,
                    child: HomeScreen(),
                  ),
                  LogOutWidget(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MiCrédito',
                      style: TextStyle(
                        fontSize: 28,
                        height: 1.05,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.8,
                        color: RedesignColors.ink,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      _countryName(flavor),
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: RedesignColors.inkMuted,
                      ),
                    ),
                    const Gap(16),
                    const Row(
                      children: [
                        ConnectionPillWidget(),
                        Gap(8),
                        _LastSyncPill(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LastSyncPill extends StatelessWidget {
  const _LastSyncPill();

  String _lastSyncLabel(int lastSyncMillis) {
    if (lastSyncMillis == 0) return 'Sin sincronizar';

    final difference = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastSyncMillis));
    if (difference.inMinutes < 1) return 'Sincronizado ahora';
    if (difference.inHours < 1) {
      return 'Sincronizado hace ${difference.inMinutes} min';
    }
    if (difference.inDays < 1) {
      return 'Sincronizado hace ${difference.inHours} h';
    }
    return 'Sincronizado hace ${difference.inDays} d';
  }

  @override
  Widget build(BuildContext context) {
    final needsSync = CatalogoSync.needToSync();
    final color = needsSync ? RedesignColors.amber : RedesignColors.inkMuted;

    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: needsSync ? RedesignColors.amberTint : RedesignColors.surface,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            needsSync ? Icons.sync_problem_rounded : Icons.sync_rounded,
            size: 14,
            color: color,
          ),
          const Gap(6),
          Text(
            _lastSyncLabel(LocalStorage().lastUpdate),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
  });

  Future<void> _confirmLogOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: RedesignColors.surface,
        title: const Text('Cerrar sesión'),
        content: const Text('¿Seguro que quieres cerrar tu sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: RedesignColors.inkMuted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              'Cerrar sesión',
              style: TextStyle(color: AppColors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;
    context.read<InternetConnectionCubit>().makeToOnlineMode();
    context.read<AuthCubit>().logOut(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () => _confirmLogOut(context),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout_rounded, size: 20, color: AppColors.red),
                const Gap(6),
                Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
