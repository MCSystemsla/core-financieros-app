# SPEC 03 — Fiadores de análisis NI en modo offline

> **Status:** Approved
> **Depends on:** SPEC 02
> **Date:** 2026-10-28
> **Objective:** Permitir que el asesor de Nicaragua registre fiadores sin conexión desde la lista offline de análisis, guardándolos en ObjectBox para enviarlos a mano por solicitud cuando vuelva a estar en línea.

## Por qué existe esta spec

SPEC 02 dejó el flujo de fiadores NI solo en línea: la card "Registrar Fiadores" de `SelectTypeAnalisisModalSheetNiWidget` bloquea el acceso sin conexión, y `AnalisisFiadoresNiCubit` no guarda nada en local.

Además, hoy NI no tiene análisis offline. Sin conexión, `CarteraScreen` abre `AnalisisSolicitudesHnOfflineScreen`, pero:

- La lista sale de `AnalisisListDataHn`, que solo llena `guardarAnalisisAsignados()` del sync de HN (`SolicitudCatalogoHnCubit`). En NI aparece vacía.
- El sheet de esa pantalla (`_SelectTypeAnalisis`) abre formularios de HN.
- `getTipoSolicitud()` lee el parámetro `MENORMIL` de `SolicitudesHnBoxService` con `!`. En NI ese parámetro no se sincroniza y la tarjeta puede fallar.

Por eso esta spec incluye una pantalla offline propia para NI: el sync descarga las solicitudes en análisis, y el sheet offline de NI ofrece lo mismo que el de HN (análisis, imágenes, ubicación) más fiadores. El plan de inversión offline queda fuera, como en HN.

El formulario de 4 pasos ya funciona sin red: sus catálogos (`SEXO`, `ESTADOCIVIL`, `RELACIONPERSONAS`, `PAIS`/`DEP`/`MUN`, `ACTIVIDADECONOMICA`, `TIPOVIVIENDA`, `PARENTESCO`) están en ObjectBox, y la cédula se valida en local.

## Scope

**In:**

- Entidad ObjectBox nueva `AnalisisFiadorNiLocalDb`, que guarda el body del fiador como JSON más metadatos. Se registra en `AnalisisBoxServiceHn`, el mismo store que ya usan los borradores de análisis NI.
- `AnalisisFiadorNi.fromJson`, para reconstruir el DTO desde el JSON guardado.
- Métodos de pendientes en `AnalisisBoxServiceHn`: guardar, listar por solicitud y usuario, buscar duplicado por cédula y eliminar.
- `createAnalisisFiador` de `AnalisisFormsRepositoryNiImpl` propaga el `ErrorNetworkCode` que devuelve `getErrorMessage` dentro del `AppException`. Así el cubit distingue un error de red de un error de backend.
- `AnalisisFiadoresNiCubit`:
  - Extrae el armado del DTO a un método reutilizable.
  - Agrega `guardarFiadorLocal(numeroSolicitud)`.
  - Agrega `isNetworkError` al state.
- Cubit nuevo `FiadoresNiPendientesCubit` que lista, envía y elimina los pendientes de una solicitud.
- Pantalla nueva `FiadoresNiPendientesScreen`, con la lista de pendientes (nombre, cédula, fecha de guardado), "Enviar" y "Eliminar" por fila, y el botón "Nuevo fiador".
- `AnalisisFiadoresNiSendingWidget` con dos modos:
  - **Enviar** (como hoy). Si falla por red, ofrece "Guardar para enviar después" además de "Reintentar envío".
  - **Guardar local**: guarda en ObjectBox y muestra `SendingStatusView` en ámbar con el texto "Fiador guardado en el teléfono. Envíalo cuando tengas conexión". Al cerrar, vuelve a `FiadoresNiPendientesScreen` de esa solicitud.
- Al tocar "Enviar" en el paso 4: con conexión se usa el modo Enviar, sin conexión el modo Guardar local (según `InternetConnectionCubit`).
- Bloquear guardar un pendiente con la misma cédula en la misma solicitud, para el mismo usuario.
- Card "Registrar Fiadores" del sheet NI en línea:
  - Ya no bloquea sin conexión, porque al sheet online solo se llega en línea.
  - Si la solicitud no tiene pendientes locales del usuario, abre `FiadoresNiFormScreen` directo, como hoy.
  - Si tiene, abre `FiadoresNiPendientesScreen`.
- Lista offline NI mínima:
  - `SolicitudCatalogoCubit` (sync de NI) descarga la página 1 de las solicitudes asignadas al asesor (`EstadoCredito.asignada`, `isAsignadaToAsesorCredito: true`, el mismo filtro de `AnalisisSolicitudesScreen`) y la guarda con `saveAnalisisListDataHn`.
  - Solo corre con `Flavor.nicaragua`. Si falla, agrega `'ANALISISASIGNADOS'` a `unsyncedCatalogos` sin cortar el resto del sync.
- Pantalla nueva `AnalisisSolicitudesNiOfflineScreen` (`screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_ni_offline_screen.dart`), separada de la de HN:
  - Lee `AnalisisListDataHn` y no llama `getTipoSolicitud()`.
  - El subtítulo del encabezado dice que se pueden registrar el análisis, las imágenes, la ubicación y los fiadores sin conexión.
  - El sheet de la tarjeta tiene las mismas opciones que el sheet offline de HN, con las mismas pantallas compartidas, más fiadores:
    - "Registrar Analisis" abre `AnalisisSolicitudesInterceptor` (NI), con el tipo de formulario del `getTipoSolicitud` de NI (umbral 1000).
    - "Registrar Imágenes del negocio" abre `ImagenesNegocioHnScreen(isOfflineMode: true)`.
    - "Registrar Ubicacion" abre `UbicacionClienteOfflineHnScreen`.
    - "Registrar Fiadores" abre `FiadoresNiPendientesScreen` (o el formulario directo si no hay pendientes, con la misma regla que en línea).
  - `CarteraScreen` la abre sin conexión con `Flavor.nicaragua`. HN y Costa Rica siguen abriendo `AnalisisSolicitudesHnOfflineScreen`, que no cambia.
- Sin conexión, `FiadoresNiPendientesScreen` muestra los pendientes con "Enviar" deshabilitado y un aviso de que se envían en línea.
- Cada pendiente guarda `LocalStorage().userId`, y cada asesor solo ve y envía los suyos.
- Un pendiente enviado con éxito (`201`) se borra de ObjectBox.
- Actualizar `references/app-modules-reference.md` y `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Plan de inversión sin conexión en NI. El sheet offline de HN tampoco lo tiene.
- Cambiar los formularios de análisis, imágenes o ubicación para NI offline. Se abren tal cual los usa HN offline.
- Descargar todas las páginas de solicitudes asignadas. Se queda en la página 1, igual que HN.
- Envío automático al reconectar, o una pantalla global con los pendientes de todas las solicitudes.
- Editar un fiador pendiente. Si algo está mal, se elimina y se vuelve a crear.
- Que el cierre del análisis tome en cuenta los pendientes locales. El diálogo sigue mirando solo `TieneFiadores` del backend.
- Detectar offline si el fiador ya existe en el backend.
- Fiadores offline en HN.
- Costa Rica. Su análisis sigue siendo un placeholder, y su sync no descarga la lista.
- Borrar pendientes al cerrar sesión o por antigüedad.

## Data model

```dart
// lib/src/datasource/analisis/ni/fiadores/local_db/analisis_fiador_ni_local_db.dart
@Entity()
class AnalisisFiadorNiLocalDb {
  @Id()
  int id = 0;
  @Unique()
  String uuid;                 // Uuid().v4() al guardar
  @Index()
  int numeroSolicitud;
  String userId;               // LocalStorage().userId
  String nombreCompleto;       // nombre1 nombre2 apellido1 apellido2, para la lista
  String cedula;               // para la lista y el control de duplicados
  @Property(type: PropertyType.date)
  DateTime fechaGuardado;
  String payloadJson;          // json.encode(AnalisisFiadorNi.toJson())
}
```

```dart
// lib/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart
class AnalisisFiadorNi {
  // ...campos de SPEC 02, sin cambios
  factory AnalisisFiadorNi.fromJson(Map<String, dynamic> json);  // inverso de toJson()
}
```

```dart
// lib/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart
late final Box<AnalisisFiadorNiLocalDb> analisisFiadorNiLocalDbBox;

void saveFiadorNiPendiente(AnalisisFiadorNiLocalDb fiador);
List<AnalisisFiadorNiLocalDb> getFiadoresNiPendientes({required int numeroSolicitud, required String userId});
bool existsFiadorNiPendiente({required int numeroSolicitud, required String cedula, required String userId});
void removeFiadorNiPendiente(int id);
```

```dart
// lib/src/presentation/bloc/analisis/ni/fiadores_pendientes/fiadores_ni_pendientes_state.dart
class FiadoresNiPendientesState {
  final List<AnalisisFiadorNiLocalDb> pendientes;
  final Status status;          // carga de la lista
  final String? enviandoUuid;   // fila con envío en curso
  final String? errorMsg;       // último error de envío
}
```

Conventions:

- `payloadJson` guarda el body ya armado: totales calculados, `database`, `Activo` y `EsFirmaDigitalFiador` incluidos. Al enviar, `AnalisisFiadorNi.fromJson(json.decode(payloadJson))` se manda tal cual. No se recalcula nada.
- `toJson()` ya descarta `null` y `''`, así que `fromJson` usa `''`/`0`/`false`/`null` por defecto en las llaves ausentes. Se cumple que `fromJson(toJson(x)).toJson() == toJson(x)`.
- La cédula del control de duplicados se compara tal cual se guardó (ya formateada por el formulario).
- Error de red = `AppException.status` en `ErrorNetworkCode.noConnection` o `ErrorNetworkCode.timeOutError`. Cualquier otro error es de backend, y no ofrece guardar en local.
- La llamada a `getErrorMessage` de `createAnalisisFiador` pasa un `errorMsg` propio, porque el texto por defecto ("La solicitud se guardó localmente.") no es cierto en el modo Enviar.

## Implementation plan

1. Crear `AnalisisFiadorNiLocalDb` en `lib/src/datasource/analisis/ni/fiadores/local_db/analisis_fiador_ni_local_db.dart`. Registrar su box en `AnalisisBoxServiceHn` con los cuatro métodos de pendientes. Correr `dart run tool/build_script.dart` para regenerar `objectbox.g.dart` y `objectbox-model.json`. Verificar con `flutter analyze`.
2. Agregar `AnalisisFiadorNi.fromJson`.
3. En `AnalisisFormsRepositoryNiImpl.createAnalisisFiador`, pasar el `ErrorNetworkCode` de `getErrorMessage` a `AppException(status: ...)`, con un `errorMsg` propio.
4. En `AnalisisFiadoresNiCubit`:
   - Extraer el armado del DTO de `createAnalisisFiador` a `AnalisisFiadorNi buildFiador({required int numeroSolicitud})`.
   - Agregar `isNetworkError` al state. Se pone en `true` cuando el `AppException` trae `noConnection` o `timeOutError`.
   - Agregar `guardarFiadorLocal({required int numeroSolicitud})`. Valida duplicado con `existsFiadorNiPendiente` (si existe, emite `error` con "Ya hay un fiador pendiente con esta cédula en esta solicitud"), arma la entidad y la guarda. Emite `inProgress`, después `done` o `error`.
5. Crear `FiadoresNiPendientesCubit` + state en `lib/src/presentation/bloc/analisis/ni/fiadores_pendientes/`:
   - `load({numeroSolicitud})` lee de `AnalisisBoxServiceHn` con el `userId` actual.
   - `enviar(AnalisisFiadorNiLocalDb)` llama a `createAnalisisFiador` con el DTO de `fromJson`. Si sale bien, borra el registro y recarga. Si falla, deja el registro y guarda `errorMsg`.
   - `eliminar(id)` borra y recarga.
6. Crear `FiadoresNiPendientesScreen` en `screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_pendientes_screen.dart`:
   - Lleva `ScreenHeaderWidget`, la lista de pendientes en tarjetas con `RedesignColors`, y "Nuevo fiador" (abre `FiadoresNiFormScreen`).
   - "Enviar" muestra un loader en la fila y, si falla, un snackbar con el error. Sin conexión, está deshabilitado y se ve un aviso.
   - "Eliminar" pide confirmación con un diálogo.
   - Al volver del formulario, recarga la lista.
7. En `AnalisisFiadoresNiSendingWidget`:
   - Agregar el parámetro `guardarLocal`. Con `true`, llama `guardarFiadorLocal` y muestra `SendingStatusView` en ámbar (`RedesignColors.amberTint` / `amber`) con el texto de guardado. Al cerrar, reemplaza la ruta por `FiadoresNiPendientesScreen` de la solicitud.
   - En modo Enviar con `isNetworkError`, agregar el botón "Guardar para enviar después", que llama `guardarFiadorLocal` y muestra el mismo estado de guardado.
8. En el paso 4 (`analisis_fiadores_ni_ingresos_vivienda.dart`), el botón "Enviar" abre el widget de envío con `guardarLocal: !isConnected`.
9. En `select_type_analisis_modal_sheet_ni_widget.dart`, la card "Registrar Fiadores" deja de chequear conexión. Abre `FiadoresNiPendientesScreen` si `getFiadoresNiPendientes` devuelve algo, y si no, `FiadoresNiFormScreen`.
10. En `SolicitudCatalogoCubit`:
    - Agregar `guardarAnalisisAsignadosNi()` con el mapeo de `SolicitudEstado` (NI) a `AnalisisListDataHn`.
    - Llamarlo desde `saveCatalogosSolicitudesCreditoToLocalDb` solo con `Flavor.nicaragua`, dentro de `try/catch`, agregando `'ANALISISASIGNADOS'` a `unsynced` si falla.
11. Crear `AnalisisSolicitudesNiOfflineScreen` en `screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_ni_offline_screen.dart`:
    - Lista de `AnalisisListDataHn` con tarjetas propias de NI, sin el `getTipoSolicitud()` de HN.
    - Subtítulo del encabezado propio de NI.
    - Sheet con "Registrar Analisis" (`AnalisisSolicitudesInterceptor` de NI), "Registrar Imágenes del negocio" y "Registrar Ubicacion" (las pantallas offline compartidas con HN), y "Registrar Fiadores" con la regla de navegación del paso 9.
    - En `CarteraScreen`, sin conexión, abrirla con `Flavor.nicaragua`. HN y Costa Rica siguen con `AnalisisSolicitudesHnOfflineScreen`, que no cambia.
12. Actualizar `references/app-modules-reference.md`:
    - Fiadores NI pasa a "online y offline (envío en línea)".
    - Reemplazar la nota de "Análisis offline" por la nueva regla de NI.

    Agregar en `CLAUDE.md` un subapartado en "NI análisis: fiadores" sobre los pendientes offline.

## Acceptance criteria

- [ ] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [ ] Después de sincronizar en NI con conexión, al apagar la red, Cartera → Análisis muestra las solicitudes asignadas al asesor (página 1).
- [ ] Al abrir esa lista offline en NI, no hay excepción por `MENORMIL`.
- [ ] En NI offline, el sheet de una solicitud muestra "Registrar Analisis", "Registrar Imágenes del negocio", "Registrar Ubicacion" y "Registrar Fiadores".
- [ ] En NI offline, "Registrar Analisis" abre el formulario de NI que corresponde al tipo y monto de la solicitud (el mismo que abre la lista online).
- [ ] En HN offline, la lista y el sheet se ven y funcionan igual que antes.
- [ ] Sin conexión, llenar los 4 pasos y tocar "Enviar" muestra la pantalla ámbar de "Fiador guardado en el teléfono" y no hace ninguna llamada HTTP.
- [ ] Al cerrar esa pantalla, se abre `FiadoresNiPendientesScreen` con el fiador recién guardado (nombre, cédula, fecha).
- [ ] Sin conexión, "Enviar" de la fila está deshabilitado y se ve el aviso de envío en línea.
- [ ] Guardar un segundo fiador con la misma cédula en la misma solicitud muestra el error de duplicado y no crea otro registro.
- [ ] Se puede guardar un fiador con la misma cédula en otra solicitud.
- [ ] "Eliminar" pide confirmación y, al aceptar, el fiador desaparece de la lista y de ObjectBox.
- [ ] Al cerrar y volver a abrir la app, los pendientes siguen ahí.
- [ ] Con otro usuario en el mismo teléfono, los pendientes del primero no aparecen.
- [ ] Con conexión, la card "Registrar Fiadores" del sheet NI abre el formulario directo si la solicitud no tiene pendientes, y `FiadoresNiPendientesScreen` si tiene.
- [ ] Con conexión, "Enviar" de un pendiente manda a `POST /cartera/analisis-fiador/create` el mismo body que se guardó (visible en `BitacoraService`). Con `201`, la fila desaparece y el registro se borra de ObjectBox.
- [ ] Si el envío de un pendiente falla, la fila se queda y se muestra el mensaje del backend.
- [ ] Con conexión, si el envío desde el formulario falla por red, la pantalla de envío muestra "Reintentar envío" y "Guardar para enviar después". Al guardar, el fiador aparece en pendientes.
- [ ] Si el envío desde el formulario falla por un error de backend (por ejemplo, de validación), no aparece "Guardar para enviar después".
- [ ] El diálogo de cierre del análisis no cambia: solo usa `TieneFiadores`.
- [ ] En Costa Rica, el sync no descarga la lista de análisis y la pantalla offline no cambia.
- [ ] Se registró un fiador offline en QA NI, se envió después en línea, y backend lo confirmó (verificación manual).

## Decisions

- **Sí:** lista offline NI. Sin ella el asesor no tiene cómo llegar al formulario de fiadores offline.
- **Sí:** el sheet offline de NI lleva las mismas opciones que el de HN (análisis, imágenes, ubicación) más fiadores. Lo pidió el usuario durante la implementación: imágenes y ubicación son pantallas compartidas con HN que ya guardan en local, y el análisis abre el interceptor de NI.
- **No:** adaptar los formularios de análisis, imágenes o ubicación para NI offline. Se abren tal cual, igual que en HN offline.
- **No:** permitir fiadores offline solo cuando el sheet ya estaba abierto. Depende de que la red se caiga en el momento justo.
- **Sí:** reutilizar la entidad `AnalisisListDataHn`. Tiene todos los campos que hacen falta.
- **Sí:** pantalla offline propia de NI (`AnalisisSolicitudesNiOfflineScreen`), con `CarteraScreen` eligiendo por flavor. Lo pidió el usuario durante la implementación, para no mezclar NI con HN, igual que la regla `hn`/`ni` de `CLAUDE.md`.
- **No:** meter una rama por flavor dentro de `AnalisisSolicitudesHnOfflineScreen`. Fue la primera versión del paso 11 y se descartó por mezclar los dos países en una pantalla.
- **Sí:** solo la página 1 de solicitudes asignadas, igual que `guardarAnalisisAsignados` de HN. Lo decidió el usuario. Un asesor con muchas solicitudes no las verá todas offline.
- **Sí:** envío manual por solicitud desde `FiadoresNiPendientesScreen`. El asesor ve el error de backend en el momento y puede corregir. Es el patrón de la ubicación offline de HN.
- **No:** envío automático al reconectar. Los errores de backend quedarían ocultos.
- **No:** pantalla global de pendientes. Para el volumen esperado alcanza con verlos por solicitud.
- **Sí:** con conexión, si el envío falla por red, ofrecer "Guardar para enviar después". Si es un error de backend, no, porque reenviar el mismo body daría el mismo error.
- **No:** guardar siempre en local antes de enviar. Cambiaría el flujo online de SPEC 02, que ya funciona.
- **Sí:** entidad con el JSON del body más metadatos, no con columnas planas. Si cambia el DTO, no hace falta tocar la entidad ni regenerar ObjectBox.
- **Sí:** registrar la entidad en `AnalisisBoxServiceHn`, aunque el nombre diga HN. Los borradores de análisis NI ya viven ahí, y abrir otro store no aporta nada.
- **Sí:** guardar el body ya calculado y enviarlo tal cual. Lo que se envía es exactamente lo que el asesor vio en pantalla.
- **Sí:** ver y eliminar pendientes, sin editar. Editar obligaría a cargar el JSON en el cubit del formulario de 4 pasos.
- **Sí:** bloquear la misma cédula en la misma solicitud y para el mismo usuario. Evita el duplicado más común, que es guardar dos veces. Lo que ya está en el backend no se puede revisar offline.
- **No:** que el cierre del análisis mire los pendientes locales. Lo decidió el usuario. El diálogo sigue mirando solo `TieneFiadores`.
- **Sí:** los pendientes son del `userId` que los guardó, y no se borran al cerrar sesión. Evita que otro asesor envíe con su JWT un fiador que no capturó, y evita perder datos.
- **Sí:** la card online abre los pendientes si hay, y si no, el formulario directo. El flujo online de SPEC 02 no suma un toque cuando no hay nada pendiente.
- **Sí:** distinguir el error de red con el `ErrorNetworkCode` que ya calcula `getErrorMessage`, propagándolo en `AppException.status`. No se inventa un tipo de excepción nuevo.
- **No:** Costa Rica. El sync y la elección de la pantalla offline se guardan con `Flavor.nicaragua`.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| La solicitud cambia de estado o se reasigna mientras el fiador está pendiente, y el envío falla | El registro se queda y se muestra el error del backend. El asesor puede eliminarlo. |
| Se envía un pendiente de un fiador que otro canal ya registró, y queda duplicado en el backend | No se puede detectar offline. Se acepta, porque SPEC 02 ya permite varios fiadores por solicitud. |
| El sync de NI pisa la lista de HN en `AnalisisListDataHn` (`saveAnalisisListDataHn` hace `removeAll`) | Cada build es de un solo país, y el sync de NI solo corre con `Flavor.nicaragua`. |
| Un cambio futuro del DTO deja JSON viejos que `fromJson` no entiende | `fromJson` usa valores por defecto en las llaves ausentes. |
| `getErrorMessage` clasifica como error de backend un error de red con otro texto, y no se ofrece guardar | El asesor puede reintentar o volver más tarde. Si pasa en QA, se agrega el texto a `_getErrorMessage`. |
| Algún formulario de análisis NI (nueva menor, mayor a mil, asalariado, represtamo) no funciona bien sin conexión, porque hasta ahora solo se usaban en línea | Los cuatro guardan borrador automático en ObjectBox. Se prueba cada uno offline en QA NI, y si alguno falla se corrige en su propia spec. |
| Sin conexión no se puede revisar `tieneAnalisis`, y el asesor puede llenar un análisis que ya está registrado | Se acepta, igual que en HN offline. El backend lo rechaza al enviar. |
| El token vence mientras hay pendientes, y al enviar sale el diálogo de re-auth | Es el flujo normal de `SessionReauthHandler`. Al autenticarse, el envío se reintenta. |

## What is **not** in this spec

- Plan de inversión offline en NI, y cambios en los formularios de análisis, imágenes o ubicación para NI offline.
- Descargar más de la página 1 de solicitudes asignadas.
- Envío automático o pantalla global de pendientes.
- Edición de fiadores pendientes.
- Cierre del análisis que tome en cuenta los pendientes locales.
- Detección offline de fiadores que ya existen en el backend.
- Fiadores offline en HN.
- Costa Rica.
- Limpieza de pendientes al cerrar sesión o por antigüedad.

Cada uno, si llega, va en su propia spec.
