import 'dart:math' as math;

import 'package:core_financiero_app/src/config/helpers/temporada/temporada_navidena.dart';
import 'package:flutter/material.dart';

/// Nevada corta que cae sobre el Inicio al entrar, durante la temporada
/// navideña.
///
/// Sale una sola vez por sesión de la app (aunque el Inicio se vuelva a
/// construir o se empuje de nuevo tras sincronizar), dura unos 16 segundos y
/// se detiene sola. Se dibuja con un [CustomPainter] (sin assets) e ignora los
/// toques. Si el sistema tiene las animaciones desactivadas, no se muestra.
class NevadaNavidenaWidget extends StatefulWidget {
  final Duration duration;
  final int flakeCount;

  const NevadaNavidenaWidget({
    super.key,
    this.duration = const Duration(seconds: 16),
    this.flakeCount = 110,
  });

  @override
  State<NevadaNavidenaWidget> createState() => _NevadaNavidenaWidgetState();
}

class _NevadaNavidenaWidgetState extends State<NevadaNavidenaWidget>
    with SingleTickerProviderStateMixin {
  /// Se marca al arrancar la nevada para no repetirla en la misma sesión.
  static bool _yaSeMostro = false;

  late final AnimationController _controller;
  late final List<_Flake> _flakes;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final random = math.Random();
    final totalSeconds =
        widget.duration.inMilliseconds / Duration.millisecondsPerSecond;
    _flakes = List.generate(widget.flakeCount, (_) {
      // Cada copo aparece en un momento distinto y vive entre 5 y 8 s, sin
      // pasarse del final de la animación.
      final life = 5 + random.nextDouble() * 3;
      final delay = random.nextDouble() * (totalSeconds - life);
      return _Flake(
        x: random.nextDouble(),
        startY: -0.05 + random.nextDouble() * 0.6,
        delay: delay,
        life: life,
        speed: 45 + random.nextDouble() * 50,
        radius: 4 + random.nextDouble() * 5,
        swayPhase: random.nextDouble() * math.pi * 2,
        spin: (random.nextDouble() - 0.5) * 1.6,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (_yaSeMostro || reduceMotion || !TemporadaNavidena.activa()) return;
    if (_controller.isDismissed) {
      _yaSeMostro = true;
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
            painter: _NevadaPainter(
              flakes: _flakes,
              seconds: _controller.value *
                  widget.duration.inMilliseconds /
                  Duration.millisecondsPerSecond,
            ),
          );
        },
      ),
    );
  }
}

class _Flake {
  /// Posición horizontal, como fracción del ancho.
  final double x;

  /// Posición vertical inicial, como fracción del alto.
  final double startY;
  final double delay;
  final double life;

  /// Velocidad de caída en px/s.
  final double speed;
  final double radius;
  final double swayPhase;
  final double spin;

  const _Flake({
    required this.x,
    required this.startY,
    required this.delay,
    required this.life,
    required this.speed,
    required this.radius,
    required this.swayPhase,
    required this.spin,
  });
}

class _NevadaPainter extends CustomPainter {
  /// Gris azulado: se ve sobre el banner verde agua y sobre el fondo blanco.
  static const _flakeColor = Color(0xff7393AE);

  final List<_Flake> flakes;
  final double seconds;

  _NevadaPainter({required this.flakes, required this.seconds});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.9
      ..strokeCap = StrokeCap.round;

    for (final flake in flakes) {
      final t = seconds - flake.delay;
      if (t < 0 || t > flake.life) continue;

      // Aparece y se desvanece suave a lo largo de su vida.
      // Sube rápido a opacidad plena y se desvanece solo al final.
      final opacity =
          math.min(1.0, math.sin(math.pi * (t / flake.life)) * 1.6);
      final dx = flake.x * size.width +
          math.sin(flake.swayPhase + t * 1.4) * 10;
      final dy = flake.startY * size.height + flake.speed * t;

      paint.color = _flakeColor.withValues(alpha: opacity);

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(flake.spin * t);
      // Copo de seis brazos: tres líneas cruzadas a 60 grados.
      for (var i = 0; i < 3; i++) {
        canvas.drawLine(
          Offset(-flake.radius, 0),
          Offset(flake.radius, 0),
          paint,
        );
        canvas.rotate(math.pi / 3);
      }
      canvas.drawCircle(Offset.zero, flake.radius * 0.28, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_NevadaPainter oldDelegate) =>
      oldDelegate.seconds != seconds;
}
