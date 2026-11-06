# SPEC 08 — Análisis NI offline para solicitudes sin número

> **Status:** Implemented
> **Depends on:** SPEC 03, SPEC 06
> **Date:** 2026-11-06
> **Objective:** Llevar a Nicaragua el flujo de SPEC 06: el asesor hace sin conexión el análisis, el plan de inversión, los fiadores, las imágenes y la ubicación de una solicitud que creó offline y todavía no tiene número, y al abrir después la solicitud AUT con la misma cédula y tipo la app ofrece pasarle esos datos.

## Por qué existe esta spec

SPEC 06 resolvió esto solo para Honduras. En NI pasa lo mismo: el asesor crea la solicitud offline (`ResponseLocalDb`, `AsalariadoResponsesLocalDb`, `ReprestamoResponsesLocalDb` en `ObjectBoxService`), pero "Análisis offline" (`AnalisisSolicitudesNiOfflineScreen`) solo lista las AUT que bajó el sync.

Casi todo se reusa de SPEC 06:

- Los formularios de análisis NI ya guardan en las tablas HN (`NuevaMenorMilLocalDb`, `AnalisisNuevaMayorAMilHnLocalDb`, `AnalisisAsalariadoHnLocalDb`, `AnalisisReprestamoHnLocalDb` y sus tablas compartidas).
- Plan de inversión, imágenes y ubicación usan las mismas pantallas y tablas que HN. Ya respetan `numeroSolicitud < 0`.
- `AnalisisBorradorSinNumeroHnLocalDb`, `getOrCreateBorradorSinNumero`, `vincularBorradorSinNumero` y los diálogos no dependen del país.

NI no tiene grupales.

## Scope

**In:**

- `AnalisisSolicitudesNiOfflineScreen` lista además las solicitudes NI locales terminadas (`isDone`), de tipo nueva (`NUEVAMENOR`), asalariado (`ASALARIADO`) y represtamo (`REPRESTAMO`), más los borradores huérfanos. Se ocultan las que ya tienen una AUT en `AnalisisListDataHn` con la misma cédula normalizada y el mismo tipo. Tienen el tag "Sin número" y abren el sheet offline de NI con el número provisional.
- Los 4 formularios de análisis NI (menor mil, mayor mil, asalariado, represtamo) deshabilitan "Enviar Analisis" y muestran `SinNumeroNoticeWidget` cuando `numeroSolicitud < 0`.
- Fiadores NI: con número provisional, el formulario siempre guarda local (`guardarLocal: true`), y `FiadoresNiPendientesScreen` deshabilita "Enviar" y muestra el aviso.
- El módulo `fiadores` de `modulosConDatos`, `vincularBorradorSinNumero` y `descartarBorradorSinNumero` incluye `AnalisisFiadorNiLocalDb`. Los fiadores NI no tienen archivos.
- `ofrecerBorradorSinNumeroHn` corre en HN y NI (`usaBorradorSinNumero`). Para decidir si cambió el formulario usa el `getTipoSolicitud` de NI (umbral 1000).
- El diálogo sale en `AnalisisCreditCard` (lista online NI, ahora recibe `monto`) y en las filas del sync de `AnalisisSolicitudesNiOfflineScreen`.
- Al enviar un fiador pendiente (HN y NI), `NumeroSolicitud` del payload se toma de la fila. Antes, un fiador vinculado se enviaba con el número provisional guardado en `payloadJson`.

**Out of scope:**

- Costa Rica.
- Grupales (NI no tiene).
- Lo mismo que SPEC 06: vínculo automático, envío automático, detección de rechazos y limpieza de borradores.

## Decisions

- **Sí:** reusar la entidad `AnalisisBorradorSinNumeroHnLocalDb` y `AnalisisBoxServiceHn`, como hacen los fiadores NI de SPEC 03. No hay que regenerar ObjectBox.
- **Sí:** filtrar por `isDone` sin filtro de usuario. Las solicitudes NI locales no tienen `userId`. El borrador sí guarda el `userId`.
- **Sí:** corregir el `NumeroSolicitud` del payload de los fiadores pendientes en el envío y no al vincular. Cubre HN y NI sin migrar los JSON guardados.

## Acceptance criteria

- [ ] `flutter analyze` no reporta issues nuevos.
- [ ] En NI offline, una solicitud nueva/asalariado/represtamo creada offline y terminada aparece con el tag "Sin número".
- [ ] Con número provisional, ningún módulo llama al backend, aunque haya conexión (verificar en `BitacoraService`).
- [ ] Con número provisional, los 4 formularios de análisis, el plan y los fiadores pendientes tienen "Enviar" deshabilitado con el aviso ámbar.
- [ ] Al tocar la AUT con la misma cédula y tipo (online u offline) sale "¿Usar datos guardados?". "Usar" mueve análisis, plan, fiadores, imágenes y ubicación.
- [ ] Un fiador NI vinculado se envía con el número real.
- [ ] Si el monto de la AUT cruza 1000 respecto al local, el análisis se descarta y el resto se vincula.
- [ ] En Costa Rica no aparece nada de esto.
- [ ] Verificación manual en QA NI.
