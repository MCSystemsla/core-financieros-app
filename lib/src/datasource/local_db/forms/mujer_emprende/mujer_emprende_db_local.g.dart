// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mujer_emprende_db_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMujerEmprendeDbLocalCollection on Isar {
  IsarCollection<MujerEmprendeDbLocal> get mujerEmprendeDbLocals =>
      this.collection();
}

const MujerEmprendeDbLocalSchema = CollectionSchema(
  name: r'MujerEmprendeDbLocal',
  id: 6236235407898117669,
  properties: {
    r'comoImpactariaNegocio': PropertySchema(
      id: 0,
      name: r'comoImpactariaNegocio',
      type: IsarType.string,
    ),
    r'comoMejoraCalidadVida': PropertySchema(
      id: 1,
      name: r'comoMejoraCalidadVida',
      type: IsarType.string,
    ),
    r'conocioMujerEmprende': PropertySchema(
      id: 2,
      name: r'conocioMujerEmprende',
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
    r'impulsoOptar': PropertySchema(
      id: 5,
      name: r'impulsoOptar',
      type: IsarType.string,
    ),
    r'motivoEmprender': PropertySchema(
      id: 6,
      name: r'motivoEmprender',
      type: IsarType.string,
    ),
    r'motivoPrestamo': PropertySchema(
      id: 7,
      name: r'motivoPrestamo',
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
    r'quienApoya': PropertySchema(
      id: 15,
      name: r'quienApoya',
      type: IsarType.string,
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
    )
  },
  estimateSize: _mujerEmprendeDbLocalEstimateSize,
  serialize: _mujerEmprendeDbLocalSerialize,
  deserialize: _mujerEmprendeDbLocalDeserialize,
  deserializeProp: _mujerEmprendeDbLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _mujerEmprendeDbLocalGetId,
  getLinks: _mujerEmprendeDbLocalGetLinks,
  attach: _mujerEmprendeDbLocalAttach,
  version: '3.1.0+1',
);

int _mujerEmprendeDbLocalEstimateSize(
  MujerEmprendeDbLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comoImpactariaNegocio;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.comoMejoraCalidadVida;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.conocioMujerEmprende;
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
    final value = object.impulsoOptar;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motivoEmprender;
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
  return bytesCount;
}

void _mujerEmprendeDbLocalSerialize(
  MujerEmprendeDbLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.comoImpactariaNegocio);
  writer.writeString(offsets[1], object.comoMejoraCalidadVida);
  writer.writeString(offsets[2], object.conocioMujerEmprende);
  writer.writeString(offsets[3], object.database);
  writer.writeString(offsets[4], object.edadHijos);
  writer.writeString(offsets[5], object.impulsoOptar);
  writer.writeString(offsets[6], object.motivoEmprender);
  writer.writeString(offsets[7], object.motivoPrestamo);
  writer.writeLong(offsets[8], object.numeroHijos);
  writer.writeString(offsets[9], object.objOrigenCatalogoValorId);
  writer.writeLong(offsets[10], object.objSolicitudNuevamenorId);
  writer.writeString(offsets[11], object.otrosDatosCliente);
  writer.writeBool(offsets[12], object.otrosIngresos);
  writer.writeString(offsets[13], object.otrosIngresosDescripcion);
  writer.writeLong(offsets[14], object.personasCargo);
  writer.writeString(offsets[15], object.quienApoya);
  writer.writeBool(offsets[16], object.tieneTrabajo);
  writer.writeString(offsets[17], object.tipoEstudioHijos);
  writer.writeString(offsets[18], object.trabajoNegocioDescripcion);
}

MujerEmprendeDbLocal _mujerEmprendeDbLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MujerEmprendeDbLocal();
  object.comoImpactariaNegocio = reader.readStringOrNull(offsets[0]);
  object.comoMejoraCalidadVida = reader.readStringOrNull(offsets[1]);
  object.conocioMujerEmprende = reader.readStringOrNull(offsets[2]);
  object.database = reader.readStringOrNull(offsets[3]);
  object.edadHijos = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.impulsoOptar = reader.readStringOrNull(offsets[5]);
  object.motivoEmprender = reader.readStringOrNull(offsets[6]);
  object.motivoPrestamo = reader.readStringOrNull(offsets[7]);
  object.numeroHijos = reader.readLongOrNull(offsets[8]);
  object.objOrigenCatalogoValorId = reader.readStringOrNull(offsets[9]);
  object.objSolicitudNuevamenorId = reader.readLongOrNull(offsets[10]);
  object.otrosDatosCliente = reader.readStringOrNull(offsets[11]);
  object.otrosIngresos = reader.readBoolOrNull(offsets[12]);
  object.otrosIngresosDescripcion = reader.readStringOrNull(offsets[13]);
  object.personasCargo = reader.readLongOrNull(offsets[14]);
  object.quienApoya = reader.readStringOrNull(offsets[15]);
  object.tieneTrabajo = reader.readBoolOrNull(offsets[16]);
  object.tipoEstudioHijos = reader.readStringOrNull(offsets[17]);
  object.trabajoNegocioDescripcion = reader.readStringOrNull(offsets[18]);
  return object;
}

P _mujerEmprendeDbLocalDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mujerEmprendeDbLocalGetId(MujerEmprendeDbLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mujerEmprendeDbLocalGetLinks(
    MujerEmprendeDbLocal object) {
  return [];
}

void _mujerEmprendeDbLocalAttach(
    IsarCollection<dynamic> col, Id id, MujerEmprendeDbLocal object) {
  object.id = id;
}

extension MujerEmprendeDbLocalQueryWhereSort
    on QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QWhere> {
  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MujerEmprendeDbLocalQueryWhere
    on QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QWhereClause> {
  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterWhereClause>
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterWhereClause>
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

extension MujerEmprendeDbLocalQueryFilter on QueryBuilder<MujerEmprendeDbLocal,
    MujerEmprendeDbLocal, QFilterCondition> {
  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoImpactariaNegocio',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoImpactariaNegocio',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoImpactariaNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoImpactariaNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoImpactariaNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoImpactariaNegocio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoImpactariaNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoImpactariaNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      comoImpactariaNegocioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoImpactariaNegocio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      comoImpactariaNegocioMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoImpactariaNegocio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoImpactariaNegocio',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoImpactariaNegocioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoImpactariaNegocio',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comoMejoraCalidadVida',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comoMejoraCalidadVida',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comoMejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comoMejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comoMejoraCalidadVida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comoMejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comoMejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      comoMejoraCalidadVidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comoMejoraCalidadVida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      comoMejoraCalidadVidaMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comoMejoraCalidadVida',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comoMejoraCalidadVida',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> comoMejoraCalidadVidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comoMejoraCalidadVida',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'conocioMujerEmprende',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'conocioMujerEmprende',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conocioMujerEmprende',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conocioMujerEmprende',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conocioMujerEmprende',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conocioMujerEmprende',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conocioMujerEmprende',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conocioMujerEmprende',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      conocioMujerEmprendeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conocioMujerEmprende',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      conocioMujerEmprendeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conocioMujerEmprende',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conocioMujerEmprende',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> conocioMujerEmprendeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conocioMujerEmprende',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'database',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'edadHijos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> edadHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edadHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'impulsoOptar',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'impulsoOptar',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'impulsoOptar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'impulsoOptar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'impulsoOptar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'impulsoOptar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'impulsoOptar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'impulsoOptar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      impulsoOptarContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'impulsoOptar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      impulsoOptarMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'impulsoOptar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'impulsoOptar',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> impulsoOptarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'impulsoOptar',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoEmprender',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoEmprender',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoEmprender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motivoEmprender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motivoEmprender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motivoEmprender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motivoEmprender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motivoEmprender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      motivoEmprenderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoEmprender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
          QAfterFilterCondition>
      motivoEmprenderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoEmprender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoEmprender',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoEmprenderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoEmprender',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoPrestamo',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> motivoPrestamoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoPrestamo',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> numeroHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> numeroHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroHijos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> numeroHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objOrigenCatalogoValorId',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> objOrigenCatalogoValorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objOrigenCatalogoValorId',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'objSolicitudNuevamenorId',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> objSolicitudNuevamenorIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objSolicitudNuevamenorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosDatosCliente',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosDatosClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosDatosCliente',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresos',
        value: value,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otrosIngresosDescripcion',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> otrosIngresosDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otrosIngresosDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> personasCargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> personasCargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personasCargo',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> personasCargoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personasCargo',
        value: value,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> quienApoyaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> quienApoyaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quienApoya',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> quienApoyaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> quienApoyaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quienApoya',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tieneTrabajo',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> tieneTrabajoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tieneTrabajo',
        value: value,
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoEstudioHijos',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> tipoEstudioHijosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoEstudioHijos',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trabajoNegocioDescripcion',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
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

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal,
      QAfterFilterCondition> trabajoNegocioDescripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trabajoNegocioDescripcion',
        value: '',
      ));
    });
  }
}

extension MujerEmprendeDbLocalQueryObject on QueryBuilder<MujerEmprendeDbLocal,
    MujerEmprendeDbLocal, QFilterCondition> {}

extension MujerEmprendeDbLocalQueryLinks on QueryBuilder<MujerEmprendeDbLocal,
    MujerEmprendeDbLocal, QFilterCondition> {}

extension MujerEmprendeDbLocalQuerySortBy
    on QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QSortBy> {
  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByComoImpactariaNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoImpactariaNegocio', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByComoImpactariaNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoImpactariaNegocio', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByComoMejoraCalidadVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCalidadVida', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByComoMejoraCalidadVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCalidadVida', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByConocioMujerEmprende() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conocioMujerEmprende', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByConocioMujerEmprendeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conocioMujerEmprende', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByImpulsoOptar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impulsoOptar', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByImpulsoOptarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impulsoOptar', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByMotivoEmprender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoEmprender', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByMotivoEmprenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoEmprender', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      sortByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension MujerEmprendeDbLocalQuerySortThenBy
    on QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QSortThenBy> {
  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByComoImpactariaNegocio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoImpactariaNegocio', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByComoImpactariaNegocioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoImpactariaNegocio', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByComoMejoraCalidadVida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCalidadVida', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByComoMejoraCalidadVidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comoMejoraCalidadVida', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByConocioMujerEmprende() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conocioMujerEmprende', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByConocioMujerEmprendeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conocioMujerEmprende', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByEdadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByEdadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edadHijos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByImpulsoOptar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impulsoOptar', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByImpulsoOptarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impulsoOptar', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByMotivoEmprender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoEmprender', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByMotivoEmprenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoEmprender', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByMotivoPrestamo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByMotivoPrestamoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoPrestamo', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByNumeroHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroHijos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByObjOrigenCatalogoValorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objOrigenCatalogoValorId', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByObjSolicitudNuevamenorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objSolicitudNuevamenorId', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByOtrosDatosCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByOtrosDatosClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosDatosCliente', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByOtrosIngresosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByOtrosIngresosDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otrosIngresosDescripcion', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByPersonasCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personasCargo', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByQuienApoya() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByQuienApoyaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quienApoya', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByTieneTrabajoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tieneTrabajo', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByTipoEstudioHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByTipoEstudioHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEstudioHijos', Sort.desc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.asc);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QAfterSortBy>
      thenByTrabajoNegocioDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trabajoNegocioDescripcion', Sort.desc);
    });
  }
}

extension MujerEmprendeDbLocalQueryWhereDistinct
    on QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct> {
  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByComoImpactariaNegocio({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoImpactariaNegocio',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByComoMejoraCalidadVida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comoMejoraCalidadVida',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByConocioMujerEmprende({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conocioMujerEmprende',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByDatabase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByEdadHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edadHijos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByImpulsoOptar({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'impulsoOptar', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByMotivoEmprender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoEmprender',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByMotivoPrestamo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoPrestamo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByNumeroHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroHijos');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByObjOrigenCatalogoValorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objOrigenCatalogoValorId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByObjSolicitudNuevamenorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByOtrosDatosCliente({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosDatosCliente',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByOtrosIngresos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresos');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByOtrosIngresosDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otrosIngresosDescripcion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByPersonasCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personasCargo');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByQuienApoya({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quienApoya', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByTieneTrabajo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tieneTrabajo');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByTipoEstudioHijos({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoEstudioHijos',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, MujerEmprendeDbLocal, QDistinct>
      distinctByTrabajoNegocioDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trabajoNegocioDescripcion',
          caseSensitive: caseSensitive);
    });
  }
}

extension MujerEmprendeDbLocalQueryProperty on QueryBuilder<
    MujerEmprendeDbLocal, MujerEmprendeDbLocal, QQueryProperty> {
  QueryBuilder<MujerEmprendeDbLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      comoImpactariaNegocioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoImpactariaNegocio');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      comoMejoraCalidadVidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comoMejoraCalidadVida');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      conocioMujerEmprendeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conocioMujerEmprende');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      edadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edadHijos');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      impulsoOptarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'impulsoOptar');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      motivoEmprenderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoEmprender');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      motivoPrestamoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoPrestamo');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, int?, QQueryOperations>
      numeroHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroHijos');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      objOrigenCatalogoValorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objOrigenCatalogoValorId');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, int?, QQueryOperations>
      objSolicitudNuevamenorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objSolicitudNuevamenorId');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      otrosDatosClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosDatosCliente');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, bool?, QQueryOperations>
      otrosIngresosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresos');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      otrosIngresosDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otrosIngresosDescripcion');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, int?, QQueryOperations>
      personasCargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personasCargo');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      quienApoyaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quienApoya');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, bool?, QQueryOperations>
      tieneTrabajoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tieneTrabajo');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      tipoEstudioHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEstudioHijos');
    });
  }

  QueryBuilder<MujerEmprendeDbLocal, String?, QQueryOperations>
      trabajoNegocioDescripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trabajoNegocioDescripcion');
    });
  }
}
