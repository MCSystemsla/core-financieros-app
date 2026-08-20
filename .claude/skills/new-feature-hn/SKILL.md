---
name: new-feature-hn
description: Scaffold a new Honduras-only feature (endpoint + repository + cubit/state) following this repo's existing `hn/` pattern. Use when the user asks to add an API-backed feature, screen action, or cubit that only ships in the Honduras flavor (`micreditoHonduras`, `lib/main_hn.dart`).
---

# new-feature-hn

Scaffold a Honduras-only feature across the three layers this codebase always uses together: `Endpoint` → `Repository` → `Cubit/State`. Everything generated lives under an `hn/` folder; no `ni` variant is created and Nicaragua/Costa Rica are left untouched.

If the feature also needs Nicaragua/Costa Rica, use the `new-feature-hn-ni` skill instead — do not silently generate a `ni` copy from this one.

## 1. Gather inputs

**One single `AskUserQuestion` call, four questions, nothing else.** Everything not in those four is inferred from the repo (rules below) — do not open a second round unless something inferred is genuinely impossible to resolve.

Before asking, drop any of the four the user already answered in their request; if all four are covered, ask nothing and go straight to step 2.

### The one round

| # | Question | Options to offer |
|---|---|---|
| 1 | **Domain group** under `lib/src/domain/repository/` | the real folders that already have an `hn/` subfolder (`solicitudes_credito`, `comite`, `analisis`, `supervisiones`, …), plus "Otro" for a new group |
| 2 | **HTTP method** | `GET`, `POST`, `PUT`, `PATCH`/`DELETE` |
| 3 | **Feature name** (PascalCase, e.g. `RenovarPromesaPago`) | placeholder only — label `Escribir nombre en Otro`. Never suggest a name. |
| 4 | **Full hn path** | placeholder only — label `Escribir ruta completa en Otro`; a second option may show the module prefix *shape* seen in siblings (`/cartera/...`, `/ahorro/...`, `/pla/...`) as a format hint. Never a full guessed path. |

Feature name and path are new values only the user knows: do not scan siblings for candidates, do not invent plausible ones. After the answer, grep the repo for the path — if it already exists, say so and re-ask just that one.

### Inferred, never asked

- **snake_case name** — derived from the PascalCase answer.
- **Success status code** — `201` for POST, `200` for everything else. Only ask if a sibling endpoint in the same group contradicts this.
- **`'database': LocalStorage().database`** — included, matching siblings.
- **Cubit needed** — yes by default. Skip only if the user explicitly said "sin cubit" or "solo el repositorio".
- **Request fields** — take them from what the user wrote in their prompt. **Never reuse an existing request model**: an existing model carries fields this feature does not need and silently drifts when that model changes. If the user gave no fields:
  - POST/PUT/PATCH/DELETE — generate `body` with a default `Map<String, dynamic> data` field (plus `'database'`) and a `// TODO: definir campos del body` comment.
  - GET — generate `queryParameters` with `database` only and a `// TODO: agregar filtros` comment.
  Do not block on this.
- **Response shape** — never reuse an existing response model either. Return `Map<String, dynamic>` unless the user described the response, and say so at the end.

Report every inference in the final message (step 6) so the user can correct it in one pass instead of answering three rounds up front.

## 2. Endpoint layer

Add one class per call to:
- `lib/src/domain/repository/<group>/hn/endpoint/<group>_hn_endpoint.dart`

Pattern (copy exactly, only the body/queryParameters/path/method/generics change) — **GET** uses `queryParameters`, never `body`:

```dart
class <FeatureName>HNEndpoint extends Endpoint {
  final String algunFiltro; // one field per queryParameter gathered from the user
  final int? otroFiltro;

  <FeatureName>HNEndpoint({required this.algunFiltro, this.otroFiltro});

  @override
  Method get method => Method.get;

  @override
  String get path => '/<full-endpoint-path>'; // full NEW path, ask user — no fixed prefix (module varies: cartera, ahorro, pla, etc.). Must not match any existing endpoint's path.

  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'AlgunFiltro': algunFiltro,
        if (otroFiltro != null) 'OtroFiltro': otroFiltro.toString(),
      };
}
```

**POST/PUT/PATCH/DELETE** use `body` instead:

```dart
class <FeatureName>HNEndpoint extends Endpoint {
  final Map<String, dynamic> data; // default: raw map, NOT an existing request model

  <FeatureName>HNEndpoint({required this.data});

  @override
  Method get method => Method.post; // post/put/patch/delete

  @override
  String get path => '/<full-endpoint-path>';

  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        ...data, // TODO: definir campos del body
      };
}
```

If the user listed concrete request fields, replace `data` with one typed field per value and build `body` from them — but create a **new** model/fields for this feature; never import an existing request model from another feature.

Rules learned from existing code:
- Every authenticated endpoint sets `Authorization` header from `LocalStorage().jwt`.
- Almost every GET/POST body or query includes `'database': LocalStorage().database` (multi-tenant db selector) — check a sibling endpoint in the same group before omitting it.
- `TypeBody.formData` + `files` list only for file/image uploads; otherwise leave `typeBody` at its `raw` default.
- Keep the `HN` infix in the class name even though nothing else is generated — it matches every existing Honduras endpoint and keeps imports unambiguous.

## 3. Repository layer

Add the method signature to the existing `abstract class <Group>HnRepository` (or create the interface + `Impl` if the group is new, matching `lib/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart` as the template) and implement it in `<...>Impl`:

```dart
@override
Future<ReturnType> <methodName>({required Args args}) async {
  final endpoint = <FeatureName>HNEndpoint(data: args);
  try {
    final resp = await _api.request(endpoint: endpoint);
    if (resp['statusCode'] != <expectedCode>) {
      _logger.e(resp);
      final (errorMsg, _) = getErrorMessage(
        resp,
        errorMsg: 'Tienes problemas de conexión. Revisa tu conexión a internet.',
      );
      throw AppException(optionalMsg: errorMsg);
    }
    return ReturnType.fromJson(resp);
  } catch (e) {
    _logger.e(e);
    rethrow;
  }
}
```

`_api = global<APIRepository>()` and `_logger = Logger()` are already fields on the class — reuse them, don't redeclare.

Success status code conventions seen in this repo: `200` for GET/most PATCH, `201` for POST creates. Apply the convention directly — do not ask; report the chosen code in the final message so the user can correct it.

Do not touch the sibling `ni/` repository, and do not add the new method to a shared/base interface that `ni` also implements — that would break the Nicaragua build.

## 4. Cubit/State layer (skip if the user said no cubit needed)

Directory convention:
- `lib/src/presentation/bloc/<parent-feature>/hn/<feature_snake>/`

Two files, `<feature_snake>_cubit.dart` and `<feature_snake>_state.dart`, always paired with `part`/`part of`:

```dart
// <feature_snake>_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart'; // for shared Status enum
import 'package:equatable/equatable.dart';

part '<feature_snake>_state.dart';

class <FeatureName>Cubit extends Cubit<<FeatureName>State> {
  final <Group>HnRepository _repository;
  <FeatureName>Cubit(this._repository) : super(<FeatureName>Initial());

  Future<void> <action>() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.<repositoryMethod>();
      emit(state.copyWith(status: Status.done, /* data field */: resp));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
```

```dart
// <feature_snake>_state.dart
part of '<feature_snake>_cubit.dart';

class <FeatureName>State extends Equatable {
  final Status status;
  final String errorMsg;
  // ...feature fields

  const <FeatureName>State({
    this.status = Status.notStarted,
    this.errorMsg = '',
    // ...defaults
  });

  @override
  List<Object> get props => [status, errorMsg /*, ...*/];

  <FeatureName>State copyWith({
    Status? status,
    String? errorMsg,
    // ...
  }) {
    return <FeatureName>State(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      // ...
    );
  }
}

final class <FeatureName>Initial extends <FeatureName>State {}
```

`Status` (`notStarted, inProgress, done, error`) is defined once in `lib/src/presentation/bloc/auth/branch_team/branchteam_state.dart` — import and reuse it, never redefine a local status enum.

## 5. Wiring (Honduras-only)

Because this feature exists only for Honduras, it must never be reachable from the Nicaragua/Costa Rica builds:

- Prefer providing the cubit locally at the Honduras screen that uses it (`BlocProvider` in that screen's build), not globally. Only register it in the `MultiBlocProvider` in `lib/app.dart` if truly app-wide — that provider tree is shared by all flavors, so a global registration also constructs the repository on NI/CR.
- Guard any UI entry point with the flavor switch from `lib/src/presentation/widgets/solicitudes/solicitudes_by_flavor_interceptor.dart`:
  ```dart
  switch (global<FlavorCubit>().state.flavor) {
    Flavor.honduras => HnWidget(),
    _ => const SizedBox.shrink(), // or the existing NI widget, if one exists
  }
  ```
- If a `go_router` route is added in `lib/src/config/router/router.dart`, keep the route registered but make the screen itself flavor-guarded (or redirect non-HN flavors away) — the route table is shared across flavors.

## 6. After generating

- Run `flutter analyze` and fix anything flagged.
- If a new datasource model with `fromJson`/`toJson` was added, no code generation is needed unless it's an Isar/ObjectBox entity (`@Entity`/`@collection`) — in that case run `dart run tool/build_script.dart` (or just `flutter pub run build_runner build`) before considering the task done.
- Tell the user which files were created/edited, and state explicitly that only the Honduras variant was generated and where the flavor guard was placed.
- List every value that was **inferred** instead of asked (status code, cubit yes/no, request fields, response model) in one short block, so a wrong inference is a one-line correction rather than a re-run.
