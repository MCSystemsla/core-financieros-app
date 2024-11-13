// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrente_saneamiento_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurrenteSaneamientoDbLocalCollection on Isar {
  IsarCollection<RecurrenteSaneamientoDbLocal>
      get recurrenteSaneamientoDbLocals => this.collection();
}

const RecurrenteSaneamientoDbLocalSchema = CollectionSchema(
  name: r'RecurrenteSaneamientoDbLocal',
  id: 5426677003042572035,
  properties: {
    r'alcanzaraMeta': PropertySchema(
      id: 0,
      name: r'alcanzaraMeta',
      type: IsarType.bool,
    ),
    r'coincideRespuesta': PropertySchema(
      id: 1,
      name: r'coincideRespuesta',
      type: IsarType.bool,
    ),
    r'comoAyudoCondiciones': PropertySchema(
      id: 2,
      name: r'comoAyudoCondiciones',
      type: IsarType.string,
    ),
    r'comoMejoraCondicionesEntorno': PropertySchema(
      id: 3,
      name: r'comoMejoraCondicionesEntorno',
      type: IsarType.string,
    ),
    r'database': PropertySchema(
      id: 4,
      name: r'database',
      type: IsarType.string,
    ),
    r'edadHijos': PropertySchema(
      id: 5,
      name: r'edadHijos',
      type: IsarType.string,
    ),
    r'explicacionAlcanzaraMeta': PropertySchema(
      id: 6,
      name: r'explicacionAlcanzaraMeta',
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
    r'otrosDatosCliente': PropertySchema(
      id: 11,
      name: r'otrosDatosCliente',
      type: IsarType.string,
    ),
    r'otrosIngresos': PropertySchema(
      id: 12,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 13,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 14,
      name: r'personasCargo',
      type: IsarType.string,
    ),
    r'quienApoya': PropertySchema(
      id: 15,
      name: r'quienApoya',
      type: IsarType.string,
    ),
    r'siguientePaso': PropertySchema(
      id: 16,
      name: r'siguientePaso',
      type: IsarType.string,
    ),
    r'tiempoActividad': PropertySchema(
      id: 17,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 18,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 19,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    ),
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 20,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    )
  },
  estimateSize: _recurrenteSaneamientoDbLocalEstimateSize,
  serialize: _recurrenteSaneamientoDbLocalSerialize,
  deserialize: _recurrenteSaneamientoDbLocalDeserialize,
  deserializeProp: _recurrenteSaneamientoDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurrenteSaneamientoDbLocalGetId,
  getLinks: _recurrenteSaneamientoDbLocalGetLinks,
  attach: _recurrenteSaneamientoDbLocalAttach,
  version: '3.1.0+1',
);

int _recurrenteSaneamientoDbLocalEstimateSize(
  RecurrenteSaneamientoDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comoAyudoCondiciones;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.comoMejoraCondicionesEntorno;
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
    final value = object.motivoPrestamo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.otrosDatosCliente;
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
  {
    final value = object.trabajoNegocioDescripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recurrenteSaneamientoDbLocalSerialize(
  RecurrenteSaneamientoDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.alcanzaraMeta);
  writer.writeBool(offsets[1], object.coincideRespuesta);
  writer.writeString(offsets[2], object.comoAyudoCondiciones);
  writer.writeString(offsets[3], object.comoMejoraCondicionesEntorno);
  writer.writeString(offsets[4], object.database);
  writer.writeString(offsets[5], object.edadHijos);
  writer.writeString(offsets[6], object.explicacionAlcanzaraMeta);
  writer.writeString(offsets[7], object.explicacionInversion);
  writer.writeString(offsets[8], object.motivoPrestamo);
  writer.writeLong(offsets[9], object.numeroHijos);
  writer.writeLong(offsets[10], object.objSolicitudRecurrenteId);
  writer.writeString(offsets[11], object.otrosDatosCliente);
  writer.writeBool(offsets[12], object.otrosIngresos);
  writer.writeString(offsets[13], object.otrosIngresosDescripcion);
  writer.writeString(offsets[14], object.personasCargo);
  writer.writeString(offsets[15], object.quienApoya);
  writer.writeString(offsets[16], object.siguientePaso);
  writer.writeLong(offsets[17], object.tiempoActividad);
  writer.writeBool(offsets[18], object.tieneTrabajo);
  writer.writeString(offsets[19], object.tipoEstudioHijos);
  writer.writeString(offsets[20], object.trabajoNegocioDescripcion);
}

RecurrenteSaneamientoDbLocal _recurrenteSaneamientoDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurrenteSaneamientoDbLocal();
  object.alcanzaraMeta = reader.readBoolOrNull(offsets[0]);
  object.coincideRespuesta = reader.readBoolOrNull(offsets[1]);
  object.comoAyudoCondiciones = reader.readStringOrNull(offsets[2]);
  object.comoMejoraCondicionesEntorno = reader.readStringOrNull(offsets[3]);
  object.database = reader.readStringOrNull(offsets[4]);
  object.edadHijos = reader.readStringOrNull(offsets[5]);
  object.explicacionAlcanzaraMeta = reader.readStringOrNull(offsets[6]);
  object.explicacionInversion = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.motivoPrestamo = reader.readStringOrNull(offsets[8]);
  object.numeroHijos = reader.readLongOrNull(offsets[9]);
  object.objSolicitudRecurrenteId = reader.readLongOrNull(offsets[10]);
  object.otrosDatosCliente = reader.readStringOrNull(offsets[11]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[12]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[13]);
  object.personasCargo = reader.readStringOrNull(offsets[14]);
  object.quienApoya = reader.readStringOrNull(offsets[15]);
  object.siguientePaso = reader.readStringOrNull(offsets[16]);
  object.tiempoActividad = reader.readLongOrNull(offsets[17]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[18]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[19]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[20]);
  return object;
}

P _recurrenteSaneamientoDbLocalDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readBoolOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recurrenteSaneamientoDbLocalGetId(RecurrenteSaneamientoDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurrenteSaneamientoDbLocalGetLinks(
    RecurrenteSaneamientoDbLocal object) {
  return [];
}

void _recurrenteSaneamientoDbLocalAttach(
    IsarCollection<dynamic> col, Id id, RecurrenteSaneamientoDbLocal object) {
  object.id = id;
}

extension RecurrenteSaneamientoDbLocalQueryWhereSort on QueryBuilder<
    RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal, QWhere> {
  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurrenteSaneamientoDbLocalQueryWhere on QueryBuilder<
    RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal, QWhereClause> {
  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

extension RecurrenteSaneamientoDbLocalQueryFilter on QueryBuilder<
    RecurrenteSaneamientoDbLocal,
    RecurrenteSaneamientoDbLocal,
    QFilterCondition> {
  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> alcanzaraMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> alcanzaraMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> alcanzaraMetaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alcanzaraMeta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> coincideRespuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coincideRespuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoAyudoCondiciones',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoAyudoCondiciones',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudoCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoAyudoCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoAyudoCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoAyudoCondiciones',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoAyudoCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoAyudoCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QAfterFilterCondition>
      comoAyudoCondicionesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoAyudoCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QAfterFilterCondition>
      comoAyudoCondicionesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoAyudoCondiciones',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudoCondiciones',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoAyudoCondicionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoAyudoCondiciones',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoMejoraCondicionesEntorno',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoMejoraCondicionesEntorno',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraCondicionesEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoMejoraCondicionesEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoMejoraCondicionesEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoMejoraCondicionesEntorno',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoMejoraCondicionesEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoMejoraCondicionesEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QAfterFilterCondition>
      comoMejoraCondicionesEntornoContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoMejoraCondicionesEntorno',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QAfterFilterCondition>
      comoMejoraCondicionesEntornoMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoMejoraCondicionesEntorno',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraCondicionesEntorno',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> comoMejoraCondicionesEntornoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoMejoraCondicionesEntorno',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionAlcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionAlcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionAlcanzaraMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionAlcanzaraMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionInversionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionInversionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'otrosDatosCliente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QAfterFilterCondition>
      otrosDatosClienteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QAfterFilterCondition>
      otrosDatosClienteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'otrosDatosCliente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> personasCargoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> personasCargoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> siguientePasoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> siguientePasoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> siguientePasoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> siguientePasoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
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

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }
}

extension RecurrenteSaneamientoDbLocalQueryObject on QueryBuilder<
    RecurrenteSaneamientoDbLocal,
    RecurrenteSaneamientoDbLocal,
    QFilterCondition> {}

extension RecurrenteSaneamientoDbLocalQueryLinks on QueryBuilder<
    RecurrenteSaneamientoDbLocal,
    RecurrenteSaneamientoDbLocal,
    QFilterCondition> {}

extension RecurrenteSaneamientoDbLocalQuerySortBy on QueryBuilder<
    RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal, QSortBy> {
  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByComoAyudoCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoCondiciones', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByComoAyudoCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoCondiciones', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByComoMejoraCondicionesEntorno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCondicionesEntorno', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByComoMejoraCondicionesEntornoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCondicionesEntorno', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByExplicacionAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByExplicacionAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension RecurrenteSaneamientoDbLocalQuerySortThenBy on QueryBuilder<
    RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal, QSortThenBy> {
  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByComoAyudoCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoCondiciones', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByComoAyudoCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoCondiciones', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByComoMejoraCondicionesEntorno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCondicionesEntorno', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByComoMejoraCondicionesEntornoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCondicionesEntorno', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByExplicacionAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByExplicacionAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension RecurrenteSaneamientoDbLocalQueryWhereDistinct on QueryBuilder<
    RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal, QDistinct> {
  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByComoAyudoCondiciones({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoAyudoCondiciones',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QDistinct>
      distinctByComoMejoraCondicionesEntorno({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoMejoraCondicionesEntorno',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QDistinct>
      distinctByExplicacionAlcanzaraMeta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionAlcanzaraMeta',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByExplicacionInversion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionInversion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByOtrosDatosCliente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosDatosCliente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByPersonasCargo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctBySiguientePaso({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguientePaso',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
      QDistinct> distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, RecurrenteSaneamientoDbLocal,
          QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }
}

extension RecurrenteSaneamientoDbLocalQueryProperty on QueryBuilder<
    RecurrenteSaneamientoDbLocal,
    RecurrenteSaneamientoDbLocal,
    QQueryProperty> {
  QueryBuilder<RecurrenteSaneamientoDbLocal, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, bool?, QQueryOperations>
      alcanzaraMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, bool?, QQueryOperations>
      coincideRespuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      comoAyudoCondicionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoAyudoCondiciones');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      comoMejoraCondicionesEntornoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoMejoraCondicionesEntorno');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      explicacionAlcanzaraMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionAlcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      explicacionInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionInversion');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, int?, QQueryOperations>
      objSolicitudRecurrenteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      otrosDatosClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosDatosCliente');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      siguientePasoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguientePaso');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<RecurrenteSaneamientoDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }
}
