import 'package:isar/isar.dart';

part 'actions_model_db.g.dart';

@Collection()
class ActionsModelDb {
  Id id = Isar.autoIncrement;
  String? action;
}
