import 'dart:math' as math;

import 'package:core_financiero_app/src/config/helpers/temporada/temporada_navidena.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:flutter/material.dart';

/// Logo del login. Durante la temporada navideña le pone un gorrito de Santa
/// sobre la punta de la hoja verde, con un vaivén leve. Fuera de temporada es
/// solo la imagen.
class LogoNavidenoWidget extends StatelessWidget {
  final String logo;
  final double width;

  const LogoNavidenoWidget({
    super.key,
    required this.logo,
    required this.width,
  });

  /// Punta de la hoja verde en cada logo, como fracción del ancho y del alto
  /// de la imagen. Si cambia un logo, hay que ajustar este punto.
  Offset get _puntaHoja => logo == ImageAsset.logoHN
      ? const Offset(0.148, 0.228)
      : const Offset(0.114, 0.107);

  @override
  Widget build(BuildContext context) {
    final image = Image(width: width, image: AssetImage(logo));
    if (!TemporadaNavidena.activa()) return image;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        image,
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Mientras la imagen carga, el Stack todavía no tiene alto.
              if (constraints.maxHeight == 0) return const SizedBox.shrink();

              final hatWidth = constraints.maxWidth * 0.1;
              final hatHeight = hatWidth * _GorritoPainter.aspectRatio;
              final punta = Offset(
                constraints.maxWidth * _puntaHoja.dx,
                constraints.maxHeight * _puntaHoja.dy,
              );
              // El centro de la franja blanca queda un poco por debajo de la
              // punta, para que el gorrito "abrace" la hoja.
              final franja = Offset(
                hatWidth * _GorritoPainter.franja.dx,
                hatHeight * _GorritoPainter.franja.dy,
              );

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: punta.dx - franja.dx,
                    top: punta.dy - franja.dy + hatHeight * 0.12,
                    width: hatWidth,
                    height: hatHeight,
                    child: const IgnorePointer(child: _GorritoAnimado()),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GorritoAnimado extends StatefulWidget {
  const _GorritoAnimado();

  @override
  State<_GorritoAnimado> createState() => _GorritoAnimadoState();
}

class _GorritoAnimadoState extends State<_GorritoAnimado>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduceMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_controller.value);
        // Vaivén de unos ±4 grados alrededor de la franja.
        return Transform.rotate(
          angle: (t - 0.5) * 2 * (4 * math.pi / 180),
          alignment: Alignment(
            _GorritoPainter.franja.dx * 2 - 1,
            _GorritoPainter.franja.dy * 2 - 1,
          ),
          child: child,
        );
      },
      child: const CustomPaint(painter: _GorritoPainter()),
    );
  }
}

/// Gorrito de Santa caído hacia la derecha, dibujado en una caja de 64x56.
class _GorritoPainter extends CustomPainter {
  const _GorritoPainter();

  static const _base = Size(64, 56);
  static double get aspectRatio => _base.height / _base.width;

  /// Centro de la franja blanca, como fracción de la caja.
  static const franja = Offset(27 / 64, 46 / 56);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / _base.width, size.height / _base.height);

    final paint = Paint();

    // Cuerpo rojo.
    paint.color = const Color(0xffC8312F);
    canvas.drawPath(
      Path()
        ..moveTo(8, 44)
        ..cubicTo(14, 20, 30, 6, 50, 8)
        ..cubicTo(44, 16, 46, 28, 54, 36)
        ..cubicTo(40, 38, 22, 41, 8, 44)
        ..close(),
      paint,
    );

    // Sombra del pliegue.
    paint.color = const Color(0xff9E2421);
    canvas.drawPath(
      Path()
        ..moveTo(50, 8)
        ..cubicTo(44, 16, 46, 28, 54, 36)
        ..cubicTo(50, 30, 48, 20, 50, 8)
        ..close(),
      paint,
    );

    final fur = Paint()..color = const Color(0xffFAFAF7);
    final furBorder = Paint()
      ..color = const Color(0xffDDE1DB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Franja blanca, inclinada 6 grados.
    canvas.save();
    canvas.translate(27, 46);
    canvas.rotate(-6 * math.pi / 180);
    final band = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: 50, height: 12),
      const Radius.circular(6),
    );
    canvas.drawRRect(band, fur);
    canvas.drawRRect(band, furBorder);
    canvas.restore();

    // Pompón.
    canvas.drawCircle(const Offset(55, 38), 6.5, fur);
    canvas.drawCircle(const Offset(55, 38), 6.5, furBorder);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_GorritoPainter oldDelegate) => false;
}
