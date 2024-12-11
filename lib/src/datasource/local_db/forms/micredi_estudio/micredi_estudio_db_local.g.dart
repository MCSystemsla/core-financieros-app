// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'micredi_estudio_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMiCrediEstudioDbLocalCollection on Isar {
  IsarCollection<MiCrediEstudioDbLocal> get miCrediEstudioDbLocals =>
      this.collection();
}

const MiCrediEstudioDbLocalSchema = CollectionSchema(
  name: r'MiCrediEstudioDbLocal',
  id: -7104167488607187244,
  properties: {
    r'aspiraLaboralmente': PropertySchema(
      id: 0,
      name: r'aspiraLaboralmente',
      type: IsarType.string,
    ),
    r'carrera': PropertySchema(
      id: 1,
      name: r'carrera',
      type: IsarType.string,
    ),
    r'comoAyudaCrecer': PropertySchema(
      id: 2,
      name: r'comoAyudaCrecer',
      type: IsarType.string,
    ),
    r'cualEstudio': PropertySchema(
      id: 3,
      name: r'cualEstudio',
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
    r'explicacionRelizandoProfesionalmente': PropertySchema(
      id: 6,
      name: r'explicacionRelizandoProfesionalmente',
      type: IsarType.string,
    ),
    r'motivoCarrera': PropertySchema(
      id: 7,
      name: r'motivoCarrera',
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
    r'ocupacionPadres': PropertySchema(
      id: 12,
      name: r'ocupacionPadres',
      type: IsarType.string,
    ),
    r'optarOtroEstudio': PropertySchema(
      id: 13,
      name: r'optarOtroEstudio',
      type: IsarType.bool,
    ),
    r'otrosDatosCliente': PropertySchema(
      id: 14,
      name: r'otrosDatosCliente',
      type: IsarType.string,
    ),
    r'otrosIngresos': PropertySchema(
      id: 15,
      name: r'otrosIngresos',
      type: IsarType.bool,
    ),
    r'otrosIngresosDescripcion': PropertySchema(
      id: 16,
      name: r'otrosIngresosDescripcion',
      type: IsarType.string,
    ),
    r'personasCargo': PropertySchema(
      id: 17,
      name: r'personasCargo',
      type: IsarType.long,
    ),
    r'planFuturo': PropertySchema(
      id: 18,
      name: r'planFuturo',
      type: IsarType.string,
    ),
    r'quienApoya': PropertySchema(
      id: 19,
      name: r'quienApoya',
      type: IsarType.string,
    ),
    r'relizandoProfesionalmente': PropertySchema(
      id: 20,
      name: r'relizandoProfesionalmente',
      type: IsarType.bool,
    ),
    r'tiempoActividad': PropertySchema(
      id: 21,
      name: r'tiempoActividad',
      type: IsarType.long,
    ),
    r'tiempoCarrera': PropertySchema(
      id: 22,
      name: r'tiempoCarrera',
      type: IsarType.long,
    ),
    r'tieneTrabajo': PropertySchema(
      id: 23,
      name: r'tieneTrabajo',
      type: IsarType.bool,
    ),
    r'tipoEstudioHijos': PropertySchema(
      id: 24,
      name: r'tipoEstudioHijos',
      type: IsarType.string,
    ),
    r'trabajoNegocioDescripcion': PropertySchema(
      id: 25,
      name: r'trabajoNegocioDescripcion',
      type: IsarType.string,
    ),
    r'universidad': PropertySchema(
      id: 26,
      name: r'universidad',
      type: IsarType.string,
    )
  },
  estimateSize: _miCrediEstudioDbLocalEstimateSize,
  serialize: _miCrediEstudioDbLocalSerialize,
  deserialize: _miCrediEstudioDbLocalDeserialize,
  deserializeProp: _miCrediEstudioDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _miCrediEstudioDbLocalGetId,
  getLinks: _miCrediEstudioDbLocalGetLinks,
  attach: _miCrediEstudioDbLocalAttach,
  version: '3.1.0+1',
);

int _miCrediEstudioDbLocalEstimateSize(
  MiCrediEstudioDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aspiraLaboralmente;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
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
    final value = object.cualEstudio;
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
    final value = object.explicacionRelizandoProfesionalmente;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motivoCarrera;
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
    final value = object.ocupacionPadres;
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
    final value = object.planFuturo;
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
    final value = object.universidad;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _miCrediEstudioDbLocalSerialize(
  MiCrediEstudioDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aspiraLaboralmente);
  writer.writeString(offsets[1], object.carrera);
  writer.writeString(offsets[2], object.comoAyudaCrecer);
  writer.writeString(offsets[3], object.cualEstudio);
  writer.writeString(offsets[4], object.database);
  writer.writeString(offsets[5], object.edadHijos);
  writer.writeString(offsets[6], object.explicacionRelizandoProfesionalmente);
  writer.writeString(offsets[7], object.motivoCarrera);
  writer.writeString(offsets[8], object.motivoPrestamo);
  writer.writeLong(offsets[9], object.numeroHijos);
  writer.writeString(offsets[10], object.objOrigenCatalogoValorId);
  writer.writeLong(offsets[11], object.objSolicitudNuevamenorId);
  writer.writeString(offsets[12], object.ocupacionPadres);
  writer.writeBool(offsets[13], object.optarOtroEstudio);
  writer.writeString(offsets[14], object.otrosDatosCliente);
  writer.writeBool(offsets[15], object.otrosIngresos);
  writer.writeString(offsets[16], object.otrosIngresosDescripcion);
  writer.writeLong(offsets[17], object.personasCargo);
  writer.writeString(offsets[18], object.planFuturo);
  writer.writeString(offsets[19], object.quienApoya);
  writer.writeBool(offsets[20], object.relizandoProfesionalmente);
  writer.writeLong(offsets[21], object.tiempoActividad);
  writer.writeLong(offsets[22], object.tiempoCarrera);
  writer.writeBool(offsets[23], object.tieneTrabajo);
  writer.writeString(offsets[24], object.tipoEstudioHijos);
  writer.writeString(offsets[25], object.trabajoNegocioDescripcion);
  writer.writeString(offsets[26], object.universidad);
}

MiCrediEstudioDbLocal _miCrediEstudioDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MiCrediEstudioDbLocal();
  object.aspiraLaboralmente = reader.readStringOrNull(offsets[0]);
  object.carrera = reader.readStringOrNull(offsets[1]);
  object.comoAyudaCrecer = reader.readStringOrNull(offsets[2]);
  object.cualEstudio = reader.readStringOrNull(offsets[3]);
  object.database = reader.readStringOrNull(offsets[4]);
  object.edadHijos = reader.readStringOrNull(offsets[5]);
  object.explicacionRelizandoProfesionalmente =
      reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.motivoCarrera = reader.readStringOrNull(offsets[7]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[8]);
  object.numeroHijos = reader.readLongOrNull(offsets[9]);
  object.objOrigenCatalogoValorId = reader.readStringOrNull(offsets[10]);
  object.objSolicitudNuevamenorId = reader.readLongOrNull(offsets[11]);
  object.ocupacionPadres = reader.readStringOrNull(offsets[12]);
  object.optarOtroEstudio = reader.readBoolOrNull(offsets[13]);
  object.otrosDatosCliente = reader.readStringOrNull(offsets[14]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[15]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[16]);
  object.personasCargo = reader.readLongOrNull(offsets[17]);
  object.planFuturo = reader.readStringOrNull(offsets[18]);
  object.quienApoya = reader.readStringOrNull(offsets[19]);
  object.relizandoProfesionalmente = reader.readBoolOrNull(offsets[20]);
  object.tiempoActividad = reader.readLongOrNull(offsets[21]);
  object.tiempoCarrera = reader.readLongOrNull(offsets[22]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[23]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[24]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[25]);
  object.universidad = reader.readStringOrNull(offsets[26]);
  return object;
}

P _miCrediEstudioDbLocalDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readBoolOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readBoolOrNull(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _miCrediEstudioDbLocalGetId(MiCrediEstudioDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _miCrediEstudioDbLocalGetLinks(
    MiCrediEstudioDbLocal object) {
  return [];
}

void _miCrediEstudioDbLocalAttach(
    IsarCollection<dynamic> col, Id id, MiCrediEstudioDbLocal object) {
  object.id = id;
}

extension MiCrediEstudioDbLocalQueryWhereSort
    on QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QWhere> {
  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MiCrediEstudioDbLocalQueryWhere on QueryBuilder<MiCrediEstudioDbLocal,
    MiCrediEstudioDbLocal, QWhereClause> {
  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterWhereClause>
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterWhereClause>
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

extension MiCrediEstudioDbLocalQueryFilter on QueryBuilder<
    MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QFilterCondition> {
  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aspiraLaboralmente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aspiraLaboralmente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aspiraLaboralmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aspiraLaboralmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aspiraLaboralmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aspiraLaboralmente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aspiraLaboralmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aspiraLaboralmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      aspiraLaboralmenteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aspiraLaboralmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      aspiraLaboralmenteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aspiraLaboralmente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aspiraLaboralmente',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> aspiraLaboralmenteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aspiraLaboralmente',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carrera',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carrera',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carrera',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> carreraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'carrera',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoAyudaCrecer',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoAyudaCrecer',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoAyudaCrecer',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> comoAyudaCrecerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoAyudaCrecer',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cualEstudio',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cualEstudio',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cualEstudio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cualEstudio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cualEstudio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cualEstudio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cualEstudio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cualEstudio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      cualEstudioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cualEstudio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      cualEstudioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cualEstudio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cualEstudio',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> cualEstudioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cualEstudio',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explicacionRelizandoProfesionalmente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explicacionRelizandoProfesionalmente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionRelizandoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explicacionRelizandoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explicacionRelizandoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explicacionRelizandoProfesionalmente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explicacionRelizandoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explicacionRelizandoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      explicacionRelizandoProfesionalmenteContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explicacionRelizandoProfesionalmente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      explicacionRelizandoProfesionalmenteMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explicacionRelizandoProfesionalmente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicacionRelizandoProfesionalmente',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> explicacionRelizandoProfesionalmenteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explicacionRelizandoProfesionalmente',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoCarrera',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoCarrera',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoCarrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motivoCarrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motivoCarrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motivoCarrera',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motivoCarrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motivoCarrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      motivoCarreraContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoCarrera',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      motivoCarreraMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoCarrera',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoCarrera',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoCarreraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoCarrera',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ocupacionPadres',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ocupacionPadres',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ocupacionPadres',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ocupacionPadres',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ocupacionPadres',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ocupacionPadres',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ocupacionPadres',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ocupacionPadres',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      ocupacionPadresContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ocupacionPadres',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      ocupacionPadresMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ocupacionPadres',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ocupacionPadres',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> ocupacionPadresIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ocupacionPadres',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> optarOtroEstudioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'optarOtroEstudio',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> optarOtroEstudioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'optarOtroEstudio',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> optarOtroEstudioEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optarOtroEstudio',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'planFuturo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'planFuturo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'planFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'planFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'planFuturo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'planFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'planFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      planFuturoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'planFuturo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
          QAfterFilterCondition>
      planFuturoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'planFuturo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> planFuturoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'planFuturo',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> relizandoProfesionalmenteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relizandoProfesionalmente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> relizandoProfesionalmenteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relizandoProfesionalmente',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> relizandoProfesionalmenteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relizandoProfesionalmente',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoActividadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoActividadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoActividad',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoActividadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoActividad',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoCarrera',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoCarrera',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tiempoCarreraEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoCarrera',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'universidad',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'universidad',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
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

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'universidad',
        value: '',
      ));
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal,
      QAfterFilterCondition> universidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'universidad',
        value: '',
      ));
    });
  }
}

extension MiCrediEstudioDbLocalQueryObject on QueryBuilder<
    MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QFilterCondition> {}

extension MiCrediEstudioDbLocalQueryLinks on QueryBuilder<MiCrediEstudioDbLocal,
    MiCrediEstudioDbLocal, QFilterCondition> {}

extension MiCrediEstudioDbLocalQuerySortBy
    on QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QSortBy> {
  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByAspiraLaboralmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspiraLaboralmente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByAspiraLaboralmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspiraLaboralmente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByComoAyudaCrecer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByComoAyudaCrecerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByCualEstudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cualEstudio', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByCualEstudioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cualEstudio', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByExplicacionRelizandoProfesionalmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionRelizandoProfesionalmente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByExplicacionRelizandoProfesionalmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'explicacionRelizandoProfesionalmente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByMotivoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoCarrera', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByMotivoCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoCarrera', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOcupacionPadres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ocupacionPadres', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOcupacionPadresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ocupacionPadres', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOptarOtroEstudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optarOtroEstudio', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOptarOtroEstudioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optarOtroEstudio', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByPlanFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planFuturo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByPlanFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planFuturo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByRelizandoProfesionalmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relizandoProfesionalmente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByRelizandoProfesionalmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relizandoProfesionalmente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTiempoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTiempoCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByUniversidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      sortByUniversidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.desc);
    });
  }
}

extension MiCrediEstudioDbLocalQuerySortThenBy
    on QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QSortThenBy> {
  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByAspiraLaboralmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspiraLaboralmente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByAspiraLaboralmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspiraLaboralmente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carrera', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByComoAyudaCrecer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByComoAyudaCrecerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoAyudaCrecer', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByCualEstudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cualEstudio', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByCualEstudioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cualEstudio', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByExplicacionRelizandoProfesionalmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicacionRelizandoProfesionalmente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByExplicacionRelizandoProfesionalmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'explicacionRelizandoProfesionalmente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByMotivoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoCarrera', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByMotivoCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoCarrera', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOcupacionPadres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ocupacionPadres', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOcupacionPadresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ocupacionPadres', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOptarOtroEstudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optarOtroEstudio', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOptarOtroEstudioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optarOtroEstudio', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByPlanFuturo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planFuturo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByPlanFuturoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planFuturo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByRelizandoProfesionalmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relizandoProfesionalmente', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByRelizandoProfesionalmenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relizandoProfesionalmente', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTiempoActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoActividad', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTiempoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTiempoCarreraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoCarrera', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByUniversidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.asc);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QAfterSortBy>
      thenByUniversidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'universidad', Sort.desc);
    });
  }
}

extension MiCrediEstudioDbLocalQueryWhereDistinct
    on QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct> {
  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByAspiraLaboralmente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aspiraLaboralmente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByCarrera({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carrera', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByComoAyudaCrecer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoAyudaCrecer',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByCualEstudio({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cualEstudio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByExplicacionRelizandoProfesionalmente(
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicacionRelizandoProfesionalmente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByMotivoCarrera({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoCarrera',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByObjOrigenCatalogoValorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objOrigenCatalogoValorId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByOcupacionPadres({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ocupacionPadres',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByOptarOtroEstudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'optarOtroEstudio');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByOtrosDatosCliente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosDatosCliente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByPlanFuturo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planFuturo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByRelizandoProfesionalmente() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relizandoProfesionalmente');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByTiempoActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoActividad');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByTiempoCarrera() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoCarrera');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QDistinct>
      distinctByUniversidad({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'universidad', caseSensitive: caseSensitive);
    });
  }
}

extension MiCrediEstudioDbLocalQueryProperty on QueryBuilder<
    MiCrediEstudioDbLocal, MiCrediEstudioDbLocal, QQueryProperty> {
  QueryBuilder<MiCrediEstudioDbLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      aspiraLaboralmenteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aspiraLaboralmente');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      carreraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carrera');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      comoAyudaCrecerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoAyudaCrecer');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      cualEstudioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cualEstudio');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      explicacionRelizandoProfesionalmenteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicacionRelizandoProfesionalmente');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      motivoCarreraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoCarrera');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      objOrigenCatalogoValorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objOrigenCatalogoValorId');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, int?, QQueryOperations>
      objSolicitudNuevamenorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      ocupacionPadresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ocupacionPadres');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, bool?, QQueryOperations>
      optarOtroEstudioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optarOtroEstudio');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      otrosDatosClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosDatosCliente');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      planFuturoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planFuturo');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, bool?, QQueryOperations>
      relizandoProfesionalmenteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relizandoProfesionalmente');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, int?, QQueryOperations>
      tiempoActividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoActividad');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, int?, QQueryOperations>
      tiempoCarreraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoCarrera');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }

  QueryBuilder<MiCrediEstudioDbLocal, String?, QQueryOperations>
      universidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'universidad');
    });
  }
}
