// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mejora_vivienda_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMejoraViviendaDbLocalCollection on Isar {
  IsarCollection<MejoraViviendaDbLocal> get mejoraViviendaDbLocals =>
      this.collection();
}

const MejoraViviendaDbLocalSchema = CollectionSchema(
  name: r'MejoraViviendaDbLocal',
  id: 818578394520398465,
  properties: {
    r'comoAyudara': PropertySchema(
      id: 0,
      name: r'comoAyudara',
      type: IsarType.string,
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
    r'motivoPrestamo': PropertySchema(
      id: 3,
      name: r'motivoPrestamo',
      type: IsarType.string,
    ),
    r'necesidadesComunidad': PropertySchema(
      id: 4,
      name: r'necesidadesComunidad',
      type: IsarType.string,
    ),
    r'numeroHijos': PropertySchema(
      id: 5,
      name: r'numeroHijos',
      type: IsarType.long,
    ),
    r'objOrigenCatalogoValorId': PropertySchema(
      id: 6,
      name: r'objOrigenCatalogoValorId',
      type: IsarType.string,
    ),
    r'objTipoComunidadId': PropertySchema(
      id: 7,
      name: r'objTipoComunidadId',
      type: IsarType.string,
    ),
    r'otrosDatosCliente': PropertySchema(
      id: 8,
      name: r'otrosDatosCliente',
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
    r'planesFuturo': PropertySchema(
      id: 12,
      name: r'planesFuturo',
      type: IsarType.string,
    ),
    r'solicitudNuevamenorId': PropertySchema(
      id: 13,
      name: r'solicitudNuevamenorId',
      type: IsarType.long,
    ),
    r'tiempoActividad': PropertySchema(
      id: 14,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 15,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 16,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    ),
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 17,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    ),
    r'username': PropertySchema(
      id: 18,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _mejoraViviendaDbLocalEstimateSize,
  serialize: _mejoraViviendaDbLocalSerialize,
  deserialize: _mejoraViviendaDbLocalDeserialize,
  deserializeProp: _mejoraViviendaDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _mejoraViviendaDbLocalGetId,
  getLinks: _mejoraViviendaDbLocalGetLinks,
  attach: _mejoraViviendaDbLocalAttach,
  version: '3.1.0+1',
);

int _mejoraViviendaDbLocalEstimateSize(
  MejoraViviendaDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comoAyudara;
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
    final value = object.objOrigenCatalogoValorId;
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
    final value = object.planesFuturo;
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
  return bytesCount;
}

void _mejoraViviendaDbLocalSerialize(
  MejoraViviendaDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.comoAyudara);
  writer.writeString(offsets[1], object.database);
  writer.writeString(offsets[2], object.edadHijos);
  writer.writeString(offsets[3], object.motivoPrestamo);
  writer.writeString(offsets[4], object.necesidadesComunidad);
  writer.writeLong(offsets[5], object.numeroHijos);
  writer.writeString(offsets[6], object.objOrigenCatalogoValorId);
  writer.writeString(offsets[7], object.objTipoComunidadId);
  writer.writeString(offsets[8], object.otrosDatosCliente);
  writer.writeBool(offsets[9], object.otrosIngresos);
  writer.writeString(offsets[10], object.otrosIngresosDescripcion);
  writer.writeString(offsets[11], object.personasCargo);
  writer.writeString(offsets[12], object.planesFuturo);
  writer.writeLong(offsets[13], object.solicitudNuevamenorId);
  writer.writeLong(offsets[14], object.tiempoActividad);
  writer.writeBool(offsets[15], object.tieneTrabajo);
  writer.writeString(offsets[16], object.tipoEstudioHijos);
  writer.writeString(offsets[17], object.trabajoNegocioDescripcion);
  writer.writeString(offsets[18], object.username);
}

MejoraViviendaDbLocal _mejoraViviendaDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MejoraViviendaDbLocal();
  object.comoAyudara = reader.readStringOrNull(offsets[0]);
  object.database = reader.readStringOrNull(offsets[1]);
  object.edadHijos = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.motivoPrestamo = reader.readStringOrNull(offsets[3]);
  object.necesidadesComunidad = reader.readStringOrNull(offsets[4]);
  object.numeroHijos = reader.readLongOrNull(offsets[5]);
  object.objOrigenCatalogoValorId = reader.readStringOrNull(offsets[6]);
  object.objTipoComunidadId = reader.readStringOrNull(offsets[7]);
  object.otrosDatosCliente = reader.readStringOrNull(offsets[8]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[9]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[10]);
  object.personasCargo = reader.readStringOrNull(offsets[11]);
  object.planesFuturo = reader.readStringOrNull(offsets[12]);
  object.solicitudNuevamenorId = reader.readLongOrNull(offsets[13]);
  object.tiempoActividad = reader.readLongOrNull(offsets[14]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[15]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[16]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[17]);
  object.username = reader.readStringOrNull(offsets[18]);
  return object;
}

P _mejoraViviendaDbLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
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
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readBoolOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mejoraViviendaDbLocalGetId(MejoraViviendaDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mejoraViviendaDbLocalGetLinks(
    MejoraViviendaDbLocal object) {
  return [];
}

void _mejoraViviendaDbLocalAttach(
    IsarCollection<dynamic> col, Id id, MejoraViviendaDbLocal object) {
  object.id = id;
}

extension MejoraViviendaDbLocalQueryWhereSort
    on QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QWhere> {
  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MejoraViviendaDbLocalQueryWhere on QueryBuilder<MejoraViviendaDbLocal,
    MejoraViviendaDbLocal, QWhereClause> {
  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterWhereClause>
      idBetween(
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

extension MejoraViviendaDbLocalQueryFilter on QueryBuilder<
    MejoraViviendaDbLocal, MejoraViviendaDbLocal, QFilterCondition> {
  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoAyudara',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoAyudara',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudara',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoAyudara',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoAyudara',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoAyudara',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoAyudara',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoAyudara',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
          QAfterFilterCondition>
      comoAyudaraContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoAyudara',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
          QAfterFilterCondition>
      comoAyudaraMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoAyudara',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudara',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> comoAyudaraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoAyudara',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'necesidadesComunidad',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'necesidadesComunidad',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'necesidadesComunidad',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> necesidadesComunidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'necesidadesComunidad',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenCatalogoValorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objOrigenCatalogoValorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objOrigenCatalogoValorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objOrigenCatalogoValorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'objOrigenCatalogoValorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'objOrigenCatalogoValorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
          QAfterFilterCondition>
      objOrigenCatalogoValorIdContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'objOrigenCatalogoValorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
          QAfterFilterCondition>
      objOrigenCatalogoValorIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'objOrigenCatalogoValorId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objTipoComunidadId',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objTipoComunidadId',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objTipoComunidadId',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> objTipoComunidadIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objTipoComunidadId',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> personasCargoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'planesFuturo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'planesFuturo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planesFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'planesFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'planesFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'planesFuturo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'planesFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'planesFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
          QAfterFilterCondition>
      planesFuturoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'planesFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
          QAfterFilterCondition>
      planesFuturoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'planesFuturo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planesFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> planesFuturoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'planesFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> solicitudNuevamenorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'solicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> solicitudNuevamenorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'solicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> solicitudNuevamenorIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'solicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> solicitudNuevamenorIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'solicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> solicitudNuevamenorIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'solicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> solicitudNuevamenorIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'solicitudNuevamenorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
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

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal,
      QAfterFilterCondition> usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension MejoraViviendaDbLocalQueryObject on QueryBuilder<
    MejoraViviendaDbLocal, MejoraViviendaDbLocal, QFilterCondition> {}

extension MejoraViviendaDbLocalQueryLinks on QueryBuilder<MejoraViviendaDbLocal,
    MejoraViviendaDbLocal, QFilterCondition> {}

extension MejoraViviendaDbLocalQuerySortBy
    on QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QSortBy> {
  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByComoAyudara() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudara', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByComoAyudaraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudara', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByNecesidadesComunidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByNecesidadesComunidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByObjTipoComunidadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByObjTipoComunidadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByPlanesFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByPlanesFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortBySolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortBySolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension MejoraViviendaDbLocalQuerySortThenBy
    on QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QSortThenBy> {
  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByComoAyudara() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudara', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByComoAyudaraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudara', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByNecesidadesComunidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByNecesidadesComunidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'necesidadesComunidad', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByObjTipoComunidadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByObjTipoComunidadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objTipoComunidadId', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByPlanesFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByPlanesFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenBySolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenBySolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QAfterSortBy>
      thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension MejoraViviendaDbLocalQueryWhereDistinct
    on QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct> {
  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByComoAyudara({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoAyudara', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByNecesidadesComunidad({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'necesidadesComunidad',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByObjOrigenCatalogoValorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objOrigenCatalogoValorId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByObjTipoComunidadId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objTipoComunidadId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByOtrosDatosCliente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosDatosCliente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByPersonasCargo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByPlanesFuturo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planesFuturo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctBySolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'solicitudNuevamenorId');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, MejoraViviendaDbLocal, QDistinct>
      distinctByUsername({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension MejoraViviendaDbLocalQueryProperty on QueryBuilder<
    MejoraViviendaDbLocal, MejoraViviendaDbLocal, QQueryProperty> {
  QueryBuilder<MejoraViviendaDbLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      comoAyudaraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoAyudara');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      necesidadesComunidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'necesidadesComunidad');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      objOrigenCatalogoValorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objOrigenCatalogoValorId');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      objTipoComunidadIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objTipoComunidadId');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      otrosDatosClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosDatosCliente');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      planesFuturoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planesFuturo');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, int?, QQueryOperations>
      solicitudNuevamenorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'solicitudNuevamenorId');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }

  QueryBuilder<MejoraViviendaDbLocal, String?, QQueryOperations>
      usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
