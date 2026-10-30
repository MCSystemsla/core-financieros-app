# SPEC 05 — Fiadores de análisis HN en modo offline

> **Status:** Approved
> **Depends on:** SPEC 01, SPEC 03
> **Date:** 2026-10-30
> **Objective:** Permitir que el asesor de Honduras registre fiadores sin conexión desde la lista offline de análisis, guardando el formulario, las fotos de la cédula y la firma en el teléfono para enviarlos a mano por solicitud cuando vuelva a estar en línea.

## Por qué existe esta spec

Hoy los fiadores HN son solo en línea, en cuatro puntos:

- El sheet offline de HN (`_SelectTypeAnalisis` en `analisis_solicitudes_hn_offline_screen.dart`) no ofrece fiadores.
- `FiadoresHnScreen` llama `AnalisisFiadorAvalCubit.checkFiadorAval` para saber si ya hay cónyuge, aval o codeudor.
- `FiadoresSearchByDocumentScreen` busca a la persona en el backend (`getAnalisisFiadorByDocument`). Sin red muestra "Necesitas conexión a internet para crear fiadores".
- `AnalisisFiadoresCubit` no guarda nada en local. Envía en tres llamadas encadenadas: crear el fiador (devuelve el `id`), enviar la firma con ese `id` (`fiadoresEnviarFirmaDigital`) y subir el PDF de la cédula al expediente (`_subirCedulaFiador`, SPEC 01).

Además, `FiadorSignatureWidget` guarda la firma en `getTemporaryDirectory()`, que el sistema puede limpiar. Un pendiente que dure días no puede depender de esa ruta.

El modelo es el de SPEC 03 (fiadores NI): una lista de pendientes por solicitud que se envían a mano. La diferencia es que HN también guarda tres archivos (frente y reverso de la cédula y la firma), y que el envío tiene tres pasos que pueden fallar por separado.

## Scope

**In:**

- Entidad ObjectBox nueva `AnalisisFiadorHnLocalDb`, con el body del fiador como JSON, las rutas de los tres archivos, el `fiadorId` devuelto por el backend y metadatos. Se registra en `AnalisisBoxServiceHn`.
- `AnalisisFiadoresHn.fromJson` y `HistorialCredito.fromJson`, para reconstruir el DTO desde el JSON guardado.
- Métodos de pendientes en `AnalisisBoxServiceHn`: guardar, listar por solicitud y usuario, buscar duplicado por cédula, contar cónyuges pendientes, actualizar `fiadorId` y eliminar (borrando también la carpeta de archivos).
- Al guardar un pendiente, las fotos de la cédula y la firma se copian a `getApplicationDocumentsDirectory()/fiadores_hn/<uuid>/` (`cedula_frente.jpg`, `cedula_reverso.jpg`, `firma.png`). La fila guarda esas rutas, no las originales.
- `AnalisisFiadoresCubit`:
  - Extrae el armado del DTO de `createAnalisisFiador` a un método reutilizable.
  - Agrega `guardarFiadorLocal()`.
  - Extrae la subida del PDF de la cédula a una función que también use el envío de pendientes.
- Card "Registrar Fiadores" en el sheet offline de HN, visible solo con `Flavor.honduras` (Costa Rica comparte la pantalla) y nunca en solicitudes grupales. Abre `FiadoresHnScreen`.
- `FiadoresHnScreen`:
  - Sin conexión, no llama `checkFiadorAval`, no muestra error y no muestra las etiquetas "Registrado".
  - Cónyuge se bloquea si el backend dice `tieneConyugue` (solo en línea) o si la solicitud ya tiene un cónyuge (`TFD2`) pendiente local del usuario.
  - Si la solicitud tiene pendientes del usuario, muestra una fila "Pendientes en el teléfono (N)", en línea y sin conexión, que abre `FiadoresHnPendientesScreen`.
- `FiadoresSearchByDocumentScreen`: sin conexión, no llama al backend y pasa al formulario con los nombres, la cédula y el tipo de documento tecleados, igual que el caso `isNewUser`.
- `AnalisisFiadoresSendingWidget` con el parámetro `guardarLocal`. Con `true`, guarda en ObjectBox y muestra `SendingStatusView` en ámbar con el texto "Fiador guardado en el teléfono. Envíalo cuando tengas conexión". Al cerrar, reemplaza la ruta por `FiadoresHnPendientesScreen` de esa solicitud.
- Al tocar "Enviar" en el último paso (`analisis_fiadores_datos_de_ingresos.dart`): con conexión se envía como hoy, sin conexión se abre el widget con `guardarLocal: true` (según `InternetConnectionCubit`).
- Cubit nuevo `FiadoresHnPendientesCubit` que lista, envía y elimina los pendientes de una solicitud.
- Pantalla nueva `FiadoresHnPendientesScreen`, con la lista de pendientes (nombre, cédula, tipo de fiador, fecha de guardado, y "Falta la firma" si ya tiene `fiadorId`), "Enviar" y "Eliminar" por fila. Sin conexión, "Enviar" está deshabilitado y se ve un aviso de que se envían en línea.
- Envío de un pendiente:
  1. Si `fiadorId` está vacío, crea el fiador con el DTO de `fromJson`. Si el backend no devuelve `id`, falla y el pendiente se queda.
  2. Guarda el `fiadorId` en la fila antes de seguir.
  3. Envía la firma desde `firmaPath`.
  4. Sube el PDF de la cédula. Si falla, solo se reporta con `ErrorReporter`, como hoy.
  5. Con la firma enviada, borra la fila y la carpeta de archivos.
- Si falla el paso 3, el pendiente se queda con su `fiadorId`, y el siguiente "Enviar" empieza en la firma, sin volver a crear el fiador.
- No se puede guardar un pendiente con la misma cédula en la misma solicitud, para el mismo usuario.
- Cada pendiente guarda `LocalStorage().userId`, y cada asesor solo ve y envía los suyos.
- Actualizar `references/app-modules-reference.md` y `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Borrador automático del formulario a medio llenar. Si el asesor sale antes de "Enviar", pierde lo capturado, como hoy.
- Editar un pendiente. Si algo está mal, se elimina y se vuelve a capturar.
- "Guardar para enviar después" cuando el envío en línea falla por red. En línea, el flujo de envío no cambia.
- Cambiar la card "Registrar Fiadores" del sheet online de HN. Los pendientes se ven desde `FiadoresHnScreen`.
- Envío automático al reconectar, o una pantalla global con los pendientes de todas las solicitudes.
- Buscar a la persona en el backend sin conexión, o precargar sus datos.
- Bloquear offline un cónyuge que ya existe en el backend.
- Que el cierre del análisis tome en cuenta los pendientes locales.
- Fiadores offline en Costa Rica. NI ya los tiene (SPEC 03) y no cambia.
- Borrar pendientes al cerrar sesión o por antigüedad.

## Data model

```dart
// lib/src/datasource/analisis/hn/fiadores/local_db/analisis_fiador_hn_local_db.dart
@Entity()
class AnalisisFiadorHnLocalDb {
  @Id()
  int id = 0;
  @Unique()
  String uuid;                 // Uuid().v4() al guardar; nombre de la carpeta de archivos
  @Index()
  int numeroSolicitud;
  String userId;               // LocalStorage().userId
  String tipoFiadorCodigo;     // TFD1 aval, TFD2 cónyuge, TFD3 codeudor
  String nombreCompleto;       // nombre1 nombre2 apellido1 apellido2, para la lista
  String cedula;               // para la lista y el control de duplicados
  @Property(type: PropertyType.date)
  DateTime fechaGuardado;
  String payloadJson;          // json.encode(AnalisisFiadoresHn.toJson())
  String cedulaFrontPath;      // .../fiadores_hn/<uuid>/cedula_frente.jpg
  String cedulaBackPath;       // .../fiadores_hn/<uuid>/cedula_reverso.jpg
  String firmaPath;            // .../fiadores_hn/<uuid>/firma.png
  String fiadorId;             // '' hasta que el backend crea el fiador
}
```

```dart
// lib/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart
class AnalisisFiadoresHn {
  // ...campos actuales, sin cambios
  factory AnalisisFiadoresHn.fromJson(Map<String, dynamic> json);  // inverso de toJson()
}

// lib/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart
class HistorialCredito {
  // ...campos actuales, sin cambios
  factory HistorialCredito.fromJson(Map<String, dynamic> json);    // inverso de toJson(), genera uuid si falta
}
```

```dart
// lib/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart
late final Box<AnalisisFiadorHnLocalDb> analisisFiadorHnLocalDbBox;

void saveFiadorHnPendiente(AnalisisFiadorHnLocalDb fiador);
List<AnalisisFiadorHnLocalDb> getFiadoresHnPendientes({required int numeroSolicitud, required String userId});
bool existsFiadorHnPendiente({required int numeroSolicitud, required String cedula, required String userId});
bool existsConyugeHnPendiente({required int numeroSolicitud, required String userId});
void updateFiadorHnPendienteFiadorId({required int id, required String fiadorId});
Future<void> removeFiadorHnPendiente(AnalisisFiadorHnLocalDb fiador);  // borra la fila y la carpeta <uuid>
```

```dart
// lib/src/presentation/bloc/analisis/hn/fiadores_pendientes/fiadores_hn_pendientes_state.dart
class FiadoresHnPendientesState {
  final List<AnalisisFiadorHnLocalDb> pendientes;
  final Status status;          // carga de la lista
  final Status envioStatus;     // envío de un pendiente; dispara los snackbars de éxito y error
  final String? enviandoUuid;   // fila con envío en curso
  final String? errorMsg;       // último error de envío
}
```

Conventions:

- `payloadJson` guarda el body ya armado: totales calculados (`totalIngresosFamiliares`, `gananciaNegocio`, `saldoDisponible`), `database`, `historialCredito` y `tipoFiadorCodigo` incluidos. Al enviar, `AnalisisFiadoresHn.fromJson(json.decode(payloadJson))` se manda tal cual. No se recalcula nada.
- `fromJson` usa `''`/`0`/`false`/`null`/`[]` por defecto en las llaves ausentes. Se cumple que `fromJson(toJson(x)).toJson() == toJson(x)`.
- Las rutas de los archivos son absolutas y apuntan a la carpeta del `uuid`. Los archivos originales (cámara y firma temporal) no se tocan.
- La cédula del control de duplicados se compara tal cual se guardó.
- El PDF de la cédula se genera al enviar, no al guardar, con `ImagesToPdfService` y `fileName: 'cedula_fiador_<fiadorId>'`, como hoy.

## Implementation plan

1. Crear `AnalisisFiadorHnLocalDb` en `lib/src/datasource/analisis/hn/fiadores/local_db/analisis_fiador_hn_local_db.dart`. Registrar su box en `AnalisisBoxServiceHn`. Correr `dart run tool/build_script.dart` para regenerar `objectbox.g.dart` y `objectbox-model.json`. Verificar con `flutter analyze`.
2. Agregar `HistorialCredito.fromJson` y `AnalisisFiadoresHn.fromJson`. Sin test unitario, por decisión del usuario.
3. Agregar a `AnalisisBoxServiceHn` los seis métodos de pendientes. `removeFiadorHnPendiente` borra la carpeta `fiadores_hn/<uuid>/` si existe, y después la fila.
4. En `AnalisisFiadoresCubit`:
   - Extraer el armado del DTO de `createAnalisisFiador` a `AnalisisFiadoresHn buildFiador()`.
   - Extraer `_subirCedulaFiador` a una función pública que reciba las dos rutas, la cédula, el número de solicitud y el `fiadorId`, para usarla también desde los pendientes.
   - Agregar `guardarFiadorLocal()`. Valida duplicado con `existsFiadorHnPendiente` (si existe, emite `error` con "Ya hay un fiador pendiente con esta cédula en esta solicitud"). Copia los tres archivos a `fiadores_hn/<uuid>/`, arma la entidad y la guarda. Si falta algún archivo, emite `error` y no guarda nada. Emite `inProgress`, después `done` o `error`.
5. Crear `FiadoresHnPendientesCubit` + state en `lib/src/presentation/bloc/analisis/hn/fiadores_pendientes/`:
   - `load({numeroSolicitud})` lee de `AnalisisBoxServiceHn` con el `userId` actual.
   - `enviar(AnalisisFiadorHnLocalDb)` sigue los pasos de envío del scope: crear si `fiadorId` está vacío, guardar `fiadorId`, enviar la firma, subir la cédula, y borrar con `removeFiadorHnPendiente`. Si falla, deja el registro, guarda `errorMsg` y recarga.
   - `eliminar(fiador)` llama `removeFiadorHnPendiente` y recarga.
6. Crear `FiadoresHnPendientesScreen` en `screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_pendientes_screen.dart`:
   - Lleva `ScreenHeaderWidget` y la lista de pendientes en tarjetas con `RedesignColors`. Si una fila tiene `fiadorId`, muestra un `CardTagWidget` "Falta la firma".
   - "Enviar" muestra un loader en la fila y, si falla, un snackbar con el error. Sin conexión, está deshabilitado y se ve un aviso.
   - "Eliminar" pide confirmación con un diálogo.
   - Exponer `routeName`, `route()` y `open()`, como `FiadoresNiPendientesScreen`, para que el widget de envío vuelva a una lista existente en vez de apilar otra.
7. En `AnalisisFiadoresSendingWidget`, agregar `guardarLocal`. Con `true`, llama `guardarFiadorLocal` en `initState` y muestra `SendingStatusView` en ámbar (`RedesignColors.amberTint` / `amber`) con el texto de guardado. Al cerrar, reemplaza la ruta por `FiadoresHnPendientesScreen` de la solicitud. Con `false`, no cambia.
8. En `analisis_fiadores_datos_de_ingresos.dart`, el botón "Enviar" abre el widget de envío con `guardarLocal: !isConnected`.
9. En `FiadoresSearchByDocumentScreen`, sin conexión, el submit no llama `getUserByDocument`. Llama un método nuevo de `AnalisisSearchByDocumentCubit` que emite `isNewUser` con los datos tecleados, y el listener abre el formulario como hoy.
10. En `FiadoresHnScreen`:
    - Sin conexión, no llamar `checkFiadorAval` y no mostrar las etiquetas "Registrado".
    - Al tocar "Cónyuge", bloquear con el diálogo actual si `state.tieneConyugue` o `existsConyugeHnPendiente` es `true`.
    - Mostrar la fila "Pendientes en el teléfono (N)" si `getFiadoresHnPendientes` devuelve algo. Abre `FiadoresHnPendientesScreen`, y al volver recarga el conteo.
11. En `_SelectTypeAnalisis` de `analisis_solicitudes_hn_offline_screen.dart`, agregar con `Flavor.honduras` la card "Registrar Fiadores" (mismo ícono y color que el sheet online), que abre `FiadoresHnScreen(numeroSolicitud: int.parse(numeroSolicitud), tipoSolicitud: tipoSolicitud!.toTypeForInterceptorString())`. El subtítulo del encabezado de la pantalla offline suma los fiadores.
12. Actualizar `references/app-modules-reference.md`: Fiadores HN pasa a "online y offline (envío en línea)", y la nota de "Análisis offline" suma fiadores en HN.

    Agregar en `CLAUDE.md` un apartado "HN análisis: fiadores offline" con los pendientes, la carpeta de archivos y el envío en tres pasos con `fiadorId`.

## Acceptance criteria

- [ ] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [ ] En HN offline, el sheet de una solicitud muestra "Registrar Fiadores" y abre `FiadoresHnScreen` sin diálogo de error.
- [ ] En Costa Rica offline, el sheet de `AnalisisSolicitudesHnOfflineScreen` no muestra la card de fiadores.
- [ ] En NI, el flujo de fiadores (online y offline) no cambia.
- [ ] Sin conexión, en `FiadoresSearchByDocumentScreen`, tocar continuar abre el formulario con los nombres y la cédula tecleados, sin llamada HTTP.
- [ ] Sin conexión, tomar las fotos, firmar, llenar los pasos y tocar "Enviar" muestra la pantalla ámbar de "Fiador guardado en el teléfono" y no hace ninguna llamada HTTP.
- [ ] Al cerrar esa pantalla, se abre `FiadoresHnPendientesScreen` con el fiador recién guardado (nombre, cédula, tipo, fecha).
- [ ] La carpeta `fiadores_hn/<uuid>/` existe y tiene `cedula_frente.jpg`, `cedula_reverso.jpg` y `firma.png`.
- [ ] Sin conexión, "Enviar" de la fila está deshabilitado y se ve el aviso de envío en línea.
- [ ] Guardar un segundo fiador con la misma cédula en la misma solicitud muestra el error de duplicado y no crea otro registro ni otra carpeta.
- [ ] Con un cónyuge pendiente en la solicitud, tocar "Cónyuge" muestra el diálogo "No se puede crear mas de un fiador cónyuge", en línea y sin conexión.
- [ ] `FiadoresHnScreen` muestra "Pendientes en el teléfono (N)" cuando la solicitud tiene pendientes del usuario, en línea y sin conexión.
- [ ] Al cerrar y volver a abrir la app, los pendientes y sus archivos siguen ahí.
- [ ] Con otro usuario en el mismo teléfono, los pendientes del primero no aparecen.
- [ ] Con conexión, "Enviar" de un pendiente manda a `createAnalisisFiador` el mismo body que se guardó (visible en `BitacoraService`), después la firma, después el PDF de la cédula. Al terminar, la fila desaparece, se borran el registro y la carpeta, y se muestra el snackbar "Fiador enviado exitosamente".
- [ ] Si falla la creación, la fila se queda sin `fiadorId` y se muestra el mensaje del backend.
- [ ] Si la creación sale bien y falla la firma, la fila se queda con la etiqueta "Falta la firma". El siguiente "Enviar" no vuelve a crear el fiador (no hay segundo `POST` de creación en `BitacoraService`) y solo manda la firma y la cédula.
- [ ] Si falla solo la subida del PDF de la cédula, el pendiente se borra igual y el error queda en `ErrorReporter`.
- [ ] "Eliminar" pide confirmación y, al aceptar, el fiador desaparece de la lista, de ObjectBox y del disco.
- [ ] En línea, crear un fiador desde el sheet online funciona igual que hoy y no guarda nada en ObjectBox.
- [ ] El diálogo de cierre del análisis no cambia.
- [ ] Se registró un fiador offline en QA HN, se envió después en línea, y backend confirmó el fiador, la firma y la cédula en el expediente (verificación manual).

## Decisions

- **Sí:** lista de pendientes por solicitud que se envían a mano, como SPEC 03. Lo eligió el usuario. Cada fiador es un registro independiente.
- **No:** borrador automático del formulario a medio llenar. Lo descartó el usuario. Habría que rehidratar las siete páginas del `PageView`, incluidas las fotos y la firma.
- **Sí:** sin conexión se salta la búsqueda por documento y se usa lo tecleado, como `isNewUser`. Lo eligió el usuario. La búsqueda solo precarga datos.
- **Sí:** los tres tipos se habilitan offline, y cónyuge se bloquea si ya hay uno pendiente local. Lo eligió el usuario. El cónyuge que ya existe en el backend no se puede revisar sin red.
- **Sí:** guardar `fiadorId` en la fila y reintentar desde la firma. Lo eligió el usuario. Volver a crear el fiador dejaría un duplicado en el backend, y borrar el pendiente al crear dejaría un fiador sin firma.
- **No:** borrar el pendiente apenas se crea el fiador. Si la firma falla, se pierde.
- **Sí:** la subida del PDF de la cédula sigue sin bloquear. Lo eligió el usuario. Es el comportamiento de hoy en línea (SPEC 01).
- **Sí:** copiar los archivos a `fiadores_hn/<uuid>/`. Lo eligió el usuario. La firma vive hoy en el directorio temporal, que el sistema puede limpiar, y una carpeta por pendiente se borra de una sola vez.
- **No:** usar las rutas originales de las fotos y la firma.
- **Sí:** el PDF de la cédula se genera al enviar. Su nombre depende del `fiadorId`, que offline no existe.
- **Sí:** solo la card del sheet offline de HN como entrada nueva, y la fila de pendientes dentro de `FiadoresHnScreen` para enviar en línea. Lo eligió el usuario. La card del sheet online no cambia.
- **No:** "Guardar para enviar después" cuando el envío en línea falla por red. Lo descartó el usuario. El flujo en línea queda igual.
- **Sí:** bloquear la misma cédula en la misma solicitud y para el mismo usuario. Lo confirmó el usuario.
- **Sí:** los pendientes son del `userId` que los guardó, y no se borran al cerrar sesión. Lo confirmó el usuario. Evita que otro asesor envíe con su JWT un fiador que no capturó.
- **Sí:** ver, enviar y eliminar, sin editar. Lo eligió el usuario.
- **Sí:** entidad con el JSON del body más metadatos, no con columnas planas. Si cambia el DTO, no hace falta tocar la entidad ni regenerar ObjectBox. Es el patrón de SPEC 03.
- **Sí:** registrar la entidad en `AnalisisBoxServiceHn`. Los borradores de análisis HN, el plan de inversión offline y los fiadores NI ya viven ahí.
- **No:** reusar `AnalisisFiadorNiLocalDb`. El DTO de HN es otro, y HN necesita rutas de archivos y `fiadorId`.
- **No:** Costa Rica. La card offline se guarda con `Flavor.honduras`.
- **Sí:** la card offline no aparece en solicitudes grupales. Lo decidió el usuario durante la implementación: el sheet online la oculta con `if (!esGrupal)`.
- **Sí:** el conteo de "Pendientes en el teléfono (N)" escucha el box de ObjectBox (`query().watch()`), en vez de recargar solo al volver. Se decidió durante la implementación: la lista de pendientes también se abre desde la pantalla de envío, y un envío o eliminación desde ahí no pasaba por `FiadoresHnScreen`.
- **Sí:** `subirCedulaFiadorHn` es una función top-level que también recibe el `ExpedienteDigitalRepository`, porque fuera del cubit no hay otro acceso a él.
- **Sí:** en modo guardar local, cerrar la pantalla de envío con error vuelve al formulario, que conserva los datos, en vez de ir a análisis.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| Varios pendientes con fotos ocupan espacio en el teléfono | Se borran al enviar o eliminar. La limpieza por antigüedad queda fuera de esta spec. |
| El backend ya tiene un cónyuge y el asesor guarda otro offline | No se puede detectar sin red. Al enviar, el backend lo rechaza, se muestra su error y el asesor elimina el pendiente. |
| La persona ya existe en el backend y offline se capturan datos distintos a los suyos | Se acepta. La búsqueda solo precarga, y hoy el asesor también puede cambiar los datos precargados. |
| El fiador se crea, falla la firma, y el asesor elimina el pendiente | El fiador queda sin firma en el backend. El diálogo de eliminar advierte "Este fiador ya está creado en el servidor y le falta la firma" cuando la fila tiene `fiadorId`. |
| Se borra o falta un archivo de la carpeta antes de enviar | `fiadoresEnviarFirmaDigital` del cubit ya valida que la firma exista. El envío del pendiente hace la misma validación, falla con mensaje claro, y el asesor puede eliminar y recapturar. |
| La solicitud cambia de estado o se reasigna con un pendiente guardado | El envío falla, se muestra el error del backend y el pendiente se queda. |
| Un cambio futuro del DTO deja JSON viejos que `fromJson` no entiende | `fromJson` usa valores por defecto en las llaves ausentes. |
| El token vence con pendientes y al enviar sale el diálogo de re-auth | Es el flujo normal de `SessionReauthHandler`. Al autenticarse, el envío se reintenta. |
| `_formData` (subida de firma) no tiene manejo de 401 | Si la firma falla por sesión vencida, el pendiente se queda con `fiadorId` y el siguiente "Enviar" solo manda la firma. |

## What is **not** in this spec

- Borrador automático del formulario a medio llenar.
- Edición de fiadores pendientes.
- "Guardar para enviar después" cuando el envío en línea falla por red.
- Cambios en la card "Registrar Fiadores" del sheet online.
- Envío automático o pantalla global de pendientes.
- Búsqueda por documento sin conexión, y detección offline de un cónyuge que ya existe en el backend.
- Cierre del análisis que tome en cuenta los pendientes locales.
- Costa Rica, y cambios en los fiadores NI.
- Limpieza de pendientes al cerrar sesión o por antigüedad.

Cada uno, si llega, va en su propia spec.
