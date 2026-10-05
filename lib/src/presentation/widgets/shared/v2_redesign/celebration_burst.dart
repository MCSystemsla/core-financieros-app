import 'dart:math' as math;

import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Rafaga de confeti que se dispara una sola vez al montarse, con un haptic.
///
/// Se dibuja con un [CustomPainter] (sin assets) e ignora los toques, asi que
/// puede ir encima de cualquier contenido. Si el sistema tiene las animaciones
/// desactivadas, solo da el haptic.
class CelebrationBurst extends StatefulWidget {
  /// Punto de origen dentro del area disponible.
  final Alignment origin;
  final Duration duration;
  final int particleCount;

  const CelebrationBurst({
    super.key,
    this.origin = const Alignment(0, -0.62),
    this.duration = const Duration(milliseconds: 1900),
    this.particleCount = 46,
  });

  @override
  State<CelebrationBurst> createState() => _CelebrationBurstState();
}

class _CelebrationBurstState extends State<CelebrationBurst>
    with SingleTickerProviderStateMixin {
  static const _colors = [
    RedesignColors.green,
    RedesignColors.teal,
    RedesignColors.amber,
    RedesignColors.indigo,
  ];

  late final AnimationController _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    HapticFeedback.mediumImpact();

    final random = math.Random();
    _particles = List.generate(widget.particleCount, (i) {
      // Abanico hacia arriba (entre -160 y -20 grados) para que caiga en arco.
      final angle = -math.pi * (0.11 + random.nextDouble() * 0.78);
      final speed = 260 + random.nextDouble() * 320;
      return _Particle(
        velocity: Offset(math.cos(angle) * speed, math.sin(angle) * speed),
        color: _colors[i % _colors.length],
        size: Size(5 + random.nextDouble() * 5, 3 + random.nextDouble() * 4),
        spin: (random.nextDouble() - 0.5) * 14,
        isCircle: random.nextDouble() < 0.25,
      );
    });

    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (!reduceMotion && _controller.isDismissed) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (!_controller.isAnimating) return const SizedBox.expand();
          return CustomPaint(
            size: Size.infinite,
            painter: _ConfettiPainter(
              particles: _particles,
              progress: _controller.value,
              seconds: _controller.value *
                  widget.duration.inMilliseconds /
                  Duration.millisecondsPerSecond,
              origin: widget.origin,
            ),
          );
        },
      ),
    );
  }
}

class _Particle {
  final Offset velocity;
  final Color color;
  final Size size;
  final double spin;
  final bool isCircle;

  const _Particle({
    required this.velocity,
    required this.color,
    required this.size,
    required this.spin,
    required this.isCircle,
  });
}

class _ConfettiPainter extends CustomPainter {
  static const _gravity = 620.0;

  /// Frenado del aire: la velocidad inicial decae con esta constante (1/s).
  static const _airDrag = 1.6;

  final List<_Particle> particles;
  final double progress;
  final double seconds;
  final Alignment origin;

  _ConfettiPainter({
    required this.particles,
    required this.progress,
    required this.seconds,
    required this.origin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final start = origin.alongSize(size);
    final t = seconds;
    // Distancia recorrida con frenado exponencial: (1 - e^-kt) / k.
    final travel = (1 - math.exp(-_airDrag * t)) / _airDrag;
    final fall = 0.5 * _gravity * t * t;
    // Se desvanece en el ultimo 35% de la animacion.
    final opacity = progress < 0.65 ? 1.0 : (1 - progress) / 0.35;
    final paint = Paint();

    for (final p in particles) {
      final position =
          start + Offset(p.velocity.dx * travel, p.velocity.dy * travel + fall);

      paint.color = p.color.withValues(alpha: opacity.clamp(0.0, 1.0));

      canvas.save();
      canvas.translate(position.dx, position.dy);
      canvas.rotate(p.spin * t);
      if (p.isCircle) {
        canvas.drawCircle(Offset.zero, p.size.height / 2 + 1, paint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset.zero,
              width: p.size.width,
              height: p.size.height,
            ),
            const Radius.circular(1.2),
          ),
          paint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
