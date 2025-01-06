// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrente_micredi_estudio_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurrenteMiCrediEstudioDbLocalCollection on Isar {
  IsarCollection<RecurrenteMiCrediEstudioDbLocal>
      get recurrenteMiCrediEstudioDbLocals => this.collection();
}

const RecurrenteMiCrediEstudioDbLocalSchema = CollectionSchema(
  name: r'RecurrenteMiCrediEstudioDbLocal',
  id: 1412827047034033619,
  properties: {
    r'alcanzaraMeta': PropertySchema(
      id: 0,
      name: r'alcanzaraMeta',
      type: IsarType.bool,
    ),
    r'carrera': PropertySchema(
      id: 1,
      name: r'carrera',
      type: IsarType.string,
    ),
    r'coincideRespuesta': PropertySchema(
      id: 2,
      name: r'coincideRespuesta',
      type: IsarType.bool,
    ),
    r'comoAyudaCrecer': PropertySchema(
      id: 3,
      name: r'comoAyudaCrecer',
      type: IsarType.string,
    ),
    r'comoAyudoProfesionalmente': PropertySchema(
      id: 4,
      name: r'comoAyudoProfesionalmente',
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
    r'motivoPrestamo': PropertySchema(
      id: 9,
      name: r'motivoPrestamo',
      type: IsarType.string,
    ),
    r'numeroHijos': PropertySchema(
      id: 10,
      name: r'numeroHijos',
      type: IsarType.long,
    ),
    r'objSolicitudRecurrenteId': PropertySchema(
      id: 11,
      name: r'objSolicitudRecurrenteId',
      type: IsarType.long,
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
      type: IsarType.long,
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
    r'tiempoCarrera': PropertySchema(
      id: 18,
      name: r'tiempoCarrera',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 19,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 20,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    ),
    r'tipoSolicitud': PropertySchema(
      id: 21,
      name: r'tipoSolicitud',
      type: IsarType.string,
    ),
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 22,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    ),
    r'universidad': PropertySchema(
      id: 23,
      name: r'universidad',
      type: IsarType.string,
    )
  },
  estimateSize: _recurrenteMiCrediEstudioDbLocalEstimateSize,
  serialize: _recurrenteMiCrediEstudioDbLocalSerialize,
  deserialize: _recurrenteMiCrediEstudioDbLocalDeserialize,
  deserializeProp: _recurrenteMiCrediEstudioDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurrenteMiCrediEstudioDbLocalGetId,
  getLinks: _recurrenteMiCrediEstudioDbLocalGetLinks,
  attach: _recurrenteMiCrediEstudioDbLocalAttach,
  version: '3.1.0+1',
);

int _recurrenteMiCrediEstudioDbLocalEstimateSize(
  RecurrenteMiCrediEstudioDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.carrera;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.comoAyudaCrecer;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.comoAyudoProfesionalmente;
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
  {
    final value = object.universidad;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recurrenteMiCrediEstudioDbLocalSerialize(
  RecurrenteMiCrediEstudioDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.alcanzaraMeta);
  writer.writeString(offsets[1], object.carrera);
  writer.writeBool(offsets[2], object.coincideRespuesta);
  writer.writeString(offsets[3], object.comoAyudaCrecer);
  writer.writeString(offsets[4], object.comoAyudoProfesionalmente);
  writer.writeString(offsets[5], object.database);
  writer.writeString(offsets[6], object.edadHijos);
  writer.writeString(offsets[7], object.explicacionAlcanzaraMeta);
  writer.writeString(offsets[8], object.explicacionInversion);
  writer.writeString(offsets[9], object.motivoPrestamo);
  writer.writeLong(offsets[10], object.numeroHijos);
  writer.writeLong(offsets[11], object.objSolicitudRecurrenteId);
  writer.writeBool(offsets[12], object.otrosIngresos);
  writer.writeString(offsets[13], object.otrosIngresosDescripcion);
  writer.writeLong(offsets[14], object.personasCargo);
  writer.writeString(offsets[15], object.quienApoya);
  writer.writeString(offsets[16], object.siguientePaso);
  writer.writeLong(offsets[17], object.tiempoActividad);
  writer.writeLong(offsets[18], object.tiempoCarrera);
  writer.writeBool(offsets[19], object.tieneTrabajo);
  writer.writeString(offsets[20], object.tipoEstudioHijos);
  writer.writeString(offsets[21], object.tipoSolicitud);
  writer.writeString(offsets[22], object.trabajoNegocioDescripcion);
  writer.writeString(offsets[23], object.universidad);
}

RecurrenteMiCrediEstudioDbLocal _recurrenteMiCrediEstudioDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurrenteMiCrediEstudioDbLocal();
  object.alcanzaraMeta = reader.readBoolOrNull(offsets[0]);
  object.carrera = reader.readStringOrNull(offsets[1]);
  object.coincideRespuesta = reader.readBoolOrNull(offsets[2]);
  object.comoAyudaCrecer = reader.readStringOrNull(offsets[3]);
  object.comoAyudoProfesionalmente = reader.readStringOrNull(offsets[4]);
  object.database = reader.readStringOrNull(offsets[5]);
  object.edadHijos = reader.readStringOrNull(offsets[6]);
  object.explicacionAlcanzaraMeta = reader.readStringOrNull(offsets[7]);
  object.explicacionInversion = reader.readStringOrNull(offsets[8]);
  object.id = id;
  object.motivoPrestamo = reader.readStringOrNull(offsets[9]);
  object.numeroHijos = reader.readLongOrNull(offsets[10]);
  object.objSolicitudRecurrenteId = reader.readLongOrNull(offsets[11]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[12]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[13]);
  object.personasCargo = reader.readLongOrNull(offsets[14]);
  object.quienApoya = reader.readStringOrNull(offsets[15]);
  object.siguientePaso = reader.readStringOrNull(offsets[16]);
  object.tiempoActividad = reader.readLongOrNull(offsets[17]);
  object.tiempoCarrera = reader.readLongOrNull(offsets[18]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[19]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[20]);
  object.tipoSolicitud = reader.readStringOrNull(offsets[21]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[22]);
  object.universidad = reader.readStringOrNull(offsets[23]);
  return object;
}

P _recurrenteMiCrediEstudioDbLocalDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readBoolOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recurrenteMiCrediEstudioDbLocalGetId(
    RecurrenteMiCrediEstudioDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurrenteMiCrediEstudioDbLocalGetLinks(
    RecurrenteMiCrediEstudioDbLocal object) {
  return [];
}

void _recurrenteMiCrediEstudioDbLocalAttach(IsarCollection<dynamic> col, Id id,
    RecurrenteMiCrediEstudioDbLocal object) {
  object.id = id;
}

extension RecurrenteMiCrediEstudioDbLocalQueryWhereSort on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal, QWhere> {
  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurrenteMiCrediEstudioDbLocalQueryWhere on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal,
    RecurrenteMiCrediEstudioDbLocal,
    QWhereClause> {
  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

extension RecurrenteMiCrediEstudioDbLocalQueryFilter on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal,
    RecurrenteMiCrediEstudioDbLocal,
    QFilterCondition> {
  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> alcanzaraMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> alcanzaraMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> alcanzaraMetaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alcanzaraMeta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carrera',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carrera',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carrera',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'carrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'carrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      carreraContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'carrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      carreraMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'carrera',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carrera',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'carrera',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> coincideRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coincideRespuesta',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> coincideRespuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coincideRespuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoAyudaCrecer',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoAyudaCrecer',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudaCrecer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoAyudaCrecer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoAyudaCrecer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoAyudaCrecer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoAyudaCrecer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoAyudaCrecer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      comoAyudaCrecerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoAyudaCrecer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      comoAyudaCrecerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoAyudaCrecer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudaCrecer',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoAyudaCrecer',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoAyudoProfesionalmente',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoAyudoProfesionalmente',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoAyudoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoAyudoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoAyudoProfesionalmente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoAyudoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoAyudoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      comoAyudoProfesionalmenteContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoAyudoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      comoAyudoProfesionalmenteMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoAyudoProfesionalmente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudoProfesionalmente',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudoProfesionalmenteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoAyudoProfesionalmente',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionAlcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionAlcanzaraMeta',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionAlcanzaraMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionAlcanzaraMetaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionAlcanzaraMeta',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionInversionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionInversion',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionInversionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionInversionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionInversion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudRecurrenteId',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> objSolicitudRecurrenteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudRecurrenteId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> siguientePasoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> siguientePasoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguientePaso',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> siguientePasoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> siguientePasoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguientePaso',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoCarrera',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoCarrera',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoCarrera',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tiempoCarrera',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tiempoCarrera',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tiempoCarrera',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      tipoSolicitudContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoSolicitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      tipoSolicitudMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoSolicitud',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoSolicitudIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
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

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'universidad',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'universidad',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'universidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'universidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'universidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'universidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'universidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'universidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      universidadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'universidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QAfterFilterCondition>
      universidadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'universidad',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'universidad',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'universidad',
        value: '',
      ));
    });
  }
}

extension RecurrenteMiCrediEstudioDbLocalQueryObject on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal,
    RecurrenteMiCrediEstudioDbLocal,
    QFilterCondition> {}

extension RecurrenteMiCrediEstudioDbLocalQueryLinks on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal,
    RecurrenteMiCrediEstudioDbLocal,
    QFilterCondition> {}

extension RecurrenteMiCrediEstudioDbLocalQuerySortBy on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal, QSortBy> {
  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByComoAyudaCrecer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByComoAyudaCrecerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByComoAyudoProfesionalmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoProfesionalmente', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByComoAyudoProfesionalmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoProfesionalmente', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByExplicacionAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByExplicacionAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTiempoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTiempoCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByUniversidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> sortByUniversidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.desc);
    });
  }
}

extension RecurrenteMiCrediEstudioDbLocalQuerySortThenBy on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal,
    RecurrenteMiCrediEstudioDbLocal,
    QSortThenBy> {
  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByCoincideRespuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coincideRespuesta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByComoAyudaCrecer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByComoAyudaCrecerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByComoAyudoProfesionalmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoProfesionalmente', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByComoAyudoProfesionalmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudoProfesionalmente', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByExplicacionAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByExplicacionAlcanzaraMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionAlcanzaraMeta', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByExplicacionInversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByExplicacionInversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionInversion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByObjSolicitudRecurrenteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudRecurrenteId', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenBySiguientePaso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenBySiguientePasoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguientePaso', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTiempoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTiempoCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByUniversidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.asc);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QAfterSortBy> thenByUniversidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.desc);
    });
  }
}

extension RecurrenteMiCrediEstudioDbLocalQueryWhereDistinct on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal,
    RecurrenteMiCrediEstudioDbLocal,
    QDistinct> {
  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByAlcanzaraMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByCarrera({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carrera', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByCoincideRespuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByComoAyudaCrecer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoAyudaCrecer',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QDistinct>
      distinctByComoAyudoProfesionalmente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoAyudoProfesionalmente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QDistinct>
      distinctByExplicacionAlcanzaraMeta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionAlcanzaraMeta',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByExplicacionInversion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionInversion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByObjSolicitudRecurrenteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctBySiguientePaso({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguientePaso',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByTiempoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoCarrera');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByTipoSolicitud({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoSolicitud',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
          QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, RecurrenteMiCrediEstudioDbLocal,
      QDistinct> distinctByUniversidad({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'universidad', caseSensitive: caseSensitive);
    });
  }
}

extension RecurrenteMiCrediEstudioDbLocalQueryProperty on QueryBuilder<
    RecurrenteMiCrediEstudioDbLocal,
    RecurrenteMiCrediEstudioDbLocal,
    QQueryProperty> {
  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, bool?, QQueryOperations>
      alcanzaraMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      carreraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carrera');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, bool?, QQueryOperations>
      coincideRespuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coincideRespuesta');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      comoAyudaCrecerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoAyudaCrecer');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      comoAyudoProfesionalmenteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoAyudoProfesionalmente');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      explicacionAlcanzaraMetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionAlcanzaraMeta');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      explicacionInversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionInversion');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, int?, QQueryOperations>
      objSolicitudRecurrenteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudRecurrenteId');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      siguientePasoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguientePaso');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, int?, QQueryOperations>
      tiempoCarreraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoCarrera');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      tipoSolicitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoSolicitud');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }

  QueryBuilder<RecurrenteMiCrediEstudioDbLocal, String?, QQueryOperations>
      universidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'universidad');
    });
  }
}
