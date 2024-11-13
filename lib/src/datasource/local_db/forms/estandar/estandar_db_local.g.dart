// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estandar_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEstandarDbLocalCollection on Isar {
  IsarCollection<EstandarDbLocal> get estandarDbLocals => this.collection();
}

const EstandarDbLocalSchema = CollectionSchema(
  name: r'EstandarDbLocal',
  id: -7602069176135598235,
  properties: {
    r'apoyanNegocio': PropertySchema(
      id: 0,
      name: r'apoyanNegocio',
      type: IsarType.bool,
    ),
    r'comoMejoraVida': PropertySchema(
      id: 1,
      name: r'comoMejoraVida',
      type: IsarType.string,
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
    r'inicioNegocio': PropertySchema(
      id: 5,
      name: r'inicioNegocio',
      type: IsarType.dateTime,
    ),
    r'motivoPrestamo': PropertySchema(
      id: 6,
      name: r'motivoPrestamo',
      type: IsarType.string,
    ),
    r'negocioProximosAnios': PropertySchema(
      id: 7,
      name: r'negocioProximosAnios',
      type: IsarType.string,
    ),
    r'numeroHijos': PropertySchema(
      id: 8,
      name: r'numeroHijos',
      type: IsarType.long,
    ),
    r'objOrigenCatalogoValorId': PropertySchema(
      id: 9,
      name: r'objOrigenCatalogoValorId',
      type: IsarType.string,
    ),
    r'objSolicitudNuevamenorId': PropertySchema(
      id: 10,
      name: r'objSolicitudNuevamenorId',
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
      type: IsarType.long,
    ),
    r'planesFuturo': PropertySchema(
      id: 15,
      name: r'planesFuturo',
      type: IsarType.string,
    ),
    r'publicitarNegocio': PropertySchema(
      id: 16,
      name: r'publicitarNegocio',
      type: IsarType.string,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 17,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    )
  },
  estimateSize: _estandarDbLocalEstimateSize,
  serialize: _estandarDbLocalSerialize,
  deserialize: _estandarDbLocalDeserialize,
  deserializeProp: _estandarDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _estandarDbLocalGetId,
  getLinks: _estandarDbLocalGetLinks,
  attach: _estandarDbLocalAttach,
  version: '3.1.0+1',
);

int _estandarDbLocalEstimateSize(
  EstandarDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comoMejoraVida;
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
    final value = object.motivoPrestamo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.negocioProximosAnios;
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
    final value = object.planesFuturo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.publicitarNegocio;
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

void _estandarDbLocalSerialize(
  EstandarDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.apoyanNegocio);
  writer.writeString(offsets[1], object.comoMejoraVida);
  writer.writeString(offsets[2], object.cuantosApoyan);
  writer.writeString(offsets[3], object.database);
  writer.writeString(offsets[4], object.edadHijos);
  writer.writeDateTime(offsets[5], object.inicioNegocio);
  writer.writeString(offsets[6], object.motivoPrestamo);
  writer.writeString(offsets[7], object.negocioProximosAnios);
  writer.writeLong(offsets[8], object.numeroHijos);
  writer.writeString(offsets[9], object.objOrigenCatalogoValorId);
  writer.writeLong(offsets[10], object.objSolicitudNuevamenorId);
  writer.writeString(offsets[11], object.otrosDatosCliente);
  writer.writeBool(offsets[12], object.otrosIngresos);
  writer.writeString(offsets[13], object.otrosIngresosDescripcion);
  writer.writeLong(offsets[14], object.personasCargo);
  writer.writeString(offsets[15], object.planesFuturo);
  writer.writeString(offsets[16], object.publicitarNegocio);
  writer.writeString(offsets[17], object.tipoEstudioHijos);
}

EstandarDbLocal _estandarDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EstandarDbLocal();
  object.apoyanNegocio = reader.readBoolOrNull(offsets[0]);
  object.comoMejoraVida = reader.readStringOrNull(offsets[1]);
  object.cuantosApoyan = reader.readStringOrNull(offsets[2]);
  object.database = reader.readStringOrNull(offsets[3]);
  object.edadHijos = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.inicioNegocio = reader.readDateTimeOrNull(offsets[5]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[6]);
  object.negocioProximosAnios = reader.readStringOrNull(offsets[7]);
  object.numeroHijos = reader.readLongOrNull(offsets[8]);
  object.objOrigenCatalogoValorId = reader.readStringOrNull(offsets[9]);
  object.objSolicitudNuevamenorId = reader.readLongOrNull(offsets[10]);
  object.otrosDatosCliente = reader.readStringOrNull(offsets[11]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[12]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[13]);
  object.personasCargo = reader.readLongOrNull(offsets[14]);
  object.planesFuturo = reader.readStringOrNull(offsets[15]);
  object.publicitarNegocio = reader.readStringOrNull(offsets[16]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[17]);
  return object;
}

P _estandarDbLocalDeserializeProp<P>(
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
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
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _estandarDbLocalGetId(EstandarDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _estandarDbLocalGetLinks(EstandarDbLocal object) {
  return [];
}

void _estandarDbLocalAttach(
    IsarCollection<dynamic> col, Id id, EstandarDbLocal object) {
  object.id = id;
}

extension EstandarDbLocalQueryWhereSort
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QWhere> {
  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EstandarDbLocalQueryWhere
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QWhereClause> {
  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterWhereClause>
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterWhereClause> idBetween(
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

extension EstandarDbLocalQueryFilter
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QFilterCondition> {
  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      apoyanNegocioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      apoyanNegocioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apoyanNegocio',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      apoyanNegocioEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apoyanNegocio',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoMejoraVida',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoMejoraVida',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoMejoraVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoMejoraVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoMejoraVida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoMejoraVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoMejoraVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoMejoraVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoMejoraVida',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraVida',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      comoMejoraVidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoMejoraVida',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cuantosApoyan',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cuantosApoyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cuantosApoyan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      cuantosApoyanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuantosApoyan',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'database',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'edadHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      inicioNegocioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inicioNegocio',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      inicioNegocioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inicioNegocio',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      inicioNegocioEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inicioNegocio',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      inicioNegocioGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inicioNegocio',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      inicioNegocioLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inicioNegocio',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      inicioNegocioBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inicioNegocio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoPrestamo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'negocioProximosAnios',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'negocioProximosAnios',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'negocioProximosAnios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'negocioProximosAnios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'negocioProximosAnios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'negocioProximosAnios',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'negocioProximosAnios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'negocioProximosAnios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'negocioProximosAnios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'negocioProximosAnios',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'negocioProximosAnios',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      negocioProximosAniosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'negocioProximosAnios',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      numeroHijosGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      numeroHijosLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      numeroHijosBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objSolicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objSolicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objSolicitudNuevamenorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'otrosDatosCliente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      personasCargoGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      personasCargoLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      personasCargoBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'planesFuturo',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'planesFuturo',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'planesFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'planesFuturo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planesFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      planesFuturoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'planesFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'publicitarNegocio',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'publicitarNegocio',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publicitarNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'publicitarNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'publicitarNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'publicitarNegocio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'publicitarNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'publicitarNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'publicitarNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'publicitarNegocio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publicitarNegocio',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      publicitarNegocioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'publicitarNegocio',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosEqualTo(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosGreaterThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosLessThan(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosBetween(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosStartsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosEndsWith(
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

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoEstudioHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }
}

extension EstandarDbLocalQueryObject
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QFilterCondition> {}

extension EstandarDbLocalQueryLinks
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QFilterCondition> {}

extension EstandarDbLocalQuerySortBy
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QSortBy> {
  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByComoMejoraVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraVida', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByComoMejoraVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraVida', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByInicioNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioNegocio', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByInicioNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioNegocio', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByNegocioProximosAnios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'negocioProximosAnios', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByNegocioProximosAniosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'negocioProximosAnios', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByPlanesFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByPlanesFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByPublicitarNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicitarNegocio', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByPublicitarNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicitarNegocio', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }
}

extension EstandarDbLocalQuerySortThenBy
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QSortThenBy> {
  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByApoyanNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apoyanNegocio', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByComoMejoraVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraVida', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByComoMejoraVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraVida', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByCuantosApoyan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByCuantosApoyanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuantosApoyan', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByInicioNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioNegocio', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByInicioNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioNegocio', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByNegocioProximosAnios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'negocioProximosAnios', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByNegocioProximosAniosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'negocioProximosAnios', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByPlanesFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByPlanesFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planesFuturo', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByPublicitarNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicitarNegocio', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByPublicitarNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicitarNegocio', Sort.desc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QAfterSortBy>
      thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }
}

extension EstandarDbLocalQueryWhereDistinct
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct> {
  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByApoyanNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apoyanNegocio');
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByComoMejoraVida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoMejoraVida',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByCuantosApoyan({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuantosApoyan',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct> distinctByDatabase(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct> distinctByEdadHijos(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByInicioNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inicioNegocio');
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByNegocioProximosAnios({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'negocioProximosAnios',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByObjOrigenCatalogoValorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objOrigenCatalogoValorId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByOtrosDatosCliente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosDatosCliente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByPlanesFuturo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planesFuturo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByPublicitarNegocio({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'publicitarNegocio',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstandarDbLocal, EstandarDbLocal, QDistinct>
      distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }
}

extension EstandarDbLocalQueryProperty
    on QueryBuilder<EstandarDbLocal, EstandarDbLocal, QQueryProperty> {
  QueryBuilder<EstandarDbLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EstandarDbLocal, bool?, QQueryOperations>
      apoyanNegocioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apoyanNegocio');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      comoMejoraVidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoMejoraVida');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      cuantosApoyanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuantosApoyan');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations> databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations> edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<EstandarDbLocal, DateTime?, QQueryOperations>
      inicioNegocioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inicioNegocio');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      negocioProximosAniosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'negocioProximosAnios');
    });
  }

  QueryBuilder<EstandarDbLocal, int?, QQueryOperations> numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      objOrigenCatalogoValorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objOrigenCatalogoValorId');
    });
  }

  QueryBuilder<EstandarDbLocal, int?, QQueryOperations>
      objSolicitudNuevamenorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      otrosDatosClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosDatosCliente');
    });
  }

  QueryBuilder<EstandarDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<EstandarDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      planesFuturoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planesFuturo');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      publicitarNegocioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'publicitarNegocio');
    });
  }

  QueryBuilder<EstandarDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }
}
