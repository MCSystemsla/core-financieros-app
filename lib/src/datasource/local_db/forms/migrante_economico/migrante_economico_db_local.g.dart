// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migrante_economico_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMigranteEconomicoDbLocalCollection on Isar {
  IsarCollection<MigranteEconomicoDbLocal> get migranteEconomicoDbLocals =>
      this.collection();
}

const MigranteEconomicoDbLocalSchema = CollectionSchema(
  name: r'MigranteEconomicoDbLocal',
  id: 1007188782371311052,
  properties: {
    r'ayudaMejorarCondiciones': PropertySchema(
      id: 0,
      name: r'ayudaMejorarCondiciones',
      type: IsarType.bool,
    ),
    r'ayudaMejorarCondicionesExplicacion': PropertySchema(
      id: 1,
      name: r'ayudaMejorarCondicionesExplicacion',
      type: IsarType.string,
    ),
    r'database': PropertySchema(
      id: 2,
      name: r'database',
      type: IsarType.string,
    ),
    r'dedicabaPaisOrigen': PropertySchema(
      id: 3,
      name: r'dedicabaPaisOrigen',
      type: IsarType.string,
    ),
    r'edadHijos': PropertySchema(
      id: 4,
      name: r'edadHijos',
      type: IsarType.string,
    ),
    r'enviaRemesas': PropertySchema(
      id: 5,
      name: r'enviaRemesas',
      type: IsarType.bool,
    ),
    r'enviaRemesasExplicacion': PropertySchema(
      id: 6,
      name: r'enviaRemesasExplicacion',
      type: IsarType.string,
    ),
    r'fortalecerIngresos': PropertySchema(
      id: 7,
      name: r'fortalecerIngresos',
      type: IsarType.bool,
    ),
    r'fortalecerIngresosExplicacion': PropertySchema(
      id: 8,
      name: r'fortalecerIngresosExplicacion',
      type: IsarType.string,
    ),
    r'metasFuturo': PropertySchema(
      id: 9,
      name: r'metasFuturo',
      type: IsarType.string,
    ),
    r'motivoDejarPais': PropertySchema(
      id: 10,
      name: r'motivoDejarPais',
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
    r'objOrigenUbicacionGeograficaId': PropertySchema(
      id: 13,
      name: r'objOrigenUbicacionGeograficaId',
      type: IsarType.string,
    ),
    r'objSolicitudNuevamenorId': PropertySchema(
      id: 14,
      name: r'objSolicitudNuevamenorId',
      type: IsarType.long,
    ),
    r'otrosDatosCliente': PropertySchema(
      id: 15,
      name: r'otrosDatosCliente',
      type: IsarType.string,
    ),
    r'otrosIngresos': PropertySchema(
      id: 16,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 17,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 18,
      name: r'personasCargo',
      type: IsarType.long,
    ),
    r'piensaRegresar': PropertySchema(
      id: 19,
      name: r'piensaRegresar',
      type: IsarType.string,
    ),
    r'propositosProximos': PropertySchema(
      id: 20,
      name: r'propositosProximos',
      type: IsarType.string,
    ),
    r'quienApoya': PropertySchema(
      id: 21,
      name: r'quienApoya',
      type: IsarType.string,
    ),
    r'situacionMigratoria': PropertySchema(
      id: 22,
      name: r'situacionMigratoria',
      type: IsarType.string,
    ),
    r'tiempoActividad': PropertySchema(
      id: 23,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 24,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 25,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    ),
    r'tipoSolicitud': PropertySchema(
      id: 26,
      name: r'tipoSolicitud',
      type: IsarType.string,
    ),
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 27,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    ),
    r'vivePaisActual': PropertySchema(
      id: 28,
      name: r'vivePaisActual',
      type: IsarType.string,
    )
  },
  estimateSize: _migranteEconomicoDbLocalEstimateSize,
  serialize: _migranteEconomicoDbLocalSerialize,
  deserialize: _migranteEconomicoDbLocalDeserialize,
  deserializeProp: _migranteEconomicoDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _migranteEconomicoDbLocalGetId,
  getLinks: _migranteEconomicoDbLocalGetLinks,
  attach: _migranteEconomicoDbLocalAttach,
  version: '3.1.0+1',
);

int _migranteEconomicoDbLocalEstimateSize(
  MigranteEconomicoDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ayudaMejorarCondicionesExplicacion;
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
    final value = object.dedicabaPaisOrigen;
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
    final value = object.enviaRemesasExplicacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fortalecerIngresosExplicacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.metasFuturo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motivoDejarPais;
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
    final value = object.objOrigenUbicacionGeograficaId;
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
    final value = object.piensaRegresar;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.propositosProximos;
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
    final value = object.situacionMigratoria;
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
    final value = object.vivePaisActual;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _migranteEconomicoDbLocalSerialize(
  MigranteEconomicoDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.ayudaMejorarCondiciones);
  writer.writeString(offsets[1], object.ayudaMejorarCondicionesExplicacion);
  writer.writeString(offsets[2], object.database);
  writer.writeString(offsets[3], object.dedicabaPaisOrigen);
  writer.writeString(offsets[4], object.edadHijos);
  writer.writeBool(offsets[5], object.enviaRemesas);
  writer.writeString(offsets[6], object.enviaRemesasExplicacion);
  writer.writeBool(offsets[7], object.fortalecerIngresos);
  writer.writeString(offsets[8], object.fortalecerIngresosExplicacion);
  writer.writeString(offsets[9], object.metasFuturo);
  writer.writeString(offsets[10], object.motivoDejarPais);
  writer.writeString(offsets[11], object.motivoPrestamo);
  writer.writeLong(offsets[12], object.numeroHijos);
  writer.writeString(offsets[13], object.objOrigenUbicacionGeograficaId);
  writer.writeLong(offsets[14], object.objSolicitudNuevamenorId);
  writer.writeString(offsets[15], object.otrosDatosCliente);
  writer.writeBool(offsets[16], object.otrosIngresos);
  writer.writeString(offsets[17], object.otrosIngresosDescripcion);
  writer.writeLong(offsets[18], object.personasCargo);
  writer.writeString(offsets[19], object.piensaRegresar);
  writer.writeString(offsets[20], object.propositosProximos);
  writer.writeString(offsets[21], object.quienApoya);
  writer.writeString(offsets[22], object.situacionMigratoria);
  writer.writeLong(offsets[23], object.tiempoActividad);
  writer.writeBool(offsets[24], object.tieneTrabajo);
  writer.writeString(offsets[25], object.tipoEstudioHijos);
  writer.writeString(offsets[26], object.tipoSolicitud);
  writer.writeString(offsets[27], object.trabajoNegocioDescripcion);
  writer.writeString(offsets[28], object.vivePaisActual);
}

MigranteEconomicoDbLocal _migranteEconomicoDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MigranteEconomicoDbLocal();
  object.ayudaMejorarCondiciones = reader.readBoolOrNull(offsets[0]);
  object.ayudaMejorarCondicionesExplicacion =
      reader.readStringOrNull(offsets[1]);
  object.database = reader.readStringOrNull(offsets[2]);
  object.dedicabaPaisOrigen = reader.readStringOrNull(offsets[3]);
  object.edadHijos = reader.readStringOrNull(offsets[4]);
  object.enviaRemesas = reader.readBoolOrNull(offsets[5]);
  object.enviaRemesasExplicacion = reader.readStringOrNull(offsets[6]);
  object.fortalecerIngresos = reader.readBoolOrNull(offsets[7]);
  object.fortalecerIngresosExplicacion = reader.readStringOrNull(offsets[8]);
  object.id = id;
  object.metasFuturo = reader.readStringOrNull(offsets[9]);
  object.motivoDejarPais = reader.readStringOrNull(offsets[10]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[11]);
  object.numeroHijos = reader.readLongOrNull(offsets[12]);
  object.objOrigenUbicacionGeograficaId = reader.readStringOrNull(offsets[13]);
  object.objSolicitudNuevamenorId = reader.readLongOrNull(offsets[14]);
  object.otrosDatosCliente = reader.readStringOrNull(offsets[15]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[16]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[17]);
  object.personasCargo = reader.readLongOrNull(offsets[18]);
  object.piensaRegresar = reader.readStringOrNull(offsets[19]);
  object.propositosProximos = reader.readStringOrNull(offsets[20]);
  object.quienApoya = reader.readStringOrNull(offsets[21]);
  object.situacionMigratoria = reader.readStringOrNull(offsets[22]);
  object.tiempoActividad = reader.readLongOrNull(offsets[23]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[24]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[25]);
  object.tipoSolicitud = reader.readStringOrNull(offsets[26]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[27]);
  object.vivePaisActual = reader.readStringOrNull(offsets[28]);
  return object;
}

P _migranteEconomicoDbLocalDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset)) as P;
    case 24:
      return (reader.readBoolOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _migranteEconomicoDbLocalGetId(MigranteEconomicoDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _migranteEconomicoDbLocalGetLinks(
    MigranteEconomicoDbLocal object) {
  return [];
}

void _migranteEconomicoDbLocalAttach(
    IsarCollection<dynamic> col, Id id, MigranteEconomicoDbLocal object) {
  object.id = id;
}

extension MigranteEconomicoDbLocalQueryWhereSort on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QWhere> {
  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MigranteEconomicoDbLocalQueryWhere on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QWhereClause> {
  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

extension MigranteEconomicoDbLocalQueryFilter on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QFilterCondition> {
  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ayudaMejorarCondiciones',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ayudaMejorarCondiciones',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayudaMejorarCondiciones',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ayudaMejorarCondicionesExplicacion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ayudaMejorarCondicionesExplicacion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayudaMejorarCondicionesExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ayudaMejorarCondicionesExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ayudaMejorarCondicionesExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ayudaMejorarCondicionesExplicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ayudaMejorarCondicionesExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ayudaMejorarCondicionesExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      ayudaMejorarCondicionesExplicacionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ayudaMejorarCondicionesExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      ayudaMejorarCondicionesExplicacionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ayudaMejorarCondicionesExplicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayudaMejorarCondicionesExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> ayudaMejorarCondicionesExplicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ayudaMejorarCondicionesExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dedicabaPaisOrigen',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dedicabaPaisOrigen',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dedicabaPaisOrigen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dedicabaPaisOrigen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dedicabaPaisOrigen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dedicabaPaisOrigen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dedicabaPaisOrigen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dedicabaPaisOrigen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      dedicabaPaisOrigenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dedicabaPaisOrigen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      dedicabaPaisOrigenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dedicabaPaisOrigen',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dedicabaPaisOrigen',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> dedicabaPaisOrigenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dedicabaPaisOrigen',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enviaRemesas',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enviaRemesas',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enviaRemesas',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enviaRemesasExplicacion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enviaRemesasExplicacion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enviaRemesasExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'enviaRemesasExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'enviaRemesasExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'enviaRemesasExplicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'enviaRemesasExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'enviaRemesasExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      enviaRemesasExplicacionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'enviaRemesasExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      enviaRemesasExplicacionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'enviaRemesasExplicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enviaRemesasExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> enviaRemesasExplicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'enviaRemesasExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fortalecerIngresos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fortalecerIngresos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fortalecerIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fortalecerIngresosExplicacion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fortalecerIngresosExplicacion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fortalecerIngresosExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fortalecerIngresosExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fortalecerIngresosExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fortalecerIngresosExplicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fortalecerIngresosExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fortalecerIngresosExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      fortalecerIngresosExplicacionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fortalecerIngresosExplicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      fortalecerIngresosExplicacionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fortalecerIngresosExplicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fortalecerIngresosExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> fortalecerIngresosExplicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fortalecerIngresosExplicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'metasFuturo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'metasFuturo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metasFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metasFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metasFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metasFuturo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metasFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metasFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      metasFuturoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metasFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      metasFuturoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metasFuturo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metasFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> metasFuturoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metasFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoDejarPais',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoDejarPais',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoDejarPais',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motivoDejarPais',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motivoDejarPais',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motivoDejarPais',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motivoDejarPais',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motivoDejarPais',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      motivoDejarPaisContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoDejarPais',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      motivoDejarPaisMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoDejarPais',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoDejarPais',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoDejarPaisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoDejarPais',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objOrigenUbicacionGeograficaId',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objOrigenUbicacionGeograficaId',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenUbicacionGeograficaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objOrigenUbicacionGeograficaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objOrigenUbicacionGeograficaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objOrigenUbicacionGeograficaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'objOrigenUbicacionGeograficaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'objOrigenUbicacionGeograficaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      objOrigenUbicacionGeograficaIdContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'objOrigenUbicacionGeograficaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      objOrigenUbicacionGeograficaIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'objOrigenUbicacionGeograficaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenUbicacionGeograficaId',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objOrigenUbicacionGeograficaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objOrigenUbicacionGeograficaId',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdGreaterThan(
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdLessThan(
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdBetween(
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'piensaRegresar',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'piensaRegresar',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'piensaRegresar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'piensaRegresar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'piensaRegresar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'piensaRegresar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'piensaRegresar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'piensaRegresar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      piensaRegresarContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'piensaRegresar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      piensaRegresarMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'piensaRegresar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'piensaRegresar',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> piensaRegresarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'piensaRegresar',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'propositosProximos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'propositosProximos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propositosProximos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propositosProximos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propositosProximos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propositosProximos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'propositosProximos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'propositosProximos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      propositosProximosContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'propositosProximos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      propositosProximosMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'propositosProximos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propositosProximos',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> propositosProximosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'propositosProximos',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'situacionMigratoria',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'situacionMigratoria',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'situacionMigratoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'situacionMigratoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'situacionMigratoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'situacionMigratoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'situacionMigratoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'situacionMigratoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      situacionMigratoriaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'situacionMigratoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      situacionMigratoriaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'situacionMigratoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'situacionMigratoria',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> situacionMigratoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'situacionMigratoria',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> tipoSolicitudIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
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

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vivePaisActual',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vivePaisActual',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vivePaisActual',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vivePaisActual',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vivePaisActual',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vivePaisActual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vivePaisActual',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vivePaisActual',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      vivePaisActualContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vivePaisActual',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
          QAfterFilterCondition>
      vivePaisActualMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vivePaisActual',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vivePaisActual',
        value: '',
      ));
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal,
      QAfterFilterCondition> vivePaisActualIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vivePaisActual',
        value: '',
      ));
    });
  }
}

extension MigranteEconomicoDbLocalQueryObject on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QFilterCondition> {}

extension MigranteEconomicoDbLocalQueryLinks on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QFilterCondition> {}

extension MigranteEconomicoDbLocalQuerySortBy on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QSortBy> {
  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByAyudaMejorarCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondiciones', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByAyudaMejorarCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondiciones', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByAyudaMejorarCondicionesExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondicionesExplicacion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByAyudaMejorarCondicionesExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondicionesExplicacion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByDedicabaPaisOrigen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedicabaPaisOrigen', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByDedicabaPaisOrigenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedicabaPaisOrigen', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByEnviaRemesas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesas', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByEnviaRemesasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesas', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByEnviaRemesasExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesasExplicacion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByEnviaRemesasExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesasExplicacion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByFortalecerIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByFortalecerIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByFortalecerIngresosExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresosExplicacion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByFortalecerIngresosExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresosExplicacion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByMetasFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasFuturo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByMetasFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasFuturo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByMotivoDejarPais() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoDejarPais', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByMotivoDejarPaisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoDejarPais', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByObjOrigenUbicacionGeograficaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenUbicacionGeograficaId', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByObjOrigenUbicacionGeograficaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenUbicacionGeograficaId', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByPiensaRegresar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'piensaRegresar', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByPiensaRegresarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'piensaRegresar', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByPropositosProximos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propositosProximos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByPropositosProximosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propositosProximos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortBySituacionMigratoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionMigratoria', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortBySituacionMigratoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionMigratoria', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByVivePaisActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vivePaisActual', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      sortByVivePaisActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vivePaisActual', Sort.desc);
    });
  }
}

extension MigranteEconomicoDbLocalQuerySortThenBy on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QSortThenBy> {
  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByAyudaMejorarCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondiciones', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByAyudaMejorarCondicionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondiciones', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByAyudaMejorarCondicionesExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondicionesExplicacion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByAyudaMejorarCondicionesExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayudaMejorarCondicionesExplicacion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByDedicabaPaisOrigen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedicabaPaisOrigen', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByDedicabaPaisOrigenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dedicabaPaisOrigen', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByEnviaRemesas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesas', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByEnviaRemesasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesas', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByEnviaRemesasExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesasExplicacion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByEnviaRemesasExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enviaRemesasExplicacion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByFortalecerIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByFortalecerIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByFortalecerIngresosExplicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresosExplicacion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByFortalecerIngresosExplicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fortalecerIngresosExplicacion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByMetasFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasFuturo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByMetasFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metasFuturo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByMotivoDejarPais() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoDejarPais', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByMotivoDejarPaisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoDejarPais', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByObjOrigenUbicacionGeograficaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenUbicacionGeograficaId', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByObjOrigenUbicacionGeograficaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenUbicacionGeograficaId', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByPiensaRegresar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'piensaRegresar', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByPiensaRegresarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'piensaRegresar', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByPropositosProximos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propositosProximos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByPropositosProximosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propositosProximos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenBySituacionMigratoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionMigratoria', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenBySituacionMigratoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'situacionMigratoria', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByVivePaisActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vivePaisActual', Sort.asc);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QAfterSortBy>
      thenByVivePaisActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vivePaisActual', Sort.desc);
    });
  }
}

extension MigranteEconomicoDbLocalQueryWhereDistinct on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct> {
  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByAyudaMejorarCondiciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ayudaMejorarCondiciones');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByAyudaMejorarCondicionesExplicacion(
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ayudaMejorarCondicionesExplicacion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByDedicabaPaisOrigen({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dedicabaPaisOrigen',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByEnviaRemesas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enviaRemesas');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByEnviaRemesasExplicacion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enviaRemesasExplicacion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByFortalecerIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fortalecerIngresos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByFortalecerIngresosExplicacion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fortalecerIngresosExplicacion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByMetasFuturo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metasFuturo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByMotivoDejarPais({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoDejarPais',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByObjOrigenUbicacionGeograficaId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objOrigenUbicacionGeograficaId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByOtrosDatosCliente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosDatosCliente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByPiensaRegresar({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'piensaRegresar',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByPropositosProximos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propositosProximos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctBySituacionMigratoria({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'situacionMigratoria',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByTipoSolicitud({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoSolicitud',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QDistinct>
      distinctByVivePaisActual({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vivePaisActual',
          caseSensitive: caseSensitive);
    });
  }
}

extension MigranteEconomicoDbLocalQueryProperty on QueryBuilder<
    MigranteEconomicoDbLocal, MigranteEconomicoDbLocal, QQueryProperty> {
  QueryBuilder<MigranteEconomicoDbLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, bool?, QQueryOperations>
      ayudaMejorarCondicionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ayudaMejorarCondiciones');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      ayudaMejorarCondicionesExplicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ayudaMejorarCondicionesExplicacion');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      dedicabaPaisOrigenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dedicabaPaisOrigen');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, bool?, QQueryOperations>
      enviaRemesasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enviaRemesas');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      enviaRemesasExplicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enviaRemesasExplicacion');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, bool?, QQueryOperations>
      fortalecerIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fortalecerIngresos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      fortalecerIngresosExplicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fortalecerIngresosExplicacion');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      metasFuturoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metasFuturo');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      motivoDejarPaisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoDejarPais');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      objOrigenUbicacionGeograficaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objOrigenUbicacionGeograficaId');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, int?, QQueryOperations>
      objSolicitudNuevamenorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      otrosDatosClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosDatosCliente');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      piensaRegresarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'piensaRegresar');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      propositosProximosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propositosProximos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      situacionMigratoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'situacionMigratoria');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      tipoSolicitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoSolicitud');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }

  QueryBuilder<MigranteEconomicoDbLocal, String?, QQueryOperations>
      vivePaisActualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vivePaisActual');
    });
  }
}
