// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saneamiento_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSaneamientoDbLocalCollection on Isar {
  IsarCollection<SaneamientoDbLocal> get saneamientoDbLocals =>
      this.collection();
}

const SaneamientoDbLocalSchema = CollectionSchema(
  name: r'SaneamientoDbLocal',
  id: -5207328479651886546,
  properties: {
    r'cumpliriaPropuesta': PropertySchema(
      id: 0,
      name: r'cumpliriaPropuesta',
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
    r'explicacionCumpliriaPropuesta': PropertySchema(
      id: 3,
      name: r'explicacionCumpliriaPropuesta',
      type: IsarType.string,
    ),
    r'importanciaMejorarCondiciones': PropertySchema(
      id: 4,
      name: r'importanciaMejorarCondiciones',
      type: IsarType.string,
    ),
    r'mejoraCalidadVida': PropertySchema(
      id: 5,
      name: r'mejoraCalidadVida',
      type: IsarType.string,
    ),
    r'metasProximas': PropertySchema(
      id: 6,
      name: r'metasProximas',
      type: IsarType.string,
    ),
    r'motivacionCredito': PropertySchema(
      id: 7,
      name: r'motivacionCredito',
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
    r'objOrigenCatalogoValorId': PropertySchema(
      id: 10,
      name: r'objOrigenCatalogoValorId',
      type: IsarType.string,
    ),
    r'objSolicitudNuevamenorId': PropertySchema(
      id: 11,
      name: r'objSolicitudNuevamenorId',
      type: IsarType.long,
    ),
    r'otrosDatosCliente': PropertySchema(
      id: 12,
      name: r'otrosDatosCliente',
      type: IsarType.string,
    ),
    r'otrosIngresos': PropertySchema(
      id: 13,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 14,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 15,
      name: r'personasCargo',
      type: IsarType.string,
    ),
    r'siguienteProyectoCalidadVida': PropertySchema(
      id: 16,
      name: r'siguienteProyectoCalidadVida',
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
  estimateSize: _saneamientoDbLocalEstimateSize,
  serialize: _saneamientoDbLocalSerialize,
  deserialize: _saneamientoDbLocalDeserialize,
  deserializeProp: _saneamientoDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _saneamientoDbLocalGetId,
  getLinks: _saneamientoDbLocalGetLinks,
  attach: _saneamientoDbLocalAttach,
  version: '3.1.0+1',
);

int _saneamientoDbLocalEstimateSize(
  SaneamientoDbLocal object,
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
    final value = object.explicacionCumpliriaPropuesta;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importanciaMejorarCondiciones;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mejoraCalidadVida;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.metasProximas;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motivacionCredito;
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
    final value = object.personasCargo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.siguienteProyectoCalidadVida;
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

void _saneamientoDbLocalSerialize(
  SaneamientoDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.cumpliriaPropuesta);
  writer.writeString(offsets[1], object.database);
  writer.writeString(offsets[2], object.edadHijos);
  writer.writeString(offsets[3], object.explicacionCumpliriaPropuesta);
  writer.writeString(offsets[4], object.importanciaMejorarCondiciones);
  writer.writeString(offsets[5], object.mejoraCalidadVida);
  writer.writeString(offsets[6], object.metasProximas);
  writer.writeString(offsets[7], object.motivacionCredito);
  writer.writeString(offsets[8], object.motivoPrestamo);
  writer.writeLong(offsets[9], object.numeroHijos);
  writer.writeString(offsets[10], object.objOrigenCatalogoValorId);
  writer.writeLong(offsets[11], object.objSolicitudNuevamenorId);
  writer.writeString(offsets[12], object.otrosDatosCliente);
  writer.writeBool(offsets[13], object.otrosIngresos);
  writer.writeString(offsets[14], object.otrosIngresosDescripcion);
  writer.writeString(offsets[15], object.personasCargo);
  writer.writeString(offsets[16], object.siguienteProyectoCalidadVida);
  writer.writeLong(offsets[17], object.tiempoActividad);
  writer.writeBool(offsets[18], object.tieneTrabajo);
  writer.writeString(offsets[19], object.tipoEstudioHijos);
  writer.writeString(offsets[20], object.trabajoNegocioDescripcion);
}

SaneamientoDbLocal _saneamientoDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SaneamientoDbLocal();
  object.cumpliriaPropuesta = reader.readBoolOrNull(offsets[0]);
  object.database = reader.readStringOrNull(offsets[1]);
  object.edadHijos = reader.readStringOrNull(offsets[2]);
  object.explicacionCumpliriaPropuesta = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.importanciaMejorarCondiciones = reader.readStringOrNull(offsets[4]);
  object.mejoraCalidadVida = reader.readStringOrNull(offsets[5]);
  object.metasProximas = reader.readStringOrNull(offsets[6]);
  object.motivacionCredito = reader.readStringOrNull(offsets[7]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[8]);
  object.numeroHijos = reader.readLongOrNull(offsets[9]);
  object.objOrigenCatalogoValorId = reader.readStringOrNull(offsets[10]);
  object.objSolicitudNuevamenorId = reader.readLongOrNull(offsets[11]);
  object.otrosDatosCliente = reader.readStringOrNull(offsets[12]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[13]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[14]);
  object.personasCargo = reader.readStringOrNull(offsets[15]);
  object.siguienteProyectoCalidadVida = reader.readStringOrNull(offsets[16]);
  object.tiempoActividad = reader.readLongOrNull(offsets[17]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[18]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[19]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[20]);
  return object;
}

P _saneamientoDbLocalDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readBoolOrNull(offset)) as P;
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

Id _saneamientoDbLocalGetId(SaneamientoDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _saneamientoDbLocalGetLinks(
    SaneamientoDbLocal object) {
  return [];
}

void _saneamientoDbLocalAttach(
    IsarCollection<dynamic> col, Id id, SaneamientoDbLocal object) {
  object.id = id;
}

extension SaneamientoDbLocalQueryWhereSort
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QWhere> {
  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SaneamientoDbLocalQueryWhere
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QWhereClause> {
  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterWhereClause>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterWhereClause>
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

extension SaneamientoDbLocalQueryFilter
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QFilterCondition> {
  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      cumpliriaPropuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cumpliriaPropuesta',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      cumpliriaPropuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cumpliriaPropuesta',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      cumpliriaPropuestaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cumpliriaPropuesta',
        value: value,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      databaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      databaseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'database',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      edadHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'edadHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      edadHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'edadHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionCumpliriaPropuesta',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionCumpliriaPropuesta',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionCumpliriaPropuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explicacionCumpliriaPropuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explicacionCumpliriaPropuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explicacionCumpliriaPropuesta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explicacionCumpliriaPropuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explicacionCumpliriaPropuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explicacionCumpliriaPropuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explicacionCumpliriaPropuesta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionCumpliriaPropuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      explicacionCumpliriaPropuestaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionCumpliriaPropuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importanciaMejorarCondiciones',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importanciaMejorarCondiciones',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importanciaMejorarCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importanciaMejorarCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importanciaMejorarCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importanciaMejorarCondiciones',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importanciaMejorarCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importanciaMejorarCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importanciaMejorarCondiciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importanciaMejorarCondiciones',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importanciaMejorarCondiciones',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      importanciaMejorarCondicionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importanciaMejorarCondiciones',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mejoraCalidadVida',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mejoraCalidadVida',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mejoraCalidadVida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mejoraCalidadVida',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mejoraCalidadVida',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      mejoraCalidadVidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mejoraCalidadVida',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'metasProximas',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'metasProximas',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metasProximas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metasProximas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metasProximas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metasProximas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metasProximas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metasProximas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metasProximas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metasProximas',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metasProximas',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      metasProximasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metasProximas',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivacionCredito',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivacionCredito',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivacionCredito',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motivacionCredito',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motivacionCredito',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motivacionCredito',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motivacionCredito',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motivacionCredito',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivacionCredito',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivacionCredito',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivacionCredito',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivacionCreditoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivacionCredito',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivoPrestamoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoPrestamo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivoPrestamoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoPrestamo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      objOrigenCatalogoValorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      objSolicitudNuevamenorIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosDatosClienteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'otrosDatosCliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosDatosClienteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'otrosDatosCliente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosDatosClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoEqualTo(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoGreaterThan(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoLessThan(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoBetween(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoStartsWith(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoEndsWith(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'personasCargo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'personasCargo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      personasCargoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personasCargo',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'siguienteProyectoCalidadVida',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'siguienteProyectoCalidadVida',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteProyectoCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'siguienteProyectoCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'siguienteProyectoCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'siguienteProyectoCalidadVida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'siguienteProyectoCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'siguienteProyectoCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'siguienteProyectoCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'siguienteProyectoCalidadVida',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siguienteProyectoCalidadVida',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      siguienteProyectoCalidadVidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siguienteProyectoCalidadVida',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tiempoActividadGreaterThan(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tiempoActividadLessThan(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tiempoActividadBetween(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoEstudioHijos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoEstudioHijos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionEqualTo(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionGreaterThan(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionLessThan(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionBetween(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionStartsWith(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionEndsWith(
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
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

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterFilterCondition>
      trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }
}

extension SaneamientoDbLocalQueryObject
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QFilterCondition> {}

extension SaneamientoDbLocalQueryLinks
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QFilterCondition> {}

extension SaneamientoDbLocalQuerySortBy
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QSortBy> {
  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByCumpliriaPropuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cumpliriaPropuesta', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByCumpliriaPropuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cumpliriaPropuesta', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByExplicacionCumpliriaPropuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionCumpliriaPropuesta', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByExplicacionCumpliriaPropuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionCumpliriaPropuesta', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByImportanciaMejorarCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importanciaMejorarCondiciones', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByImportanciaMejorarCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importanciaMejorarCondiciones', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMejoraCalidadVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCalidadVida', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMejoraCalidadVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCalidadVida', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMetasProximas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasProximas', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMetasProximasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasProximas', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMotivacionCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivacionCredito', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMotivacionCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivacionCredito', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortBySiguienteProyectoCalidadVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteProyectoCalidadVida', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortBySiguienteProyectoCalidadVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteProyectoCalidadVida', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension SaneamientoDbLocalQuerySortThenBy
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QSortThenBy> {
  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByCumpliriaPropuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cumpliriaPropuesta', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByCumpliriaPropuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cumpliriaPropuesta', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByExplicacionCumpliriaPropuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionCumpliriaPropuesta', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByExplicacionCumpliriaPropuestaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionCumpliriaPropuesta', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByImportanciaMejorarCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importanciaMejorarCondiciones', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByImportanciaMejorarCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importanciaMejorarCondiciones', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMejoraCalidadVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCalidadVida', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMejoraCalidadVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mejoraCalidadVida', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMetasProximas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasProximas', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMetasProximasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasProximas', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMotivacionCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivacionCredito', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMotivacionCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivacionCredito', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenBySiguienteProyectoCalidadVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteProyectoCalidadVida', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenBySiguienteProyectoCalidadVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siguienteProyectoCalidadVida', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension SaneamientoDbLocalQueryWhereDistinct
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct> {
  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByCumpliriaPropuesta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cumpliriaPropuesta');
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByExplicacionCumpliriaPropuesta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionCumpliriaPropuesta',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByImportanciaMejorarCondiciones({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'importanciaMejorarCondiciones',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByMejoraCalidadVida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mejoraCalidadVida',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByMetasProximas({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metasProximas',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByMotivacionCredito({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivacionCredito',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByObjOrigenCatalogoValorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objOrigenCatalogoValorId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByOtrosDatosCliente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosDatosCliente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByPersonasCargo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctBySiguienteProyectoCalidadVida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siguienteProyectoCalidadVida',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }
}

extension SaneamientoDbLocalQueryProperty
    on QueryBuilder<SaneamientoDbLocal, SaneamientoDbLocal, QQueryProperty> {
  QueryBuilder<SaneamientoDbLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SaneamientoDbLocal, bool?, QQueryOperations>
      cumpliriaPropuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cumpliriaPropuesta');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      explicacionCumpliriaPropuestaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionCumpliriaPropuesta');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      importanciaMejorarCondicionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importanciaMejorarCondiciones');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      mejoraCalidadVidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mejoraCalidadVida');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      metasProximasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metasProximas');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      motivacionCreditoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivacionCredito');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<SaneamientoDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      objOrigenCatalogoValorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objOrigenCatalogoValorId');
    });
  }

  QueryBuilder<SaneamientoDbLocal, int?, QQueryOperations>
      objSolicitudNuevamenorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      otrosDatosClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosDatosCliente');
    });
  }

  QueryBuilder<SaneamientoDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      siguienteProyectoCalidadVidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siguienteProyectoCalidadVida');
    });
  }

  QueryBuilder<SaneamientoDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<SaneamientoDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<SaneamientoDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }
}
