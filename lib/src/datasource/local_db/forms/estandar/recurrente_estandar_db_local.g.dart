// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrente_estandar_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurrenteEstandarDbLocalCollection on Isar {
  IsarCollection<RecurrenteEstandarDbLocal> get recurrenteEstandarDbLocals =>
      this.collection();
}

const RecurrenteEstandarDbLocalSchema = CollectionSchema(
  name: r'RecurrenteEstandarDbLocal',
  id: 738249294679775,
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
    r'comoFortalece': PropertySchema(
      id: 2,
      name: r'comoFortalece',
      type: IsarType.string,
    ),
    r'comoMejoraEntorno': PropertySchema(
      id: 3,
      name: r'comoMejoraEntorno',
      type: IsarType.string,
    ),
    r'cuantosApoyan': PropertySchema(
      id: 4,
      name: r'cuantosApoyan',
      type: IsarType.string,
    ),
    r'database': PropertySchema(
      id: 5,
      name: r'database',
      type: IsarType.string,
    ),
    r'edadHijos': PropertySchema(
      id: 6,
      name: r'edadHijos',
      type: IsarType.string,
    ),
    r'explicacionInversion': PropertySchema(
      id: 7,
      name: r'explicacionInversion',
      type: IsarType.string,
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
    r'personaAutoSuficiente': PropertySchema(
      id: 13,
      name: r'personaAutoSuficiente',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 14,
      name: r'personasCargo',
      type: IsarType.long,
    ),
    r'siguientePaso': PropertySchema(
      id: 15,
      name: r'siguientePaso',
      type: IsarType.string,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 16,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    )
  },
  estimateSize: _recurrenteEstandarDbLocalEstimateSize,
  serialize: _recurrenteEstandarDbLocalSerialize,
  deserialize: _recurrenteEstandarDbLocalDeserialize,
  deserializeProp: _recurrenteEstandarDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurrenteEstandarDbLocalGetId,
  getLinks: _recurrenteEstandarDbLocalGetLinks,
  attach: _recurrenteEstandarDbLocalAttach,
  version: '3.1.0+1',
);

int _recurrenteEstandarDbLocalEstimateSize(
  RecurrenteEstandarDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comoFortalece;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.comoMejoraEntorno;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
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
    final value = object.personaAutoSuficiente;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.siguientePaso;
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
  return bytesCount;
}

void _recurrenteEstandarDbLocalSerialize(
  RecurrenteEstandarDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.apoyanNegocio);
  writer.writeBool(offsets[1], object.coincideRespuesta);
  writer.writeString(offsets[2], object.comoFortalece);
  writer.writeString(offsets[3], object.comoMejoraEntorno);
  writer.writeString(offsets[4], object.cuantosApoyan);
  writer.writeString(offsets[5], object.database);
  writer.writeString(offsets[6], object.edadHijos);
  writer.writeString(offsets[7], object.explicacionInversion);
  writer.writeString(offsets[8], object.motivoPrestamo);
  writer.writeLong(offsets[9], object.numeroHijos);
  writer.writeLong(offsets[10], object.objSolicitudRecurrenteId);
  writer.writeBool(offsets[11], object.otrosIngresos);
  writer.writeString(offsets[12], object.otrosIngresosDescripcion);
  writer.writeString(offsets[13], object.personaAutoSuficiente);
  writer.writeLong(offsets[14], object.personasCargo);
  writer.writeString(offsets[15], object.siguientePaso);
  writer.writeString(offsets[16], object.tipoEstudioHijos);
}

RecurrenteEstandarDbLocal _recurrenteEstandarDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurrenteEstandarDbLocal();
  object.apoyanNegocio = reader.readBoolOrNull(offsets[0]);
  object.coincideRespuesta = reader.readBoolOrNull(offsets[1]);
  object.comoFortalece = reader.readStringOrNull(offsets[2]);
  object.comoMejoraEntorno = reader.readStringOrNull(offsets[3]);
  object.cuantosApoyan = reader.readStringOrNull(offsets[4]);
  object.database = reader.readStringOrNull(offsets[5]);
  object.edadHijos = reader.readStringOrNull(offsets[6]);
  object.explicacionInversion = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.motivoPrestamo = reader.readStringOrNull(offsets[8]);
  object.numeroHijos = reader.readLongOrNull(offsets[9]);
  object.objSolicitudRecurrenteId = reader.readLongOrNull(offsets[10]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[11]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[12]);
  object.personaAutoSuficiente = reader.readStringOrNull(offsets[13]);
  object.personasCargo = reader.readLongOrNull(offsets[14]);
  object.siguientePaso = reader.readStringOrNull(offsets[15]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[16]);
  return object;
}

P _recurrenteEstandarDbLocalDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
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
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recurrenteEstandarDbLocalGetId(RecurrenteEstandarDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurrenteEstandarDbLocalGetLinks(
    RecurrenteEstandarDbLocal object) {
  return [];
}

void _recurrenteEstandarDbLocalAttach(
    IsarCollection<dynamic> col, Id id, RecurrenteEstandarDbLocal object) {
  object.id = id;
}

extension RecurrenteEstandarDbLocalQueryWhereSort on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QWhere> {
  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurrenteEstandarDbLocalQueryWhere on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QWhereClause> {
  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterWhereClause> idBetween(
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

extension RecurrenteEstandarDbLocalQueryFilter on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QFilterCondition> {
  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> apoyanNegocioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> apoyanNegocioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> apoyanNegocioEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apoyanNegocio',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> coincideRespuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coincideRespuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoFortalece',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoFortalece',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoFortalece',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoFortalece',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoFortalece',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoFortalece',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoFortalece',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoFortalece',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      comoFortaleceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoFortalece',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      comoFortaleceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoFortalece',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoFortalece',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoFortaleceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoFortalece',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoMejoraEntorno',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoMejoraEntorno',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoMejoraEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoMejoraEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoMejoraEntorno',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoMejoraEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoMejoraEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      comoMejoraEntornoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoMejoraEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      comoMejoraEntornoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoMejoraEntorno',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraEntorno',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> comoMejoraEntornoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoMejoraEntorno',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      cuantosApoyanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      cuantosApoyanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cuantosApoyan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> cuantosApoyanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      databaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      databaseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'database',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      edadHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      edadHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'edadHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> explicacionInversionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      explicacionInversionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explicacionInversion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      explicacionInversionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explicacionInversion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> explicacionInversionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      motivoPrestamoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      motivoPrestamoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoPrestamo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personaAutoSuficiente',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personaAutoSuficiente',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personaAutoSuficiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personaAutoSuficiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personaAutoSuficiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personaAutoSuficiente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'personaAutoSuficiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'personaAutoSuficiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      personaAutoSuficienteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'personaAutoSuficiente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      personaAutoSuficienteMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'personaAutoSuficiente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personaAutoSuficiente',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personaAutoSuficienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personaAutoSuficiente',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguientePaso',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'siguientePaso',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'siguientePaso',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'siguientePaso',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'siguientePaso',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'siguientePaso',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      siguientePasoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'siguientePaso',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      siguientePasoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'siguientePaso',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> siguientePasoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
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

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      tipoEstudioHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
          QAfterFilterCondition>
      tipoEstudioHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoEstudioHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }
}

extension RecurrenteEstandarDbLocalQueryObject on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QFilterCondition> {}

extension RecurrenteEstandarDbLocalQueryLinks on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QFilterCondition> {}

extension RecurrenteEstandarDbLocalQuerySortBy on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QSortBy> {
  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByComoFortalece() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoFortalece', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByComoFortaleceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoFortalece', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByComoMejoraEntorno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraEntorno', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByComoMejoraEntornoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraEntorno', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByPersonaAutoSuficiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personaAutoSuficiente', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByPersonaAutoSuficienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personaAutoSuficiente', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }
}

extension RecurrenteEstandarDbLocalQuerySortThenBy on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QSortThenBy> {
  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByComoFortalece() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoFortalece', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByComoFortaleceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoFortalece', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByComoMejoraEntorno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraEntorno', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByComoMejoraEntornoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraEntorno', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByPersonaAutoSuficiente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personaAutoSuficiente', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByPersonaAutoSuficienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personaAutoSuficiente', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal,
      QAfterSortBy> thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }
}

extension RecurrenteEstandarDbLocalQueryWhereDistinct on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct> {
  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apoyanNegocio');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByComoFortalece({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoFortalece',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByComoMejoraEntorno({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoMejoraEntorno',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByCuantosApoyan({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuantosApoyan',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByExplicacionInversion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionInversion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByPersonaAutoSuficiente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personaAutoSuficiente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctBySiguientePaso({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguientePaso',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QDistinct>
      distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }
}

extension RecurrenteEstandarDbLocalQueryProperty on QueryBuilder<
    RecurrenteEstandarDbLocal, RecurrenteEstandarDbLocal, QQueryProperty> {
  QueryBuilder<RecurrenteEstandarDbLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, bool?, QQueryOperations>
      apoyanNegocioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apoyanNegocio');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, bool?, QQueryOperations>
      coincideRespuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      comoFortaleceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoFortalece');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      comoMejoraEntornoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoMejoraEntorno');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      cuantosApoyanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuantosApoyan');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      explicacionInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionInversion');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, int?, QQueryOperations>
      objSolicitudRecurrenteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      personaAutoSuficienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personaAutoSuficiente');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      siguientePasoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguientePaso');
    });
  }

  QueryBuilder<RecurrenteEstandarDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }
}
