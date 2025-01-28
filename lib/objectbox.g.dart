// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'src/datasource/solicitudes/local_db/catalogo/catalogo_parentesco.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(4, 2155957539051073423),
      name: 'CatalogoParentesco',
      lastPropertyId: const obx_int.IdUid(4, 5790461611913583184),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6374105552846890728),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6638228479275970397),
            name: 'valor',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2092806545684967002),
            name: 'nombre',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5790461611913583184),
            name: 'type',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(5, 1884745770876461125),
      name: 'CatalogoLocalDb',
      lastPropertyId: const obx_int.IdUid(4, 6807186367900511600),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7479864557436850925),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6458622037609275421),
            name: 'valor',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 6518956915383222863),
            name: 'nombre',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 6807186367900511600),
            name: 'type',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(5, 1884745770876461125),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [
        9202958733338752880,
        5684422469629762898,
        1674317648935978538
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        8004479164939835464,
        2229639635448296630,
        475466870791721722,
        8964871672081983833,
        3911703238609290790,
        145085970733923128,
        2548468207022499454,
        1933263533513327159,
        9149075065927782478,
        4231670949194548259,
        8381761593523512187
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    CatalogoParentesco: obx_int.EntityDefinition<CatalogoParentesco>(
        model: _entities[0],
        toOneRelations: (CatalogoParentesco object) => [],
        toManyRelations: (CatalogoParentesco object) => {},
        getId: (CatalogoParentesco object) => object.id,
        setId: (CatalogoParentesco object, int id) {
          object.id = id;
        },
        objectToFB: (CatalogoParentesco object, fb.Builder fbb) {
          final valorOffset = fbb.writeString(object.valor);
          final nombreOffset = fbb.writeString(object.nombre);
          final typeOffset = fbb.writeString(object.type);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, valorOffset);
          fbb.addOffset(2, nombreOffset);
          fbb.addOffset(3, typeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final valorParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final nombreParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final typeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final object = CatalogoParentesco(
              valor: valorParam, nombre: nombreParam, type: typeParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    CatalogoLocalDb: obx_int.EntityDefinition<CatalogoLocalDb>(
        model: _entities[1],
        toOneRelations: (CatalogoLocalDb object) => [],
        toManyRelations: (CatalogoLocalDb object) => {},
        getId: (CatalogoLocalDb object) => object.id,
        setId: (CatalogoLocalDb object, int id) {
          object.id = id;
        },
        objectToFB: (CatalogoLocalDb object, fb.Builder fbb) {
          final valorOffset = fbb.writeString(object.valor);
          final nombreOffset = fbb.writeString(object.nombre);
          final typeOffset = fbb.writeString(object.type);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, valorOffset);
          fbb.addOffset(2, nombreOffset);
          fbb.addOffset(3, typeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final valorParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final nombreParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final typeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final object = CatalogoLocalDb(
              valor: valorParam, nombre: nombreParam, type: typeParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [CatalogoParentesco] entity fields to define ObjectBox queries.
class CatalogoParentesco_ {
  /// See [CatalogoParentesco.id].
  static final id =
      obx.QueryIntegerProperty<CatalogoParentesco>(_entities[0].properties[0]);

  /// See [CatalogoParentesco.valor].
  static final valor =
      obx.QueryStringProperty<CatalogoParentesco>(_entities[0].properties[1]);

  /// See [CatalogoParentesco.nombre].
  static final nombre =
      obx.QueryStringProperty<CatalogoParentesco>(_entities[0].properties[2]);

  /// See [CatalogoParentesco.type].
  static final type =
      obx.QueryStringProperty<CatalogoParentesco>(_entities[0].properties[3]);
}

/// [CatalogoLocalDb] entity fields to define ObjectBox queries.
class CatalogoLocalDb_ {
  /// See [CatalogoLocalDb.id].
  static final id =
      obx.QueryIntegerProperty<CatalogoLocalDb>(_entities[1].properties[0]);

  /// See [CatalogoLocalDb.valor].
  static final valor =
      obx.QueryStringProperty<CatalogoLocalDb>(_entities[1].properties[1]);

  /// See [CatalogoLocalDb.nombre].
  static final nombre =
      obx.QueryStringProperty<CatalogoLocalDb>(_entities[1].properties[2]);

  /// See [CatalogoLocalDb.type].
  static final type =
      obx.QueryStringProperty<CatalogoLocalDb>(_entities[1].properties[3]);
}
