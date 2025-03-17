// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitudes_pendientes.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSolicitudesPendientesCollection on Isar {
  IsarCollection<SolicitudesPendientes> get solicitudesPendientes =>
      this.collection();
}

const SolicitudesPendientesSchema = CollectionSchema(
  name: r'SolicitudesPendientes',
  id: -897172854623419597,
  properties: {
    r'cantidadHijos': PropertySchema(
      id: 0,
      name: r'cantidadHijos',
      type: IsarType.long,
    ),
    r'cedula': PropertySchema(
      id: 1,
      name: r'cedula',
      type: IsarType.string,
    ),
    r'estado': PropertySchema(
      id: 2,
      name: r'estado',
      type: IsarType.string,
    ),
    r'fecha': PropertySchema(
      id: 3,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'idAsesor': PropertySchema(
      id: 4,
      name: r'idAsesor',
      type: IsarType.long,
    ),
    r'moneda': PropertySchema(
      id: 5,
      name: r'moneda',
      type: IsarType.string,
    ),
    r'monto': PropertySchema(
      id: 6,
      name: r'monto',
      type: IsarType.double,
    ),
    r'motivoAnterior': PropertySchema(
      id: 7,
      name: r'motivoAnterior',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(
      id: 8,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'numero': PropertySchema(
      id: 9,
      name: r'numero',
      type: IsarType.string,
    ),
    r'producto': PropertySchema(
      id: 10,
      name: r'producto',
      type: IsarType.string,
    ),
    r'solicitudId': PropertySchema(
      id: 11,
      name: r'solicitudId',
      type: IsarType.string,
    ),
    r'sucursal': PropertySchema(
      id: 12,
      name: r'sucursal',
      type: IsarType.string,
    ),
    r'tipoSolicitud': PropertySchema(
      id: 13,
      name: r'tipoSolicitud',
      type: IsarType.string,
    )
  },
  estimateSize: _solicitudesPendientesEstimateSize,
  serialize: _solicitudesPendientesSerialize,
  deserialize: _solicitudesPendientesDeserialize,
  deserializeProp: _solicitudesPendientesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _solicitudesPendientesGetId,
  getLinks: _solicitudesPendientesGetLinks,
  attach: _solicitudesPendientesAttach,
  version: '3.1.0+1',
);

int _solicitudesPendientesEstimateSize(
  SolicitudesPendientes object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cedula;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.estado;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.moneda;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motivoAnterior;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.numero;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.producto;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.solicitudId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sucursal;
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
  return bytesCount;
}

void _solicitudesPendientesSerialize(
  SolicitudesPendientes object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cantidadHijos);
  writer.writeString(offsets[1], object.cedula);
  writer.writeString(offsets[2], object.estado);
  writer.writeDateTime(offsets[3], object.fecha);
  writer.writeLong(offsets[4], object.idAsesor);
  writer.writeString(offsets[5], object.moneda);
  writer.writeDouble(offsets[6], object.monto);
  writer.writeString(offsets[7], object.motivoAnterior);
  writer.writeString(offsets[8], object.nombre);
  writer.writeString(offsets[9], object.numero);
  writer.writeString(offsets[10], object.producto);
  writer.writeString(offsets[11], object.solicitudId);
  writer.writeString(offsets[12], object.sucursal);
  writer.writeString(offsets[13], object.tipoSolicitud);
}

SolicitudesPendientes _solicitudesPendientesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SolicitudesPendientes();
  object.cantidadHijos = reader.readLongOrNull(offsets[0]);
  object.cedula = reader.readStringOrNull(offsets[1]);
  object.estado = reader.readStringOrNull(offsets[2]);
  object.fecha = reader.readDateTimeOrNull(offsets[3]);
  object.id = id;
  object.idAsesor = reader.readLongOrNull(offsets[4]);
  object.moneda = reader.readStringOrNull(offsets[5]);
  object.monto = reader.readDoubleOrNull(offsets[6]);
  object.motivoAnterior = reader.readStringOrNull(offsets[7]);
  object.nombre = reader.readStringOrNull(offsets[8]);
  object.numero = reader.readStringOrNull(offsets[9]);
  object.producto = reader.readStringOrNull(offsets[10]);
  object.solicitudId = reader.readStringOrNull(offsets[11]);
  object.sucursal = reader.readStringOrNull(offsets[12]);
  object.tipoSolicitud = reader.readStringOrNull(offsets[13]);
  return object;
}

P _solicitudesPendientesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _solicitudesPendientesGetId(SolicitudesPendientes object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _solicitudesPendientesGetLinks(
    SolicitudesPendientes object) {
  return [];
}

void _solicitudesPendientesAttach(
    IsarCollection<dynamic> col, Id id, SolicitudesPendientes object) {
  object.id = id;
}

extension SolicitudesPendientesQueryWhereSort
    on QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QWhere> {
  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SolicitudesPendientesQueryWhere on QueryBuilder<SolicitudesPendientes,
    SolicitudesPendientes, QWhereClause> {
  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterWhereClause>
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterWhereClause>
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

extension SolicitudesPendientesQueryFilter on QueryBuilder<
    SolicitudesPendientes, SolicitudesPendientes, QFilterCondition> {
  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cantidadHijosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cantidadHijos',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cantidadHijosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cantidadHijos',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cantidadHijosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cantidadHijosGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cantidadHijosLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadHijos',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cantidadHijosBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadHijos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cedula',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cedula',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cedula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cedula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cedula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cedula',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cedula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cedula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      cedulaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cedula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      cedulaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cedula',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cedula',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> cedulaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cedula',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'estado',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'estado',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      estadoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      estadoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estado',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> fechaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fecha',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> fechaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fecha',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> fechaEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> fechaGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> fechaLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> fechaBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fecha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> idAsesorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idAsesor',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> idAsesorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idAsesor',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> idAsesorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idAsesor',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> idAsesorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idAsesor',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> idAsesorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idAsesor',
        value: value,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> idAsesorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idAsesor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'moneda',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'moneda',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moneda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moneda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moneda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moneda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'moneda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'moneda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      monedaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'moneda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      monedaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'moneda',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moneda',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> monedaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'moneda',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> montoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monto',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> montoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monto',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> montoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> montoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> montoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> montoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motivoAnterior',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motivoAnterior',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoAnterior',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motivoAnterior',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motivoAnterior',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motivoAnterior',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motivoAnterior',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motivoAnterior',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      motivoAnteriorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motivoAnterior',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      motivoAnteriorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motivoAnterior',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motivoAnterior',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> motivoAnteriorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motivoAnterior',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numero',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numero',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numero',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'numero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'numero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      numeroContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'numero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      numeroMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'numero',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numero',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> numeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'numero',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'producto',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'producto',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'producto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      productoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'producto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      productoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'producto',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'producto',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> productoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'producto',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'solicitudId',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'solicitudId',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'solicitudId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'solicitudId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'solicitudId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'solicitudId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'solicitudId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'solicitudId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      solicitudIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'solicitudId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      solicitudIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'solicitudId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'solicitudId',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> solicitudIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'solicitudId',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sucursal',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sucursal',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sucursal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sucursal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sucursal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sucursal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sucursal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sucursal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      sucursalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sucursal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
          QAfterFilterCondition>
      sucursalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sucursal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sucursal',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> sucursalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sucursal',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> tipoSolicitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> tipoSolicitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipoSolicitud',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
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

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> tipoSolicitudIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes,
      QAfterFilterCondition> tipoSolicitudIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoSolicitud',
        value: '',
      ));
    });
  }
}

extension SolicitudesPendientesQueryObject on QueryBuilder<
    SolicitudesPendientes, SolicitudesPendientes, QFilterCondition> {}

extension SolicitudesPendientesQueryLinks on QueryBuilder<SolicitudesPendientes,
    SolicitudesPendientes, QFilterCondition> {}

extension SolicitudesPendientesQuerySortBy
    on QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QSortBy> {
  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByCantidadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadHijos', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByCantidadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadHijos', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByCedula() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cedula', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByCedulaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cedula', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByIdAsesor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idAsesor', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByIdAsesorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idAsesor', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByMoneda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneda', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByMonedaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneda', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByMontoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByMotivoAnterior() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoAnterior', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByMotivoAnteriorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoAnterior', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortBySolicitudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortBySolicitudIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortBySucursal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sucursal', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortBySucursalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sucursal', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      sortByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }
}

extension SolicitudesPendientesQuerySortThenBy
    on QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QSortThenBy> {
  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByCantidadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadHijos', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByCantidadHijosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadHijos', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByCedula() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cedula', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByCedulaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cedula', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByIdAsesor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idAsesor', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByIdAsesorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idAsesor', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByMoneda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneda', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByMonedaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneda', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByMontoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByMotivoAnterior() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoAnterior', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByMotivoAnteriorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivoAnterior', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'producto', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenBySolicitudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenBySolicitudIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenBySucursal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sucursal', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenBySucursalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sucursal', Sort.desc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByTipoSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.asc);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QAfterSortBy>
      thenByTipoSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoSolicitud', Sort.desc);
    });
  }
}

extension SolicitudesPendientesQueryWhereDistinct
    on QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct> {
  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByCantidadHijos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadHijos');
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByCedula({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cedula', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByEstado({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByIdAsesor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idAsesor');
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByMoneda({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moneda', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monto');
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByMotivoAnterior({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivoAnterior',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByNumero({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numero', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByProducto({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'producto', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctBySolicitudId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'solicitudId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctBySucursal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sucursal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SolicitudesPendientes, SolicitudesPendientes, QDistinct>
      distinctByTipoSolicitud({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoSolicitud',
          caseSensitive: caseSensitive);
    });
  }
}

extension SolicitudesPendientesQueryProperty on QueryBuilder<
    SolicitudesPendientes, SolicitudesPendientes, QQueryProperty> {
  QueryBuilder<SolicitudesPendientes, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SolicitudesPendientes, int?, QQueryOperations>
      cantidadHijosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadHijos');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      cedulaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cedula');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<SolicitudesPendientes, DateTime?, QQueryOperations>
      fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<SolicitudesPendientes, int?, QQueryOperations>
      idAsesorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idAsesor');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      monedaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moneda');
    });
  }

  QueryBuilder<SolicitudesPendientes, double?, QQueryOperations>
      montoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monto');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      motivoAnteriorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivoAnterior');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      numeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numero');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      productoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'producto');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      solicitudIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'solicitudId');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      sucursalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sucursal');
    });
  }

  QueryBuilder<SolicitudesPendientes, String?, QQueryOperations>
      tipoSolicitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoSolicitud');
    });
  }
}
