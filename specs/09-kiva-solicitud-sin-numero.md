# SPEC 09 — Kiva offline para solicitudes sin número

> **Status:** Implemented
> **Depends on:** —
> **Date:** 2026-11-07
> **Objective:** Mostrar las solicitudes creadas offline con producto Kiva, todavía sin sincronizar, dentro de la lista Kiva offline con los tags "Sin número" y "Kiva pendiente"/"Kiva llenado", en lugar del botón flotante actual, y corregir los bugs de datos vacíos y crashes de ese flujo.

## Por qué existe esta spec

Hoy, para llenar el Kiva de una solicitud creada offline, el asesor entra a Cartera → Kiva (sin conexión) → `OfflineFormKivaScreen` ("Solicitudes en Trámite (Offline)") y toca el FAB negro "Crear nueva solicitud KIVA". Eso abre `SolicitudesKivaOffline`. El FAB está en una pantalla que lista otra cosa (Kiva de solicitudes que ya tienen número), así que casi nadie lo encuentra.

Además, `SolicitudesKivaOffline`:

- no dice si el Kiva ya se llenó, y permite llenarlo dos veces;
- lista solicitudes ya sincronizadas (filtra solo por `isDone`), cuyo Kiva quedaría huérfano con el `uuid`;
- pasa `cedula: ''`, `numero: ''` y `tipoSolicitud: ''` a `KivaRouteCubit`.

La idea es la misma que la de SPEC 08: las solicitudes sin número aparecen en la lista de siempre, con un tag. La diferencia con SPEC 08 es que Kiva **ya se enlaza solo por `uuid`** al sincronizar (`processSolicitud` → `setNumeroSolicitudAndSolicitudIdWhenSolicitudCreditoIsKiva`). Por eso no hace falta el borrador ni el diálogo "¿Usar datos guardados?".

## Scope

**In:**

- `OfflineFormKivaScreen` lista arriba las solicitudes NI locales terminadas y no sincronizadas (`isDone == true && hasVerified != true`) cuyo `nombreFormularioKiva` es uno de los 12 formularios Kiva (nueva `ResponseLocalDb`, asalariado `AsalariadoResponsesLocalDb`, represtamo `ReprestamoResponsesLocalDb`). Debajo siguen las `SolicitudesPendientes` de siempre.
- Cada solicitud sin número muestra el tag "Sin número" y un tag de estado: "Kiva pendiente" (ámbar) si no hay formulario Kiva local con `solicitudCreditoId == uuid`, y "Kiva llenado" (verde) si lo hay. Los tags usan `CardTagWidget` dentro del `ListTile` actual.
- Al tocar una "Kiva pendiente", se carga `KivaRouteCubit` con los datos reales de la solicitud local (nombre, cédula, tipo, cantidad de hijos, `uuid` como `solicitudId`/`solicitudCreditoId`) y se abre `SolicitudesCreditoKivaOfflineInterceptor`.
- Al tocar una "Kiva llenado", sale un diálogo "Este Kiva ya fue llenado" con "Eliminar y llenar de nuevo" (pide confirmación) y "Cerrar". Eliminar borra el formulario Kiva local y su `ImageModel` (`solicitudUuid == uuid`), y abre el formulario vacío.
- Al volver del formulario, la lista se recarga y los tags se actualizan.
- Se quita el FAB "Crear nueva solicitud KIVA" de `OfflineFormKivaScreen`.
- Aplica a Nicaragua y Costa Rica, igual que el Kiva de hoy (sin guard por flavor).
- Bugs corregidos:
  - Datos vacíos: `cedula`, `tipoSolicitud` y `cantidadHijos` reales al abrir desde una solicitud sin número.
  - Crashes: `widget.solicitud.nombre!` (lista y filtro), `nombreFormulario!.toFormularioKival()!` (si es null se muestra un snackbar de error y no navega), `int.parse(solcitudId)` en las imágenes de `setNumeroSolicitudAndSolicitudIdWhenSolicitudCreditoIsKiva` (pasa a `int.tryParse(...) ?? 0`) y `uuid!` en `getProductosSolicitudesCredito` (se descartan las filas sin `uuid`).
  - Async: `setState` sin `mounted` en `_RequestWidgetState._getNumSolicitud`.

**Out of scope:**

- Cambiar cómo se enlaza el Kiva: sigue siendo automático por `uuid` al sincronizar la solicitud.
- Avisar o bloquear el sync de una solicitud Kiva sin formulario: se queda como hoy (silencioso).
- Avisos extra: diálogo al terminar la solicitud, contador en Cartera o tags en la lista de solicitudes offline.
- Rediseño v2 de `OfflineFormKivaScreen`, `KivaFormScreen` y del historial Kiva.
- Borrar `SolicitudesKivaOffline` y `SelectTypeKivaScreen` (con el contador "9" escrito a mano), aunque queden sin entrada desde el FAB.
- Listar las solicitudes sin número en `KivaFormScreen` (con conexión).
- Honduras (no tiene Kiva).

## Data model

No hay entidades nuevas ni hay que regenerar Isar u ObjectBox.

`KivaSolicitudModel` (`datasource/solicitudes/ni/kiva/kiva_solicitud_model.dart`) suma campos:

```dart
class KivaSolicitudModel {
  final String uuid;
  final String nombre;
  final String nombreFormularioKiva;
  final int cantidadHijos;
  final String cedula;         // nuevo
  final String tipoSolicitud;  // nuevo: 'NUEVAMENOR' | 'ASAL' | 'REPRESTAMO'
  final bool kivaLlenado;      // nuevo: hay formulario Kiva local con solicitudCreditoId == uuid
}
```

- `tipoSolicitud` usa los mismos valores que `toTypeFormId()` (`ResponseLocalDb` → `NUEVAMENOR`, `AsalariadoResponsesLocalDb` → `ASAL`, `ReprestamoResponsesLocalDb` → `REPRESTAMO`). Al sincronizar, `setNumeroSolicitudAndSolicitudIdWhenSolicitudCreditoIsKiva` lo reemplaza con el valor del backend, como hoy.
- `cantidadHijos` sigue en 0 para represtamo, porque `ReprestamoResponsesLocalDb` no tiene ese campo.

## Implementation plan

1. **Modelo y consulta.** Agregar `cedula`, `tipoSolicitud` y `kivaLlenado` (por defecto `false`) a `KivaSolicitudModel`. En `ObjectBoxService.getProductosSolicitudesCredito` filtrar además `hasVerified != true`, descartar filas sin `uuid` y llenar `cedula` y `tipoSolicitud`. `SolicitudesKivaOffline` sigue compilando.
2. **Detección y borrado en Isar.** En `SolicitudesPendientesLocalDbCubit`:
   - `Future<bool> tieneKivaSinNumero({required String uuid, required String nombreFormularioKiva})`: reusa `getKivaByNumeroSolicitud` (busca por `solicitudCreditoId == uuid` en la colección del formulario).
   - `Future<void> eliminarKivaSinNumero({required String uuid, required String nombreFormularioKiva})`: en una `writeTxn`, borra la fila del formulario y el `ImageModel` con `solicitudUuid == uuid`.
3. **Carga en la pantalla.** `OfflineFormKivaScreen` crea un `SolicitudesOfflineCubit` (`global<ObjectBoxService>()`) y, para cada solicitud sin número, calcula `kivaLlenado` con `tieneKivaSinNumero`. Se quita el `Future.delayed(3s)` del camino que usa esta pantalla.
4. **UI de la lista.** `KivaOfflineContent` recibe también la lista sin número y la pinta arriba con `_SinNumeroKivaTile` (`ListTile` + `CardTagWidget` "Sin número" y "Kiva pendiente"/"Kiva llenado"). El buscador filtra ambas listas por nombre (null-safe). Se agrega `didUpdateWidget` para que la recarga se vea. Se quita el FAB.
5. **Tap en "Kiva pendiente".** `setCurrentRouteProduct` con `cedula`, `tipoSolicitud`, `cantidadHijos`, `nombre`, `solicitudId`/`solicitudCreditoId = uuid` y `numero: ''`, y luego push de `SolicitudesCreditoKivaOfflineInterceptor`. Al volver (`await Navigator.push`), recargar la lista.
6. **Tap en "Kiva llenado".** Diálogo "Este Kiva ya fue llenado" → "Eliminar y llenar de nuevo" → confirmación → `eliminarKivaSinNumero` → mismo flujo del paso 5. "Cerrar" no hace nada.
7. **Crashes y async.** Quitar `nombre!` y `nombreFormulario!.toFormularioKival()!` en `_RequestWidget` (snackbar de error si el formulario no se reconoce), agregar `if (!mounted) return;` en `_getNumSolicitud`, y cambiar `int.parse(solcitudId)` por `int.tryParse(solcitudId) ?? 0` en las 12 ramas de `setNumeroSolicitudAndSolicitudIdWhenSolicitudCreditoIsKiva`.
8. **Docs.** Actualizar `CLAUDE.md` (sección corta "NI/CR Kiva: solicitudes sin número") y `references/app-modules-reference.md` si menciona el FAB.

## Acceptance criteria

- [X] `flutter analyze` no reporta issues nuevos.
- [X] `OfflineFormKivaScreen` ya no tiene el FAB "Crear nueva solicitud KIVA".
- [X] Una solicitud nueva, asalariado o represtamo creada offline con producto Kiva y terminada aparece arriba en `OfflineFormKivaScreen` con "Sin número" y "Kiva pendiente".
- [X] Una solicitud ya sincronizada (`hasVerified == true`) no aparece en esa lista.
- [X] Una solicitud sin producto Kiva no aparece.
- [X] Al llenar el Kiva y volver, la misma fila muestra "Kiva llenado" sin salir de la pantalla.
- [X] El formulario Kiva guardado desde una solicitud sin número tiene la cédula y el tipo de la solicitud local, no vacíos.
- [X] Tocar "Kiva llenado" no abre el formulario: muestra el diálogo. "Eliminar y llenar de nuevo" borra el formulario y sus imágenes locales y abre uno vacío.
- [X] Al sincronizar la solicitud con conexión, el Kiva llenado se envía con el número real (comportamiento actual, sin regresión).
- [X] Un `SolicitudesPendientes` con `nombre` o `nombreFormulario` null no crashea la lista ni el tap.
- [X] Funciona igual en Nicaragua y Costa Rica.
- [X] Verificación manual en QA NI.

## Decisions

- **Sí:** enlace automático por `uuid` al sincronizar, como hoy. La solicitud local ya lleva el `uuid`. Un diálogo por cédula (como SPEC 08) sería trabajo extra sin beneficio.
- **No:** borrador `AnalisisBorradorSinNumeroHnLocalDb` ni número provisional negativo. Kiva no lo necesita porque el `uuid` ya identifica la solicitud.
- **Sí:** ocultar las solicitudes con `hasVerified == true`. Evita llenar Kiva que ya no se enlazarían y quedarían huérfanos.
- **Sí:** listarlas en `OfflineFormKivaScreen`, que es la pantalla que el asesor ya abre sin conexión, y no en una pantalla aparte detrás de un FAB.
- **Sí:** permitir "Eliminar y llenar de nuevo" en vez de solo avisar. El asesor puede corregir un Kiva antes del sync. No hay edición in situ porque los formularios Kiva no la soportan.
- **No:** avisar o bloquear el sync si falta el Kiva. El usuario prefirió dejarlo como hoy.
- **No:** avisos extra (diálogo al terminar, contador en Cartera, tags en la lista offline). El usuario prefirió solo la lista.
- **No:** rediseño v2 de la pantalla. Solo se agregan `CardTagWidget`. El rediseño de Kiva va en otra spec.
- **Sí:** NI y CR sin guard. Kiva ya se muestra en ambos y CR reusa las solicitudes offline de NI.
- **No:** borrar `SolicitudesKivaOffline` y `SelectTypeKivaScreen` en esta spec. No se pidió limpieza.

## Risks

| Risk | Mitigation |
| --- | --- |
| Calcular `kivaLlenado` hace una consulta Isar por solicitud. | Son pocas filas locales y la consulta es por un campo filtrado. Si se nota lento, se agrupa por `nombreFormularioKiva`. |
| La sincronización corre mientras la pantalla está abierta y la lista queda vieja. | La lista se recarga al volver del formulario. Una solicitud ya sincronizada que se toque abre el flujo sin número y su Kiva no se enlazaría. Se acepta en esta spec: es poco probable porque la pantalla se usa sin conexión. |
| `cantidadHijos` en represtamo sigue en 0. | Es una limitación del modelo local (`ReprestamoResponsesLocalDb` no tiene el campo). Queda documentado. |
| Eliminar el Kiva borra las imágenes locales. | Confirmación explícita antes de borrar. |

## What is **not** in this spec

- Aviso o bloqueo del sync cuando falta el Kiva.
- Diálogo al terminar la solicitud, contador en Cartera o tags en la lista de solicitudes offline.
- Rediseño v2 del módulo Kiva.
- Limpieza de `SolicitudesKivaOffline` y `SelectTypeKivaScreen`.
- Solicitudes sin número en `KivaFormScreen` (online).
- Honduras.
