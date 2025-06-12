import 'package:isar/isar.dart';

part 'image_model.g.dart';

@Collection()
class ImageModel {
  Id id = Isar.autoIncrement;
  int? solicitudId;
  String? imagen1;
  String? imagen2;
  String? imagen3;
  String? imagen4;
  String? imagenFirma;
  String? typeSigner;
}
