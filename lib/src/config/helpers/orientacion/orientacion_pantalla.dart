import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const _portrait = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
];

/// Controla qué pantallas pueden girar a landscape.
///
/// La app está bloqueada en portrait (`app.dart`). Las pantallas adaptadas a
/// landscape lo piden con [PermiteLandscapeMixin], y cuando abren una pantalla
/// que no está adaptada usan [abrirEnPortrait].
///
/// Cada petición queda en una pila y manda la última que sigue activa. Así no
/// importa el orden en que corren el `dispose` de la pantalla que se cierra,
/// el `initState` de la que se abre y el `await` de la navegación (por ejemplo,
/// el login hace `pushReplacement('/')` y el Home se monta antes de que el
/// login se destruya).
class OrientacionPantalla {
  OrientacionPantalla._();

  static final _pila = <_Peticion>[];
  static bool? _landscapeAplicado;

  /// Permite landscape hasta que se llame a [liberar] con el token devuelto.
  static Object permitirLandscape() => _agregar(landscape: true);

  /// Fuerza portrait hasta que se llame a [liberar] con el token devuelto.
  static Object forzarPortrait() => _agregar(landscape: false);

  static void liberar(Object token) {
    _pila.remove(token);
    _aplicar();
  }

  /// Fuerza portrait mientras dure [navegar] (normalmente un `push` que se
  /// completa al volver) y luego devuelve la orientación anterior.
  static Future<T?> abrirEnPortrait<T>(Future<T?> Function() navegar) async {
    final token = forzarPortrait();
    try {
      return await navegar();
    } finally {
      liberar(token);
    }
  }

  static Object _agregar({required bool landscape}) {
    final peticion = _Peticion(landscape: landscape);
    _pila.add(peticion);
    _aplicar();
    return peticion;
  }

  static void _aplicar() {
    final landscape = _pila.isNotEmpty && _pila.last.landscape;
    if (landscape == _landscapeAplicado) return;
    _landscapeAplicado = landscape;
    SystemChrome.setPreferredOrientations(
      landscape ? DeviceOrientation.values : _portrait,
    );
  }
}

class _Peticion {
  final bool landscape;
  _Peticion({required this.landscape});
}

/// Permite landscape mientras el `State` está montado. Para abrir desde aquí
/// una pantalla que no está adaptada, usa [OrientacionPantalla.abrirEnPortrait].
mixin PermiteLandscapeMixin<T extends StatefulWidget> on State<T> {
  late final Object _tokenOrientacion;

  @override
  void initState() {
    super.initState();
    _tokenOrientacion = OrientacionPantalla.permitirLandscape();
  }

  @override
  void dispose() {
    OrientacionPantalla.liberar(_tokenOrientacion);
    super.dispose();
  }
}
