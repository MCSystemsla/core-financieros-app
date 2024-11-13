// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrente_energia_limpia_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurrenteEnergiaLimpiaDbLocalCollection on Isar {
  IsarCollection<RecurrenteEnergiaLimpiaDbLocal>
      get recurrenteEnergiaLimpiaDbLocals => this.collection();
}

const RecurrenteEnergiaLimpiaDbLocalSchema = CollectionSchema(
  name: r'RecurrenteEnergiaLimpiaDbLocal',
  id: 8528146287997486682,
  properties: {
    r'coincideRespuesta': PropertySchema(
      id: 0,
      name: r'coincideRespuesta',
      type: IsarType.bool,
    ),
    r'comoMejoraSituacion': PropertySchema(
      id: 1,
      name: r'comoMejoraSituacion',
      type: IsarType.string,
    ),
    r'database': PropertySchema(
      id: 2,
      name: r'database',
      type: IsarType.string,
    ),
    r'edadHijos': PropertySchema(
      id: 3,
      name: r'edadHijos',
      type: IsarType.string,
    ),
    r'explicacionInversion': PropertySchema(
      id: 4,
      name: r'explicacionInversion',
      type: IsarType.string,
    ),
    r'motivoPrestamo': PropertySchema(
      id: 5,
      name: r'motivoPrestamo',
      type: IsarType.string,
    ),
    r'numeroHijos': PropertySchema(
      id: 6,
      name: r'numeroHijos',
      type: IsarType.long,
    ),
    r'objSolicitudRecurrenteId': PropertySchema(
      id: 7,
      name: r'objSolicitudRecurrenteId',
      type: IsarType.long,
    ),
    r'objTipoComunidadId': PropertySchema(
      id: 8,
      name: r'objTipoComunidadId',
      type: IsarType.string,
    ),
    r'otrosIngresos': PropertySchema(
      id: 9,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 10,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 11,
      name: r'personasCargo',
      type: IsarType.string,
    ),
    r'quienApoya': PropertySchema(
      id: 12,
      name: r'quienApoya',
      type: IsarType.string,
    ),
    r'siguienteMeta': PropertySchema(
      id: 13,
      name: r'siguienteMeta',
      type: IsarType.string,
    ),
    r'situacionAntesAhora': PropertySchema(
      id: 14,
      name: r'situacionAntesAhora',
      type: IsarType.string,
    ),
    r'tiempoActividad': PropertySchema(
      id: 15,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tieneProblemasEnergia': PropertySchema(
      id: 16,
      name: r'tieneProblemasEnergia',
      type: IsarType.bool,
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
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 19,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    )
  },
  estimateSize: _recurrenteEnergiaLimpiaDbLocalEstimateSize,
  serialize: _recurrenteEnergiaLimpiaDbLocalSerialize,
  deserialize: _recurrenteEnergiaLimpiaDbLocalDeserialize,
  deserializeProp: _recurrenteEnergiaLimpiaDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurrenteEnergiaLimpiaDbLocalGetId,
  getLinks: _recurrenteEnergiaLimpiaDbLocalGetLinks,
  attach: _recurrenteEnergiaLimpiaDbLocalAttach,
  version: '3.1.0+1',
);

int _recurrenteEnergiaLimpiaDbLocalEstimateSize(
  RecurrenteEnergiaLimpiaDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comoMejoraSituacion;
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
    final value = object.objTipoComunidadId;
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
    final value = object.personasCargo;
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
    final value = object.situacionAntesAhora;
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
    final value = object.trabajoNegocioDescripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recurrenteEnergiaLimpiaDbLocalSerialize(
  RecurrenteEnergiaLimpiaDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.coincideRespuesta);
  writer.writeString(offsets[1], object.comoMejoraSituacion);
  writer.writeString(offsets[2], object.database);
  writer.writeString(offsets[3], object.edadHijos);
  writer.writeString(offsets[4], object.explicacionInversion);
  writer.writeString(offsets[5], object.motivoPrestamo);
  writer.writeLong(offsets[6], object.numeroHijos);
  writer.writeLong(offsets[7], object.objSolicitudRecurrenteId);
  writer.writeString(offsets[8], object.objTipoComunidadId);
  writer.writeBool(offsets[9], object.otrosIngresos);
  writer.writeString(offsets[10], object.otrosIngresosDescripcion);
  writer.writeString(offsets[11], object.personasCargo);
  writer.writeString(offsets[12], object.quienApoya);
  writer.writeString(offsets[13], object.siguienteMeta);
  writer.writeString(offsets[14], object.situacionAntesAhora);
  writer.writeLong(offsets[15], object.tiempoActividad);
  writer.writeBool(offsets[16], object.tieneProblemasEnergia);
  writer.writeBool(offsets[17], object.tieneTrabajo);
  writer.writeString(offsets[18], object.tipoEstudioHijos);
  writer.writeString(offsets[19], object.trabajoNegocioDescripcion);
}

RecurrenteEnergiaLimpiaDbLocal _recurrenteEnergiaLimpiaDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurrenteEnergiaLimpiaDbLocal();
  object.coincideRespuesta = reader.readBoolOrNull(offsets[0]);
  object.comoMejoraSituacion = reader.readStringOrNull(offsets[1]);
  object.database = reader.readStringOrNull(offsets[2]);
  object.edadHijos = reader.readStringOrNull(offsets[3]);
  object.explicacionInversion = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.motivoPrestamo = reader.readStringOrNull(offsets[5]);
  object.numeroHijos = reader.readLongOrNull(offsets[6]);
  object.objSolicitudRecurrenteId = reader.readLongOrNull(offsets[7]);
  object.objTipoComunidadId = reader.readStringOrNull(offsets[8]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[9]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[10]);
  object.personasCargo = reader.readStringOrNull(offsets[11]);
  object.quienApoya = reader.readStringOrNull(offsets[12]);
  object.siguienteMeta = reader.readStringOrNull(offsets[13]);
  object.situacionAntesAhora = reader.readStringOrNull(offsets[14]);
  object.tiempoActividad = reader.readLongOrNull(offsets[15]);
  object.tieneProblemasEnergia = reader.readBoolOrNull(offsets[16]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[17]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[18]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[19]);
  return object;
}

P _recurrenteEnergiaLimpiaDbLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readBoolOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recurrenteEnergiaLimpiaDbLocalGetId(RecurrenteEnergiaLimpiaDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurrenteEnergiaLimpiaDbLocalGetLinks(
    RecurrenteEnergiaLimpiaDbLocal object) {
  return [];
}

void _recurrenteEnergiaLimpiaDbLocalAttach(
    IsarCollection<dynamic> col, Id id, RecurrenteEnergiaLimpiaDbLocal object) {
  object.id = id;
}

extension RecurrenteEnergiaLimpiaDbLocalQueryWhereSort on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal, QWhere> {
  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurrenteEnergiaLimpiaDbLocalQueryWhere on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal,
    RecurrenteEnergiaLimpiaDbLocal,
    QWhereClause> {
  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

extension RecurrenteEnergiaLimpiaDbLocalQueryFilter on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal,
    RecurrenteEnergiaLimpiaDbLocal,
    QFilterCondition> {
  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> coincideRespuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coincideRespuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoMejoraSituacion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoMejoraSituacion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraSituacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoMejoraSituacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoMejoraSituacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoMejoraSituacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoMejoraSituacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoMejoraSituacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      comoMejoraSituacionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoMejoraSituacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      comoMejoraSituacionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoMejoraSituacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraSituacion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> comoMejoraSituacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoMejoraSituacion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> explicacionInversionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> explicacionInversionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objTipoComunidadId',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objTipoComunidadId',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objTipoComunidadId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objTipoComunidadId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objTipoComunidadId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objTipoComunidadId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'objTipoComunidadId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'objTipoComunidadId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      objTipoComunidadIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'objTipoComunidadId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      objTipoComunidadIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'objTipoComunidadId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objTipoComunidadId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objTipoComunidadId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personasCargo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personasCargo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personasCargo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'personasCargo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'personasCargo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      personasCargoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'personasCargo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      personasCargoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'personasCargo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> personasCargoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      quienApoyaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quienApoya',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      quienApoyaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quienApoya',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> siguienteMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguienteMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> siguienteMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguienteMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      siguienteMetaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'siguienteMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      siguienteMetaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'siguienteMeta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> siguienteMetaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> siguienteMetaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguienteMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'situacionAntesAhora',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'situacionAntesAhora',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'situacionAntesAhora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'situacionAntesAhora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'situacionAntesAhora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'situacionAntesAhora',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'situacionAntesAhora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'situacionAntesAhora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      situacionAntesAhoraContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'situacionAntesAhora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
      situacionAntesAhoraMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'situacionAntesAhora',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'situacionAntesAhora',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> situacionAntesAhoraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'situacionAntesAhora',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tieneProblemasEnergiaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneProblemasEnergia',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tieneProblemasEnergiaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneProblemasEnergia',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tieneProblemasEnergiaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneProblemasEnergia',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QAfterFilterCondition>
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

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }
}

extension RecurrenteEnergiaLimpiaDbLocalQueryObject on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal,
    RecurrenteEnergiaLimpiaDbLocal,
    QFilterCondition> {}

extension RecurrenteEnergiaLimpiaDbLocalQueryLinks on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal,
    RecurrenteEnergiaLimpiaDbLocal,
    QFilterCondition> {}

extension RecurrenteEnergiaLimpiaDbLocalQuerySortBy on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal, QSortBy> {
  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByComoMejoraSituacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraSituacion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByComoMejoraSituacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraSituacion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByObjTipoComunidadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByObjTipoComunidadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortBySiguienteMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortBySiguienteMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortBySituacionAntesAhora() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionAntesAhora', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortBySituacionAntesAhoraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionAntesAhora', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTieneProblemasEnergia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneProblemasEnergia', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTieneProblemasEnergiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneProblemasEnergia', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension RecurrenteEnergiaLimpiaDbLocalQuerySortThenBy on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal,
    RecurrenteEnergiaLimpiaDbLocal,
    QSortThenBy> {
  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByComoMejoraSituacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraSituacion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByComoMejoraSituacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraSituacion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByObjTipoComunidadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByObjTipoComunidadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenBySiguienteMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenBySiguienteMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenBySituacionAntesAhora() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionAntesAhora', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenBySituacionAntesAhoraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionAntesAhora', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTieneProblemasEnergia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneProblemasEnergia', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTieneProblemasEnergiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneProblemasEnergia', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension RecurrenteEnergiaLimpiaDbLocalQueryWhereDistinct on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal, QDistinct> {
  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByComoMejoraSituacion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoMejoraSituacion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByExplicacionInversion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionInversion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByObjTipoComunidadId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objTipoComunidadId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByPersonasCargo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctBySiguienteMeta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguienteMeta',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctBySituacionAntesAhora({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'situacionAntesAhora',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByTieneProblemasEnergia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneProblemasEnergia');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
      QDistinct> distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, RecurrenteEnergiaLimpiaDbLocal,
          QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }
}

extension RecurrenteEnergiaLimpiaDbLocalQueryProperty on QueryBuilder<
    RecurrenteEnergiaLimpiaDbLocal,
    RecurrenteEnergiaLimpiaDbLocal,
    QQueryProperty> {
  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, bool?, QQueryOperations>
      coincideRespuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      comoMejoraSituacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoMejoraSituacion');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      explicacionInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionInversion');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, int?, QQueryOperations>
      objSolicitudRecurrenteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      objTipoComunidadIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objTipoComunidadId');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      siguienteMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguienteMeta');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      situacionAntesAhoraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'situacionAntesAhora');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, bool?, QQueryOperations>
      tieneProblemasEnergiaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneProblemasEnergia');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<RecurrenteEnergiaLimpiaDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }
}
