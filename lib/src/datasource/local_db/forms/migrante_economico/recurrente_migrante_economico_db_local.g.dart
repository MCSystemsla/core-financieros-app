// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrente_migrante_economico_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurrenteMigranteEconomicoDbLocalCollection on Isar {
  IsarCollection<RecurrenteMigranteEconomicoDbLocal>
      get recurrenteMigranteEconomicoDbLocals => this.collection();
}

const RecurrenteMigranteEconomicoDbLocalSchema = CollectionSchema(
  name: r'RecurrenteMigranteEconomicoDbLocal',
  id: -4021317763094518359,
  properties: {
    r'apoyanNegocio': PropertySchema(
      id: 0,
      name: r'apoyanNegocio',
      type: IsarType.bool,
    ),
    r'coincideRespuesta': PropertySchema(
      id: 1,
      name: r'coincideRespuesta',
      type: IsarType.bool,
    ),
    r'cuantosApoyan': PropertySchema(
      id: 2,
      name: r'cuantosApoyan',
      type: IsarType.string,
    ),
    r'database': PropertySchema(
      id: 3,
      name: r'database',
      type: IsarType.string,
    ),
    r'edadHijos': PropertySchema(
      id: 4,
      name: r'edadHijos',
      type: IsarType.string,
    ),
    r'explicacionInversion': PropertySchema(
      id: 5,
      name: r'explicacionInversion',
      type: IsarType.string,
    ),
    r'explicacionMejoraCondiciones': PropertySchema(
      id: 6,
      name: r'explicacionMejoraCondiciones',
      type: IsarType.string,
    ),
    r'mejoraCondiciones': PropertySchema(
      id: 7,
      name: r'mejoraCondiciones',
      type: IsarType.bool,
    ),
    r'motivoPrestamo': PropertySchema(
      id: 8,
      name: r'motivoPrestamo',
      type: IsarType.string,
    ),
    r'numeroHijos': PropertySchema(
      id: 9,
      name: r'numeroHijos',
      type: IsarType.long,
    ),
    r'objSolicitudRecurrenteId': PropertySchema(
      id: 10,
      name: r'objSolicitudRecurrenteId',
      type: IsarType.long,
    ),
    r'otrosIngresos': PropertySchema(
      id: 11,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 12,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 13,
      name: r'personasCargo',
      type: IsarType.long,
    ),
    r'quienApoya': PropertySchema(
      id: 14,
      name: r'quienApoya',
      type: IsarType.string,
    ),
    r'siguienteMeta': PropertySchema(
      id: 15,
      name: r'siguienteMeta',
      type: IsarType.string,
    ),
    r'tiempoActividad': PropertySchema(
      id: 16,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 17,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 18,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    ),
    r'tipoSolicitud': PropertySchema(
      id: 19,
      name: r'tipoSolicitud',
      type: IsarType.string,
    ),
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 20,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    )
  },
  estimateSize: _recurrenteMigranteEconomicoDbLocalEstimateSize,
  serialize: _recurrenteMigranteEconomicoDbLocalSerialize,
  deserialize: _recurrenteMigranteEconomicoDbLocalDeserialize,
  deserializeProp: _recurrenteMigranteEconomicoDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurrenteMigranteEconomicoDbLocalGetId,
  getLinks: _recurrenteMigranteEconomicoDbLocalGetLinks,
  attach: _recurrenteMigranteEconomicoDbLocalAttach,
  version: '3.1.0+1',
);

int _recurrenteMigranteEconomicoDbLocalEstimateSize(
  RecurrenteMigranteEconomicoDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cuantosApoyan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.database;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.edadHijos;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.explicacionInversion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.explicacionMejoraCondiciones;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motivoPrestamo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.otrosIngresosDescripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.quienApoya;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.siguienteMeta;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tipoEstudioHijos;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tipoSolicitud;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.trabajoNegocioDescripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recurrenteMigranteEconomicoDbLocalSerialize(
  RecurrenteMigranteEconomicoDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.apoyanNegocio);
  writer.writeBool(offsets[1], object.coincideRespuesta);
  writer.writeString(offsets[2], object.cuantosApoyan);
  writer.writeString(offsets[3], object.database);
  writer.writeString(offsets[4], object.edadHijos);
  writer.writeString(offsets[5], object.explicacionInversion);
  writer.writeString(offsets[6], object.explicacionMejoraCondiciones);
  writer.writeBool(offsets[7], object.mejoraCondiciones);
  writer.writeString(offsets[8], object.motivoPrestamo);
  writer.writeLong(offsets[9], object.numeroHijos);
  writer.writeLong(offsets[10], object.objSolicitudRecurrenteId);
  writer.writeBool(offsets[11], object.otrosIngresos);
  writer.writeString(offsets[12], object.otrosIngresosDescripcion);
  writer.writeLong(offsets[13], object.personasCargo);
  writer.writeString(offsets[14], object.quienApoya);
  writer.writeString(offsets[15], object.siguienteMeta);
  writer.writeLong(offsets[16], object.tiempoActividad);
  writer.writeBool(offsets[17], object.tieneTrabajo);
  writer.writeString(offsets[18], object.tipoEstudioHijos);
  writer.writeString(offsets[19], object.tipoSolicitud);
  writer.writeString(offsets[20], object.trabajoNegocioDescripcion);
}

RecurrenteMigranteEconomicoDbLocal
    _recurrenteMigranteEconomicoDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurrenteMigranteEconomicoDbLocal();
  object.apoyanNegocio = reader.readBoolOrNull(offsets[0]);
  object.coincideRespuesta = reader.readBoolOrNull(offsets[1]);
  object.cuantosApoyan = reader.readStringOrNull(offsets[2]);
  object.database = reader.readStringOrNull(offsets[3]);
  object.edadHijos = reader.readStringOrNull(offsets[4]);
  object.explicacionInversion = reader.readStringOrNull(offsets[5]);
  object.explicacionMejoraCondiciones = reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.mejoraCondiciones = reader.readBoolOrNull(offsets[7]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[8]);
  object.numeroHijos = reader.readLongOrNull(offsets[9]);
  object.objSolicitudRecurrenteId = reader.readLongOrNull(offsets[10]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[11]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[12]);
  object.personasCargo = reader.readLongOrNull(offsets[13]);
  object.quienApoya = reader.readStringOrNull(offsets[14]);
  object.siguienteMeta = reader.readStringOrNull(offsets[15]);
  object.tiempoActividad = reader.readLongOrNull(offsets[16]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[17]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[18]);
  object.tipoSolicitud = reader.readStringOrNull(offsets[19]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[20]);
  return object;
}

P _recurrenteMigranteEconomicoDbLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readBoolOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recurrenteMigranteEconomicoDbLocalGetId(
    RecurrenteMigranteEconomicoDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurrenteMigranteEconomicoDbLocalGetLinks(
    RecurrenteMigranteEconomicoDbLocal object) {
  return [];
}

void _recurrenteMigranteEconomicoDbLocalAttach(IsarCollection<dynamic> col,
    Id id, RecurrenteMigranteEconomicoDbLocal object) {
  object.id = id;
}

extension RecurrenteMigranteEconomicoDbLocalQueryWhereSort on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QWhere> {
  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurrenteMigranteEconomicoDbLocalQueryWhere on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QWhereClause> {
  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecurrenteMigranteEconomicoDbLocalQueryFilter on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QFilterCondition> {
  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> apoyanNegocioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> apoyanNegocioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> apoyanNegocioEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apoyanNegocio',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> coincideRespuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coincideRespuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cuantosApoyan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      cuantosApoyanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      cuantosApoyanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cuantosApoyan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'database',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      databaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      databaseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'database',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'edadHijos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      edadHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      edadHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'edadHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explicacionInversion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explicacionInversion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explicacionInversion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explicacionInversion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explicacionInversion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      explicacionInversionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explicacionInversion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      explicacionInversionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explicacionInversion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionMejoraCondiciones',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionMejoraCondiciones',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionMejoraCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explicacionMejoraCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explicacionMejoraCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explicacionMejoraCondiciones',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explicacionMejoraCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explicacionMejoraCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      explicacionMejoraCondicionesContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explicacionMejoraCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      explicacionMejoraCondicionesMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explicacionMejoraCondiciones',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionMejoraCondiciones',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> explicacionMejoraCondicionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionMejoraCondiciones',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> mejoraCondicionesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mejoraCondiciones',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> mejoraCondicionesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mejoraCondiciones',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> mejoraCondicionesEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraCondiciones',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motivoPrestamo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      motivoPrestamoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      motivoPrestamoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoPrestamo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroHijos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objSolicitudRecurrenteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'otrosIngresosDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'otrosIngresosDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'otrosIngresosDescripcion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'otrosIngresosDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'otrosIngresosDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'otrosIngresosDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'otrosIngresosDescripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personasCargo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quienApoya',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quienApoya',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quienApoya',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quienApoya',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quienApoya',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      quienApoyaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quienApoya',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      quienApoyaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quienApoya',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguienteMeta',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguienteMeta',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'siguienteMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'siguienteMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'siguienteMeta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'siguienteMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'siguienteMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      siguienteMetaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'siguienteMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      siguienteMetaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'siguienteMeta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> siguienteMetaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguienteMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tiempoActividad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoEstudioHijos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoEstudioHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoSolicitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoSolicitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoSolicitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoSolicitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoSolicitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoSolicitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      tipoSolicitudContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoSolicitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      tipoSolicitudMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoSolicitud',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trabajoNegocioDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trabajoNegocioDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trabajoNegocioDescripcion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trabajoNegocioDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trabajoNegocioDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trabajoNegocioDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trabajoNegocioDescripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }
}

extension RecurrenteMigranteEconomicoDbLocalQueryObject on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QFilterCondition> {}

extension RecurrenteMigranteEconomicoDbLocalQueryLinks on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QFilterCondition> {}

extension RecurrenteMigranteEconomicoDbLocalQuerySortBy on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QSortBy> {
  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByExplicacionMejoraCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionMejoraCondiciones', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByExplicacionMejoraCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionMejoraCondiciones', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByMejoraCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCondiciones', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByMejoraCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCondiciones', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortBySiguienteMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortBySiguienteMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> sortByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension RecurrenteMigranteEconomicoDbLocalQuerySortThenBy on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QSortThenBy> {
  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByExplicacionMejoraCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionMejoraCondiciones', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByExplicacionMejoraCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionMejoraCondiciones', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByMejoraCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCondiciones', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByMejoraCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCondiciones', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenBySiguienteMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenBySiguienteMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QAfterSortBy> thenByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension RecurrenteMigranteEconomicoDbLocalQueryWhereDistinct on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QDistinct> {
  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QDistinct> distinctByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apoyanNegocio');
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coincideRespuesta');
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByCuantosApoyan({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuantosApoyan',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByExplicacionInversion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionInversion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QDistinct>
      distinctByExplicacionMejoraCondiciones({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionMejoraCondiciones',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByMejoraCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mejoraCondiciones');
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QDistinct> distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QDistinct> distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QDistinct> distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctBySiguienteMeta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguienteMeta',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal, QDistinct> distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      RecurrenteMigranteEconomicoDbLocal,
      RecurrenteMigranteEconomicoDbLocal,
      QDistinct> distinctByTipoSolicitud({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoSolicitud',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal,
          RecurrenteMigranteEconomicoDbLocal, QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }
}

extension RecurrenteMigranteEconomicoDbLocalQueryProperty on QueryBuilder<
    RecurrenteMigranteEconomicoDbLocal,
    RecurrenteMigranteEconomicoDbLocal,
    QQueryProperty> {
  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, bool?, QQueryOperations>
      apoyanNegocioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apoyanNegocio');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, bool?, QQueryOperations>
      coincideRespuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      cuantosApoyanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuantosApoyan');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      explicacionInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionInversion');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      explicacionMejoraCondicionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionMejoraCondiciones');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, bool?, QQueryOperations>
      mejoraCondicionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mejoraCondiciones');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, int?, QQueryOperations>
      objSolicitudRecurrenteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      siguienteMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguienteMeta');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      tipoSolicitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoSolicitud');
    });
  }

  QueryBuilder<RecurrenteMigranteEconomicoDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }
}
