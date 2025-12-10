import 'package:objectbox/objectbox.dart';

@Entity()
class KivaConfiguracionLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  final String? productoCodigo;
  final String? producto;
  final bool? esRecurrente;
  final String? formularioKiva;
  final int? montoMinimo;
  final int? montoMaximo;
  final int? plazoMinimo;
  final int? plazoMaximo;
  final bool? aplicaMigrantesEconomicos;
  final bool? masculino;
  final bool? femenino;

  KivaConfiguracionLocalDb({
    this.productoCodigo,
    this.producto,
    this.esRecurrente,
    this.formularioKiva,
    this.montoMinimo,
    this.montoMaximo,
    this.plazoMinimo,
    this.plazoMaximo,
    this.aplicaMigrantesEconomicos,
    this.masculino,
    this.femenino,
  });
}
