# SPEC 07 — Análisis grupal HN offline para solicitudes sin número

> **Status:** Implemented
> **Depends on:** SPEC 06
> **Date:** 2026-10-30
> **Objective:** Extender SPEC 06 a las solicitudes grupales creadas offline sin número, para que abran el análisis grupal con el número provisional y al abrir la solicitud grupal AUT del mismo cliente la app ofrezca pasarle los datos.

## Por qué existe esta spec

SPEC 06 dejó fuera las solicitudes grupales ("**No:** grupales"), y después de implementarla se agregó un filtro en `_getSolicitudesSinNumero` (`analisis_solicitudes_hn_offline_screen.dart`) que las oculta. Pero las grupales sí se crean offline:

- Los formularios offline de nueva (`nueva_menor_offline_hn_1.dart`) y asalariado (`solicitud_asalariado_offline_1.dart`) preguntan "¿La solicitud es de tipo Grupal?" y guardan `grupoCodigo`, `grupoCodigoNombre`, `cargoGrupoCodigo` y `cargoGrupoNombre`, con los catálogos `gruposActivos` y `cargosDisponibles` del sync HN. Las no grupales guardan `grupoCodigo: ''`.
- Represtamo no tiene campos de grupo.

`AnalisisGrupaHnForm` ya trabaja por `numeroSolicitud` con autosave en `AnalisisGrupalHnLocalDb` y no llama al backend al abrir, así que funciona con un número provisional. Lo que falta es reconocerlas en la lista, distinguir el borrador grupal del individual, bloquear su envío y sumar su tabla al vínculo.

## Scope

**In:**

- Campo nuevo `esGrupal` en `AnalisisBorradorSinNumeroHnLocalDb` (por defecto `false`).
- Llave del borrador:
  - Individual: `userId` + cédula + tipo base + `esGrupal == false` (igual que SPEC 06).
  - Grupal: `userId` + cédula + `esGrupal == true`, sin mirar el tipo.
- `AnalisisSolicitudesHnOfflineScreen`, solo con `Flavor.honduras`:
  - Quitar el filtro `_noEsGrupal` y marcar como grupales las solicitudes locales nueva y asalariado con `grupoCodigo` no vacío.
  - Ocultar una grupal local si `AnalisisListDataHn` tiene una AUT con la misma cédula y `esSolicitudGrupal == true`. Las individuales se ocultan solo contra AUT no grupales.
  - Las grupales abren el sheet con `getTipoSolicitud(esGrupal: true)`, que lleva a `AnalisisGrupaHnForm`.
  - La card de una grupal sin número suma el tag "Grupal".
- El sheet offline ofrece para una grupal sin número lo mismo que el sheet online grupal: análisis, plan de inversión, imágenes y ubicación. Sin fiadores (ya se ocultan con `tipoSolicitud == grupal`) y sin supervisión grupal.
- Con número provisional, el botón de envío de `AnalisisGrupaHnForm` (el que abre `GrupalSendingAnalisisHn`) queda deshabilitado y se ve `SinNumeroNoticeWidget`.
- `AnalisisGrupalHnLocalDb` entra al módulo `ModuloBorradorHn.analisis` en `modulosConDatos`, `_moverModulo` y `_borrarModulo`.
- Al vincular, la fila de `AnalisisGrupalHnLocalDb` toma el `tipoSolicitud` de la AUT.
- `ofrecerBorradorSinNumeroHn`:
  - Ya no sale con `esGrupal`. Busca el borrador con el `esGrupal` de la AUT.
  - Con `esGrupal`, el análisis nunca se descarta por monto.
- Actualizar `references/app-modules-reference.md` y `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Crear grupos offline (`POST /cartera/grupales/crear-grupo`).
- Supervisión grupal offline (necesita `cicloGrupoId` del backend).
- Represtamos grupales.
- Vincular un borrador grupal con una AUT individual, o al revés.
- Limpiar los borradores grupales que se hayan creado como individuales antes de esta spec (casos de QA).
- Todo lo que SPEC 06 ya dejó fuera.

## Data model

```dart
// lib/src/datasource/analisis/hn/borrador_sin_numero/local_db/analisis_borrador_sin_numero_hn_local_db.dart
@Entity()
class AnalisisBorradorSinNumeroHnLocalDb {
  // ...campos de SPEC 06, sin cambios
  bool esGrupal = false;   // nuevo
}
```

```dart
// lib/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart
AnalisisBorradorSinNumeroHnLocalDb getOrCreateBorradorSinNumero({
  // ...parámetros de SPEC 06
  required bool esGrupal,              // nuevo
});
AnalisisBorradorSinNumeroHnLocalDb? findBorradorSinNumero({
  required String userId,
  required String cedula,
  required String tipoSolicitud,       // se ignora con esGrupal
  required bool esGrupal,              // nuevo
});
Future<VinculoBorradorResultado> vincularBorradorSinNumero({
  required AnalisisBorradorSinNumeroHnLocalDb borrador,
  required int numeroReal,
  required bool descartarAnalisis,
  required String tipoSolicitudReal,   // nuevo; se escribe en AnalisisGrupalHnLocalDb.tipoSolicitud
});
```

```dart
// lib/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_hn_offline_screen.dart
class _SolicitudSinNumero {
  // ...campos de SPEC 06
  final bool esGrupal;                 // nuevo: grupoCodigo no vacío
  String get llave;                    // '<cedula>|G' si esGrupal, '<cedula>|<tipo>' si no
}
```

Conventions:

- Una solicitud local es grupal si `grupoCodigo?.trim().isNotEmpty == true`. Solo aplica a `SolicitudNuevaMenorHnLocalDb` y `SolicitudAsalariadoHnDbLocal`.
- Una AUT es grupal si `AnalisisListDataHn.esSolicitudGrupal` (offline) o `esGrupal` de la card (online).
- El borrador grupal guarda igual `tipoSolicitud` (NUEVAMENOR o ASALARIADO) para la card y para el formulario, pero no lo usa en la llave.
- Agregar `esGrupal` es un cambio aditivo de ObjectBox: las filas existentes quedan con `false`.

## Implementation plan

1. Agregar `bool esGrupal = false` a `AnalisisBorradorSinNumeroHnLocalDb`. Correr `dart run tool/build_script.dart` para regenerar `objectbox.g.dart` y `objectbox-model.json`. Verificar con `flutter analyze`.
2. En `AnalisisBoxServiceHn`:
   - `findBorradorSinNumero` recibe `esGrupal`. Con `true` filtra por usuario + cédula + `esGrupal`. Con `false`, por usuario + cédula + tipo + `esGrupal == false`.
   - `getOrCreateBorradorSinNumero` recibe `esGrupal`, lo pasa a la búsqueda y lo guarda al crear.
3. Sumar `analisisGrupalHnLocalDb` (`AnalisisGrupalHnLocalDb_.numeroSolicitud`) al módulo análisis en `modulosConDatos`, `_moverModulo` y `_borrarModulo`.
4. `vincularBorradorSinNumero` recibe `tipoSolicitudReal`. Al mover el módulo análisis, la fila de `AnalisisGrupalHnLocalDb` toma también ese `tipoSolicitud`.
5. En `analisis_solicitudes_hn_offline_screen.dart`:
   - `_SolicitudSinNumero` suma `esGrupal`, y `llave` lo incluye.
   - En `_getSolicitudesSinNumero`, quitar `_noEsGrupal` y calcular `esGrupal` desde `grupoCodigo`. Las llaves de las AUT usan `esSolicitudGrupal`. Los borradores huérfanos usan su `esGrupal`.
   - `crearBorrador()` pasa `esGrupal`.
   - En `_ListDataWidget`, `getTipoSolicitud(esGrupal: solicitud.esGrupal)`.
   - `AnalisisCreditoOfflineCard` recibe `esGrupal` (por defecto `false`) y, en filas sin número, muestra el tag "Grupal".
6. En `analisis_grupal_hn_form.dart`, con `numeroSolicitud < 0`, deshabilitar el botón que abre `GrupalSendingAnalisisHn` y mostrar `SinNumeroNoticeWidget` arriba.
7. En `ofrecerBorradorSinNumeroHn`:
   - Quitar la salida temprana por `esGrupal`.
   - Llamar `findBorradorSinNumero` con `esGrupal`.
   - Con `esGrupal`, `descartarAnalisis: false`. Sin él, la comparación de `getTipoSolicitud` de SPEC 06.
   - Pasar `tipoSolicitudReal: tipoSolicitud` a `vincularBorradorSinNumero`.
8. Actualizar `references/app-modules-reference.md` (la nota de SPEC 06 suma las grupales) y el apartado "HN análisis: solicitudes sin número" de `CLAUDE.md` (grupales incluidas, llave con `esGrupal`, tabla grupal en el vínculo).

## Acceptance criteria

- [X] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [X] Una solicitud nueva grupal creada offline y terminada aparece en "Análisis offline" con los tags "Sin número" y "Grupal".
- [X] Lo mismo con una asalariado grupal.
- [X] Una solicitud individual sigue apareciendo sin el tag "Grupal" y abre su formulario de siempre.
- [X] Tocar la grupal abre el sheet con análisis, plan de inversión, imágenes y ubicación, y sin fiadores.
- [X] "Registrar Analisis" abre `AnalisisGrupaHnForm`.
- [X] Con número provisional, el envío del análisis grupal está deshabilitado y se ve el aviso "Esta solicitud aún no tiene número", aunque haya conexión.
- [X] Al salir y volver a entrar, el análisis grupal conserva lo capturado (autosave con el número provisional).
- [X] Cuando el sync trae una AUT grupal con la misma cédula, la grupal local desaparece de la lista.
- [X] Una AUT individual con la misma cédula no oculta la grupal local, y al revés.
- [X] Tocar la AUT grupal (online u offline) muestra el diálogo "¿Usar datos guardados?".
- [X] Una AUT individual con la misma cédula no ofrece el borrador grupal, y una AUT grupal no ofrece el borrador individual.
- [X] "Usar" pasa el análisis grupal, el plan, las imágenes y la ubicación al número real. El resumen no muestra "el monto cambió".
- [X] Después de vincular, la fila de `AnalisisGrupalHnLocalDb` tiene el número real y el `tipoSolicitud` de la AUT.
- [X] "Descartar" borra también la fila de `AnalisisGrupalHnLocalDb` del borrador.
- [X] Los borradores individuales creados con SPEC 06 siguen funcionando después de la actualización.
- [X] En NI y Costa Rica no cambia nada.
- [X] Se creó una solicitud grupal offline en QA HN, se hizo el análisis grupal offline, el jefe la autorizó, se vinculó con "Usar", y backend confirmó el análisis grupal con el número real (verificación manual).

## Decisions

- **Sí:** spec aparte en lugar de un anexo de SPEC 06. Lo eligió el usuario.
- **Sí:** nueva y asalariado grupales. Lo eligió el usuario. Son las únicas que guardan `grupoCodigo` offline.
- **No:** represtamos grupales. No tienen campos de grupo.
- **Sí:** las grupales se emparejan por cédula + `esGrupal`, sin el tipo. Lo eligió el usuario. No se sabe qué `tipoSolicitud` trae una AUT grupal en el sync, y así funciona con cualquier código.
- **Sí:** `esGrupal` es parte de la llave también para las individuales. Evita que un borrador individual se ofrezca en una AUT grupal del mismo cliente, o al revés.
- **Sí:** el sheet offline de una grupal ofrece lo mismo que el online grupal: análisis, plan, imágenes y ubicación. Lo eligió el usuario.
- **No:** supervisión grupal offline. Necesita `cicloGrupoId`, que solo da el backend.
- **Sí:** los borradores existentes quedan con `esGrupal = false`. Lo eligió el usuario. Los de SPEC 06 son individuales.
- **Sí:** en grupales, el análisis nunca se descarta por monto. `getTipoSolicitud` devuelve `grupal` antes de mirar el monto, así que el formulario no cambia.
- **Sí:** al vincular, `AnalisisGrupalHnLocalDb.tipoSolicitud` toma el de la AUT. El borrador guardó el tipo de la solicitud local, y el envío tiene que usar el que da el backend.
- **Sí:** tag "Grupal" en la card sin número, para distinguirla de una individual del mismo cliente.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| El cliente tiene dos solicitudes grupales offline (por ejemplo en dos grupos) | Comparten el mismo borrador por la llave cédula + grupal. Se acepta: es raro, y la lista muestra una sola card por llave, como en SPEC 06. |
| `AnalisisGrupaHnForm` carga el `tipoSolicitud` de la fila local en vez del de la AUT al enviar | El paso 4 lo reescribe al vincular. Hay un criterio de aceptación que lo revisa. |
| La AUT grupal llega con otra cédula (formato) | Las cédulas se comparan normalizadas, como en SPEC 06. |
| Hay borradores grupales creados como individuales antes del filtro de SPEC 06 | Se acepta: son casos de QA. Se borran con los datos de la app. |
| `esSolicitudGrupal` viene mal en el sync | Una grupal local no se ocultaría y su AUT no ofrecería el borrador. Se detecta en la verificación manual de QA. |

## What is **not** in this spec

- Crear grupos offline.
- Supervisión grupal offline.
- Represtamos grupales.
- Vincular grupal con individual.
- Limpieza de borradores grupales viejos de QA.

Cada uno, si llega, va en su propia spec.
