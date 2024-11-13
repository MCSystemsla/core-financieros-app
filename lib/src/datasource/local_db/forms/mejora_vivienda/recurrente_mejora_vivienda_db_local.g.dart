// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrente_mejora_vivienda_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurrenteMejoraViviendaDbLocalCollection on Isar {
  IsarCollection<RecurrenteMejoraViviendaDbLocal>
      get recurrenteMejoraViviendaDbLocals => this.collection();
}

const RecurrenteMejoraViviendaDbLocalSchema = CollectionSchema(
  name: r'RecurrenteMejoraViviendaDbLocal',
  id: 5587364506344647406,
  properties: {
    r'coincideRespuesta': PropertySchema(
      id: 0,
      name: r'coincideRespuesta',
      type: IsarType.bool,
    ),
    r'database': PropertySchema(
      id: 1,
      name: r'database',
      type: IsarType.string,
    ),
    r'edadHijos': PropertySchema(
      id: 2,
      name: r'edadHijos',
      type: IsarType.string,
    ),
    r'explicacionInversion': PropertySchema(
      id: 3,
      name: r'explicacionInversion',
      type: IsarType.string,
    ),
    r'mejoraSeguridadFamilia': PropertySchema(
      id: 4,
      name: r'mejoraSeguridadFamilia',
      type: IsarType.string,
    ),
    r'motivoPrestamo': PropertySchema(
      id: 5,
      name: r'motivoPrestamo',
      type: IsarType.string,
    ),
    r'necesidadesComunidad': PropertySchema(
      id: 6,
      name: r'necesidadesComunidad',
      type: IsarType.string,
    ),
    r'numeroHijos': PropertySchema(
      id: 7,
      name: r'numeroHijos',
      type: IsarType.long,
    ),
    r'objSolicitudRecurrenteId': PropertySchema(
      id: 8,
      name: r'objSolicitudRecurrenteId',
      type: IsarType.long,
    ),
    r'objTipoComunidadId': PropertySchema(
      id: 9,
      name: r'objTipoComunidadId',
      type: IsarType.string,
    ),
    r'otrosIngresos': PropertySchema(
      id: 10,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 11,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 12,
      name: r'personasCargo',
      type: IsarType.string,
    ),
    r'quienApoya': PropertySchema(
      id: 13,
      name: r'quienApoya',
      type: IsarType.string,
    ),
    r'siguienteMeta': PropertySchema(
      id: 14,
      name: r'siguienteMeta',
      type: IsarType.string,
    ),
    r'tiempoActividad': PropertySchema(
      id: 15,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 16,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 17,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    ),
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 18,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    ),
    r'username': PropertySchema(
      id: 19,
      name: r'username',
      type: IsarType.string,
    ),
    r'viviendaAntesDespues': PropertySchema(
      id: 20,
      name: r'viviendaAntesDespues',
      type: IsarType.string,
    )
  },
  estimateSize: _recurrenteMejoraViviendaDbLocalEstimateSize,
  serialize: _recurrenteMejoraViviendaDbLocalSerialize,
  deserialize: _recurrenteMejoraViviendaDbLocalDeserialize,
  deserializeProp: _recurrenteMejoraViviendaDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurrenteMejoraViviendaDbLocalGetId,
  getLinks: _recurrenteMejoraViviendaDbLocalGetLinks,
  attach: _recurrenteMejoraViviendaDbLocalAttach,
  version: '3.1.0+1',
);

int _recurrenteMejoraViviendaDbLocalEstimateSize(
  RecurrenteMejoraViviendaDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
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
    final value = object.mejoraSeguridadFamilia;
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
    final value = object.necesidadesComunidad;
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
  {
    final value = object.username;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.viviendaAntesDespues;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recurrenteMejoraViviendaDbLocalSerialize(
  RecurrenteMejoraViviendaDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.coincideRespuesta);
  writer.writeString(offsets[1], object.database);
  writer.writeString(offsets[2], object.edadHijos);
  writer.writeString(offsets[3], object.explicacionInversion);
  writer.writeString(offsets[4], object.mejoraSeguridadFamilia);
  writer.writeString(offsets[5], object.motivoPrestamo);
  writer.writeString(offsets[6], object.necesidadesComunidad);
  writer.writeLong(offsets[7], object.numeroHijos);
  writer.writeLong(offsets[8], object.objSolicitudRecurrenteId);
  writer.writeString(offsets[9], object.objTipoComunidadId);
  writer.writeBool(offsets[10], object.otrosIngresos);
  writer.writeString(offsets[11], object.otrosIngresosDescripcion);
  writer.writeString(offsets[12], object.personasCargo);
  writer.writeString(offsets[13], object.quienApoya);
  writer.writeString(offsets[14], object.siguienteMeta);
  writer.writeLong(offsets[15], object.tiempoActividad);
  writer.writeBool(offsets[16], object.tieneTrabajo);
  writer.writeString(offsets[17], object.tipoEstudioHijos);
  writer.writeString(offsets[18], object.trabajoNegocioDescripcion);
  writer.writeString(offsets[19], object.username);
  writer.writeString(offsets[20], object.viviendaAntesDespues);
}

RecurrenteMejoraViviendaDbLocal _recurrenteMejoraViviendaDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurrenteMejoraViviendaDbLocal();
  object.coincideRespuesta = reader.readBoolOrNull(offsets[0]);
  object.database = reader.readStringOrNull(offsets[1]);
  object.edadHijos = reader.readStringOrNull(offsets[2]);
  object.explicacionInversion = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.mejoraSeguridadFamilia = reader.readStringOrNull(offsets[4]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[5]);
  object.necesidadesComunidad = reader.readStringOrNull(offsets[6]);
  object.numeroHijos = reader.readLongOrNull(offsets[7]);
  object.objSolicitudRecurrenteId = reader.readLongOrNull(offsets[8]);
  object.objTipoComunidadId = reader.readStringOrNull(offsets[9]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[10]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[11]);
  object.personasCargo = reader.readStringOrNull(offsets[12]);
  object.quienApoya = reader.readStringOrNull(offsets[13]);
  object.siguienteMeta = reader.readStringOrNull(offsets[14]);
  object.tiempoActividad = reader.readLongOrNull(offsets[15]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[16]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[17]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[18]);
  object.username = reader.readStringOrNull(offsets[19]);
  object.viviendaAntesDespues = reader.readStringOrNull(offsets[20]);
  return object;
}

P _recurrenteMejoraViviendaDbLocalDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
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
      return (reader.readStringOrNull(offset)) as P;
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

Id _recurrenteMejoraViviendaDbLocalGetId(
    RecurrenteMejoraViviendaDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurrenteMejoraViviendaDbLocalGetLinks(
    RecurrenteMejoraViviendaDbLocal object) {
  return [];
}

void _recurrenteMejoraViviendaDbLocalAttach(IsarCollection<dynamic> col, Id id,
    RecurrenteMejoraViviendaDbLocal object) {
  object.id = id;
}

extension RecurrenteMejoraViviendaDbLocalQueryWhereSort on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal, QWhere> {
  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurrenteMejoraViviendaDbLocalQueryWhere on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal,
    QWhereClause> {
  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

extension RecurrenteMejoraViviendaDbLocalQueryFilter on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal,
    QFilterCondition> {
  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> coincideRespuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coincideRespuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> explicacionInversionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> explicacionInversionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mejoraSeguridadFamilia',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mejoraSeguridadFamilia',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraSeguridadFamilia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mejoraSeguridadFamilia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mejoraSeguridadFamilia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mejoraSeguridadFamilia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mejoraSeguridadFamilia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mejoraSeguridadFamilia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      mejoraSeguridadFamiliaContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mejoraSeguridadFamilia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      mejoraSeguridadFamiliaMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mejoraSeguridadFamilia',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraSeguridadFamilia',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> mejoraSeguridadFamiliaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mejoraSeguridadFamilia',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'necesidadesComunidad',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'necesidadesComunidad',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'necesidadesComunidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'necesidadesComunidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'necesidadesComunidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'necesidadesComunidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'necesidadesComunidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'necesidadesComunidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      necesidadesComunidadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'necesidadesComunidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      necesidadesComunidadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'necesidadesComunidad',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'necesidadesComunidad',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'necesidadesComunidad',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objTipoComunidadId',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objTipoComunidadId',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objTipoComunidadId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objTipoComunidadId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> siguienteMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguienteMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> siguienteMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguienteMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> siguienteMetaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> siguienteMetaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguienteMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
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

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'viviendaAntesDespues',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'viviendaAntesDespues',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viviendaAntesDespues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viviendaAntesDespues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viviendaAntesDespues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viviendaAntesDespues',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viviendaAntesDespues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viviendaAntesDespues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      viviendaAntesDespuesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viviendaAntesDespues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QAfterFilterCondition>
      viviendaAntesDespuesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viviendaAntesDespues',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viviendaAntesDespues',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterFilterCondition> viviendaAntesDespuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viviendaAntesDespues',
        value: '',
      ));
    });
  }
}

extension RecurrenteMejoraViviendaDbLocalQueryObject on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal,
    QFilterCondition> {}

extension RecurrenteMejoraViviendaDbLocalQueryLinks on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal,
    QFilterCondition> {}

extension RecurrenteMejoraViviendaDbLocalQuerySortBy on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal, QSortBy> {
  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByMejoraSeguridadFamilia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraSeguridadFamilia', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByMejoraSeguridadFamiliaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraSeguridadFamilia', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByNecesidadesComunidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByNecesidadesComunidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByObjTipoComunidadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByObjTipoComunidadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortBySiguienteMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortBySiguienteMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByViviendaAntesDespues() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viviendaAntesDespues', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> sortByViviendaAntesDespuesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viviendaAntesDespues', Sort.desc);
    });
  }
}

extension RecurrenteMejoraViviendaDbLocalQuerySortThenBy on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal,
    QSortThenBy> {
  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByMejoraSeguridadFamilia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraSeguridadFamilia', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByMejoraSeguridadFamiliaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraSeguridadFamilia', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByNecesidadesComunidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByNecesidadesComunidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByObjTipoComunidadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByObjTipoComunidadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenBySiguienteMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenBySiguienteMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByViviendaAntesDespues() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viviendaAntesDespues', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QAfterSortBy> thenByViviendaAntesDespuesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viviendaAntesDespues', Sort.desc);
    });
  }
}

extension RecurrenteMejoraViviendaDbLocalQueryWhereDistinct on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal,
    QDistinct> {
  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByExplicacionInversion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionInversion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByMejoraSeguridadFamilia({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mejoraSeguridadFamilia',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByNecesidadesComunidad({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'necesidadesComunidad',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByObjTipoComunidadId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objTipoComunidadId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByPersonasCargo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctBySiguienteMeta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguienteMeta',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
          QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByUsername({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, RecurrenteMejoraViviendaDbLocal,
      QDistinct> distinctByViviendaAntesDespues({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'viviendaAntesDespues',
          caseSensitive: caseSensitive);
    });
  }
}

extension RecurrenteMejoraViviendaDbLocalQueryProperty on QueryBuilder<
    RecurrenteMejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal,
    QQueryProperty> {
  QueryBuilder<RecurrenteMejoraViviendaDbLocal, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, bool?, QQueryOperations>
      coincideRespuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      explicacionInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionInversion');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      mejoraSeguridadFamiliaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mejoraSeguridadFamilia');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      necesidadesComunidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'necesidadesComunidad');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, int?, QQueryOperations>
      objSolicitudRecurrenteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      objTipoComunidadIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objTipoComunidadId');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      siguienteMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguienteMeta');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }

  QueryBuilder<RecurrenteMejoraViviendaDbLocal, String?, QQueryOperations>
      viviendaAntesDespuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'viviendaAntesDespues');
    });
  }
}
