import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_parentesco.dart';

class ObjectBoxService {
  late final Store _store;
  late final Box<CatalogoParentesco> userBox;

  ObjectBoxService._create(this._store) {
    userBox = _store.box<CatalogoParentesco>();
  }

  static Future<ObjectBoxService> init() async {
    final store = await openStore(); // Inicializa el Store.
    return ObjectBoxService._create(store);
  }

  void close() {
    _store.close(); // Cierra la conexión con la base de datos.
  }
}
