# SPEC 02 — Módulo de fiadores en análisis de Nicaragua

> **Status:** Approved
> **Depends on:** —
> **Date:** 2026-10-21
> **Objective:** Permitir que el asesor registre fiadores de una solicitud desde el menú de análisis de Nicaragua, con un formulario por pasos igual al de HN pero sin fotos de cédula, firma, búsqueda por documento ni historial crediticio, enviado a `POST /cartera/analisis-fiador/create`.

## Por qué existe esta spec

HN ya tiene el módulo de fiadores (`screens/cartera/analisis_solicitudes/hn/fiadores/`), pero en NI no existe nada: ni modelo, ni endpoint, ni cubit, ni pantalla. Lo único que hay es el flag `TieneFiadores` en `analisis_checks_response_ni.dart`, y hoy no se muestra en ningún lado. El body de NI comparte casi todas las llaves con `AnalisisFiadoresHn`. Lo que cambia es lo que se captura: NI no lleva fotos de cédula, firma, RTN, aldea/caserío, los tres slots CNBS, APNFD ni historial crediticio. Por eso se hace un flujo propio en `ni/` (siguiendo la regla de `CLAUDE.md`) en lugar de meter `if (flavor)` dentro del flujo de HN.

## Scope

**In:**

- DTO de request `AnalisisFiadorNi` con exactamente las llaves del curl. `toJson()` descarta los valores `null` y `''`, igual que HN.
- Endpoint `CreateAnalisisFiadorEndpointNi`: `POST /cartera/analisis-fiador/create`, con Bearer JWT y el body JSON.
- Método `createAnalisisFiador` en `AnalisisFormsRepositoryNi`. Espera `201` y devuelve `CrearFiadorResponseHn` (se reutiliza el DTO de HN).
- Cubit `AnalisisFiadoresNiCubit` + `AnalisisFiadoresNiState`, que tienen el estado del formulario y hacen el envío.
- Enum `FiadoresNiFormType` con códigos **provisionales** de tipo de fiador (ver Data model).
- Pantalla de selección de tipo `FiadoresNiScreen`: un `ModuleTileWidget` por tipo, con `ScreenHeaderWidget` y `RedesignColors`.
- Pantalla de formulario `FiadoresNiFormScreen`: `PageView` de 5 pasos con `FormStepHeaderWidget` y secciones en `FiadorNiSectionCard` (`widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart`), con el estilo del rediseño.
  1. Datos generales
  2. Datos personales
  3. Actividad económica
  4. Datos de actividad
  5. Datos de ingresos
- Pantalla de envío `AnalisisFiadoresNiSendingWidget` con `SendingStatusView`. Permite reintentar mientras siga abierta y, al terminar con éxito, vuelve a `AnalisisInterceptorByFlavor`.
- Catálogos con `SearchDropdownWidget` / `CatalogoValorNacionalidad`, usando los mismos códigos que HN, sin aldea y sin CNBS.
- Validaciones: las mismas de HN en los campos que comparten. La cédula se valida con `ClassValidator.validateCedulaByFlavor`.
- Totales calculados con las mismas fórmulas que HN.
- Nueva `SelectableCardItem` "Registrar Fiadores" en `SelectTypeAnalisisModalSheetNiWidget`:
  - Se oculta si `esGrupal`.
  - Usa `userHaveDataAlready: state.tieneFiadores`.
  - Solo funciona en línea.
  - Se agrega `'Fiadores'` a la lista de pendientes que se muestra al cerrar el análisis.
- Se permiten varios fiadores por solicitud, sin bloqueos.
- Actualizar `references/app-modules-reference.md` y `CLAUDE.md`.

**Out of scope (para futuras specs):**

- Fotos de cédula del fiador y subida del PDF al expediente digital.
- Firma del fiador y `PATCH /cartera/analisis-fiador/subir-firma`.
- Búsqueda por documento y autocompletado (`/cartera/analisis-fiador/obtener-auto-completado`).
- Historial crediticio (`HistorialCredito[]`).
- Bloque empresario completo: nombre del negocio, tiempo, horarios, condición del local y nivel de ingresos.
- Slots 2 y 3 de actividad económica y APNFD.
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
  final String direccionTrabajo, barrioTrabajo, telefonoTrabajo, lugarTrabajoAnterior;
  final int personasACargo, cantidadDependientes;
  final bool tieneDocumentosDomicilio;
  final String tipoDomicilioCodigo, duenoVivienda, profesion;
  final int anosVivirDomicilio;
  final String nombreFamiliarCercano, parentescoFamiliarCercanoCodigo;
  final String direccionFamiliarCercano, telefonoFamiliarCercano;
  final double salarioNetoCordoba, otrosIngresosCordoba, totalIngresosFamiliares;
  final double ventaNegocio, costoVenta, gastosOperativos, gananciaNegocio;
  final double otrosIngresos, consumoFamiliar, saldoDisponible;
  final bool activo;                // siempre true
  final String tipoDocumentoCodigo;
  final bool esFirmaDigitalFiador;  // siempre false
  final String tipoFiadorCodigo;    // FiadoresNiFormType.codigo
  final String escolaridadCodigo, ocupacionCodigo, profesionCodigo;
  final String paisNacimientoCodigo, nacionalidad1Codigo;
  final int cantidadHijos;
  final String tipoViviendaCodigo, tipoPersonaCNBSCodigo, estatusCodigo, tipoClienteCodigo;
  final String actividadEconomicaCNBS1Codigo, actividadEconomicaDescripcion1;
  final String paisOcupacionCodigo, departamentoOcupacionCodigo, municipioOcupacionCodigo;

  Map<String, dynamic> toJson(); // llaves EXACTAS del curl, incluida 'Nacionalidad1codigo' con "c" minúscula
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

**Campos por paso** (catálogo entre paréntesis):

| Paso | Campos |
| --- | --- |
| 1. Datos generales | TipoDocumentoCodigo (`TIPODOCUMENTOPERSONA`, por defecto `CEDULAIDENTIDAD`), Cedula, Nombre1, Nombre2, Apellido1, Apellido2, FechaNacimiento, PaisNacimientoCodigo (`PAIS`), SexoCodigo (`SEXO`), EstadoCivilCodigo (`ESTADOCIVIL`), RelacionClienteCodigo (`RELACIONPERSONAS`), PersonasACargo |
| 2. Datos personales | PaisCodigo → DepartamentoCodigo → MunicipioCodigo (`PAIS`/`DEP`/`MUN`, en cascada con `where:`), BarrioCasa, Direccion, Nacionalidad1codigo (`CatalogoValorNacionalidad`), Telefono, Celular, Email, EscolaridadCodigo (`ESCOLARIDAD`), ProfesionCodigo (`PROFESION`), OcupacionCodigo (`OCUPACION`), CantidadDependientes, CantidadHijos, TipoPersonaCNBSCodigo (`TIPOPERSONACNBS`), EstatusCodigo (`ESTATUSCLIENTE`), TipoClienteCodigo (`TIPOCLIENTE`) |
| 3. Actividad económica | ActividadEconomicaCNBS1Codigo (`ACTIVIDADECONOMICA`), ActividadEconomicaDescripcion1 |
| 4. Datos de actividad | Switch EsAsalariado → Empresa, Cargo, TiempoLaborar, DireccionTrabajo, BarrioTrabajo, TelefonoTrabajo, LugarTrabajoAnterior. Switch EsEmpresario. PaisOcupacionCodigo → DepartamentoOcupacionCodigo → MunicipioOcupacionCodigo |
| 5. Datos de ingresos | SalarioNetoCordoba, OtrosIngresosCordoba, TotalIngresosFamiliares (solo lectura). VentaNegocio, CostoVenta, GastosOperativos y GananciaNegocio (solo lectura) aparecen solo si EsEmpresario. OtrosIngresos, ConsumoFamiliar, SaldoDisponible (solo lectura), Tipo de propiedad (`TIPOVIVIENDA`, se guarda en TipoDomicilioCodigo y TipoViviendaCodigo), AnosVivirDomicilio, TieneDocumentosDomicilio, DuenoVivienda, NombreFamiliarCercano, ParentescoFamiliarCercanoCodigo (`PARENTESCO`), DireccionFamiliarCercano, TelefonoFamiliarCercano |

Convenciones:

- Fórmulas (iguales a HN, en `AnalisisFiadoresCubit`):
  - `TotalIngresosFamiliares = SalarioNetoCordoba + OtrosIngresosCordoba`
  - `GananciaNegocio = VentaNegocio - CostoVenta - GastosOperativos`
  - `SaldoDisponible = TotalIngresosFamiliares + GananciaNegocio + OtrosIngresos - ConsumoFamiliar`
- Los campos de moneda aceptan decimales: `numberWithOptions(decimal: true)`, `CurrencyInputFormatter()` y `toNumericString(v, allowPeriod: true)`.
- Si EsEmpresario está apagado, VentaNegocio, CostoVenta, GastosOperativos y GananciaNegocio se envían en `0`.
- `Profesion` (texto) se llena con el nombre del ítem elegido en `PROFESION`. `ProfesionCodigo` se llena con su código.
- Valores fijos: `Activo = true`, `EsFirmaDigitalFiador = false`, `database = LocalStorage().database`.

## Implementation plan

1. Crear `lib/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart` con `AnalisisFiadorNi` y su `toJson()`. Verificar con `flutter analyze`.
2. Agregar `CreateAnalisisFiadorEndpointNi` en `lib/src/domain/repository/analisis/ni/endpoint/analisis_forms_endpoint_ni.dart`, y `createAnalisisFiador(AnalisisFiadorNi)` en `AnalisisFormsRepositoryNi` / `Impl` usando `_post()`. Debe esperar `201` y devolver `CrearFiadorResponseHn`.
3. Crear `lib/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart` + `_state.dart`:
   - El state lleva todos los campos del DTO, `status` y `errorMsg`.
   - `onFieldChanged(() => state.copyWith(...))`.
   - `setTipoFiador(FiadoresNiFormType)`.
   - `createAnalisisFiador({required int numeroSolicitud})` calcula los totales, arma el DTO y emite `inProgress`, después `done` o `error`.
4. Crear `screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_screen.dart`:
   - Lleva `ScreenHeaderWidget` y un `ModuleTileWidget` por cada valor de `FiadoresNiFormType`.
   - Al tocar un tipo, abre `FiadoresNiFormScreen`.
   - Si no hay conexión según `InternetConnectionCubit`, muestra `showV2CustomSnackbar` de advertencia y no navega.
5. Crear `screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_form_screen.dart`:
   - Contiene el enum, el `BlocProvider` de `AnalisisFiadoresNiCubit` y el `PageView` con `NeverScrollableScrollPhysics`.
   - Arriba va `FormStepHeaderWidget` con los 5 pasos en el mismo orden que el `PageView`.
   - Al principio, cada paso es un placeholder.
6. Crear `widgets/analisis_solicitudes/ni/fiadores/analisis_fiadores_ni_datos_generales.dart` (paso 1) y conectarlo al `PageView`.
   - El botón "Siguiente" valida el `Form` del paso antes de avanzar.
7. Crear `analisis_fiadores_ni_datos_personales.dart` (paso 2). Tiene la cascada País → Departamento → Municipio.
8. Crear `analisis_fiadores_ni_actividad_economica.dart` (paso 3).
9. Crear `analisis_fiadores_ni_datos_de_actividad.dart` (paso 4). Tiene los switches EsAsalariado y EsEmpresario y la cascada de ocupación.
10. Crear `analisis_fiadores_ni_datos_de_ingresos.dart` (paso 5):
    - Muestra los totales en solo lectura y los campos de negocio de forma condicional.
    - El botón "Enviar" valida el paso y abre la pantalla de envío.
11. Crear `widgets/analisis_solicitudes/ni/fiadores/analisis_fiadores_ni_sending_widget.dart`:
    - Llama `createAnalisisFiador` en `initState` y muestra `SendingStatusView`.
    - Si falla, se puede reintentar. Si sale bien, vuelve a `AnalisisInterceptorByFlavor`.
12. En `select_type_analisis_modal_sheet_ni_widget.dart`:
    - Agregar la `SelectableCardItem` "Registrar Fiadores" (`if (!esGrupal)`, `userHaveDataAlready: state.tieneFiadores`), que hace push de `FiadoresNiScreen(numeroSolicitud: ...)`.
    - Agregar `'Fiadores': state.tieneFiadores` a `analisisItems`.
13. Actualizar `references/app-modules-reference.md` con el submódulo Fiadores en NI (solo en línea, CR no aplica). Agregar en `CLAUDE.md` una línea sobre el flujo de fiadores NI y los códigos provisionales de `FiadoresNiFormType`.

## Acceptance criteria

- [ ] `flutter analyze` no reporta issues nuevos en los archivos creados o modificados.
- [ ] En NI, el sheet de análisis de una solicitud individual muestra "Registrar Fiadores".
- [ ] En una solicitud grupal NI, el sheet no muestra "Registrar Fiadores".
- [ ] Si `TieneFiadores` es `true`, la tarjeta se ve como "ya registrado", pero se puede volver a entrar y registrar otro fiador.
- [ ] Al cerrar el análisis sin fiadores, "Fiadores" aparece en la lista de pendientes del diálogo.
- [ ] `FiadoresNiScreen` muestra un mosaico por cada valor de `FiadoresNiFormType`.
- [ ] Sin conexión, tocar un tipo muestra un snackbar de advertencia y no abre el formulario.
- [ ] El formulario tiene 5 pasos, y `FormStepHeaderWidget` muestra "Paso X de 5" con el nombre correcto de cada paso.
- [ ] No hay paso de fotos de cédula, firma, búsqueda por documento ni historial crediticio.
- [ ] No se puede avanzar de paso si un campo obligatorio (los mismos que en HN) está vacío o no es válido.
- [ ] Una cédula NI con formato inválido muestra el error de `validateCedulaByFlavor`.
- [ ] Al elegir otro departamento, el municipio se limpia y el dropdown de municipio solo muestra los de ese departamento.
- [ ] Con salario 12000, otros ingresos en córdobas 500, otros ingresos 500, consumo 6000 y EsEmpresario apagado, la pantalla muestra un total de 12,500 y un saldo disponible de 7,000.
- [ ] Con EsEmpresario apagado, los campos de negocio no aparecen y se envían en `0`.
- [ ] El body enviado (visible en `BitacoraService`) usa exactamente las llaves del curl. Incluye `Nacionalidad1codigo`, `Activo: true`, `EsFirmaDigitalFiador: false` y el `TipoFiadorCodigo` del tipo elegido, y no incluye `RTN`, `AldeaCodigo` ni `HistorialCredito`.
- [ ] Ninguna llave con valor `''` o `null` aparece en el body.
- [ ] Con una respuesta `201`, la pantalla de envío muestra éxito y vuelve a `AnalisisInterceptorByFlavor`.
- [ ] Con una respuesta de error, la pantalla de envío muestra el mensaje del backend. "Reintentar" reenvía con los mismos datos sin volver a llenar el formulario.
- [ ] Ningún archivo nuevo vive bajo `hn/`, y ningún archivo de HN fiadores cambia.
- [ ] Se registró un fiador real en QA NI con la solicitud de prueba, y backend lo confirmó (verificación manual).

## Decisions

- **Sí:** flujo propio en `ni/` (DTO, cubit, pantallas, widgets). Es lo que pide `CLAUDE.md` y no toca el flujo de HN que ya funciona.
- **No:** reutilizar `FiadoresHnFormScreen` con `if (flavor)`. Mezclaría pasos, catálogos y endpoints de dos países en una sola clase.
- **Sí:** reutilizar `CrearFiadorResponseHn` como respuesta. `AnalisisFormsRepositoryNi` ya reutiliza DTOs de HN, y la respuesta (`ok`, `message`, `data.FiadorID`) es la misma.
- **Sí:** el método va en `AnalisisFormsRepositoryNi`. Ya tiene el helper `_post()` que espera `201`.
- **Sí:** tipos de fiador en un enum con códigos provisionales (`FIA`, `CON`, `COD`). El usuario los corrige después. Solo `FIA` está confirmado por el curl.
- **Sí:** formulario directo, sin búsqueda ni autocompletado. No hay confirmación de que el endpoint de autocompletado sirva para NI.
- **No:** firma digital. NI no la lleva, así que `EsFirmaDigitalFiador` siempre es `false`.
- **No:** fotos de cédula ni expediente digital. Lo pidió el usuario.
- **No:** historial crediticio. No viene en el curl de NI.
- **Sí:** se permiten varios fiadores, y la tarjeta del sheet usa `TieneFiadores`. NI no devuelve checks por tipo, así que no hay tag por tipo ni regla de un solo cónyuge.
- **Sí:** los catálogos usan los mismos códigos que HN (`RELACIONPERSONAS`, `PROFESION`, `OCUPACION`, `TIPOPERSONACNBS`, `ESTATUSCLIENTE`, `TIPOCLIENTE`). Si alguno viene vacío en NI, se reporta a backend en lugar de inventar valores.
- **No:** mandar TipoPersonaCNBS, Estatus o TipoCliente con valores fijos. Eso ocultaría un problema de sincronización de catálogos.
- **Sí:** un solo slot de actividad con `ACTIVIDADECONOMICA`. `CatalogoActividadesCNBSDropdown` solo lee el box de HN, y el curl trae un solo slot.
- **No:** los 3 slots CNBS ni APNFD.
- **Sí:** para empresario, solo el switch y los montos del negocio. Las demás llaves del bloque empresario de HN no vienen en el curl de NI.
- **Sí:** pasos con rediseño (`FormStepHeaderWidget`, `RedesignColors`). `CLAUDE.md` lo pide para pantallas nuevas. Se mantienen los mismos pasos y campos que HN, menos lo excluido.
- **Sí:** secciones en `FiadorNiSectionCard`, una tarjeta propia de fiadores NI con la etiqueta en el estilo de `SectionBlockWidget`.
- **No:** `SectionBlockWidget` para los inputs. Agrega 20 px de padding encima del que ya traen `OutlineTextfieldWidget` y `SearchDropdownWidget`, y el del dropdown no se puede cambiar, así que los campos quedan desalineados. Tampoco se modifica el widget compartido.
- **Sí:** las mismas validaciones obligatorias que HN, y la cédula con `validateCedulaByFlavor`.
- **Sí:** solo en línea, sin ObjectBox. Es igual que HN, y la persistencia offline sería una spec propia.
- **Sí:** navegación con `Navigator.push(MaterialPageRoute)`, sin rutas en `go_router`. Es el mismo patrón del sheet de análisis NI y del flujo de fiadores HN.
- **No:** soporte para Costa Rica. `AnalisisInterceptorByFlavor` no llega al sheet NI en CR.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| Los catálogos `RELACIONPERSONAS`, `PROFESION`, `OCUPACION`, `TIPOPERSONACNBS`, `ESTATUSCLIENTE` o `TIPOCLIENTE` no están sincronizados en el ObjectBox de NI, y el dropdown sale vacío | Verificar en QA NI al implementar el paso 2. Si falta alguno, se reporta a backend. Si ese campo bloquea el envío, se deja temporalmente como opcional y se anota en la spec. |
| Los códigos provisionales `CON` / `COD` no existen en backend y el create falla | Están centralizados en `FiadoresNiFormType`, así que corregirlos es cambiar una línea. Se prueba primero con `FIA`, que sí está confirmado. |
| Los límites de edad de la fecha de nacimiento en HN dependen de parámetros que no existan en NI | Al implementar el paso 1, revisar de dónde lee HN esos límites. Si no hay parámetro en NI, se validan solo fecha requerida y mayoría de edad, y se anota. |
| Backend responde `200` en lugar de `201` en NI | `_post()` centraliza el código esperado. Se confirma con el primer envío real en QA. |
| El body crece y se desalinea del curl | El criterio de aceptación pide revisar el body en `BitacoraService` contra la lista de llaves del curl. |

## What is **not** in this spec

- Fotos de cédula y PDF al expediente digital.
- Firma del fiador.
- Búsqueda por documento y autocompletado.
- Historial crediticio.
- Bloque empresario completo, slots CNBS 2/3 y APNFD.
- Listado, edición o borrado de fiadores.
- Tag por tipo y regla de un solo cónyuge.
- Guardado offline.
- Costa Rica.
- Fiadores en garantías NI.
- Rediseño de los pasos de fiadores HN.

Cada uno, si llega, va en su propia spec.
