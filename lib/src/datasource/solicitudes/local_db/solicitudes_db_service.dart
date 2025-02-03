import 'dart:developer';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_dep.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_mun.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_pais_db.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';

class ObjectBoxService {
  late final Store _store;
  late final Box<CatalogoLocalDb> catalogoBox;
  late final Box<CatalogoNacionalidadPaisDb> catalogoNacionalidadPaisBox;
  late final Box<CatalogoNacionalidadDepDb> catalogoNacionalidadDepBox;
  late final Box<CatalogoNacionalidadMunDb> catalogoNacionalidadMunBox;

  ObjectBoxService._create(this._store) {
    catalogoBox = _store.box<CatalogoLocalDb>();
    catalogoNacionalidadPaisBox = _store.box<CatalogoNacionalidadPaisDb>();
    catalogoNacionalidadDepBox = _store.box<CatalogoNacionalidadDepDb>();
    catalogoNacionalidadMunBox = _store.box<CatalogoNacionalidadMunDb>();
  }

  static Future<ObjectBoxService> init() async {
    final store = await openStore(); // Inicializa el Store.
    return ObjectBoxService._create(store);
  }

  void close() {
    _store.close(); // Cierra la conexión con la base de datos.
  }

  List<CatalogoLocalDb> findParentescosByNombre({required String type}) {
    final query = catalogoBox.query(CatalogoLocalDb_.type.equals(type)).build();

    final results = query.find();
    query.close();

    return results;
  }

  List<ItemNacionalidad> getNacionalidadesDep({required String valor}) {
    final query = catalogoNacionalidadDepBox
        .query(CatalogoNacionalidadDepDb_.relacion.equals(valor))
        .build();

    final results = query.find();
    query.close();
    return results
        .map((e) => ItemNacionalidad(
              id: e.id,
              valor: e.valor,
              nombre: e.nombre,
              relacion: e.relacion ?? 'No data',
            ))
        .toSet()
        .toList();
  }

  List<ItemNacionalidad> getNacionalidadPaises(
      {required String codigo, String whereClause = ''}) {
    switch (codigo) {
      case 'PAIS':
        final query = catalogoNacionalidadPaisBox.query().build();

        final results = query.find();
        query.close();
        return results
            .map((e) => ItemNacionalidad(
                  id: e.id,
                  valor: e.valor,
                  nombre: e.nombre,
                  relacion: e.relacion ?? 'No data',
                ))
            .toList();

      case 'DEP':
        log('Where Clause:$whereClause');
        if (whereClause.isEmpty) {
          final query = catalogoNacionalidadDepBox.query().build();
          final results = query.find();
          log(' Results: $results');
          query.close();
          return results
              .map((e) => ItemNacionalidad(
                    id: e.id,
                    valor: e.valor,
                    nombre: e.nombre,
                    relacion: e.relacion ?? 'No data',
                  ))
              .toList();
        }
        final query = catalogoNacionalidadDepBox.query().build();

        final results = query.find();
        final newResults =
            results.where((element) => element.relacion == whereClause);
        query.close();
        return newResults
            .map((e) => ItemNacionalidad(
                  id: e.id,
                  valor: e.valor,
                  nombre: e.nombre,
                  relacion: e.relacion ?? 'No data',
                ))
            .toList();
      case 'MUN':
        final query = catalogoNacionalidadMunBox.query().build();

        final results = query.find();
        query.close();
        return results
            .map((e) => ItemNacionalidad(
                  id: e.id,
                  valor: e.valor,
                  nombre: e.nombre,
                  relacion: e.relacion ?? 'No data',
                ))
            .toList();
    }
    return [];
  }
}
