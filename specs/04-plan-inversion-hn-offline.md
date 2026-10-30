# SPEC 04 — Plan de inversión de análisis HN en modo offline

> **Status:** Approved
> **Depends on:** —
> **Date:** 2026-10-30
> **Objective:** Permitir que el asesor de Honduras capture el plan de inversión sin conexión desde la lista offline de análisis, con un borrador automático en ObjectBox por solicitud que se precarga en `PlanInversionScreen` y se envía a mano cuando vuelve a estar en línea.

## Por qué existe esta spec

Hoy el plan de inversión es solo en línea:

- `PlanInversionScreen` (`screens/cartera/analisis_solicitudes/hn/plan_inversion/plan_inversion_screen.dart`) guarda los artículos solo en memoria, en `AnalisisPlanInversionHnCubit`. Si el asesor sale de la pantalla o se cae el envío, pierde todo lo capturado.
- El sheet offline de HN (`_SelectTypeAnalisis` en `analisis_solicitudes_hn_offline_screen.dart`) ofrece análisis, imágenes y ubicación, pero no el plan de inversión.

El plan es una lista de artículos que se envía completa en un solo `POST` (`createAnalisisPlanInversion`, espera `201`). Por eso el modelo elegido es un borrador único por solicitud y usuario, no una lista de pendientes como los fiadores NI de SPEC 03. Es el mismo patrón que la ubicación offline de HN: se captura sin red y la pantalla de siempre toma lo guardado cuando hay red.

`PlanInversionScreen` también la abre el sheet online de NI (`select_type_analisis_modal_sheet_ni_widget.dart`). El borrador solo corre con `Flavor.honduras`, así que NI y Costa Rica no cambian.

## Scope

**In:**

- Entidad ObjectBox nueva `AnalisisPlanInversionHnLocalDb`, con la lista de artículos como JSON más metadatos. Se registra en `AnalisisBoxServiceHn`.
- `PlanInversion.fromJson` y `PlanInversion.toLocalJson()` (incluye `uuid`), para guardar y reconstruir los artículos.
- Métodos de borrador en `AnalisisBoxServiceHn`: obtener, guardar (upsert) y eliminar, por `numeroSolicitud` y `userId`.
- `AnalisisPlanInversionHnCubit`, solo con `Flavor.honduras`:
  - Al fijar el número de solicitud, carga el borrador del usuario si existe.
  - Cada `createPlanInversion`, `editPlanInversion` y `deletePlanInversion` guarda el borrador. Si la lista queda vacía, borra el registro.
  - Con `201`, borra el borrador.
  - Agrega `fechaBorrador` al state.
- `PlanInversionScreen`:
  - Si hay borrador, muestra la etiqueta "Borrador en el teléfono" con la fecha del último cambio.
  - Sin conexión (`InternetConnectionCubit.state.isConnected == false`), "Enviar" está deshabilitado y se ve un aviso ámbar: "Guardado en el teléfono. Envíalo cuando tengas conexión".
- Card "Registrar Plan de inversión" en el sheet offline de HN (`_SelectTypeAnalisis`), visible solo con `Flavor.honduras`. Abre `PlanInversionScreen`.
- Actualizar el subtítulo de `AnalisisSolicitudesHnOfflineScreen` para incluir el plan de inversión, solo con `Flavor.honduras`.
- Actualizar `references/app-modules-reference.md` y `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Plan de inversión offline o borrador en NI y Costa Rica.
- Envío automático al reconectar, o una pantalla global de borradores.
- Indicador de borrador en la card del sheet online de HN. El aviso se ve dentro de la pantalla.
- Diálogo de "continuar o descartar" al entrar, o un botón "Descartar borrador". Para descartar, el asesor elimina los artículos.
- Precargar desde el backend un plan ya registrado (`tienePlanInversion`), o editarlo.
- Decimales en precio unitario y total. Siguen con `mantissaLength: 0` y `total` entero.
- Borrar borradores al cerrar sesión o por antigüedad.
- Que el cierre del análisis tome en cuenta el borrador local. Sigue mirando `TienePlanInversion` del backend.

## Data model

```dart
// lib/src/datasource/analisis/hn/plan_inversion/local_db/analisis_plan_inversion_hn_local_db.dart
@Entity()
class AnalisisPlanInversionHnLocalDb {
  @Id()
  int id = 0;
  @Index()
  int numeroSolicitud;
  String userId;               // LocalStorage().userId
  @Property(type: PropertyType.date)
  DateTime fechaActualizacion; // último cambio, se muestra en la etiqueta
  String itemsJson;            // json.encode(planInversion.map((e) => e.toLocalJson()).toList())
}
```

```dart
// lib/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart
class PlanInversion {
  // ...campos actuales, sin cambios
  Map<String, dynamic> toLocalJson();  // toJson() + 'uuid'
  factory PlanInversion.fromJson(Map<String, dynamic> json);  // inverso de toLocalJson()
}
```

```dart
// lib/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart
late final Box<AnalisisPlanInversionHnLocalDb> analisisPlanInversionHnLocalDbBox;

AnalisisPlanInversionHnLocalDb? getPlanInversionBorrador({required int numeroSolicitud, required String userId});
void savePlanInversionBorrador({required int numeroSolicitud, required String userId, required List<PlanInversion> items});
void removePlanInversionBorrador({required int numeroSolicitud, required String userId});
```

```dart
// lib/src/presentation/bloc/analisis/hn/analisis_plan_inversion/analisis_plan_inversion_hn_state.dart
class AnalisisPlanInversionHnState {
  // ...campos actuales
  final DateTime? fechaBorrador; // null si no hay borrador guardado
}
```

Conventions:

- Hay como máximo un borrador por `numeroSolicitud` + `userId`. `savePlanInversionBorrador` busca el registro y lo actualiza. Si no existe, lo crea.
- `savePlanInversionBorrador` con una lista vacía borra el registro.
- El body del `POST` no cambia. Se sigue armando `AnalisisPlanDeInversion` con `LocalStorage().database` al momento de enviar, y `PlanInversion.toJson()` sigue sin mandar `uuid`.
- `fromJson` usa `''`/`0`/`0.0` por defecto en las llaves ausentes, y genera un `uuid` nuevo si falta.
- El borrador solo se lee y se escribe con `global<FlavorCubit>().state.flavor == Flavor.honduras`.

## Implementation plan

1. Crear `AnalisisPlanInversionHnLocalDb` en `lib/src/datasource/analisis/hn/plan_inversion/local_db/analisis_plan_inversion_hn_local_db.dart`. Registrar su box en `AnalisisBoxServiceHn`. Correr `dart run tool/build_script.dart` para regenerar `objectbox.g.dart` y `objectbox-model.json`. Verificar con `flutter analyze`.
2. Agregar `PlanInversion.toLocalJson()` y `PlanInversion.fromJson`. Sin test unitario, por decisión del usuario.
3. Agregar a `AnalisisBoxServiceHn` los métodos `getPlanInversionBorrador`, `savePlanInversionBorrador` y `removePlanInversionBorrador`.
4. En `AnalisisPlanInversionHnCubit`, solo con `Flavor.honduras`:
   - Agregar `fechaBorrador` al state.
   - En `serNumeroSolicitud`, cargar el borrador del usuario actual en `planInversion` y `fechaBorrador`.
   - Después de `createPlanInversion`, `editPlanInversion` y `deletePlanInversion`, llamar `savePlanInversionBorrador` y actualizar `fechaBorrador` (o ponerlo en `null` si la lista quedó vacía).
   - En `createAnalisisPlanInversion`, con `201`, llamar `removePlanInversionBorrador` y poner `fechaBorrador` en `null`. Si falla, el borrador se queda.
5. En `PlanInversionScreen`:
   - Si `fechaBorrador != null`, mostrar en `_ResumenInversionCard` (o debajo) un `CardTagWidget` ámbar "Borrador en el teléfono · dd/MM/yyyy HH:mm".
   - Leer `context.watch<InternetConnectionCubit>().state.isConnected`. Sin conexión, deshabilitar "Enviar" y mostrar el aviso ámbar sobre la barra inferior.
6. En `_SelectTypeAnalisis` de `analisis_solicitudes_hn_offline_screen.dart`, agregar con `Flavor.honduras` la card "Registrar Plan de inversión" (mismo ícono y color que el sheet online), que abre `PlanInversionScreen(numeroSolicitud: int.parse(numeroSolicitud))`. Con `Flavor.honduras`, el subtítulo del encabezado menciona el plan de inversión.
7. Actualizar `references/app-modules-reference.md`:
   - Agregar la fila o nota "Análisis → Plan de inversión": HN online y offline (envío en línea), NI solo online.
   - Cambiar la nota de "Análisis offline", que hoy dice que el plan de inversión no está offline en ningún país.

   Agregar en `CLAUDE.md` un apartado "HN análisis: plan de inversión offline" con el borrador por solicitud y usuario.

## Acceptance criteria

- [ ] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [ ] En HN offline, el sheet de una solicitud muestra "Registrar Plan de inversión" y abre `PlanInversionScreen`.
- [ ] En Costa Rica offline, el sheet de `AnalisisSolicitudesHnOfflineScreen` no muestra la card del plan de inversión.
- [ ] En NI offline, `AnalisisSolicitudesNiOfflineScreen` no cambia.
- [ ] Sin conexión, en HN, agregar artículos no hace ninguna llamada HTTP, "Enviar" está deshabilitado y se ve el aviso ámbar.
- [ ] Al salir de la pantalla y volver a entrar (o cerrar y abrir la app), los artículos siguen ahí y se ve la etiqueta "Borrador en el teléfono" con la fecha del último cambio.
- [ ] Editar o eliminar un artículo actualiza el borrador. Al eliminar todos, la etiqueta desaparece y el registro se borra de ObjectBox.
- [ ] Con conexión, en HN, entrar desde el sheet online a una solicitud con borrador precarga los artículos.
- [ ] Con conexión, "Enviar" manda a `POST` del plan de inversión el mismo body que hoy (sin `uuid`, visible en `BitacoraService`). Con `201`, se borra el borrador y se muestra el diálogo de éxito actual.
- [ ] Si el envío falla (red o backend), el borrador se queda y al volver a entrar los artículos siguen ahí.
- [ ] Con otro usuario en el mismo teléfono, el borrador del primero no se precarga.
- [ ] En NI online, `PlanInversionScreen` no guarda nada en ObjectBox y al salir y volver a entrar la lista está vacía, como hoy.
- [ ] Se capturó un plan de inversión offline en QA HN, se envió después en línea, y backend lo confirmó (verificación manual).

## Decisions

- **Sí:** borrador único por solicitud y usuario que se precarga en `PlanInversionScreen`. Lo eligió el usuario. Reusa la pantalla actual y el plan se envía completo en un solo `POST`.
- **No:** pantalla de pendientes aparte como los fiadores NI. Los fiadores son registros independientes; el plan es una sola lista por solicitud.
- **No:** envío automático al reconectar. Los errores de backend quedarían ocultos.
- **Sí:** borrador automático siempre, con o sin conexión. Lo eligió el usuario. Cubre el corte de red durante el envío y también salir de la pantalla por error, sin un botón extra de "Guardar para enviar después".
- **No:** distinguir error de red y de backend en el envío (`isNetworkError` de SPEC 03). Con el borrador automático, el plan ya está guardado en cualquier caso.
- **Sí:** solo Honduras, tanto la card offline como el borrador. Lo eligió el usuario. Costa Rica comparte `AnalisisSolicitudesHnOfflineScreen` y NI comparte `PlanInversionScreen`, así que ambos quedan guardados con `Flavor.honduras`.
- **Sí:** el borrador es del `userId` que lo guardó y no se borra al cerrar sesión. Igual que SPEC 03: evita que otro asesor envíe con su JWT un plan que no capturó.
- **Sí:** sin conexión, "Enviar" deshabilitado más un aviso ámbar. Lo eligió el usuario. El guardado ya es automático y un botón "Guardar en el teléfono" sería redundante.
- **Sí:** precarga directa con la etiqueta "Borrador en el teléfono". Lo eligió el usuario. Para descartar, se eliminan los artículos.
- **No:** indicador de borrador en la card del sheet online. Lo eligió el usuario. Se ve al entrar.
- **Sí:** guardar los artículos como JSON en una sola entidad, no una fila por artículo. Si cambia `PlanInversion`, no hace falta tocar la entidad ni regenerar ObjectBox.
- **Sí:** `toLocalJson()` separado de `toJson()`. El `uuid` hace falta en local para editar y eliminar, pero el backend no lo recibe hoy y el body no debe cambiar.
- **Sí:** registrar la entidad en `AnalisisBoxServiceHn`. Los borradores de análisis HN y la ubicación offline ya viven ahí.
- **Sí:** `database` se toma de `LocalStorage()` al enviar, no al guardar. El body se arma igual que hoy.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| El backend ya tiene un plan para la solicitud (`tienePlanInversion`) y el asesor envía el borrador | Es el comportamiento de hoy en línea: el sheet no bloquea la card. Si el backend lo rechaza, se muestra su error y el borrador se queda para que el asesor lo elimine. |
| La solicitud cambia de estado o se reasigna con un borrador guardado | El envío falla, se muestra el error del backend y el borrador se queda. El asesor puede eliminar los artículos. |
| Un borrador queda olvidado en el teléfono | Se acepta. La limpieza por antigüedad o al cerrar sesión queda fuera de esta spec. |
| Un cambio futuro de `PlanInversion` deja JSON viejos que `fromJson` no entiende | `fromJson` usa valores por defecto y genera `uuid` si falta. |
| `PlanInversionScreen` se abre en NI y el borrador se cuela por un guard olvidado | Todo acceso al borrador pasa por el cubit, con un solo chequeo de `Flavor.honduras`. Hay un criterio de aceptación para NI online. |
| El token vence con un borrador guardado y al enviar sale el diálogo de re-auth | Es el flujo normal de `SessionReauthHandler`. Al autenticarse, el envío se reintenta. |

## What is **not** in this spec

- Plan de inversión offline o borrador en NI y Costa Rica.
- Envío automático o pantalla global de borradores.
- Indicador de borrador en el sheet online, diálogo de descartar o botón "Descartar borrador".
- Precarga o edición del plan ya registrado en el backend.
- Decimales en precio unitario y total.
- Limpieza de borradores al cerrar sesión o por antigüedad.
- Cierre del análisis que tome en cuenta el borrador local.

Cada uno, si llega, va en su propia spec.
