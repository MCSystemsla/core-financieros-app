// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisNivelProduccionLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? articuloProduccion;
  String? frecuenciaProduccionCodigo;
  int? cantidadProduccion;
  double? precioVentaUnidad;
  int? totalMensualProduccion;
  String? uuid;
  AnalisisNivelProduccionLocalDb({
    this.articuloProduccion,
    this.frecuenciaProduccionCodigo,
    this.cantidadProduccion,
    this.precioVentaUnidad,
    this.totalMensualProduccion,
    this.uuid,
  });
}
