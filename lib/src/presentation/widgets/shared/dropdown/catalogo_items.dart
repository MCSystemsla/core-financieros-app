import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:uuid/uuid.dart';

/// Opciones locales del catálogo [codigo] según el país activo.
///
/// Honduras lee `SolicitudesHnBoxService`; Nicaragua y Costa Rica,
/// `ObjectBoxService`. Todas las opciones comparten el mismo `id` (un uuid
/// por llamada), igual que hacía `SearchDropdownWidget`.
List<Item> itemsDeCatalogo(String codigo) {
  final List<CatalogoLocalDb> catalogo =
      switch (global<FlavorCubit>().state.flavor) {
    Flavor.honduras =>
      global<SolicitudesHnBoxService>().findCatalogoByCodigo(codigo: codigo),
    Flavor.nicaragua || Flavor.costaRica =>
      global<ObjectBoxService>().findParentescosByNombre(type: codigo),
    _ => [],
  };

  final uuid = const Uuid().v4();
  return catalogo
      .map(
        (e) => Item(
          id: uuid,
          value: e.valor,
          name: e.nombre,
          interes: e.interes ?? 0,
          montoMaximo: e.montoMaximo ?? 0,
          montoMinimo: e.montoMinimo ?? 0,
          isApnfd: e.isAPNFD,
        ),
      )
      .toList();
}
