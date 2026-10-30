# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

Flutter frontend for **MiCrédito**, a multi-country financial (microcredit) core app built by MCSYSTEM. Same codebase ships as three separate country apps (Honduras, Nicaragua, Costa Rica) plus a QA build, distinguished by `Flavor` (`lib/src/datasource/flavor/flavor.dart`), Android product flavors, and a dedicated `main*.dart` entry point per country.

## Setup

```
dart run tool/build_script.dart
```
Runs `flutter pub get` + `flutter pub run build_runner build` (needed for Isar/ObjectBox generated code).

iOS (Mac only):
```
cd ios && pod cache clean --all && pod repo update && pod install && pod update
```

API keys: copy `api-key.json.tpl` to `api-key.json`, `api-key-local.json`, `api-key-prod.json`, `api-key-hn.json`, `api-key-hn-prod.json` and fill in real values (apiUrl, protocol, Cloudflare access creds, Google Sheets log URLs, Google Places key, reporte-service URL/key). These are `--dart-define-from-file` inputs, read via `String.fromEnvironment(...)` (see `lib/src/api/api_repository.dart`) — never hardcode secrets in Dart source.

## Running / building

Entry points map to countries, each with its own flavor:
- `lib/main.dart` → `Flavor.nicaragua`, Android flavor `micreditoNicaragua`
- `lib/main_hn.dart` → `Flavor.honduras`, Android flavor `micreditoHonduras`
- `lib/main_cr.dart` → `Flavor.costaRica`, Android flavor `micreditoCostaRica`
- `micreditoQA` flavor uses `lib/main.dart`

Run/debug (see `.vscode/launch.json` for the full matrix):
```
flutter run --flavor micreditoHonduras --dart-define-from-file=api-key.json --target=lib/main_hn.dart
```

Release builds (repeat per country, swapping target/flavor/key file), always obfuscated:
```
flutter build apk --flavor micreditoHonduras --dart-define-from-file=api-key.json --target=lib/main_hn.dart --release --obfuscate --split-debug-info=../
flutter build appbundle --flavor micreditoNicaragua --dart-define-from-file=api-key-prod.json --target=lib/main.dart --release --obfuscate --split-debug-info=../
flutter build ipa --flavor micreditoHonduras --dart-define-from-file=api-key.json --target=lib/main_hn.dart --release --obfuscate --split-debug-info=../
```

App version scheme: `X.Y.Z` — X for breaking platform changes, Y for new features/modules, Z for bugfixes/small tweaks. Android flavor blocks in `android/app/build.gradle` carry their own independent `versionName`/`versionCode` per country; `versionCode` always goes up by 1 per release of that flavor.

For releases, use the `release-captain` agent (`.claude/agents/release-captain.md`). It bumps the flavor's version, runs `flutter analyze`, flags block issues (missing `dimension "country"`, `signingConfigs.debug` on a production flavor), and gives you the obfuscated build command. It does not build or commit unless asked.

For QA, use the `jarvis` agent (`.claude/agents/jarvis.md`). It looks for real bugs in a screen, module or branch (async/`mounted`, cubit state, nulls and parsing, decimal amounts, HN/NI/CR divergence, offline sync, auth) and returns a report by severity with `file:line`, repro steps, a proposed fix and a suggested test, plus improvement suggestions. It is read-only.

## Lint / analyze

```
flutter analyze
```
`analysis_options.yaml` extends `flutter_lints` with `prefer_single_quotes: true` and `always_specify_types: false`.

## Tests

```
flutter test
```
Unit tests live under `test/`, mirroring the `lib/src/` path of the code they cover (e.g. `test/config/services/pdf/`). Only pure logic is covered so far. There are no widget or integration tests.

## Architecture

`lib/src/` is layered `api → datasource → domain → presentation`, plus `config` and `utils`:

- **`api/`** — transport layer. `DefaultAPIRepository` (`api_repository.dart`) is the single HTTP client: builds the URL from `apiUrl`/`protocol` dart-defines + an `Endpoint`, attaches Cloudflare Access headers, dispatches by `Method`, handles `TypeBody.formData` (multipart file upload) separately, and on a `401` transparently calls `AuthRepositoryImpl().refreshToken()`, persists the new tokens to `LocalStorage`, and retries once (skipped for `RefreshTokenEndpoint` itself to avoid loops). Every request/response is also mirrored to `BitacoraService`/`ErrorReporter`.
- **`Endpoint`** (`api/endpoint.dart`) is the abstract request descriptor (`path`, `method`, `headers`, `body`, `queryParameters`, `files`). Concrete endpoints live under `domain/repository/<feature>/[hn|ni]/endpoint/` and are one-per-call.
- **`datasource/`** — plain Dart models (request/response DTOs) and local persistence services. Two local DB engines are in play: **Isar** (legacy, e.g. `local_db/image_model.dart`, `solicitudes_pendientes.dart` — generated `.g.dart` files) and **ObjectBox** (newer; `*BoxService` classes such as `ObjectBoxService`, `SolicitudesHnBoxService`, `AnalisisBoxServiceHn`, initialized once via `.init()` and registered as GetIt singletons in `global_locator.dart`). Regenerate bindings with build_runner after touching any `@Entity`/Isar collection.
- **`domain/repository/`** — one repository interface + `*Impl` per feature, calling `APIRepository` under the hood. Where a feature diverges by country it is split into `hn/` and `ni/` subfolders with parallel endpoint sets and sometimes parallel repositories (e.g. `solicitudes_credito/hn` vs `solicitudes_credito/ni`, `analisis/hn` vs `analisis/ni`, `comite/hn` vs `comite/ni`, `supervisiones/hn` vs `supervisiones/ni`). Costa Rica currently reuses the `ni` implementations. When adding a feature that differs per country, follow this same `hn`/`ni` split rather than branching inside one class.
- **`presentation/bloc/`** — `flutter_bloc` Cubits/Blocs, one directory per feature, mirroring the domain repository split (e.g. `bloc/solicitudes-pendientes`, `bloc/comite`, `bloc/analisis`). `FlavorCubit` holds the active `Flavor` and is read via `global<FlavorCubit>()` (not `BlocProvider.of`) in places that branch UI/logic by country — see `SolicitudesByFlavorInterceptor` for the standard pattern: `switch (global<FlavorCubit>().state.flavor) { Flavor.honduras => HnScreen(), _ => NiScreen() }`.
- **`presentation/screens/`** and **`presentation/widgets/`** — screens grouped by feature; shared/reusable UI in `widgets/shared`.
- **`config/`** — cross-cutting concerns: `router/router.dart` (`go_router` route table), `theme/`, `local_storage/` (SharedPreferences wrapper — JWT/refresh token/current user/language live here), `services/` (biometric auth, camera, geolocation, Firebase, bitácora/audit logging, and `pdf/ImagesToPdfService`, which combines local images into one A4 PDF for the expediente digital. It is static and shared by all countries, and throws `ImagesToPdfException`. The PDFs are uploaded with `ExpedienteDigitalRepository` in `domain/repository/expediente_digital/`, which is also shared and does `PUT /cartera/digital-files/upload`; every expediente filename is a value of the `DigitalFilename` enum in that same file, so add new ones there), `helpers/` (formatters, validators, error handling/reporting, sync helpers, kiva-specific logic), `data/` (static data such as the Google Maps custom style).
- **`utils/extensions/`** — most enum-like domain concepts (garantía type, artículo type, form type, role, order type, etc.) are modeled as extensions on `String`/enums rather than standalone classes — check here before adding a new type helper.

### UI redesign (2026)

Two visual systems coexist. The legacy one is `config/theme/app_colors.dart` (`AppColors`) + `app_theme.dart` (`AppTheme.getTheme`, Material 3 seeded from `AppColors.getPrimaryColor()`); the new one is `config/theme/redesign_colors.dart` (`RedesignColors`: `background`, `surface`, `border`, `ink`, `inkMuted`, plus tint/solid pairs like `greenTint`/`green`) together with the shared component set in `presentation/widgets/shared/v2_redesign/`:

- `ScreenHeaderWidget` — standard screen header (back button, big title, subtitle, trailing slot defaulting to `ConnectionPillWidget`).
- `ModuleTileWidget` / `ModuleIconTile` / `ModuleEntryCard` — module list rows and entry cards; `tag` surfaces business rules the advisor must see before tapping (e.g. `'Solo en línea'`).
- `SolicitudEstadoCard` + `CardTagWidget` — credit-request cards for the by-state lists in both countries (HN: assigned, reject, update, supervisiones; NI: asignación, autorización, rechazo, análisis). Replaces `CreditProductDynamicHn` / `CreditProductItemHn` (NI's `CreditProductItem` is already deleted).
- `SolicitudClienteHeader` + `InfoRowWidget` — read-only request/client data (step 1 of the supervisiones forms). Use these instead of `OutlineTextfieldWidget(readOnly: true)`.
- `FormStepHeaderWidget` — header for multi-step forms driven by a `PageController`: current/next step label, "Paso X de N" and a segmented progress bar. `steps` must follow the same order as the `PageView` children. Used by the HN supervisiones forms, offline nueva solicitud, asalariado and nueva menor.
- `SectionBlockWidget`, `HeaderBackButton`, `ConnectionPillWidget` (reads `InternetConnectionCubit`), `SendingStatusView` (Lottie-driven send/progress screens).
- `CelebrationBurst` — one-shot confetti burst with a haptic, drawn with a `CustomPainter` (no assets), ignores touches. `SendingStatusView` fires it through `celebrate`; when that is null, it fires on success, which it detects from `artTint == RedesignColors.greenTint`. When system animations are off, it only fires the haptic.

Screens are being migrated incrementally (the `rebranding_ui_app` branch). When redesigning or adding a screen, compose these widgets and take colors from `RedesignColors` instead of `AppColors`; do not restyle screens that have not been migrated yet.

Already migrated in HN análisis: garantías (`garantia_screen.dart`, `crear_garantia_screen.dart`, `tipos_garantia_hn_widget.dart`) and plan de inversión (`plan_inversion_screen.dart`). Garantías use the feature-specific `GarantiaItemCard` (`widgets/analisis_solicitudes/hn/garantia/garantia_item_card.dart`): a dashed "pending slot" while the garantía has no bien assigned (and is not DPF), and a solid card colored by garantía type once assigned.

### HN garantías: decimal amounts

Valor comercial and related currency fields in the HN garantía crear/actualizar forms (vehículo, maquinaria, derecho, DPF, hipotecario under `widgets/analisis_solicitudes/hn/garantia/v2/`) accept decimals: `TextInputType.numberWithOptions(decimal: true)`, `CurrencyInputFormatter()` with no `mantissaLength: 0`, and `toNumericString(value, allowPeriod: true)` when parsing. The response model (`analisis_garantia_obtener_bien_response.dart`) parses these values as `double`, not `int`. Keep this when adding a new garantía form.

### HN análisis: plan de inversión offline

`PlanInversionScreen` keeps an automatic local draft in Honduras, with or without a connection. Sending is never automatic.

- The draft is one `AnalisisPlanInversionHnLocalDb` row per `numeroSolicitud` + `LocalStorage().userId` (`datasource/analisis/hn/plan_inversion/local_db/`), registered in `AnalisisBoxServiceHn` (`get`/`save`/`removePlanInversionBorrador`). `itemsJson` holds the articles via `PlanInversion.toLocalJson()` (includes `uuid`); `toJson()`, the backend body, does not send `uuid`.
- `AnalisisPlanInversionHnCubit` loads the draft in `serNumeroSolicitud` and saves it on every create/edit/delete. An empty list deletes the row. A `201` deletes it. A failed send keeps it. `state.fechaBorrador` drives the "Borrador en el teléfono" tag.
- Everything is gated by `AnalisisPlanInversionHnCubit.usaBorrador` (`Flavor.honduras`). NI also opens this screen from its online sheet and keeps the old in-memory behavior.
- Offline (HN only), "Enviar" is disabled and an amber notice is shown. The HN offline sheet (`_SelectTypeAnalisis` in `analisis_solicitudes_hn_offline_screen.dart`) shows "Registrar Plan de inversión" only with `Flavor.honduras`, because Costa Rica opens that screen too.
- Drafts are not deleted on logout. Closing the análisis still uses `TienePlanInversion` from the backend.

Spec: `specs/04-plan-inversion-hn-offline.md`.

### HN análisis: fiadores offline

HN fiadores (`FiadoresHnScreen` → `FiadoresSearchByDocumentScreen` → `FiadoresHnFormScreen` → `AnalisisFiadoresSendingWidget`) can be captured without a connection and sent by hand later. Sending is never automatic.

- Entry: the HN offline sheet (`_SelectTypeAnalisis` in `analisis_solicitudes_hn_offline_screen.dart`) shows "Registrar Fiadores" only with `Flavor.honduras` (Costa Rica shares that screen) and never for grupal requests, like the online sheet.
- Offline, `FiadoresHnScreen` skips `checkFiadorAval` and hides the "Registrado" tags; `FiadoresSearchByDocumentScreen` skips the backend lookup and calls `AnalisisSearchByDocumentCubit.setUserOffline` (same as `isNewUser`). Cónyuge is blocked if the backend says so (online) or the request already has a local `TFD2` pending.
- On the last step, "Enviar" opens `AnalisisFiadoresSendingWidget(guardarLocal: !isConnected)`. With `guardarLocal`, `AnalisisFiadoresCubit.guardarFiadorLocal` copies the cédula photos and the signature to `getApplicationDocumentsDirectory()/fiadores_hn/<uuid>/` (`cedula_frente.jpg`, `cedula_reverso.jpg`, `firma.png`) and saves an `AnalisisFiadorHnLocalDb` row (`datasource/analisis/hn/fiadores/local_db/`, in `AnalisisBoxServiceHn`). `payloadJson` is `AnalisisFiadoresHn.toJson()`; sending rebuilds it with `AnalisisFiadoresHn.fromJson`. Online sending is unchanged; there is no "save for later" on a network error.
- Rows are scoped to `LocalStorage().userId`, are not deleted on logout, and the same cédula cannot be saved twice for the same request.
- `FiadoresHnPendientesScreen` (`FiadoresHnPendientesCubit`) is reached from the "Pendientes en el teléfono (N)" row of `FiadoresHnScreen` (its count watches the ObjectBox box) or after saving. Sending a pending is three steps: create the fiador if `fiadorId` is empty and store the returned `fiadorId` on the row, send the signature, then upload the cédula PDF with `subirCedulaFiadorHn` (failures there are only reported, as online). Once the signature is sent, `removeFiadorHnPendiente` deletes the row and its folder. If the signature fails, the row keeps its `fiadorId` ("Falta la firma" tag) and the next send starts at the signature, so the fiador is never created twice.
- Closing the análisis ignores local pending fiadores.

Spec: `specs/05-fiadores-hn-offline.md`.

### HN análisis: solicitudes sin número

In Honduras, the advisor can fill in the análisis, plan de inversión, fiadores, imágenes and ubicación of a solicitud created offline that has no number yet (not sent, or not authorized). When the AUT solicitud arrives, the data can be moved to it. Sending is never automatic.

- `AnalisisSolicitudesHnOfflineScreen` (only `Flavor.honduras`) also lists the finished local solicitudes (`isDone`) from `SolicitudesHnBoxService` (nueva, asalariado, represtamo; never grupal), plus orphan drafts whose local solicitud was already deleted by the 30-day cleanup. Those whose AUT is already in `AnalisisListDataHn` (same normalized cédula + base type) are hidden. They show a "Sin número" tag.
- Tapping one calls `getOrCreateBorradorSinNumero` and opens the usual sheet with a provisional number. The draft is one `AnalisisBorradorSinNumeroHnLocalDb` row (`datasource/analisis/hn/borrador_sin_numero/`, in `AnalisisBoxServiceHn`) per `userId` + cédula + base type; the provisional number is `-id`. All existing tables store their data under that negative `numeroSolicitud` (as `'-<id>'` in imágenes and ubicación), so no query changed.
- With `numeroSolicitud < 0` nothing calls the backend, even with a connection: the send buttons of the four análisis forms, plan and fiadores pendientes are disabled, the fiador form always saves locally, `FiadoresHnScreen`/`FiadoresSearchByDocumentScreen` behave as offline, and imágenes only saves locally. `SinNumeroNoticeWidget` shows the amber notice, and `numeroSolicitudLabel` renders "sin número" in subtitles (`widgets/analisis_solicitudes/hn/borrador_sin_numero/`).
- Before opening the sheet of an AUT solicitud (`AnalisisCreditCardHn` online, sync rows of `AnalisisCreditoOfflineCard` offline), `ofrecerBorradorSinNumeroHn` looks for a draft of the user with the same cédula and base type and shows `UsarBorradorSinNumeroDialog`: "Usar", "Ahora no" (asks again next time) or "Descartar" (confirmed, deletes the draft data and fiador folders).
- "Usar" calls `vincularBorradorSinNumero` in one ObjectBox transaction, per module (`ModuloBorradorHn`): if the real number already has local data in that module, the real one wins and the draft's is discarded; otherwise the draft's rows get the real number. If the AUT monto changes the análisis form (`getTipoSolicitud`, menor ↔ mayor de mil), the draft's análisis is discarded and the other modules are still linked. `ResumenVinculoBorradorDialog` shows the result.
- Drafts are scoped to `LocalStorage().userId` and are not deleted on logout or by age. Represtamo local rows have no `userId`, so they are listed for any user.

Spec: `specs/06-analisis-hn-solicitud-sin-numero.md`.

### NI análisis: fiadores

NI has its own fiador flow, separate from HN's: `FiadoresNiFormScreen` → `AnalisisFiadoresNiSendingWidget` (`screens/cartera/analisis_solicitudes/ni/fiadores/`, `widgets/analisis_solicitudes/ni/fiadores/`). There is no fiador-type selection screen. The "Registrar Fiadores" card in `SelectTypeAnalisisModalSheetNiWidget` calls `FiadoresNiPendientesScreen.open`, which opens the form directly unless the request has offline fiadores pending (see below).

- The fields mirror the fiadores screen of the NI desktop system (tabs "Datos personales" and "Otros datos"), not HN's. That screen is the source of truth: do not add HN-only fields such as escolaridad, ocupación or CNBS.
- The form has 4 steps driven by `AnalisisFiadoresNiCubit`. It has no cédula photos, signature, document search or credit history.
- It posts `AnalisisFiadorNi` to `POST /cartera/analisis-fiador/create` through `AnalisisFormsRepositoryNi.createAnalisisFiador` (expects `201`).
- Step sections use `FiadorNiSectionCard` (`fiador_ni_form_layout.dart`) rather than `SectionBlockWidget`, because the inputs bring their own padding.
- NI does not send `TipoFiadorCodigo`; `AnalisisFiadorNi` has no fiador type.
- `RELACIONPERSONAS` (relación con el cliente) is synced for NI in `SolicitudCatalogoCubit._codigosCatalogo`. Before this change, only the HN sync downloaded it.

Spec: `specs/02-fiadores-analisis-ni.md`.

#### Offline fiadores (pending)

NI fiadores can be captured without a connection and sent by hand later. Sending is never automatic.

- When "Enviar" is tapped on step 4 without a connection, `AnalisisFiadoresNiSendingWidget(guardarLocal: true)` calls `AnalisisFiadoresNiCubit.guardarFiadorLocal`. With a connection it sends as before. If that send fails with a network error (`AppException.status` is `noConnection`/`timeOutError`, exposed as `state.isNetworkError`), it also offers "Guardar para enviar después". Backend errors never offer it.
- Pending fiadores are `AnalisisFiadorNiLocalDb` rows (`datasource/analisis/ni/fiadores/local_db/`), registered in `AnalisisBoxServiceHn`. `payloadJson` is the already-built body (`AnalisisFiadorNi.toJson()`), and sending rebuilds it with `AnalisisFiadorNi.fromJson` without recalculating anything. Rows are scoped to `LocalStorage().userId` and are not deleted on logout. The same cédula cannot be saved twice for the same request.
- `FiadoresNiPendientesScreen` (`FiadoresNiPendientesCubit`) lists one request's pending fiadores and lets the advisor send ("Enviar", online only) or delete each one. A `201` deletes the row. Always open it through `FiadoresNiPendientesScreen.route()` or `.open()`: the sending screen uses its `routeName` to pop back to an existing list instead of stacking a second one.
- Offline entry point: without a connection, `CarteraScreen` opens `AnalisisSolicitudesNiOfflineScreen` in NI (HN/CR keep `AnalisisSolicitudesHnOfflineScreen`). Its list is `AnalisisListDataHn`, filled by the NI sync (`SolicitudCatalogoCubit.guardarAnalisisAsignadosNi`, page 1 only, Nicaragua only). Its sheet offers análisis (NI interceptor), imágenes, ubicación (screens shared with HN) and fiadores. Plan de inversión is not offline in NI (it is in HN, see above).
- Closing the análisis ignores local pending fiadores: the dialog still uses `TieneFiadores` from the backend.

Spec: `specs/03-fiadores-ni-offline.md`.

### Solicitudes by estado (paginated lists)

Lists of credit requests filtered by `EstadoCredito` go through one cubit per country: `SolicitudesByEstadoHnCubit` (`bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/`) and `SolicitudesByEstadoNiCubit` (`bloc/solicitudes/ni/cubit/solicitudes_by_estado_ni/`, backed by `SolicitudesCreditoRepository.getSolicitudesByEstado` in `domain/repository/solicitudes_credito/ni/`). The NI cubit replaced the old `SolicitudNuevaByEstadoCubit`. Pattern:

- Each screen creates its own instance with `BlocProvider(create: ...)` (not in `app.dart`) and calls `getSolicitudesByEstado(estadoCredito: ..., estadosCredito: [...], filterEstadosCredito: ..., isAsignadaToAsesorCredito: ...)`.
- Pagination is done through `isLoadMore: true`, `hasMore`, and `isLoadingMore`. If a load-more call fails, the list already loaded stays, and `pagina` rolls back so the user can retry.
- Filters by `numeroSolicitud` / `cedulaCliente` are set in state through `onFieldChanged(() => state.copyWith(...))` before the fetch. `cleanState()` resets them.
- Bottom sheets (`show_filter_creditos_by_estado.dart`, `show_asignar_solicitud_bottom_sheet.dart`, `show_autorizar_solicitud_bottom_sheet.dart`, `show_filter_get_by_cedula_and_numero.dart`) get the cubit passed in as a parameter, because they open outside the provider's subtree. Widgets inside the tree, like `filter_content_widget.dart`, read it from `context` instead.

Use this cubit for any new NI list screen instead of writing a separate fetch cubit.

### Auth: expired password (HN only)

`AuthRepositoryImpl.login` throws `PasswordExpiredException` (`domain/exceptions/password_expired_exception.dart`) when the login response is `402` and the flavor is Honduras; other countries still get a plain `AppException`. `AuthCubit` maps it to `AuthStatus.mustChangePassword`, and `LoginFormWidget` (`widgets/auth/login_screen_view.dart`) shows a warning snackbar and pushes `ChangePasswordScreen` (`screens/auth/change_password/`) with the username and selected database. The form uses `ClassValidator.passwordRequirements` / `validateNewPassword` / `validateConfirmPassword` and the widgets in `widgets/auth/change_password/`. The submit goes through `ChangePasswordCubit` (`bloc/auth/change_password/`, provided by the screen itself) into `AuthRepositoryImpl.renovarPasswordVencida` (`RenovarPasswordVencidaEndpoint`, `POST /auth/renovar-password-vencida`, no token). The current password is the one the user just typed in login. On success the screen pops `true`, and login clears the password field and asks the user to sign in again. Still pending: the password rules are placeholders that need to be confirmed with backend.

### Auth: expired session (re-auth dialog)

The backend often wraps auth errors as HTTP 500, for example `{statusCode: 500, message: Unauthorized}` on normal endpoints and `REFRESH TOKEN EXPIRADO` on `/auth/refresh`. That is why `isUnauthorizedResponse()` (`api/api_repository.dart`) also counts a 500 with message `Unauthorized`, and why a refresh counts as rejected on any int status from 400 to 500. Network errors use the string `'500'` from `_handlerError`.

When `/auth/refresh` is rejected (4xx/500, or there is no refresh token), `AuthRepositoryImpl._doRefreshToken` throws `SessionExpiredException` and does not log out. `DefaultAPIRepository.request` then calls `SessionReauthHandler.reauthenticate()` (`config/helpers/session/`). This shows `SessionReauthDialog` (`widgets/auth/session_reauth/`) on the router's root navigator, over the current screen. The dialog shows only the username and asks only for the password; user and database stay fixed from `LocalStorage`, and the database is never shown to the user, and goes through `SessionReauthCubit` (`bloc/auth/session_reauth/`). On success the original request is retried with the new JWT, so the screen keeps its state. "No quiero autenticarme" calls `forceLogout()` and goes to `/login`. Parallel 401s share one dialog. A network error during refresh returns a normal error and keeps the session. `_formData` requests have no 401 handling.

### Module availability per country

`references/app-modules-reference.md` maps which Home / Cartera / Solicitudes modules exist in each country, which are online-only, and which `TypeAction` permission gates them (plus known gaps, e.g. Análisis in Costa Rica is a placeholder). Check it before assuming a module ships in a country, and update it when you add or gate a module.

### Dependency injection

`global_locator.dart` wires app-wide singletons via `get_it` into a top-level `global` (aliased `getIt`). `setUpGlobalLocator(flavor: ...)` runs once at startup from each `main*.dart`, before `runApp`: it initializes the ObjectBox services, registers the `Logger`, `APIRepository` factory, `BiometricCubit`, and the `FlavorCubit` pre-seeded with the current flavor. Feature Cubits that aren't global (most of them) are instead provided per-widget-tree via `MultiBlocProvider` in `lib/app.dart`, constructed with `Repository` instances and/or `global<...>()` services as dependencies.

### Localization

`flutter_translate` with `es` (fallback) and `en`, driven by `LangCubit`/`LocalizationDelegate`; translation JSON lives under `assets/i18n/` (declared in `pubspec.yaml` assets).

### Adding a country-specific feature

`.claude/skills/new-feature-hn/` and `.claude/skills/new-feature-ni/` scaffold the full endpoint + repository + cubit/state chain for a single country, following the existing `hn/`/`ni/` layout. Use them instead of hand-copying an existing feature. Remember Costa Rica reuses the `ni` implementations, so an `ni` feature also ships to Costa Rica unless it is guarded by `FlavorCubit`.

### Spec-driven workflow

For large features, use `/spec <short description>` to design a spec section by section (it asks clarifying questions first and writes to `specs/`), then `/spec-impl <NN-spec-name>` once the spec state is "Approved". `/spec-impl` creates a git branch named after the spec and implements it step by step, pausing to review diffs. Both are user-invoked only (`disable-model-invocation: true`). They come from `Klerith/fernando-skills`, are pinned by hash in `skills-lock.json`, and are mirrored in `.claude/skills/` and `.agents/skills/`. If you change one copy, change the other too.
