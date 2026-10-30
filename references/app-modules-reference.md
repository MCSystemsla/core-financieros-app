# Módulos principales por país

Fuente: `home_items_widget.dart`, `cartera_screen.dart`, `select_solicitud_hn_screen.dart`, `select_solicitud_ni_screen.dart`, `analisis_interceptor_by_flavor.dart`.
Costa Rica reutiliza las pantallas `ni`.

Leyenda: ✅ disponible · ❌ no disponible · 🌐 solo en línea · 🔒 requiere permiso (`TypeAction`)

## Home

| Módulo | Honduras | Nicaragua | Costa Rica | Permiso / condición |
|---|---|---|---|---|
| Cartera | ✅ | ✅ | ✅ | 🔒 `menuCartera` |
| OTP (validación del cliente) | ✅ 🌐 | ❌ | ❌ | 🔒 `moduloOtp` |
| Tutoriales | ❌ | ✅ 🌐 | ✅ 🌐 | — |

## Cartera

| Sección | Módulo | Honduras | Nicaragua | Costa Rica | Permiso / condición |
|---|---|---|---|---|---|
| Solicitudes y análisis | Solicitudes | ✅ | ✅ | ✅ | — |
| Solicitudes y análisis | Análisis | ✅ (online y offline) | ✅ (online y offline) | ⚠️ placeholder | — |
| Solicitudes y análisis | Análisis → Fiadores | ✅ (online y offline, envío en línea) | ✅ (online y offline, envío en línea) | ❌ | — |
| Solicitudes y análisis | Análisis → Plan de inversión | ✅ (online y offline, envío en línea) | ✅ 🌐 | ❌ | — |
| Solicitudes y análisis | Supervisiones (crédito, riesgo, regional) | ✅ 🌐 | ❌ | ❌ | 🔒 `supervisionDeCredito` |
| Formularios Kiva | Kiva (online y offline) | ❌ | ✅ | ✅ | 🔒 `llenarKiva` |
| Formularios Kiva | Kiva Histórico | ❌ | ✅ 🌐 | ✅ 🌐 | 🔒 `llenarKiva` |
| Seguimiento | Comité | ✅ 🌐 | ❌ | ❌ | 🔒 `comite` |
| Seguimiento | Reportería | ✅ 🌐 | ❌ | ❌ | — |

## Solicitudes

| Sección | Módulo | Honduras | Nicaragua | Costa Rica | Permiso / condición |
|---|---|---|---|---|---|
| Crear solicitud | Comercial / Nueva (negocio propio) | ✅ | ✅ | ✅ | — |
| Crear solicitud | Asalariado | ✅ | ✅ | ✅ | — |
| Crear solicitud | Represtamo | ❌ | ✅ | ✅ | — |
| Crear solicitud | Grupales (crédito grupal) | ✅ 🌐 | ❌ | ❌ | 🔒 `crearGrupoCredito` |
| Gestión | Modificación | ✅ 🌐 | ❌ | ❌ | 🔒 `solicitudCreditoModificar` |
| Gestión | Asignación | ✅ 🌐 | ✅ 🌐 | ✅ 🌐 | 🔒 `asignacion` |
| Gestión | Autorización | ✅ 🌐 | ✅ 🌐 | ✅ 🌐 | 🔒 `autorizacion` |
| Gestión | Rechazar solicitud | ✅ 🌐 | ✅ 🌐 | ✅ 🌐 | 🔒 `rechazarSolicitud` |
| Mi trabajo | Solicitudes en proceso offline | ✅ | ✅ | ✅ | — |
| Mi trabajo | Mis solicitudes asignadas | ✅ | ✅ | ✅ | — |

## Observaciones

- **Análisis en Costa Rica**: `AnalisisInterceptorByFlavor` devuelve `Text('This is costa rica')`; el módulo no está implementado.
- **Análisis offline**: sin conexión, `CarteraScreen` abre `AnalisisSolicitudesNiOfflineScreen` en NI y `AnalisisSolicitudesHnOfflineScreen` en HN/CR. La lista NI sale de `AnalisisListDataHn`, que llena el sync de NI (`SolicitudCatalogoCubit.guardarAnalisisAsignadosNi`, solo página 1). Su sheet ofrece análisis, imágenes del negocio, ubicación y fiadores. El sheet offline de HN ofrece análisis, imágenes del negocio y ubicación, más el plan de inversión y los fiadores solo con `Flavor.honduras` (CR no los ve). Fiadores no aparece en solicitudes grupales, igual que en línea. El plan de inversión no está offline en NI. En HN, la lista offline también muestra las solicitudes creadas offline que todavía no tienen número (tag "Sin número"): sus datos se guardan con un número provisional negativo, nada se envía, y al abrir después la AUT con la misma cédula y tipo se ofrece pasarle esos datos (SPEC 06).
- **Solicitudes y Análisis** no validan permiso: el chequeo de `llenarSolicitudes` está comentado en `cartera_screen.dart`.
- **Fiadores en el análisis**: se entra desde el sheet de análisis (`SelectTypeAnalisisModalSheetWidget` en HN, `SelectTypeAnalisisModalSheetNiWidget` en NI). HN pide fotos de cédula, firma y búsqueda por documento; NI no. En HN también se puede registrar sin conexión desde el sheet offline: la búsqueda por documento se salta, y el fiador queda pendiente en el teléfono (con copias de las fotos y la firma) para enviarlo a mano desde `FiadoresHnPendientesScreen`, a la que se llega desde `FiadoresHnScreen`. En NI no hay selección de tipo de fiador y no se envía `TipoFiadorCodigo`. En NI también se puede registrar sin conexión desde el sheet offline: el fiador queda pendiente en el teléfono y se envía a mano desde `FiadoresNiPendientesScreen` al volver a estar en línea. Costa Rica no llega a ninguno de los dos sheets.
