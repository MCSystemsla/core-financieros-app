// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class ActividadesEconomicasAliasFilteredLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  int? idActividadEconomica;
  String? codActividadEconomica;
  String? nombre;
  String? alias;
  ActividadesEconomicasAliasFilteredLocalDb({
    this.idActividadEconomica,
    this.codActividadEconomica,
    this.nombre,
    this.alias,
  });
}
