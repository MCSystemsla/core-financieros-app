# SPEC 06 — Análisis HN offline para solicitudes sin número

> **Status:** Implemented
> **Depends on:** SPEC 04, SPEC 05
> **Date:** 2026-10-30
> **Objective:** Permitir que el asesor de Honduras haga sin conexión el análisis, el plan de inversión, los fiadores, las imágenes y la ubicación de una solicitud que creó offline y todavía no tiene número, y que al abrir después la solicitud AUT con la misma cédula y tipo la app ofrezca pasarle esos datos.

## Por qué existe esta spec

El flujo de crédito en HN es: el asesor crea la solicitud, la solicitud llega al backend, el jefe la autoriza (AUT) y recién ahí se hace el análisis. En zonas sin señal, el asesor crea la solicitud offline (`SolicitudNuevaMenorHnLocalDb`, `SolicitudAsalariadoHnDbLocal`, `SolicitudReprestamoHnLocalDb`), pero no puede hacer el análisis:

- La lista "Análisis offline" (`AnalisisSolicitudesHnOfflineScreen`) solo muestra `AnalisisListDataHn`, que llena el sync con las solicitudes asignadas. Una solicitud que no se ha enviado no aparece.
- Todos los borradores locales del análisis usan `numeroSolicitud` como llave: los formularios (`NuevaMenorMilLocalDb`, `AnalisisNuevaMayorAMilHnLocalDb`, `AnalisisAsalariadoHnLocalDb`, `AnalisisReprestamoHnLocalDb`), sus tablas compartidas (ciclos, activos, pasivos, inventario, etc.), `AnalisisPlanInversionHnLocalDb`, `AnalisisFiadorHnLocalDb`, `ImagenesNegocioHnLocalDb` y `UbicacionClienteHnLocalDb`. Sin número no hay llave.

El backend no puede guardar un identificador local de la solicitud. Por eso el vínculo es por cédula y tipo, y lo confirma el asesor.

## Scope

**In:**

- Entidad ObjectBox nueva `AnalisisBorradorSinNumeroHnLocalDb`, registrada en `AnalisisBoxServiceHn`. Cada fila es un borrador sin número y su `id` da el número provisional (`-id`).
- Los borradores sin número usan como `numeroSolicitud` el número provisional negativo en todas las tablas actuales. Las queries existentes no cambian.
- `AnalisisSolicitudesHnOfflineScreen`, solo con `Flavor.honduras`, muestra además:
  - Las solicitudes locales HN terminadas (`isDone == true`) de tipo nueva, asalariado y represtamo. Las grupales no.
  - Los borradores sin número cuya solicitud local ya se borró (limpieza de 30 días).
  - Se ocultan las que ya tienen una solicitud AUT en `AnalisisListDataHn` con la misma cédula y el mismo tipo base.
  - Cada card lleva el tag "Sin número" y abre el mismo sheet `_SelectTypeAnalisis`, con el número provisional.
- Al tocar una de esas cards, se busca o se crea su `AnalisisBorradorSinNumeroHnLocalDb` antes de abrir el sheet.
- Con número provisional (`numeroSolicitud < 0`), ningún módulo llama al backend, haya o no conexión:
  - Formularios de análisis HN (menor mil, mayor mil, asalariado, represtamo): el envío del último paso queda deshabilitado.
  - `PlanInversionScreen`: "Enviar" deshabilitado.
  - Fiadores: "Enviar" del formulario siempre guarda local (`guardarLocal: true`), y "Enviar" en `FiadoresHnPendientesScreen` queda deshabilitado.
  - Imágenes y ubicación: solo guardan local.
  - En todos, aviso ámbar: "Esta solicitud aún no tiene número. Se envía cuando esté autorizada".
- Diálogo `UsarBorradorSinNumeroDialog`, solo con `Flavor.honduras`, que sale al tocar una solicitud AUT no grupal con un borrador del usuario con la misma cédula y el mismo tipo base. Sale en dos lugares, antes de abrir el sheet:
  - `AnalisisCreditCardHn` (lista online de análisis HN).
  - `AnalisisCreditoOfflineCard` (lista "Análisis offline", filas que vienen del sync).
- El diálogo tiene tres botones:
  - "Usar": vincula el borrador y luego abre el sheet.
  - "Ahora no": abre el sheet sin tocar el borrador. La próxima vez vuelve a preguntar.
  - "Descartar": pide confirmación, borra el borrador y todos sus datos, y abre el sheet.
- Vínculo, por módulo (análisis, plan de inversión, fiadores, imágenes, ubicación):
  - Si el número real ya tiene datos locales en ese módulo, se quedan esos y los del borrador se descartan.
  - Si no tiene, los datos del borrador pasan al número real.
  - Si el monto de la AUT cambia el formulario de análisis (menor ↔ mayor de mil, según `getTipoSolicitud`), el análisis del borrador se descarta. Plan, fiadores, imágenes y ubicación se vinculan igual.
  - Todo corre en una sola transacción de ObjectBox. Al final se borra la fila del borrador.
  - Después se muestra un resumen: qué módulos se pasaron y cuáles no, y por qué ("ya tenía datos" o "el monto cambió, el análisis debe hacerse de nuevo").
- El envío sigue siendo manual. Después de vincular, cada módulo se envía con su flujo de hoy.
- Los borradores son del `userId` que los creó. No se borran al cerrar sesión ni por antigüedad.
- Actualizar `references/app-modules-reference.md` y `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Vínculo automático, sin preguntar al asesor.
- Enviar al backend un identificador local de la solicitud.
- Elegir a mano entre varias solicitudes AUT, o vincular con una solicitud de otro tipo.
- Solicitudes grupales.
- Garantías y otros archivos offline.
- NI y Costa Rica.
- Envío automático al reconectar, o una pantalla global de borradores.
- Detectar que el jefe rechazó la solicitud. El asesor descarta el borrador a mano.
- Mezclar datos del borrador con los del número real dentro de un mismo módulo.
- Limpieza de borradores sin número por antigüedad o al cerrar sesión.

## Data model

```dart
// lib/src/datasource/analisis/hn/borrador_sin_numero/local_db/analisis_borrador_sin_numero_hn_local_db.dart
@Entity()
class AnalisisBorradorSinNumeroHnLocalDb {
  @Id()
  int id = 0;                   // número provisional = -id
  @Index()
  String solicitudLocalUuid;    // uuid de la solicitud local; '' si ya no existe
  String userId;                // LocalStorage().userId
  String cedula;                // normalizada: sin guiones ni espacios
  String tipoSolicitud;         // NUEVAMENOR | ASALARIADO | REPRESTAMO
  double monto;                 // monto de la solicitud local, para elegir el formulario
  String nombreCompleto;        // para la card; la cédula si la solicitud no trae nombre
  @Property(type: PropertyType.date)
  DateTime fechaCreacion;

  int get numeroProvisional => -id;
}
```

```dart
// lib/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart
late final Box<AnalisisBorradorSinNumeroHnLocalDb> analisisBorradorSinNumeroHnBox;

AnalisisBorradorSinNumeroHnLocalDb getOrCreateBorradorSinNumero({
  required String solicitudLocalUuid,
  required String userId,
  required String cedula,
  required String tipoSolicitud,
  required double monto,
  required String nombreCompleto,
});
List<AnalisisBorradorSinNumeroHnLocalDb> getBorradoresSinNumero({required String userId});
AnalisisBorradorSinNumeroHnLocalDb? findBorradorSinNumero({
  required String userId,
  required String cedula,
  required String tipoSolicitud,
});
Set<ModuloBorradorHn> modulosConDatos({required int numeroSolicitud});
VinculoBorradorResultado vincularBorradorSinNumero({
  required AnalisisBorradorSinNumeroHnLocalDb borrador,
  required int numeroReal,
  required bool descartarAnalisis,   // true si cambió el formulario
});
Future<void> descartarBorradorSinNumero(AnalisisBorradorSinNumeroHnLocalDb borrador);
```

```dart
// lib/src/datasource/analisis/hn/borrador_sin_numero/modulo_borrador_hn.dart
enum ModuloBorradorHn { analisis, planInversion, fiadores, imagenes, ubicacion }

class VinculoBorradorResultado {
  final Set<ModuloBorradorHn> vinculados;
  final Set<ModuloBorradorHn> conDatosPrevios;   // gana el número real
  final bool analisisDescartadoPorMonto;
}
```

Conventions:

- Un borrador por `userId` + cédula + tipo base. `getOrCreateBorradorSinNumero` busca primero por `solicitudLocalUuid` y después por esa terna.
- El tipo base de la solicitud local sale de su box: `SolicitudNuevaMenorHnLocalDb` → `NUEVAMENOR`, `SolicitudAsalariadoHnDbLocal` → `ASALARIADO`, `SolicitudReprestamoHnLocalDb` → `REPRESTAMO`. Es el mismo código que trae `AnalisisListDataHn.tipoSolicitud`.
- Las cédulas se comparan normalizadas (sin `-` ni espacios) en los dos lados.
- El módulo "análisis" agrupa las tablas de formulario (`NuevaMenorMilLocalDb`, `AnalisisNuevaMayorAMilHnLocalDb`, `AnalisisAsalariadoHnLocalDb`, `AnalisisReprestamoHnLocalDb`) y sus tablas compartidas: `AnalisisCicloVentaHnLocalDb`, `AnalisisCicloComprasSemanalesHnLocalDb`, `AnalisisNivelProduccionLocalDb`, `AnalisisCuentasPorCobrarHn`, `AnalisisComprasProveedorArticuloHnLocalDb`, `AnalisisCostoDePersonalHnLocalDb`, `AnalisisIngresosFamiliaresFueraNegocioHnLocalDb`, `AnalisisOtrosCreditoHnLocalDb`, `AnalisisPasivoHnLocalDb`, `AnalisisActivoHnLocalDb` y `AnalisisInventarioHnLocalDb`.
- `ImagenesNegocioHnLocalDb` y `UbicacionClienteHnLocalDb` guardan `numeroSolicitud` como `String`. El provisional se guarda como `'-<id>'`.
- Al descartar los fiadores de un borrador se usa `removeFiadorHnPendiente`, que también borra la carpeta `fiadores_hn/<uuid>/`.
- El formulario de análisis se compara con `getTipoSolicitud(tipoSolicitud, monto, esGrupal: false)` usando el monto del borrador contra el monto de la AUT.

## Implementation plan

1. Crear `AnalisisBorradorSinNumeroHnLocalDb`, `ModuloBorradorHn` y `VinculoBorradorResultado` en `lib/src/datasource/analisis/hn/borrador_sin_numero/`. Registrar el box en `AnalisisBoxServiceHn`. Correr `dart run tool/build_script.dart` para regenerar `objectbox.g.dart` y `objectbox-model.json`. Verificar con `flutter analyze`.
2. Agregar a `AnalisisBoxServiceHn` `getOrCreateBorradorSinNumero`, `getBorradoresSinNumero` y `findBorradorSinNumero`, con la normalización de cédula.
3. Agregar a `AnalisisBoxServiceHn` `modulosConDatos(numeroSolicitud)`, que revisa las tablas de cada `ModuloBorradorHn`.
4. Agregar `descartarBorradorSinNumero`: borra los datos del número provisional en todas las tablas (fiadores con `removeFiadorHnPendiente`) y la fila del borrador.
5. Agregar `vincularBorradorSinNumero`: dentro de `_store.runInTransaction`, por cada módulo con datos en el provisional, si el número real no tiene datos en ese módulo cambia `numeroSolicitud` al real. Si los tiene, o si es análisis con `descartarAnalisis`, borra los del provisional. Las carpetas de fiadores descartados se borran después de la transacción. Al final borra la fila del borrador y devuelve el `VinculoBorradorResultado`.
6. En `AnalisisSolicitudesHnOfflineScreen`, solo con `Flavor.honduras`:
   - Armar la lista de solicitudes locales: terminadas de `SolicitudesHnBoxService` (nueva, asalariado, represtamo), del usuario cuando la entidad tiene `userId`, más los borradores de `getBorradoresSinNumero` sin solicitud local.
   - Quitar las que coinciden en cédula y tipo base con una fila de `AnalisisListDataHn`.
   - Mostrarlas después de las del sync con `AnalisisCreditoOfflineCard`, con el tag "Sin número" en lugar de "Solicitud N.".
   - Al tocar, llamar `getOrCreateBorradorSinNumero` y abrir `_SelectTypeAnalisis` con `numeroSolicitud: '${borrador.numeroProvisional}'` y el tipo de `getTipoSolicitud` con el monto local.
7. Agregar el aviso ámbar compartido `SinNumeroNoticeWidget` en `widgets/analisis_solicitudes/hn/borrador_sin_numero/`. Con `numeroSolicitud < 0`:
   - En `PlanInversionScreen`, deshabilitar "Enviar" y mostrar el aviso.
   - En `FiadoresHnPendientesScreen`, deshabilitar "Enviar" y mostrar el aviso.
   - En el último paso de fiadores, abrir `AnalisisFiadoresSendingWidget` con `guardarLocal: true`.
8. Con `numeroSolicitud < 0`, en el último paso de los formularios de análisis HN (menor mil, mayor mil, asalariado, represtamo), deshabilitar el envío y mostrar el aviso. En `ImagenesNegocioHnScreen` y `UbicacionClienteOfflineHnScreen`, no llamar al backend y mostrar el aviso.
9. Crear `UsarBorradorSinNumeroDialog` en `widgets/analisis_solicitudes/hn/borrador_sin_numero/`, con `RedesignColors`. Muestra nombre, cédula, tipo y fecha del borrador, y los botones "Usar", "Ahora no" y "Descartar". "Descartar" pide confirmación. Después de "Usar", muestra el resumen del `VinculoBorradorResultado`.
10. Crear la función `ofrecerBorradorSinNumeroHn(context, {cedula, tipoSolicitud, monto, numeroSolicitud, esGrupal})` en el mismo directorio. Si no es Honduras, es grupal o no hay borrador, no hace nada. Si hay, muestra el diálogo y ejecuta la acción elegida.
11. Llamar `ofrecerBorradorSinNumeroHn` antes de abrir el sheet en `AnalisisCreditCardHn._openAnalisisSheet` y en `AnalisisCreditoOfflineCard._openAnalisisSheet` (solo en las filas del sync).
12. Actualizar `references/app-modules-reference.md`: la nota de "Análisis offline" en HN suma las solicitudes sin número. Agregar en `CLAUDE.md` un apartado "HN análisis: solicitudes sin número" con el número provisional, el diálogo y la regla de vínculo.

## Acceptance criteria

- [X] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [X] En HN, sin conexión, una solicitud nueva creada offline y terminada aparece en "Análisis offline" con el tag "Sin número".
- [X] Una solicitud local a medio llenar (`isDone == false`) no aparece.
- [X] Una solicitud grupal no aparece como local.
- [X] Tocar la card abre el sheet con análisis, plan de inversión, fiadores, imágenes y ubicación.
- [X] El análisis abre el formulario que corresponde al monto local (menor o mayor de mil).
- [X] Con número provisional, guardar datos en los cinco módulos no hace ninguna llamada HTTP, aunque haya conexión (visible en `BitacoraService`).
- [X] Con número provisional, todos los botones de envío están deshabilitados y se ve el aviso "Esta solicitud aún no tiene número".
- [X] Al cerrar y abrir la app, el borrador y sus datos siguen ahí.
- [X] Con otro usuario en el mismo teléfono, los borradores del primero no aparecen ni se ofrecen.
- [X] Después de la limpieza de 30 días de la solicitud local, el borrador sigue en la lista.
- [X] Cuando el sync trae la AUT con la misma cédula y tipo, la solicitud local desaparece de la lista y queda solo la AUT.
- [X] Tocar la AUT (online u offline) muestra el diálogo "¿Usar datos guardados?".
- [X] Una AUT con la misma cédula y otro tipo no muestra el diálogo.
- [X] Una AUT grupal no muestra el diálogo.
- [X] "Usar" pasa los datos al número real. Al entrar a cada módulo desde la AUT se ven los datos capturados offline. El borrador desaparece.
- [X] Si el número real ya tenía datos en un módulo, se quedan esos y el resumen lo dice.
- [X] Si el monto de la AUT cambia el formulario, el análisis no se pasa, el resumen muestra "el monto cambió, el análisis debe hacerse de nuevo", y los demás módulos sí se pasan.
- [X] "Ahora no" abre el sheet sin cambiar nada, y la próxima vez el diálogo vuelve a salir.
- [X] "Descartar" pide confirmación y borra el borrador, sus datos y las carpetas de fiadores.
- [X] Después de vincular, cada módulo se envía con su flujo de hoy y backend recibe el número real.
- [X] En NI y Costa Rica no aparecen solicitudes locales en la lista ni el diálogo.
- [X] Se creó una solicitud offline en QA HN, se hizo el análisis offline, el jefe la autorizó, se vinculó con "Usar", y backend confirmó el análisis, el plan, los fiadores, las imágenes y la ubicación con el número real (verificación manual).

## Decisions

- **Sí:** vínculo por cédula + tipo base, confirmado por el asesor. Lo eligió el usuario. El backend no puede guardar un identificador local.
- **No:** mandar el `uuid` de la solicitud local al backend. El backend no lo soporta.
- **No:** vínculo automático o con reglas de fecha y monto. Lo descartó el usuario por ser más complejo. El asesor decide al abrir la AUT.
- **Sí:** número provisional negativo (`-id` del borrador) en las tablas actuales. Lo eligió el usuario. No cambia ninguna query. Vincular es reescribir un número.
- **No:** agregar la cédula a las ~20 entidades. Más cambios y más riesgo.
- **Sí:** el `id` del borrador da el provisional, no el `id` de la solicitud local. Los ids de las tres boxes de solicitudes se repiten entre sí.
- **Sí:** la entrada es la lista "Análisis offline". Lo eligió el usuario. Reusa el sheet y las pantallas de siempre.
- **Sí:** el diálogo sale en la lista online y en la offline. Lo eligió el usuario.
- **Sí:** cédula + tipo base para ofrecer el borrador. Lo eligió el usuario. Evita ofrecer un borrador de nueva en un represtamo del mismo cliente.
- **Sí:** tres botones: "Usar", "Ahora no" y "Descartar". Lo eligió el usuario. Un "No" que borra perdería trabajo por un toque.
- **Sí:** si cambia el formulario por el monto, el análisis se descarta y lo demás se vincula. Lo eligió el usuario. El borrador quedaría en una tabla que el formulario nuevo no lee.
- **Sí:** si el número real ya tiene datos en un módulo, gana el real, con resumen. Lo eligió el usuario.
- **No:** mezclar datos del borrador y del real dentro de un módulo. Puede duplicar fiadores o artículos.
- **Sí:** con provisional, ningún envío al backend, aunque haya conexión, con aviso ámbar. Lo eligió el usuario. Evita mandar un número negativo.
- **Sí:** solo solicitudes locales terminadas (`isDone == true`). Lo eligió el usuario.
- **Sí:** ocultar las solicitudes locales que ya tienen una AUT con la misma cédula y tipo en la lista del sync. Lo eligió el usuario. Evita ver dos veces al cliente.
- **Sí:** el borrador guarda su propia cédula, tipo, monto y nombre, y no se borra con la limpieza de 30 días ni al cerrar sesión. Lo eligió el usuario. Es el criterio de SPEC 04 y SPEC 05.
- **No:** grupales. No se crean offline y no llevan fiadores.
- **Sí:** solo Honduras. Lo eligió el usuario. Costa Rica comparte `AnalisisSolicitudesHnOfflineScreen`, así que todo se guarda con `Flavor.honduras`.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| El cliente tiene otra solicitud AUT del mismo tipo y el asesor toca "Usar" en la equivocada | El diálogo muestra nombre, cédula, tipo y fecha del borrador. Si se vincula mal, se ven los datos en la solicitud equivocada y el asesor no los envía. |
| El jefe rechaza la solicitud y el borrador queda en la lista | Se acepta. El asesor lo descarta con "Descartar" desde el diálogo o lo deja. La detección del rechazo queda fuera. |
| `SolicitudReprestamoHnLocalDb` no tiene `userId` | En la lista se muestran los represtamos locales sin filtro de usuario, igual que en `SolicitudesPendientesScreenHN`. El borrador sí guarda el `userId` desde que se crea. |
| Un módulo envía al backend con número negativo por un guard olvidado | Hay un criterio de aceptación con `BitacoraService` para cada módulo, con conexión. |
| La transacción de vínculo falla a medias | `runInTransaction` deja todo como estaba. Las carpetas de fiadores se borran solo después de que la transacción termina. |
| La AUT tiene otro monto pero el mismo formulario | Se vincula todo. El análisis guarda los números capturados, y el asesor los revisa antes de enviar. |
| Un borrador queda olvidado en el teléfono | Se acepta. La limpieza queda fuera de esta spec. |
| El provisional de imágenes o ubicación (`String`) choca con un número real | Los números reales son positivos y el provisional siempre lleva `-`. |

## What is **not** in this spec

- Vínculo automático o con identificador local en el backend.
- Elegir entre varias solicitudes AUT o vincular con otro tipo.
- Grupales, garantías y otros archivos.
- NI y Costa Rica.
- Envío automático o pantalla global de borradores.
- Detección de solicitudes rechazadas.
- Mezcla de datos dentro de un módulo.
- Limpieza de borradores por antigüedad o al cerrar sesión.

Cada uno, si llega, va en su propia spec.
