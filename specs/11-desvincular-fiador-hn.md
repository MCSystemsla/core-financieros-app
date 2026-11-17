# SPEC 11 — Desvincular un fiador HN de la solicitud

> **Status:** Approved
> **Depends on:** SPEC 10
> **Date:** 2026-11-17
> **Objective:** Permitir que el asesor de Honduras desvincule un fiador registrado de la solicitud desde el menú de su tarjeta en "Registrados en el sistema", con un motivo obligatorio, llamando `PATCH /cartera/analisis-fiador/desvincular`.

## Por qué existe esta spec

SPEC 10 muestra los fiadores con vínculo activo de una solicitud HN, pero el asesor no puede quitar uno que ya no participa en el crédito. El backend expone ahora:

```
PATCH /cartera/analisis-fiador/desvincular
{
  "NumeroSolicitud": 4567,
  "FiadorId": 321,
  "Motivo": "El fiador ya no desea participar en el crédito."
}
```

Respuesta correcta (`200`):

```json
{ "ok": true, "message": "El fiador fue desvinculado de la solicitud No. 4567." }
```

El backend decide si el desvínculo procede (por ejemplo, con el análisis cerrado). La app no agrega reglas propias.

## Scope

**In:**

- Endpoint `DesvincularFiadorHNEndpoint` (`PATCH /cartera/analisis-fiador/desvincular`) con body `NumeroSolicitud`, `FiadorId` y `Motivo`.
- Método `desvincularFiador` en `AnalisisRepositoryHn` / `AnalisisRepositoryHNImpl`, que devuelve el `message` del backend.
- Cubit nuevo `DesvincularFiadorHnCubit`, provisto por el diálogo.
- Botón de tres puntos en cada tarjeta de `FiadoresRegistradosSection`. Abre un modal bottom sheet con el nombre y la cédula del fiador y una sola acción, "Desvincular" (en rojo). Tocar la tarjeta sigue abriendo "Ver fiador" (SPEC 10).
- Diálogo `DesvincularFiadorDialog`:
  - Muestra el nombre completo y la cédula del fiador.
  - Campo "Motivo" multilínea, obligatorio, de 10 a 250 caracteres (se valida sin espacios al inicio y al final).
  - Botones "Cancelar" y "Desvincular" (rojo).
  - Mientras envía: el botón muestra un loader, el campo y "Cancelar" se bloquean y el diálogo no se cierra con atrás ni tocando fuera.
  - Si falla: el diálogo sigue abierto, muestra el mensaje de error dentro y conserva el motivo para reintentar.
  - Si sale bien: se cierra y devuelve el `message` del backend.
- Al cerrarse con éxito, `FiadoresHnScreen`:
  - Muestra un snackbar de éxito con el `message` del backend.
  - Recarga "Registrados en el sistema" (`FiadoresSolicitudHnCubit.load`).
  - Vuelve a llamar `checkFiadorAval`, para actualizar las etiquetas "Registrado" y el bloqueo de Cónyuge.
- La acción existe solo donde existe la sección: Honduras, con conexión y con `numeroSolicitud >= 0`.
- Actualizar `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Desvincular fiadores en Nicaragua o Costa Rica (no tienen listado de registrados).
- Botón "Desvincular" dentro de "Ver fiador".
- Desvincular sin conexión o dejarlo pendiente en el teléfono.
- Desvincular fiadores pendientes locales (SPEC 05). Esos ya se eliminan desde `FiadoresHnPendientesScreen`.
- Lista fija de motivos.
- Restringir la acción por permiso `TypeAction` o por estado de la solicitud.
- Ver fiadores desvinculados o su historial de vínculos.
- Editar un fiador registrado.

## Data model

No hay entidades nuevas ni hay que regenerar Isar u ObjectBox.

```dart
// lib/src/domain/repository/analisis/hn/endpoint/analisis_endpoint_hn.dart
class DesvincularFiadorHNEndpoint extends Endpoint {
  final int numeroSolicitud;
  final int fiadorId;
  final String motivo;
  // method => Method.patch
  // path   => '/cartera/analisis-fiador/desvincular'
  // body   => {'NumeroSolicitud': numeroSolicitud, 'FiadorId': fiadorId, 'Motivo': motivo}
}
```

```dart
// lib/src/domain/repository/analisis/hn/analisis_repository_hn.dart
/// Devuelve el `message` del backend.
Future<String> desvincularFiador({
  required int numeroSolicitud,
  required int fiadorId,
  required String motivo,
});
```

```dart
// lib/src/presentation/bloc/analisis/hn/desvincular_fiador/desvincular_fiador_hn_state.dart
class DesvincularFiadorHnState {
  final Status status;     // notStarted, inProgress, done, error
  final String errorMsg;   // se muestra dentro del diálogo
  final String mensaje;    // `message` del backend cuando status == done
}

// desvincular_fiador_hn_cubit.dart
Future<void> desvincular({
  required int numeroSolicitud,
  required int fiadorId,
  required String motivo,
});
```

```dart
// lib/src/presentation/widgets/analisis_solicitudes/hn/fiadores/registrados/desvincular_fiador_dialog.dart
/// Devuelve el `message` del backend si se desvinculó, o `null` si se canceló.
static Future<String?> show(
  BuildContext context, {
  required FiadorSolicitudHn fiador,
  required int numeroSolicitud,
});
```

```dart
// FiadoresRegistradosSection
const FiadoresRegistradosSection({
  required this.onRetry,
  this.onTap,
  this.onDesvincular,   // ValueChanged<FiadorSolicitudHn>?; null → sin menú
});
```

Conventions:

- `FiadorId` es `FiadorSolicitudHn.idFiador`.
- `Motivo` se envía sin espacios al inicio y al final.
- Éxito: `statusCode == 200` y `ok == true`. Cualquier otro caso lanza `AppException` con `getErrorMessage` (mismo manejo que `getFiadoresSolicitud`). Si `message` viene vacío, se usa "Fiador desvinculado".
- El menú de una tarjeta se deshabilita mientras esa tarjeta carga su detalle (`cargandoCedula`).

## Implementation plan

1. **Endpoint y repositorio.** Crear `DesvincularFiadorHNEndpoint` en `analisis_endpoint_hn.dart` y agregar `desvincularFiador` a `AnalisisRepositoryHn` y `AnalisisRepositoryHNImpl`. Verificar con `flutter analyze`.
2. **Cubit.** Crear `DesvincularFiadorHnCubit` + state en `presentation/bloc/analisis/hn/desvincular_fiador/`, con `desvincular(...)` que pasa por `inProgress` y termina en `done` (con `mensaje`) o `error` (con `errorMsg`).
3. **Diálogo.** Crear `DesvincularFiadorDialog` en `widgets/analisis_solicitudes/hn/fiadores/registrados/`. Provee su propio `DesvincularFiadorHnCubit`, valida el motivo, bloquea el cierre mientras envía (`PopScope`, `barrierDismissible: false`), muestra el error dentro y hace `pop(mensaje)` al terminar bien. Todavía no se abre desde ningún lado.
4. **Menú en la tarjeta.** Agregar `onDesvincular` a `FiadoresRegistradosSection` y un botón de tres puntos en `_FiadorRegistradoCard` que abre un modal bottom sheet con "Desvincular"; la acción corre después de cerrar el sheet (reemplaza el chevron cuando `onDesvincular` no es null). Con `onDesvincular` null, la tarjeta se ve igual que hoy.
5. **Conexión en `FiadoresHnScreen`.** Pasar `onDesvincular`, que abre `DesvincularFiadorDialog.show`. Si devuelve un mensaje: snackbar de éxito, `FiadoresSolicitudHnCubit.load` y `checkFiadorAval` con los mismos parámetros que al entrar.
6. **Docs.** Agregar en `CLAUDE.md`, dentro de "HN análisis: fiadores registrados", un párrafo corto con el endpoint, el menú, el diálogo y qué se refresca.

## Acceptance criteria

- [X] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [X] Cada tarjeta de "Registrados en el sistema" tiene un botón de tres puntos que abre un modal bottom sheet con el nombre, la cédula y "Desvincular".
- [X] Al elegir "Desvincular", el sheet se cierra y se abre el diálogo del motivo.
- [X] Tocar la tarjeta (fuera del menú) sigue abriendo "Ver fiador".
- [X] "Desvincular" abre un diálogo con el nombre y la cédula del fiador y el campo "Motivo".
- [X] Con el motivo vacío o con menos de 10 caracteres (sin contar espacios al inicio y al final), "Desvincular" no llama al backend y muestra el error de validación.
- [X] El campo no acepta más de 250 caracteres.
- [X] "Cancelar" cierra el diálogo sin llamadas HTTP.
- [X] En `BitacoraService`, desvincular llama `PATCH /cartera/analisis-fiador/desvincular` con `NumeroSolicitud`, `FiadorId` (el `IdFiador` de la tarjeta) y `Motivo`.
- [X] Mientras envía, el botón muestra un loader y el diálogo no se cierra con atrás ni tocando fuera.
- [X] Si el backend responde error, el diálogo sigue abierto con su mensaje y el motivo escrito.
- [X] Si responde `200` con `ok: true`, el diálogo se cierra y se muestra un snackbar con el `message` del backend.
- [X] Después del éxito, el fiador ya no aparece en "Registrados en el sistema".
- [X] Después del éxito, la etiqueta "Registrado" de su tipo se actualiza según `checkFiadorAval` (por ejemplo, Cónyuge se desbloquea si era el único cónyuge).
- [X] Sin conexión o con `numeroSolicitud < 0`, la sección no aparece, así que tampoco el menú.
- [X] "Ver fiador", crear un fiador (en línea y sin conexión) y "Pendientes en el teléfono (N)" funcionan igual que antes.
- [X] Nicaragua y Costa Rica no cambian.
- [X] Verificación manual en QA HN desvinculando un fiador de una solicitud con al menos dos fiadores.

## Decisions

- **Sí:** solo Honduras. Lo eligió el usuario. Es el único país con listado de registrados (SPEC 10).
- **Sí:** menú de tres puntos en la tarjeta. Lo eligió el usuario. Deja espacio para futuras acciones (editar).
- **Sí:** el menú es un modal bottom sheet, no un `PopupMenuButton`. Lo pidió el usuario durante la implementación. Muestra a qué fiador se aplica la acción y sigue el estilo de los sheets de análisis (`ModuleTileWidget`).
- **No:** botón dentro de "Ver fiador". Lo descartó el usuario a favor del menú.
- **No:** ícono directo en la tarjeta. Es fácil tocarlo sin querer y no escala a más acciones.
- **Sí:** motivo de texto libre, obligatorio, de 10 a 250 caracteres. Lo eligió el usuario.
- **No:** lista fija de motivos. Requiere acordarla con negocio.
- **Sí:** recargar la lista y `checkFiadorAval` tras el éxito. Lo eligió el usuario. Así las etiquetas "Registrado" y el bloqueo de Cónyuge no quedan desactualizados.
- **Sí:** el diálogo se queda abierto al enviar y al fallar. Lo eligió el usuario. El asesor no pierde el motivo escrito.
- **Sí:** éxito es `200` con `ok: true`, y el snackbar usa el `message` del backend. Lo dio el usuario con la respuesta de ejemplo.
- **Sí:** sin restricciones en la app; valida el backend. Lo eligió el usuario.
- **No:** mandar `database` (ni en el body ni como query param), aunque otros PATCH de análisis HN lo mandan. Lo eligió el usuario durante la implementación: el body va exactamente como el curl del backend.
- **Sí:** un cubit propio provisto por el diálogo, no más campos en `FiadoresSolicitudHnCubit`. El estado del envío vive solo mientras el diálogo está abierto y no se mezcla con la carga de la lista y el detalle.
- **No:** quitar el fiador de la lista en memoria sin recargar. La recarga confirma con el backend que el vínculo ya no está activo.
- **No:** modo offline. Desvincular sin conexión no tiene sentido sin la lista, que es solo en línea.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| El backend responde `200` con `ok: false`. | Se trata como error y se muestra su `message` en el diálogo. |
| Se pierde la conexión mientras el diálogo está abierto. | El envío falla con el error de red, el diálogo sigue abierto y se puede reintentar. |
| El asesor desvincula por error. | El motivo obligatorio obliga a un paso deliberado. No hay "deshacer"; se vuelve a crear el fiador. |
| La recarga de la lista falla después del éxito. | La sección muestra su estado de error con "Reintentar" (SPEC 10). El snackbar de éxito ya se mostró. |
| `idFiador` llega en `0` porque el backend no lo mandó. | Se envía igual y el backend responde error, que se muestra en el diálogo. |

## What is **not** in this spec

- Nicaragua y Costa Rica.
- "Desvincular" dentro de "Ver fiador".
- Desvincular sin conexión o fiadores pendientes locales.
- Lista fija de motivos.
- Permisos o reglas de estado en la app.
- Historial de fiadores desvinculados.
- Editar un fiador registrado.

Cada uno, si llega, va en su propia spec.
