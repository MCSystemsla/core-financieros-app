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

## Lint / analyze

```
flutter analyze
```
`analysis_options.yaml` extends `flutter_lints` with `prefer_single_quotes: true` and `always_specify_types: false`.

No test suite exists in this repo currently.

## Architecture

`lib/src/` is layered `api → datasource → domain → presentation`, plus `config` and `utils`:

- **`api/`** — transport layer. `DefaultAPIRepository` (`api_repository.dart`) is the single HTTP client: builds the URL from `apiUrl`/`protocol` dart-defines + an `Endpoint`, attaches Cloudflare Access headers, dispatches by `Method`, handles `TypeBody.formData` (multipart file upload) separately, and on a `401` transparently calls `AuthRepositoryImpl().refreshToken()`, persists the new tokens to `LocalStorage`, and retries once (skipped for `RefreshTokenEndpoint` itself to avoid loops). Every request/response is also mirrored to `BitacoraService`/`ErrorReporter`.
- **`Endpoint`** (`api/endpoint.dart`) is the abstract request descriptor (`path`, `method`, `headers`, `body`, `queryParameters`, `files`). Concrete endpoints live under `domain/repository/<feature>/[hn|ni]/endpoint/` and are one-per-call.
- **`datasource/`** — plain Dart models (request/response DTOs) and local persistence services. Two local DB engines are in play: **Isar** (legacy, e.g. `local_db/image_model.dart`, `solicitudes_pendientes.dart` — generated `.g.dart` files) and **ObjectBox** (newer; `*BoxService` classes such as `ObjectBoxService`, `SolicitudesHnBoxService`, `AnalisisBoxServiceHn`, initialized once via `.init()` and registered as GetIt singletons in `global_locator.dart`). Regenerate bindings with build_runner after touching any `@Entity`/Isar collection.
- **`domain/repository/`** — one repository interface + `*Impl` per feature, calling `APIRepository` under the hood. Where a feature diverges by country it is split into `hn/` and `ni/` subfolders with parallel endpoint sets and sometimes parallel repositories (e.g. `solicitudes_credito/hn` vs `solicitudes_credito/ni`, `analisis/hn` vs `analisis/ni`, `comite/hn` vs `comite/ni`, `supervisiones/hn` vs `supervisiones/ni`). Costa Rica currently reuses the `ni` implementations. When adding a feature that differs per country, follow this same `hn`/`ni` split rather than branching inside one class.
- **`presentation/bloc/`** — `flutter_bloc` Cubits/Blocs, one directory per feature, mirroring the domain repository split (e.g. `bloc/solicitudes-pendientes`, `bloc/comite`, `bloc/analisis`). `FlavorCubit` holds the active `Flavor` and is read via `global<FlavorCubit>()` (not `BlocProvider.of`) in places that branch UI/logic by country — see `SolicitudesByFlavorInterceptor` for the standard pattern: `switch (global<FlavorCubit>().state.flavor) { Flavor.honduras => HnScreen(), _ => NiScreen() }`.
- **`presentation/screens/`** and **`presentation/widgets/`** — screens grouped by feature; shared/reusable UI in `widgets/shared`.
- **`config/`** — cross-cutting concerns: `router/router.dart` (`go_router` route table), `theme/`, `local_storage/` (SharedPreferences wrapper — JWT/refresh token/current user/language live here), `services/` (biometric auth, camera, geolocation, Firebase, bitácora/audit logging), `helpers/` (formatters, validators, error handling/reporting, sync helpers, kiva-specific logic), `data/` (static data such as the Google Maps custom style).
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
