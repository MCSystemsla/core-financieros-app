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

App version scheme: `X.Y.Z` — X for breaking platform changes, Y for new features/modules, Z for bugfixes/small tweaks. Android flavor blocks in `android/app/build.gradle` carry their own independent `versionName`/`versionCode` per country.

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
- **`config/`** — cross-cutting concerns: `router/router.dart` (`go_router` route table), `theme/`, `local_storage/` (SharedPreferences wrapper — JWT/refresh token/current user/language live here), `services/` (biometric auth, camera, geolocation, Firebase, bitácora/audit logging), `helpers/` (formatters, validators, error handling/reporting, sync helpers, kiva-specific logic).
- **`utils/extensions/`** — most enum-like domain concepts (garantía type, artículo type, form type, role, order type, etc.) are modeled as extensions on `String`/enums rather than standalone classes — check here before adding a new type helper.

### Dependency injection

`global_locator.dart` wires app-wide singletons via `get_it` into a top-level `global` (aliased `getIt`). `setUpGlobalLocator(flavor: ...)` runs once at startup from each `main*.dart`, before `runApp`: it initializes the ObjectBox services, registers the `Logger`, `APIRepository` factory, `BiometricCubit`, and the `FlavorCubit` pre-seeded with the current flavor. Feature Cubits that aren't global (most of them) are instead provided per-widget-tree via `MultiBlocProvider` in `lib/app.dart`, constructed with `Repository` instances and/or `global<...>()` services as dependencies.

### Localization

`flutter_translate` with `es` (fallback) and `en`, driven by `LangCubit`/`LocalizationDelegate`; translation JSON lives under `assets/i18n/` (declared in `pubspec.yaml` assets).
