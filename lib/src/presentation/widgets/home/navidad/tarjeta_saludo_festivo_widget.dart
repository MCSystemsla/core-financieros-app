import 'package:core_financiero_app/src/config/helpers/temporada/temporada_navidena.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Tarjeta de saludo que aparece en el Inicio solo en fechas clave:
/// Navidad (24 y 25 de diciembre) y Año Nuevo (31 de diciembre y 1 de enero).
///
/// Se cierra con la X y no vuelve a salir para ese saludo de ese año (se
/// guarda en [LocalStorage.saludosFestivosCerrados]).
class TarjetaSaludoFestivoWidget extends StatefulWidget {
  const TarjetaSaludoFestivoWidget({super.key});

  @override
  State<TarjetaSaludoFestivoWidget> createState() =>
      _TarjetaSaludoFestivoWidgetState();
}

class _TarjetaSaludoFestivoWidgetState
    extends State<TarjetaSaludoFestivoWidget> {
  static const _rojoOscuro = Color(0xff7E2A26);

  late final SaludoFestivo? _saludo;
  late bool _visible;

  @override
  void initState() {
    super.initState();
    _saludo = TemporadaNavidena.saludoDelDia();
    final saludo = _saludo;
    _visible = saludo != null &&
        !LocalStorage()
            .saludosFestivosCerrados
            .contains(TemporadaNavidena.claveSaludo(saludo));
  }

  void _cerrar() {
    final saludo = _saludo;
    if (saludo == null) return;
    setState(() => _visible = false);
    LocalStorage().addSaludoFestivoCerrado(
      TemporadaNavidena.claveSaludo(saludo),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saludo = _saludo;
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return AnimatedSize(
      duration:
          reduceMotion ? Duration.zero : const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: !_visible || saludo == null
          ? const SizedBox(width: double.infinity)
          : _Tarjeta(
              titulo: switch (saludo) {
                SaludoFestivo.navidad => '¡Feliz Navidad!',
                SaludoFestivo.anioNuevo => '¡Feliz Año Nuevo!',
              },
              mensaje: switch (saludo) {
                SaludoFestivo.navidad =>
                  'Que esta temporada llegue con salud y buenas metas. '
                      'Gracias por tu trabajo este año.',
                SaludoFestivo.anioNuevo =>
                  'Que el ${TemporadaNavidena.anioDelSaludo(saludo)} venga '
                      'con salud y buenas metas.',
              },
              onCerrar: _cerrar,
            ),
    );
  }
}

class _Tarjeta extends StatelessWidget {
  final String titulo;
  final String mensaje;
  final VoidCallback onCerrar;

  const _Tarjeta({
    required this.titulo,
    required this.mensaje,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _TarjetaSaludoFestivoWidgetState._rojoOscuro,
            RedesignColors.red,
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: _PuntosNievePainter()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 44, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 38,
                  height: 44,
                  child: CustomPaint(painter: _ArbolitoPainter()),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        mensaje,
                        style: TextStyle(
                          fontSize: 12.5,
                          height: 1.3,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Atte. MCSystems',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: IconButton(
              onPressed: onCerrar,
              tooltip: 'Cerrar saludo',
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.18),
              ),
              icon: const Icon(
                Icons.close_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Puntitos blancos tenues de fondo, como nieve.
class _PuntosNievePainter extends CustomPainter {
  const _PuntosNievePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.22);
    const step = 18.0;
    var row = 0;
    for (var y = step / 2; y < size.height; y += step, row++) {
      final offset = row.isEven ? 0.0 : step / 2;
      for (var x = step / 2 + offset; x < size.width; x += step) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_PuntosNievePainter oldDelegate) => false;
}

/// Arbolito de Navidad con estrella y dos esferas.
class _ArbolitoPainter extends CustomPainter {
  const _ArbolitoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint();

    // Tronco.
    paint.color = const Color(0xff8A5A2B);
    canvas.drawRect(
      Rect.fromLTWH(w * 0.43, h * 0.78, w * 0.14, h * 0.18),
      paint,
    );

    // Copa en dos niveles.
    paint.color = const Color(0xff3E8E3A);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.08)
        ..lineTo(w * 0.8, h * 0.44)
        ..lineTo(w * 0.64, h * 0.44)
        ..lineTo(w * 0.95, h * 0.8)
        ..lineTo(w * 0.05, h * 0.8)
        ..lineTo(w * 0.36, h * 0.44)
        ..lineTo(w * 0.2, h * 0.44)
        ..close(),
      paint,
    );

    // Esferas.
    paint.color = const Color(0xffF2C230);
    canvas.drawCircle(Offset(w * 0.6, h * 0.66), w * 0.05, paint);
    paint.color = Colors.white;
    canvas.drawCircle(Offset(w * 0.38, h * 0.54), w * 0.045, paint);

    // Estrella en la punta.
    paint.color = const Color(0xffF2C230);
    canvas.drawCircle(Offset(w * 0.5, h * 0.08), w * 0.08, paint);
  }

  @override
  bool shouldRepaint(_ArbolitoPainter oldDelegate) => false;
}
