# SPEC 02 — Módulo de fiadores en análisis de Nicaragua

> **Status:** Approved
> **Depends on:** —
> **Date:** 2026-10-21
> **Objective:** Permitir que el asesor registre fiadores de una solicitud desde el menú de análisis de Nicaragua, con un formulario por pasos que reproduce los campos de la pantalla de fiadores del sistema de escritorio de NI, enviado a `POST /cartera/analisis-fiador/create`.

## Por qué existe esta spec

HN ya tiene el módulo de fiadores (`screens/cartera/analisis_solicitudes/hn/fiadores/`), pero en NI no existía nada: ni modelo, ni endpoint, ni cubit, ni pantalla. Lo único que había era el flag `TieneFiadores` en `analisis_checks_response_ni.dart`, que no se mostraba en ningún lado.

La primera versión de esta spec copiaba los campos de HN y del curl de ejemplo. Durante la implementación, el equipo pasó capturas de la pantalla de fiadores del sistema de escritorio de NI, con dos pestañas: "Datos personales" y "Otros datos". **Esas capturas son la fuente de verdad de los campos de NI.** Por eso el formulario, el estado y el body quedaron ajustados a ellas.

Se hace un flujo propio en `ni/`, siguiendo la regla de `CLAUDE.md`, en lugar de meter `if (flavor)` dentro del flujo de HN.

## Scope

**In:**

- DTO de request `AnalisisFiadorNi`, con solo las llaves de los campos de la pantalla de NI más los valores fijos. `toJson()` descarta los valores `null` y `''`, igual que HN.
- Endpoint `CreateAnalisisFiadorEndpointNi`: `POST /cartera/analisis-fiador/create`, con Bearer JWT y el body JSON.
- Método `createAnalisisFiador` en `AnalisisFormsRepositoryNi`. Llama a `_api.request` directamente, igual que HN, espera `201` y devuelve `CrearFiadorResponseHn` (se reutiliza el DTO de HN).
- Cubit `AnalisisFiadoresNiCubit` + `AnalisisFiadoresNiState`, que guardan el estado del formulario y hacen el envío.
- Enum `FiadoresNiFormType` con códigos **provisionales** de tipo de fiador (ver Data model).
- Pantalla de selección de tipo `FiadoresNiScreen`: un `ModuleTileWidget` por tipo, con `ScreenHeaderWidget` y `RedesignColors`.
- Pantalla de formulario `FiadoresNiFormScreen`: `PageView` de 4 pasos con `FormStepHeaderWidget` y secciones en `FiadorNiSectionCard` (`widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart`), con el estilo del rediseño. Los pasos siguen las dos pestañas del escritorio:
  1. Datos personales
  2. Contacto y domicilio
  3. Datos laborales
  4. Ingresos y vivienda
- Pantalla de envío `AnalisisFiadoresNiSendingWidget` con `SendingStatusView`. Permite reintentar mientras siga abierta y, si el envío sale bien, vuelve a `AnalisisInterceptorByFlavor`.
- Catálogos con `SearchDropdownWidget` / `CatalogoValorNacionalidad`: `TIPODOCUMENTOPERSONA`, `SEXO`, `ESTADOCIVIL`, `RELACIONPERSONAS`, `PAIS`/`DEP`/`MUN`, `ACTIVIDADECONOMICA`, `TIPOVIVIENDA` y `PARENTESCO`.
- Agregar `RELACIONPERSONAS` a `_codigosCatalogo` en `presentation/bloc/solicitud_catalogo/solicitud_catalogo_cubit.dart`. Hasta ahora solo lo descargaba la sincronización de HN.
- Validaciones: las mismas de HN en los campos compartidos. La cédula se valida con `ClassValidator.validateCedulaByFlavor`.
- Totales calculados con las mismas fórmulas que HN.
- Nueva `SelectableCardItem` "Registrar Fiadores" en `SelectTypeAnalisisModalSheetNiWidget`:
  - Usa `userHaveDataAlready: state.tieneFiadores`.
  - Solo funciona en línea.
  - Agrega `'Fiadores'` a la lista de pendientes que se muestra al cerrar el análisis.
- Se permiten varios fiadores por solicitud, sin bloqueos.
- Actualizar `references/app-modules-reference.md` y `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Fotos de cédula del fiador y subida del PDF al expediente digital.
- Foto del fiador (el recuadro con avatar de la pantalla de escritorio).
- Firma del fiador y `PATCH /cartera/analisis-fiador/subir-firma`.
- Búsqueda por documento y autocompletado (`/cartera/analisis-fiador/obtener-auto-completado`).
- Historial crediticio (`HistorialCredito[]`).
- Campos que no están en la pantalla de NI: país de nacimiento, nacionalidad, escolaridad, ocupación, catálogo de profesión, número de hijos, tipo de persona CNBS, estatus, tipo de cliente, actividad económica CNBS con descripción, y ubicación de la ocupación.
- Listar, editar o eliminar fiadores ya registrados.
- Tag "Registrado" por tipo y la regla "un solo cónyuge". NI solo devuelve `TieneFiadores` en general.
- Guardado offline en ObjectBox.
- Costa Rica. Su análisis sigue siendo un placeholder.
- Fiadores en garantías de NI. Para eso haría falta un endpoint de listado.
- Pasar los pasos del formulario de HN al rediseño.

## Data model

```dart
// lib/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart
class AnalisisFiadorNi {
  final String database;            // LocalStorage().database
  final int numeroSolicitud;
  final String nombre1, nombre2, apellido1, apellido2;
  final DateTime? fechaNacimiento;  // toJson: toUtc().toIso8601String()
  final String cedula, telefono, celular, direccion, barrioCasa;
  final String municipioCodigo, departamentoCodigo, paisCodigo, email;
  final String sexoCodigo, estadoCivilCodigo, relacionClienteCodigo;
  final bool esAsalariado;
  final String empresa, cargo, tiempoLaborar;
  final bool esEmpresario;
  final String actividadCodigo, tiempoActividad;          // llaves de HN
  final String direccionTrabajo, barrioTrabajo, telefonoTrabajo, lugarTrabajoAnterior;
  final int personasACargo, cantidadDependientes;
  final bool tieneDocumentosDomicilio;
  final String tipoDomicilioCodigo, duenoVivienda;
  final double pagoAlquiler;                               // llave de HN
  final String profesion;                                  // texto libre
  final int anosVivirDomicilio;
  final String nombreFamiliarCercano, parentescoFamiliarCercanoCodigo;
  final String direccionFamiliarCercano, telefonoFamiliarCercano;
  final double salarioNetoCordoba, otrosIngresosCordoba, totalIngresosFamiliares;
  final double ventaNegocio, costoVenta, gastosOperativos, gananciaNegocio;
  final double otrosIngresos;
  final String fuenteOtrosIngresos;                        // llave de HN
  final double consumoFamiliar, saldoDisponible;
  final bool activo;                // siempre true
  final String tipoDocumentoCodigo;
  final bool esFirmaDigitalFiador;  // siempre false
  final String tipoFiadorCodigo;    // FiadoresNiFormType.codigo
  final String tipoViviendaCodigo;  // = tipoDomicilioCodigo

  Map<String, dynamic> toJson();
}
```

```dart
// lib/src/presentation/screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_form_screen.dart
// Códigos PROVISIONALES. Se reemplazan por los reales de backend NI.
enum FiadoresNiFormType {
  fiador('FIA'),     // único código confirmado (viene del curl)
  conyuge('CON'),    // provisional
  codeudor('COD');   // provisional
  final String codigo;
  const FiadoresNiFormType(this.codigo);
}
```

**Campos por paso** (catálogo entre paréntesis; la columna "Escritorio" indica de qué parte de la pantalla de NI sale cada uno):

| Paso | Escritorio | Campos |
| --- | --- | --- |
| 1. Datos personales | Pestaña "Datos personales", columna izquierda arriba y bloque sexo/estado civil/relación | Nombre1, Nombre2, Apellido1, Apellido2, FechaNacimiento, Edad (solo lectura, no se envía), TipoDocumentoCodigo (`TIPODOCUMENTOPERSONA`, por defecto `CEDULAIDENTIDAD`), Cedula, SexoCodigo (`SEXO`), EstadoCivilCodigo (`ESTADOCIVIL`), RelacionClienteCodigo (`RELACIONPERSONAS`) |
| 2. Contacto y domicilio | Pestaña "Datos personales", columna izquierda abajo | Telefono, Celular, Email, PersonasACargo, CantidadDependientes, Direccion, BarrioCasa, PaisCodigo → DepartamentoCodigo → MunicipioCodigo (`PAIS`/`DEP`/`MUN`, en cascada con `where:`), Profesion (texto) |
| 3. Datos laborales | Pestaña "Datos personales", columna derecha | Switch EsAsalariado → Empresa, Cargo, TiempoLaborar. Switch EsEmpresario → ActividadCodigo (`ACTIVIDADECONOMICA`), TiempoActividad. DireccionTrabajo, BarrioTrabajo, TelefonoTrabajo, LugarTrabajoAnterior |
| 4. Ingresos y vivienda | Pestaña "Otros datos" | SalarioNetoCordoba, OtrosIngresosCordoba, FuenteOtrosIngresos, TotalIngresosFamiliares (solo lectura). VentaNegocio, CostoVenta, GastosOperativos, GananciaNegocio (solo lectura), OtrosIngresos, ConsumoFamiliar, SaldoDisponible (solo lectura). Tipo propiedad (`TIPOVIVIENDA`, se guarda en TipoDomicilioCodigo y TipoViviendaCodigo), AnosVivirDomicilio, TieneDocumentosDomicilio, DuenoVivienda, PagoAlquiler. NombreFamiliarCercano, ParentescoFamiliarCercanoCodigo (`PARENTESCO`), TelefonoFamiliarCercano, DireccionFamiliarCercano |

Convenciones:

- Fórmulas (iguales a HN, en `AnalisisFiadoresCubit`):
  - `TotalIngresosFamiliares = SalarioNetoCordoba + OtrosIngresosCordoba`
  - `GananciaNegocio = VentaNegocio - CostoVenta - GastosOperativos`
  - `SaldoDisponible = TotalIngresosFamiliares + GananciaNegocio + OtrosIngresos - ConsumoFamiliar`
- Los campos de moneda aceptan decimales: `numberWithOptions(decimal: true)`, `CurrencyInputFormatter()` y `toNumericString(v, allowPeriod: true)`. Los totales se muestran con dos decimales.
- La sección "Información del negocio" se ve siempre, como en el escritorio. No depende de EsEmpresario.
- EsAsalariado y EsEmpresario son independientes, como las dos casillas del escritorio. Al apagar uno se limpian sus campos.
- DireccionTrabajo, BarrioTrabajo y TelefonoTrabajo son obligatorios solo si EsAsalariado o EsEmpresario están encendidos.
- Valores fijos: `Activo = true`, `EsFirmaDigitalFiador = false`, `database = LocalStorage().database`.

## Implementation plan

1. Crear `lib/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart` con `AnalisisFiadorNi` y su `toJson()`. Verificar con `flutter analyze`.
2. Agregar `CreateAnalisisFiadorEndpointNi` en `lib/src/domain/repository/analisis/ni/endpoint/analisis_forms_endpoint_ni.dart`, y `createAnalisisFiador(AnalisisFiadorNi)` en `AnalisisFormsRepositoryNi` / `Impl`, llamando a `_api.request` directamente. Debe esperar `201` y devolver `CrearFiadorResponseHn`.
3. Crear `lib/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart` + `_state.dart`:
   - El state lleva todos los campos del formulario, `status` y `errorMsg`.
   - `onFieldChanged(() => state.copyWith(...))`.
   - `setTipoFiador(FiadoresNiFormType)`.
   - `createAnalisisFiador({required int numeroSolicitud})` calcula los totales, arma el DTO y emite `inProgress`, después `done` o `error`.
4. Crear `screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_screen.dart`:
   - Lleva `ScreenHeaderWidget` y un `ModuleTileWidget` por cada valor de `FiadoresNiFormType`.
   - Al tocar un tipo, abre `FiadoresNiFormScreen`.
   - Si no hay conexión según `InternetConnectionCubit`, muestra `showV2CustomSnackbar` de advertencia y no navega.
5. Crear `screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_form_screen.dart`:
   - Contiene el enum, el `BlocProvider` de `AnalisisFiadoresNiCubit` y el `PageView` con `NeverScrollableScrollPhysics`.
   - Arriba va `FormStepHeaderWidget` con los 4 pasos, en el mismo orden que el `PageView`.
   - Atrás (encabezado y sistema) retrocede un paso, y en el primero cierra.
6. Crear `widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart` (`FiadorNiSectionCard`, `FiadorNiStepButtons`) y `analisis_fiadores_ni_datos_personales.dart` (paso 1). "Siguiente" valida el `Form` del paso antes de avanzar.
7. Crear `analisis_fiadores_ni_domicilio.dart` (paso 2), con la cascada País → Departamento → Municipio.
8. Crear `analisis_fiadores_ni_datos_laborales.dart` (paso 3). Agregar `RELACIONPERSONAS` a `_codigosCatalogo` del sync de NI.
9. Crear `analisis_fiadores_ni_ingresos_vivienda.dart` (paso 4):
   - Muestra los totales en solo lectura.
   - El botón "Enviar" valida el paso y abre la pantalla de envío.
10. Crear `widgets/analisis_solicitudes/ni/fiadores/analisis_fiadores_ni_sending_widget.dart`:
    - Llama `createAnalisisFiador` en `initState` y muestra `SendingStatusView`.
    - Si falla, se puede reintentar. Si sale bien, vuelve a `AnalisisInterceptorByFlavor`.
11. En `select_type_analisis_modal_sheet_ni_widget.dart`:
    - Agregar la `SelectableCardItem` "Registrar Fiadores" (`userHaveDataAlready: state.tieneFiadores`), que hace push de `FiadoresNiScreen(numeroSolicitud: ...)`.
    - Agregar `'Fiadores': state.tieneFiadores` a `analisisItems`.
12. Actualizar `references/app-modules-reference.md` con el submódulo Fiadores en NI (solo en línea, CR no aplica). Agregar en `CLAUDE.md` una sección sobre el flujo de fiadores NI y los códigos provisionales de `FiadoresNiFormType`.

## Acceptance criteria

- [ ] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [ ] En NI, el sheet de análisis de una solicitud muestra "Registrar Fiadores".
- [ ] Si `TieneFiadores` es `true`, la tarjeta se ve como "ya registrado", pero se puede volver a entrar y registrar otro fiador.
- [ ] Al cerrar el análisis sin fiadores, "Fiadores" aparece en la lista de pendientes del diálogo.
- [ ] `FiadoresNiScreen` muestra un mosaico por cada valor de `FiadoresNiFormType`.
- [ ] Sin conexión, tocar un tipo muestra un snackbar de advertencia y no abre el formulario.
- [ ] El formulario tiene 4 pasos, y `FormStepHeaderWidget` muestra "Paso X de 4" con el nombre correcto de cada paso.
- [ ] Cada campo de las dos pestañas de la pantalla de escritorio de NI aparece en el formulario, salvo la foto del fiador.
- [ ] El formulario no tiene país de nacimiento, nacionalidad, escolaridad, ocupación, número de hijos, tipo de persona, estatus, tipo de cliente, actividad económica CNBS ni ubicación de la ocupación.
- [ ] No hay paso de fotos de cédula, firma, búsqueda por documento ni historial crediticio.
- [ ] La edad se calcula al elegir la fecha de nacimiento.
- [ ] No se puede avanzar de paso si un campo obligatorio está vacío o no es válido.
- [ ] Una cédula NI con formato inválido muestra el error de `validateCedulaByFlavor`.
- [ ] Al elegir otro departamento, el municipio se limpia y el dropdown de municipio solo muestra los de ese departamento.
- [ ] Con "Es empresario" encendido aparecen Actividad y Tiempo actividad. Al apagarlo desaparecen y se envían vacíos.
- [ ] Con salario 12000, otros 500, otros ingresos 500, consumo 6000 y negocio en 0, la pantalla muestra un total de 12,500.00 y un saldo disponible de 7,000.00.
- [ ] El body enviado (visible en `BitacoraService`) incluye `FuenteOtrosIngresos`, `PagoAlquiler`, `ActividadCodigo` y `TiempoActividad` cuando tienen valor, además de `Activo: true`, `EsFirmaDigitalFiador: false` y el `TipoFiadorCodigo` del tipo elegido.
- [ ] El body no incluye `EscolaridadCodigo`, `OcupacionCodigo`, `ProfesionCodigo`, `PaisNacimientoCodigo`, `Nacionalidad1codigo`, `CantidadHijos`, `TipoPersonaCNBSCodigo`, `EstatusCodigo`, `TipoClienteCodigo`, `ActividadEconomicaCNBS1Codigo`, `ActividadEconomicaDescripcion1` ni las llaves de ubicación de ocupación.
- [ ] Ninguna llave con valor `''` o `null` aparece en el body.
- [ ] Con una respuesta `201`, la pantalla de envío muestra éxito y vuelve a `AnalisisInterceptorByFlavor`.
- [ ] Con una respuesta de error, la pantalla de envío muestra el mensaje del backend. "Reintentar envío" reenvía con los mismos datos, sin volver a llenar el formulario.
- [ ] Ningún archivo nuevo vive bajo `hn/`, y ningún archivo de HN fiadores cambia.
- [ ] Se registró un fiador real en QA NI con la solicitud de prueba, y backend lo confirmó (verificación manual).

## Decisions

- **Sí:** los campos de la pantalla de fiadores del sistema de escritorio de NI son la fuente de verdad. Los pasó el equipo durante la implementación y reemplazan la primera versión, que copiaba HN y el curl.
- **No:** mandar las llaves del curl que no tienen campo en la pantalla de NI. Se quitaron del DTO, para que el body refleje lo que el asesor captura.
- **Sí:** `FuenteOtrosIngresos`, `PagoAlquiler`, `ActividadCodigo` y `TiempoActividad` con los mismos nombres que HN. Es el mismo endpoint, y HN ya los envía así.
- **Sí:** el dropdown "Actividad" del empresario sale de `ACTIVIDADECONOMICA`, el catálogo de actividades que NI ya sincroniza.
- **Sí:** Profesión como texto libre, igual que en el escritorio. No se usa el catálogo `PROFESION`.
- **Sí:** Edad calculada y solo informativa. No se envía.
- **Sí:** 4 pasos que siguen las pestañas del escritorio. Las dos pestañas se parten en dos pasos cada una para que en el celular no queden demasiado largas.
- **Sí:** País → Departamento → Municipio en cascada, aunque el escritorio los muestra en orden inverso. En el celular la cascada evita elegir un municipio de otro departamento.
- **Sí:** flujo propio en `ni/` (DTO, cubit, pantallas, widgets). Es lo que pide `CLAUDE.md` y no toca el flujo de HN que ya funciona.
- **No:** reutilizar `FiadoresHnFormScreen` con `if (flavor)`. Mezclaría pasos, catálogos y endpoints de dos países en una sola clase.
- **Sí:** reutilizar `CrearFiadorResponseHn` como respuesta. `AnalisisFormsRepositoryNi` ya reutiliza DTOs de HN, y la respuesta (`ok`, `message`, `data.FiadorID`) es la misma.
- **Sí:** `createAnalisisFiador` llama a `_api.request` directamente, como HN, sin cambiar `_post()`. Así el helper que usan los otros formularios no cambia.
- **Sí:** tipos de fiador en un enum con códigos provisionales (`FIA`, `CON`, `COD`). El usuario los corrige después. Solo `FIA` está confirmado por el curl.
- **Sí:** formulario directo, sin búsqueda ni autocompletado.
- **No:** firma digital. NI no la lleva, así que `EsFirmaDigitalFiador` siempre es `false`.
- **No:** fotos de cédula ni expediente digital. Lo pidió el usuario.
- **No:** historial crediticio. No está en la pantalla de NI.
- **Sí:** se permiten varios fiadores, y la tarjeta del sheet usa `TieneFiadores`. NI no devuelve checks por tipo, así que no hay tag por tipo ni regla de un solo cónyuge.
- **Sí:** la tarjeta "Registrar Fiadores" se muestra también en solicitudes grupales. El usuario quitó la condición `esGrupal` durante la implementación. Queda pendiente confirmar si las grupales de NI llevan fiadores.
- **Sí:** pasos con rediseño (`FormStepHeaderWidget`, `RedesignColors`). `CLAUDE.md` lo pide para pantallas nuevas.
- **Sí:** secciones en `FiadorNiSectionCard`, una tarjeta propia de fiadores NI con la etiqueta en el estilo de `SectionBlockWidget`.
- **No:** `SectionBlockWidget` para los inputs. Agrega 20 px de padding encima del que ya traen `OutlineTextfieldWidget` y `SearchDropdownWidget`, y el del dropdown no se puede cambiar, así que los campos quedan desalineados. Tampoco se modifica el widget compartido.
- **Sí:** solo en línea, sin ObjectBox. Es igual que HN, y la persistencia offline sería una spec propia.
- **Sí:** navegación con `Navigator.push(MaterialPageRoute)`, sin rutas en `go_router`. Es el mismo patrón del sheet de análisis NI y del flujo de fiadores HN.
- **No:** soporte para Costa Rica. `AnalisisInterceptorByFlavor` no llega al sheet NI en CR.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| `RELACIONPERSONAS` no está sincronizado en el ObjectBox de NI, y el dropdown sale vacío | Confirmado en código: el sync de NI no lo descargaba, así que se agregó a `_codigosCatalogo`. Si backend no lo devuelve para la base de NI, el sync lo reporta en `unsyncedCatalogos` sin cortar el resto. En ese caso se reporta a backend. |
| Backend no acepta `FuenteOtrosIngresos`, `PagoAlquiler`, `ActividadCodigo` o `TiempoActividad` en NI, o exige alguna de las llaves que se quitaron | Se confirma con el primer envío real en QA NI. Los nombres están en un solo lugar, `AnalisisFiadorNi.toJson()`. |
| Los códigos provisionales `CON` / `COD` no existen en backend y el create falla | Están centralizados en `FiadoresNiFormType`, así que corregirlos es cambiar una línea. Se prueba primero con `FIA`, que sí está confirmado. |
| Backend responde `200` en lugar de `201` en NI | Se confirma con el primer envío real en QA. El código esperado está en `createAnalisisFiador`. |

## What is **not** in this spec

- Fotos de cédula, foto del fiador y PDF al expediente digital.
- Firma del fiador.
- Búsqueda por documento y autocompletado.
- Historial crediticio.
- Campos de HN o del curl que no están en la pantalla de NI.
- Listado, edición o borrado de fiadores.
- Tag por tipo y regla de un solo cónyuge.
- Guardado offline.
- Costa Rica.
- Fiadores en garantías NI.
- Rediseño de los pasos de fiadores HN.

Cada uno, si llega, va en su propia spec.
