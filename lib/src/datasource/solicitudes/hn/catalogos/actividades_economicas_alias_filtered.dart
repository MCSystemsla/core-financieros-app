import 'dart:convert';

ActividadesEconomicasAliasFilteredResponse
    actividadesEconomicasAliasFilteredFromJson(String str) =>
        ActividadesEconomicasAliasFilteredResponse.fromJson(json.decode(str));

class ActividadesEconomicasAliasFilteredResponse {
  final List<ActividadesEconomicasAliasFiltered> data;

  ActividadesEconomicasAliasFilteredResponse({
    required this.data,
  });

  factory ActividadesEconomicasAliasFilteredResponse.fromJson(
          Map<String, dynamic> json) =>
      ActividadesEconomicasAliasFilteredResponse(
        data: List<ActividadesEconomicasAliasFiltered>.from(json['data']
            .map((x) => ActividadesEconomicasAliasFiltered.fromJson(x))),
      );
}

class ActividadesEconomicasAliasFiltered {
  final int id;
  final String codActividadEconomica;
  final String nombre;
  final String alias;

  ActividadesEconomicasAliasFiltered({
    required this.id,
    required this.codActividadEconomica,
    required this.nombre,
    required this.alias,
  });

  factory ActividadesEconomicasAliasFiltered.fromJson(
          Map<String, dynamic> json) =>
      ActividadesEconomicasAliasFiltered(
        id: json['ID'],
        codActividadEconomica: json['CodActividadEconomica'],
        nombre: json['Nombre'],
        alias: json['Alias'],
      );
}
