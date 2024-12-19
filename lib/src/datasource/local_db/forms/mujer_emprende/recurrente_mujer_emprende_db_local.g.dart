// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrente_mujer_emprende_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurrenteMujerEmprendeDbLocalCollection on Isar {
  IsarCollection<RecurrenteMujerEmprendeDbLocal>
      get recurrenteMujerEmprendeDbLocals => this.collection();
}

const RecurrenteMujerEmprendeDbLocalSchema = CollectionSchema(
  name: r'RecurrenteMujerEmprendeDbLocal',
  id: -2450674273803208645,
  properties: {
    r'alcanzaraMeta': PropertySchema(
      id: 0,
      name: r'alcanzaraMeta',
      type: IsarType.bool,
    ),
    r'apoyanNegocio': PropertySchema(
      id: 1,
      name: r'apoyanNegocio',
      type: IsarType.bool,
    ),
    r'coincideRespuesta': PropertySchema(
      id: 2,
      name: r'coincideRespuesta',
      type: IsarType.bool,
    ),
    r'comoAyudo': PropertySchema(
      id: 3,
      name: r'comoAyudo',
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
    r'explicacionAlcanzaraMeta': PropertySchema(
      id: 7,
      name: r'explicacionAlcanzaraMeta',
      type: IsarType.string,
    ),
    r'explicacionInversion': PropertySchema(
      id: 8,
      name: r'explicacionInversion',
      type: IsarType.string,
    ),
    r'mejoraraEntorno': PropertySchema(
      id: 9,
      name: r'mejoraraEntorno',
      type: IsarType.bool,
    ),
    r'mejoraraEntornoExplicacion': PropertySchema(
      id: 10,
      name: r'mejoraraEntornoExplicacion',
      type: IsarType.string,
    ),
    r'motivoPrestamo': PropertySchema(
      id: 11,
      name: r'motivoPrestamo',
      type: IsarType.string,
    ),
    r'numeroHijos': PropertySchema(
      id: 12,
      name: r'numeroHijos',
      type: IsarType.long,
    ),
    r'objSolicitudRecurrenteId': PropertySchema(
      id: 13,
      name: r'objSolicitudRecurrenteId',
      type: IsarType.long,
    ),
    r'otrosIngresos': PropertySchema(
      id: 14,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 15,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 16,
      name: r'personasCargo',
      type: IsarType.long,
    ),
    r'siguientePaso': PropertySchema(
      id: 17,
      name: r'siguientePaso',
      type: IsarType.string,
    ),
    r'tiempoActividad': PropertySchema(
      id: 18,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 19,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tieneTrabajoDescripcion': PropertySchema(
      id: 20,
      name: r'tieneTrabajoDescripcion',
      type: IsarType.string,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 21,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    )
  },
  estimateSize: _recurrenteMujerEmprendeDbLocalEstimateSize,
  serialize: _recurrenteMujerEmprendeDbLocalSerialize,
  deserialize: _recurrenteMujerEmprendeDbLocalDeserialize,
  deserializeProp: _recurrenteMujerEmprendeDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurrenteMujerEmprendeDbLocalGetId,
  getLinks: _recurrenteMujerEmprendeDbLocalGetLinks,
  attach: _recurrenteMujerEmprendeDbLocalAttach,
  version: '3.1.0+1',
);

int _recurrenteMujerEmprendeDbLocalEstimateSize(
  RecurrenteMujerEmprendeDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comoAyudo;
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
    final value = object.explicacionAlcanzaraMeta;
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
    final value = object.mejoraraEntornoExplicacion;
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
    final value = object.siguientePaso;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tieneTrabajoDescripcion;
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

void _recurrenteMujerEmprendeDbLocalSerialize(
  RecurrenteMujerEmprendeDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.alcanzaraMeta);
  writer.writeBool(offsets[1], object.apoyanNegocio);
  writer.writeBool(offsets[2], object.coincideRespuesta);
  writer.writeString(offsets[3], object.comoAyudo);
  writer.writeString(offsets[4], object.cuantosApoyan);
  writer.writeString(offsets[5], object.database);
  writer.writeString(offsets[6], object.edadHijos);
  writer.writeString(offsets[7], object.explicacionAlcanzaraMeta);
  writer.writeString(offsets[8], object.explicacionInversion);
  writer.writeBool(offsets[9], object.mejoraraEntorno);
  writer.writeString(offsets[10], object.mejoraraEntornoExplicacion);
  writer.writeString(offsets[11], object.motivoPrestamo);
  writer.writeLong(offsets[12], object.numeroHijos);
  writer.writeLong(offsets[13], object.objSolicitudRecurrenteId);
  writer.writeBool(offsets[14], object.otrosIngresos);
  writer.writeString(offsets[15], object.otrosIngresosDescripcion);
  writer.writeLong(offsets[16], object.personasCargo);
  writer.writeString(offsets[17], object.siguientePaso);
  writer.writeLong(offsets[18], object.tiempoActividad);
  writer.writeBool(offsets[19], object.tieneTrabajo);
  writer.writeString(offsets[20], object.tieneTrabajoDescripcion);
  writer.writeString(offsets[21], object.tipoEstudioHijos);
}

RecurrenteMujerEmprendeDbLocal _recurrenteMujerEmprendeDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurrenteMujerEmprendeDbLocal();
  object.alcanzaraMeta = reader.readBoolOrNull(offsets[0]);
  object.apoyanNegocio = reader.readBoolOrNull(offsets[1]);
  object.coincideRespuesta = reader.readBoolOrNull(offsets[2]);
  object.comoAyudo = reader.readStringOrNull(offsets[3]);
  object.cuantosApoyan = reader.readStringOrNull(offsets[4]);
  object.database = reader.readStringOrNull(offsets[5]);
  object.edadHijos = reader.readStringOrNull(offsets[6]);
  object.explicacionAlcanzaraMeta = reader.readStringOrNull(offsets[7]);
  object.explicacionInversion = reader.readStringOrNull(offsets[8]);
  object.id = id;
  object.mejoraraEntorno = reader.readBoolOrNull(offsets[9]);
  object.mejoraraEntornoExplicacion = reader.readStringOrNull(offsets[10]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[11]);
  object.numeroHijos = reader.readLongOrNull(offsets[12]);
  object.objSolicitudRecurrenteId = reader.readLongOrNull(offsets[13]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[14]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[15]);
  object.personasCargo = reader.readLongOrNull(offsets[16]);
  object.siguientePaso = reader.readStringOrNull(offsets[17]);
  object.tiempoActividad = reader.readLongOrNull(offsets[18]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[19]);
  object.tieneTrabajoDescripcion = reader.readStringOrNull(offsets[20]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[21]);
  return object;
}

P _recurrenteMujerEmprendeDbLocalDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
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
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readBoolOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readBoolOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recurrenteMujerEmprendeDbLocalGetId(RecurrenteMujerEmprendeDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurrenteMujerEmprendeDbLocalGetLinks(
    RecurrenteMujerEmprendeDbLocal object) {
  return [];
}

void _recurrenteMujerEmprendeDbLocalAttach(
    IsarCollection<dynamic> col, Id id, RecurrenteMujerEmprendeDbLocal object) {
  object.id = id;
}

extension RecurrenteMujerEmprendeDbLocalQueryWhereSort on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal, QWhere> {
  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurrenteMujerEmprendeDbLocalQueryWhere on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal,
    RecurrenteMujerEmprendeDbLocal,
    QWhereClause> {
  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

extension RecurrenteMujerEmprendeDbLocalQueryFilter on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal,
    RecurrenteMujerEmprendeDbLocal,
    QFilterCondition> {
  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> alcanzaraMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> alcanzaraMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> alcanzaraMetaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alcanzaraMeta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> apoyanNegocioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> apoyanNegocioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> apoyanNegocioEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apoyanNegocio',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> coincideRespuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coincideRespuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoAyudo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoAyudo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoAyudo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoAyudo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoAyudo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoAyudo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoAyudo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      comoAyudoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoAyudo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      comoAyudoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoAyudo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> comoAyudoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoAyudo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> cuantosApoyanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> cuantosApoyanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionAlcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionAlcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionAlcanzaraMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explicacionAlcanzaraMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explicacionAlcanzaraMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explicacionAlcanzaraMeta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explicacionAlcanzaraMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explicacionAlcanzaraMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      explicacionAlcanzaraMetaContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explicacionAlcanzaraMeta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      explicacionAlcanzaraMetaMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explicacionAlcanzaraMeta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionAlcanzaraMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionAlcanzaraMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionInversionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionInversionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mejoraraEntorno',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mejoraraEntorno',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraraEntorno',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mejoraraEntornoExplicacion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mejoraraEntornoExplicacion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraraEntornoExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mejoraraEntornoExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mejoraraEntornoExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mejoraraEntornoExplicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mejoraraEntornoExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mejoraraEntornoExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      mejoraraEntornoExplicacionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mejoraraEntornoExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      mejoraraEntornoExplicacionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mejoraraEntornoExplicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraraEntornoExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> mejoraraEntornoExplicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mejoraraEntornoExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> siguientePasoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> siguientePasoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> siguientePasoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> siguientePasoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajoDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajoDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajoDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tieneTrabajoDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tieneTrabajoDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tieneTrabajoDescripcion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tieneTrabajoDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tieneTrabajoDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      tieneTrabajoDescripcionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tieneTrabajoDescripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QAfterFilterCondition>
      tieneTrabajoDescripcionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tieneTrabajoDescripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajoDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tieneTrabajoDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
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

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }
}

extension RecurrenteMujerEmprendeDbLocalQueryObject on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal,
    RecurrenteMujerEmprendeDbLocal,
    QFilterCondition> {}

extension RecurrenteMujerEmprendeDbLocalQueryLinks on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal,
    RecurrenteMujerEmprendeDbLocal,
    QFilterCondition> {}

extension RecurrenteMujerEmprendeDbLocalQuerySortBy on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal, QSortBy> {
  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByComoAyudo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByComoAyudoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByExplicacionAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByExplicacionAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByMejoraraEntorno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntorno', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByMejoraraEntornoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntorno', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByMejoraraEntornoExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntornoExplicacion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByMejoraraEntornoExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntornoExplicacion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTieneTrabajoDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajoDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTieneTrabajoDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajoDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }
}

extension RecurrenteMujerEmprendeDbLocalQuerySortThenBy on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal,
    RecurrenteMujerEmprendeDbLocal,
    QSortThenBy> {
  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByComoAyudo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByComoAyudoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByExplicacionAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByExplicacionAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByMejoraraEntorno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntorno', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByMejoraraEntornoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntorno', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByMejoraraEntornoExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntornoExplicacion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByMejoraraEntornoExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraraEntornoExplicacion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTieneTrabajoDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajoDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTieneTrabajoDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajoDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QAfterSortBy> thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }
}

extension RecurrenteMujerEmprendeDbLocalQueryWhereDistinct on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal, QDistinct> {
  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apoyanNegocio');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByComoAyudo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoAyudo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByCuantosApoyan({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuantosApoyan',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QDistinct>
      distinctByExplicacionAlcanzaraMeta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionAlcanzaraMeta',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByExplicacionInversion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionInversion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByMejoraraEntorno() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mejoraraEntorno');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QDistinct>
      distinctByMejoraraEntornoExplicacion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mejoraraEntornoExplicacion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctBySiguientePaso({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguientePaso',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
          QDistinct>
      distinctByTieneTrabajoDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajoDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, RecurrenteMujerEmprendeDbLocal,
      QDistinct> distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }
}

extension RecurrenteMujerEmprendeDbLocalQueryProperty on QueryBuilder<
    RecurrenteMujerEmprendeDbLocal,
    RecurrenteMujerEmprendeDbLocal,
    QQueryProperty> {
  QueryBuilder<RecurrenteMujerEmprendeDbLocal, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, bool?, QQueryOperations>
      alcanzaraMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, bool?, QQueryOperations>
      apoyanNegocioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apoyanNegocio');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, bool?, QQueryOperations>
      coincideRespuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      comoAyudoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoAyudo');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      cuantosApoyanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuantosApoyan');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      explicacionAlcanzaraMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionAlcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      explicacionInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionInversion');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, bool?, QQueryOperations>
      mejoraraEntornoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mejoraraEntorno');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      mejoraraEntornoExplicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mejoraraEntornoExplicacion');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, int?, QQueryOperations>
      objSolicitudRecurrenteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      siguientePasoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguientePaso');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      tieneTrabajoDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajoDescripcion');
    });
  }

  QueryBuilder<RecurrenteMujerEmprendeDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }
}
