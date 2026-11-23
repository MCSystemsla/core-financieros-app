import 'package:core_financiero_app/src/config/helpers/orientacion/orientacion_pantalla.dart';
import 'package:core_financiero_app/src/presentation/screens/debug/explorador_catalogos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Easter egg: 7 toques rápidos sobre [child] abren
/// [ExploradorCatalogosScreen]. Mismo gesto que `DebugPanelTrigger`.
class ExploradorCatalogosTrigger extends StatefulWidget {
  final Widget child;
  const ExploradorCatalogosTrigger({super.key, required this.child});

  @override
  State<ExploradorCatalogosTrigger> createState() =>
      _ExploradorCatalogosTriggerState();
}

class _ExploradorCatalogosTriggerState
    extends State<ExploradorCatalogosTrigger> {
  static const _tapsToOpen = 7;
  static const _tapWindow = Duration(milliseconds: 600);

  int _taps = 0;
  DateTime _lastTap = DateTime.fromMillisecondsSinceEpoch(0);

  void _onTap() {
    final now = DateTime.now();
    _taps = now.difference(_lastTap) > _tapWindow ? 1 : _taps + 1;
    _lastTap = now;

    if (_taps < _tapsToOpen) return;
    _taps = 0;
    HapticFeedback.mediumImpact();
    OrientacionPantalla.abrirEnPortrait(
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ExploradorCatalogosScreen()),
      ),
    );
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
