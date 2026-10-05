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
| Solicitudes y análisis | Análisis | ✅ (online y offline) | ✅ | ⚠️ placeholder | — |
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
- **Análisis offline**: `CarteraScreen` siempre abre `AnalisisSolicitudesHnOfflineScreen` sin conexión, también en NI/CR.
- **Solicitudes y Análisis** no validan permiso: el chequeo de `llenarSolicitudes` está comentado en `cartera_screen.dart`.
