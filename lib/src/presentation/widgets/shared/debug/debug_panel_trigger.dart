import 'dart:convert';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DebugPanelTrigger extends StatefulWidget {
  final Widget child;
  const DebugPanelTrigger({super.key, required this.child});

  @override
  State<DebugPanelTrigger> createState() => _DebugPanelTriggerState();
}

class _DebugPanelTriggerState extends State<DebugPanelTrigger> {
  static const _tapsToOpen = 7;
  static const _tapWindow = Duration(milliseconds: 600);

  int _taps = 0;
  DateTime _lastTap = DateTime.fromMillisecondsSinceEpoch(0);

  void _onTap() {
    final now = DateTime.now();
    _taps = now.difference(_lastTap) > _tapWindow ? 1 : _taps + 1;
    _lastTap = now;

    if (_taps >= _tapsToOpen) {
      _taps = 0;
      HapticFeedback.mediumImpact();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: RedesignColors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => const _DebugPanelSheet(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: widget.child,
    );
  }
}

class _DebugPanelSheet extends StatelessWidget {
  const _DebugPanelSheet();

  Future<List<(String, String)>> _loadEntries() async {
    final storage = LocalStorage();
    final info = await PackageInfo.fromPlatform();
    final flavor = global<FlavorCubit>().state.flavor;
    final lastUpdate = storage.lastUpdate;

    return [
      ('Flavor', flavor.name),
      ('Version', '${info.version}+${info.buildNumber}'),
      ('Package', info.packageName),
      ('API', _apiUrl()),
      ('Database', _orDash(storage.database)),
      ('Usuario', _orDash(storage.currentUserName)),
      ('User ID', _orDash(storage.userId)),
      ('Rol', _orDash(storage.rolUser)),
      ('Permisos', '${storage.currentActions.length} acciones'),
      ('JWT', _jwtStatus(storage.jwt)),
      ('Refresh token', storage.refreshToken.isEmpty ? 'No' : 'Si'),
      (
        'Ultimo sync catalogos',
        lastUpdate == 0
            ? '-'
            : DateTime.fromMillisecondsSinceEpoch(lastUpdate).toString()
      ),
    ];
  }

  static String _apiUrl() {
    const protocol = String.fromEnvironment('protocol');
    const apiUrl = String.fromEnvironment('apiUrl');
    if (apiUrl.isEmpty) return '-';
    return protocol.isEmpty ? apiUrl : '$protocol://$apiUrl';
  }

  static String _orDash(String value) => value.isEmpty ? '-' : value;

  /// Lee el `exp` del payload sin validar la firma; es solo informativo.
  static String _jwtStatus(String jwt) {
    if (jwt.isEmpty) return 'Sin sesion';
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return 'Formato invalido';
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      ) as Map<String, dynamic>;
      final exp = payload['exp'];
      if (exp is! int) return 'Sin exp';
      final expiresAt = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final left = expiresAt.difference(DateTime.now());
      return left.isNegative
          ? 'Expirado hace ${-left.inMinutes} min'
          : 'Vence en ${left.inMinutes} min';
    } catch (_) {
      return 'No se pudo leer';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: FutureBuilder<List<(String, String)>>(
          future: _loadEntries(),
          builder: (context, snapshot) {
            final entries = snapshot.data;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: RedesignColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Gap(16),
                const Text(
                  'Panel de debug',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                    color: RedesignColors.ink,
                  ),
                ),
                const Gap(4),
                const Text(
                  'Solo visible en builds que no son de produccion.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: RedesignColors.inkMuted,
                  ),
                ),
                const Gap(16),
                if (entries == null)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else ...[
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: RedesignColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: RedesignColors.border),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: entries.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          color: RedesignColors.border,
                        ),
                        itemBuilder: (_, i) => _DebugRow(
                          label: entries[i].$1,
                          value: entries[i].$2,
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  OutlinedButton.icon(
                    onPressed: () {
                      final text =
                          entries.map((e) => '${e.$1}: ${e.$2}').join('\n');
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Copiado al portapapeles')),
                      );
                    },
                    icon: const Icon(Icons.copy_rounded, size: 18),
                    label: const Text('Copiar todo'),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DebugRow extends StatelessWidget {
  final String label;
  final String value;
  const _DebugRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: RedesignColors.inkMuted,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                color: RedesignColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
