import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/actividades_economicas_alias_filtered.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

void buildActividadesEconomicasAliasFilteredDropdown({
  required BuildContext context,
}) {
  final localDbProvider = global<SolicitudesHnBoxService>();
  final itemsActividades =
      localDbProvider.actividadesEconomicasAliasFilteredBox.getAll();
  final actividadesEcomicas = itemsActividades.map((e) {
    return ActividadesEconomicasAliasFiltered(
      id: e.id,
      codActividadEconomica: e.codActividadEconomica ?? '',
      nombre: e.nombre ?? 'N/A',
      alias: e.alias ?? 'N/A',
    );
  }).toList();
  DropDownState<ActividadesEconomicasAliasFiltered>(
    dropDown: DropDown<ActividadesEconomicasAliasFiltered>(
      searchHintText: 'Buscar actividad económica por alias, nombre o código',
      searchDelegate: (query, dataItems) {
        if (query.isEmpty) return dataItems;

        final lowerQuery = query.toLowerCase();

        return dataItems.where((item) {
          final alias = item.data.alias.toLowerCase();
          final nombre = item.data.nombre.toLowerCase();
          final codigo = item.data.codActividadEconomica.toLowerCase();
          return alias.contains(lowerQuery) ||
              nombre.contains(lowerQuery) ||
              codigo.contains(lowerQuery);
        }).toList();
      },
      enableMultipleSelection: false,
      bottomSheetTitle: Text(
        'Lista de alias de actividades económicas',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      listItemBuilder: (index, dataItem) {
        return _Card(
          dataItem: dataItem,
        );
      },
      data: [
        ...actividadesEcomicas.map(
          (e) {
            return SelectedListItem<ActividadesEconomicasAliasFiltered>(
              data: ActividadesEconomicasAliasFiltered(
                id: e.id,
                codActividadEconomica: e.codActividadEconomica,
                nombre: e.nombre,
                alias: e.alias,
              ),
            );
          },
        )
      ],
    ),
  ).showModal(context);
}

class _Card extends StatelessWidget {
  final SelectedListItem<ActividadesEconomicasAliasFiltered> dataItem;

  const _Card({
    required this.dataItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        '${dataItem.data.codActividadEconomica} - ${dataItem.data.nombre}',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        'Alias: ${dataItem.data.alias}',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }
}
