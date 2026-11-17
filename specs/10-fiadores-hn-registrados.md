# SPEC 10 — Fiadores HN registrados en la solicitud

> **Status:** Approved
> **Depends on:** SPEC 05
> **Date:** 2026-11-17
> **Objective:** Listar en `FiadoresHnScreen` los fiadores que la solicitud HN ya tiene en el backend (`GET /cartera/analisis-fiador/fiador-solicitud`) y, al tocar uno, abrir `FiadoresHnFormScreen` precargado en modo solo lectura con sus datos y su historial crediticio.

## Por qué existe esta spec

Hoy el asesor de Honduras no puede ver qué fiadores tiene registrados una solicitud. `FiadoresHnScreen` solo sabe si hay cónyuge, aval o codeudor (`checkFiadorAval` → etiquetas "Registrado"), pero no quiénes son ni qué datos se enviaron.

El backend expone ahora `GET /cartera/analisis-fiador/fiador-solicitud`:

- Query params: `database` (requerido), `NumeroSolicitud` (requerido), `Cedula` (opcional).
- Solo devuelve fiadores con vínculo activo.
- Sin `Cedula`, `data` es un arreglo de fiadores.
- Con `Cedula`, `data` es un objeto con los mismos campos más `HistorialCredito`.
- Los campos usan los mismos nombres que el body de `POST /cartera/analisis-fiador/create`. Cada catálogo trae además `...Nombre` junto a `...Codigo`, y se agrega `IdFiador`.

Como los nombres coinciden con el body de create, la respuesta se puede leer con `AnalisisFiadoresHn.fromJson` (SPEC 05).

Esta spec deja preparado el modo solo lectura del formulario. Un endpoint de actualizar llegaría en otra spec, y podría reutilizar ese modo.

## Scope

**In:**

- Endpoint `GetFiadoresSolicitudHNEndpoint` (`GET /cartera/analisis-fiador/fiador-solicitud`) con `database`, `NumeroSolicitud` y `Cedula` opcional.
- Modelo `FiadorSolicitudHn`, que envuelve `AnalisisFiadoresHn.fromJson` más `idFiador` y el JSON crudo para leer los `...Nombre`.
- `HistorialCredito.fromJson` también acepta `MonedaCodigo`/`FrecuenciaCodigo` y los `...Nombre` que trae este endpoint.
- Dos métodos en `AnalisisRepositoryHn`: listar (sin `Cedula`) y detalle (con `Cedula`).
- Cubit nuevo `FiadoresSolicitudHnCubit`, que lista y pide el detalle de un fiador.
- Sección "Registrados en el sistema" en `FiadoresHnScreen`, debajo de Cónyuge/Aval/Codeudor:
  - Una tarjeta por fiador con nombre completo, cédula y un `CardTagWidget` con `TipoFiadorNombre`.
  - Estados: barra de progreso mientras carga; mensaje y "Reintentar" si falla; "Esta solicitud aún no tiene fiadores registrados" si viene vacía.
  - Solo se muestra con conexión y con `numeroSolicitud >= 0`. Sin conexión o sin número (SPEC 06), la sección no aparece y no se llama al backend.
  - Se recarga al volver del flujo de crear fiador (`_goToSearch`).
- Al tocar una tarjeta, se pide el detalle con `Cedula` (loader en la tarjeta) y se abre `FiadoresHnFormScreen` en modo solo lectura. Si el detalle falla, se muestra un snackbar con el error y no se navega.
- Modo solo lectura de `FiadoresHnFormScreen` (parámetro `fiadorRegistrado`):
  - El `PageView` no incluye las páginas de fotos de la cédula ni de la firma. Empieza en Datos generales.
  - Todos los campos de las 5 páginas muestran el valor del fiador y están deshabilitados.
  - Los catálogos usan `selectedItem` con `...Codigo` y `...Nombre` de la respuesta, y `enabled: false`.
  - "Siguiente" no valida el formulario. Los datos del backend pueden tener campos requeridos vacíos.
  - El historial crediticio muestra los registros de `HistorialCredito`, sin agregar, editar ni eliminar.
  - El último paso no tiene "Enviar". Tiene "Cerrar", que vuelve a `FiadoresHnScreen`.
  - El título es "Ver fiador" y no se muestra el FAB de herramientas (`buildActividadesEconomicasAliasFilteredDropdown`).
- `AnalisisFiadoresCubit.cargarFiadorRegistrado(FiadorSolicitudHn)`, que llena el estado con el fiador.
- Cada página del formulario recibe `readOnly` (por defecto `false`) y toma `initialValue`/`selectedItem` del estado del cubit. Con `readOnly: false`, crear un fiador funciona igual que hoy.
- Actualizar `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Editar un fiador registrado (necesita un endpoint de actualizar).
- Desvincular o eliminar un fiador registrado.
- Ver las fotos de la cédula o la firma de un fiador registrado. El GET no devuelve archivos.
- Cambiar `checkFiadorAval`, las etiquetas "Registrado" o el bloqueo de Cónyuge. Siguen saliendo de `fiadoresChecks`.
- Guardar el listado en local o mostrarlo sin conexión.
- Mostrar fiadores registrados en Nicaragua o Costa Rica.
- Cambiar `getFiadoresByNumeroSolicitud` (`FiadoresGarantiaCubit`, garantías).
- Mostrar los fiadores pendientes locales (SPEC 05) mezclados con los registrados.
- Rediseño v2 de las páginas del formulario de fiadores.

## Data model

No hay entidades nuevas ni hay que regenerar Isar u ObjectBox.

```dart
// lib/src/datasource/analisis/hn/fiadores/fiador_solicitud_hn.dart
class FiadorSolicitudHn {
  final int idFiador;
  final AnalisisFiadoresHn fiador;   // AnalisisFiadoresHn.fromJson(json)
  final Map<String, dynamic> raw;    // JSON tal cual, para leer los ...Nombre

  factory FiadorSolicitudHn.fromJson(Map<String, dynamic> json);

  String nombre(String campo);       // raw['${campo}Nombre'] ?? '', p. ej. nombre('Municipio')
  String get nombreCompleto;         // Nombre1 Nombre2 Apellido1 Apellido2, sin espacios dobles
  String get tipoFiadorNombre;       // nombre('TipoFiador')
}
```

```dart
// lib/src/domain/repository/analisis/hn/analisis_repository_hn.dart
Future<List<FiadorSolicitudHn>> getFiadoresSolicitud({required int numeroSolicitud});
Future<FiadorSolicitudHn> getFiadorSolicitudByCedula({
  required int numeroSolicitud,
  required String cedula,
});
```

```dart
// lib/src/presentation/bloc/analisis/hn/fiadores_solicitud/fiadores_solicitud_hn_state.dart
class FiadoresSolicitudHnState {
  final List<FiadorSolicitudHn> fiadores;
  final Status status;               // carga de la lista
  final String errorMsg;             // error de la lista
  final String? cargandoCedula;      // tarjeta con detalle en curso
  final FiadorSolicitudHn? detalle;  // último detalle cargado; el listener navega y lo limpia
  final String? detalleError;        // error del detalle; dispara el snackbar
}
```

```dart
// FiadoresHnFormScreen
const FiadoresHnFormScreen({
  required this.type,
  required this.numeroSolicitud,
  this.fiadorRegistrado,             // no null → modo solo lectura
});
```

Conventions:

- El endpoint toma `database` de `LocalStorage()`, igual que los demás endpoints HN de análisis.
- Sin `Cedula`, `data` es `List`. Con `Cedula`, `data` es `Map`. Cada método del repositorio valida el tipo que espera y lanza `AppException` si no coincide.
- `type` del formulario en modo solo lectura sale de `TipoFiadorCodigo` (`TFD1` aval, `TFD2` cónyuge, `TFD3` codeudor). Un código desconocido usa `aval`. En modo solo lectura no se llama `setRelacionCliente`.
- `HistorialCredito.fromJson` lee `TipoMonedaCodigo ?? MonedaCodigo` y `TipoFrecuenciaCodigo ?? FrecuenciaCodigo`, y llena `monedaNombre`, `frecuenciaNombre` y `estadoNombre` si vienen.
- Un catálogo en solo lectura se arma como `ItemNacionalidad(valor: <Codigo>, nombre: <Nombre>)`. Si `...Nombre` viene vacío, se muestra el código.

## Implementation plan

1. **Modelo y endpoint.** Crear `FiadorSolicitudHn` y `GetFiadoresSolicitudHNEndpoint` (en `analisis_endpoint_hn.dart`, `queryParameters` con `Cedula` solo si no está vacía). Ajustar `HistorialCredito.fromJson` con las llaves alternas. Verificar con `flutter analyze`.
2. **Repositorio.** Agregar `getFiadoresSolicitud` y `getFiadorSolicitudByCedula` a `AnalisisRepositoryHn` y `AnalisisRepositoryHNImpl`, con el mismo manejo de errores que `getFiadoresByNumeroSolicitud` (`statusCode != 200` → `AppException` con `getErrorMessage`).
3. **Cubit.** Crear `FiadoresSolicitudHnCubit` + state en `presentation/bloc/analisis/hn/fiadores_solicitud/`, con `load({numeroSolicitud})`, `verDetalle({numeroSolicitud, cedula})` y `limpiarDetalle()`.
4. **Sección en `FiadoresHnScreen`.** Proveer el cubit junto a `AnalisisFiadorAvalCubit` y llamar `load` solo si `isConnected` (que ya incluye `numeroSolicitud >= 0`). Pintar la sección "Registrados en el sistema" con sus tres estados y las tarjetas (`RedesignColors`, `CardTagWidget`). Al volver de `_goToSearch`, recargar. Tocar una tarjeta todavía no navega.
5. **Carga en el cubit del formulario.** Agregar `AnalisisFiadoresCubit.cargarFiadorRegistrado(FiadorSolicitudHn)`, que copia al estado todos los campos de `fiador` (incluidos `historialCredito`, `numeroSolicitud`, `tipoFiadorCodigo` y `fiadorId = idFiador`).
6. **Solo lectura: Datos generales y Datos personales.** Agregar `readOnly` a `AnalisisFiadoresDatosGenerales` y `AnalisisFiadoresDatosPersonales`. Cada campo toma su valor del estado (`initialValue`, `selectedItem`), se deshabilita con `readOnly`, y "Siguiente" no valida. Con `readOnly: false`, nada cambia.
7. **Solo lectura: Actividades y Datos de actividad.** Lo mismo en `AnalisisFiadoresActividades` y `AnalisisDatosDeActividad`.
8. **Solo lectura: Datos de ingresos.** Lo mismo en `AnalisisFiadoresDatosDeIngresos`. `FiadoresHistorialCredito` recibe `readOnly` y oculta agregar, editar y eliminar. Con `readOnly`, "Enviar" se reemplaza por "Cerrar".
9. **Formulario en modo solo lectura y navegación.** `FiadoresHnFormScreen` recibe `fiadorRegistrado`. Si no es null: llama `cargarFiadorRegistrado` en vez de `setRelacionCliente`, quita las páginas de fotos y firma, pasa `readOnly: true` a las 5 páginas, toma los datos generales de `fiadorRegistrado` (no de `AnalisisSearchByDocumentCubit`), usa el título "Ver fiador" y oculta el FAB. En `FiadoresHnScreen`, tocar una tarjeta llama `verDetalle`. Un `BlocListener` abre el formulario con el detalle (y llama `limpiarDetalle`) o muestra el snackbar de error.
10. **Docs.** Agregar en `CLAUDE.md` un apartado corto "HN análisis: fiadores registrados" con el endpoint, la sección y el modo solo lectura.

## Acceptance criteria

- [X] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [ ] Con conexión, `FiadoresHnScreen` de una solicitud con fiadores muestra "Registrados en el sistema" con una tarjeta por fiador activo (nombre, cédula, tipo).
- [ ] En `BitacoraService`, el listado llama `GET /cartera/analisis-fiador/fiador-solicitud` con `database` y `NumeroSolicitud`, sin `Cedula`.
- [ ] Una solicitud sin fiadores muestra "Esta solicitud aún no tiene fiadores registrados".
- [ ] Si el listado falla, se ve el mensaje del backend y "Reintentar" vuelve a llamar el endpoint.
- [ ] Sin conexión, o con `numeroSolicitud < 0`, la sección no aparece y no hay llamada HTTP al endpoint.
- [ ] Al crear un fiador en línea y volver a `FiadoresHnScreen`, el nuevo fiador aparece en la sección.
- [ ] Tocar una tarjeta muestra un loader en ella, llama el endpoint con `Cedula` y abre "Ver fiador".
- [ ] "Ver fiador" empieza en Datos generales, sin las páginas de fotos ni de firma.
- [ ] En las 5 páginas, los campos muestran los valores del fiador (catálogos con su nombre) y no se pueden cambiar.
- [ ] "Siguiente" avanza aunque haya campos requeridos vacíos.
- [ ] El historial crediticio muestra los registros de `HistorialCredito` (entidad, monto, moneda, frecuencia, estado), sin botones de agregar, editar ni eliminar.
- [ ] El último paso muestra "Cerrar" en vez de "Enviar" y vuelve a `FiadoresHnScreen` sin llamadas HTTP de creación.
- [ ] Si el detalle falla, se muestra un snackbar con el error y no se abre el formulario.
- [ ] Crear un fiador (en línea y sin conexión) funciona igual que antes: 7 páginas, validación y "Enviar".
- [ ] Las etiquetas "Registrado", el bloqueo de Cónyuge y la fila "Pendientes en el teléfono (N)" no cambian.
- [ ] Nicaragua y Costa Rica no cambian.
- [ ] Verificación manual en QA HN con una solicitud con al menos dos fiadores de tipos distintos.

## Decisions

- **Sí:** solo Honduras. Lo eligió el usuario. El ejemplo usa `MICREDITO_SPS`, `TFD1` y `HNL`.
- **Sí:** esta spec cubre solo el GET (listado y detalle). Lo eligió el usuario. Otros endpoints de fiadores van en otra spec.
- **Sí:** sección dentro de `FiadoresHnScreen`, no una pantalla aparte. Lo eligió el usuario. El asesor ya entra ahí para crear fiadores.
- **Sí:** abrir el formulario precargado en vez de una pantalla de detalle. Lo eligió el usuario. El asesor ve los datos con el mismo orden y los mismos campos con que los capturó.
- **Sí:** solo lectura. Lo eligió el usuario. No hay endpoint de actualizar, y reenviar `POST /create` duplicaría el fiador en el backend.
- **No:** formulario editable con "Enviar" deshabilitado. Confunde al asesor.
- **Sí:** `readOnly` en cada página, con valores tomados del estado del cubit. Lo eligió el usuario. Sirve también cuando llegue el endpoint de actualizar.
- **Sí:** saltar las páginas de fotos y firma. Lo eligió el usuario. El GET no devuelve archivos.
- **Sí:** en solo lectura, "Siguiente" no valida. Los fiadores del backend pueden tener campos que hoy son requeridos y antes no lo eran.
- **Sí:** reusar `AnalisisFiadoresHn.fromJson` más el JSON crudo para los `...Nombre`. Lo eligió el usuario. El ejemplo del backend está recortado y los nombres coinciden con el body de create.
- **No:** un modelo plano con todos los campos. Habría que pedir a backend la lista completa y mantenerla en dos lugares.
- **No:** cambiar `checkFiadorAval`. Lo eligió el usuario. Derivar las etiquetas del listado cambiaría una regla que hoy funciona.
- **Sí:** loader, error con "Reintentar" y vacío con texto. Lo eligió el usuario.
- **Sí:** tarjeta con nombre, cédula y tipo. Lo eligió el usuario.
- **Sí:** pedir el detalle (con `Cedula`) al tocar, no reusar la fila del listado. El listado no trae `HistorialCredito`.
- **No:** guardar el listado en local. La sección es solo en línea.
- **Sí:** los helpers de `AnalisisFiadoresHn.fromJson` y `HistorialCredito.fromJson` aceptan números como texto, textos como número, `0`/`1` como booleano y fechas inválidas (`tryParse`). Se decidió durante la implementación: el GET de QA HN mandaba un campo numérico como texto y la lista fallaba con `type 'String' is not a subtype of type 'num?'`. Los pendientes de SPEC 05 se siguen leyendo igual.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| Tocar 5 páginas del formulario (~85 campos) rompe la creación. | `readOnly` es `false` por defecto y los pasos 6–8 se prueban creando un fiador antes de seguir. |
| Algún widget de entrada no soporta valor inicial o deshabilitarse (switches, fechas, dropdowns propios). | Se revisa en el paso de cada página. Si un widget no lo soporta, se envuelve en `IgnorePointer` y se le pasa el valor del estado. |
| La respuesta trae un campo con nombre distinto al body de create. | `fromJson` usa valores por defecto. El campo sale vacío, no crashea. Se reporta a backend. |
| `HistorialCredito` guarda montos como `int` y el backend puede mandar decimales. | Se trunca al mostrar. Cambiar el tipo afecta la creación y queda fuera de esta spec. |
| Un `...Nombre` viene vacío para un catálogo. | Se muestra el código. |
| Muchos fiadores hacen la sección larga. | Es raro que una solicitud tenga más de 3 o 4. Se acepta. |

## What is **not** in this spec

- Editar, desvincular o eliminar un fiador registrado.
- Fotos de la cédula y firma de un fiador registrado.
- Cambios en `checkFiadorAval`, las etiquetas "Registrado" o el bloqueo de Cónyuge.
- Listado offline o en caché.
- Nicaragua y Costa Rica.
- Cambios en `getFiadoresByNumeroSolicitud` (garantías).
- Rediseño v2 de las páginas del formulario.

Cada uno, si llega, va en su propia spec.
