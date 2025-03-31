// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetImageModelCollection on Isar {
  IsarCollection<ImageModel> get imageModels => this.collection();
}

const ImageModelSchema = CollectionSchema(
  name: r'ImageModel',
  id: -4998388787585861710,
  properties: {
    r'imagen1': PropertySchema(
      id: 0,
      name: r'imagen1',
      type: IsarType.string,
    ),
    r'imagen2': PropertySchema(
      id: 1,
      name: r'imagen2',
      type: IsarType.string,
    ),
    r'imagen3': PropertySchema(
      id: 2,
      name: r'imagen3',
      type: IsarType.string,
    ),
    r'imagen4': PropertySchema(
      id: 3,
      name: r'imagen4',
      type: IsarType.string,
    ),
    r'imagenFirma': PropertySchema(
      id: 4,
      name: r'imagenFirma',
      type: IsarType.string,
    ),
    r'solicitudId': PropertySchema(
      id: 5,
      name: r'solicitudId',
      type: IsarType.long,
    )
  },
  estimateSize: _imageModelEstimateSize,
  serialize: _imageModelSerialize,
  deserialize: _imageModelDeserialize,
  deserializeProp: _imageModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _imageModelGetId,
  getLinks: _imageModelGetLinks,
  attach: _imageModelAttach,
  version: '3.1.0+1',
);

int _imageModelEstimateSize(
  ImageModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imagen1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imagen2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imagen3;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imagen4;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imagenFirma;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _imageModelSerialize(
  ImageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imagen1);
  writer.writeString(offsets[1], object.imagen2);
  writer.writeString(offsets[2], object.imagen3);
  writer.writeString(offsets[3], object.imagen4);
  writer.writeString(offsets[4], object.imagenFirma);
  writer.writeLong(offsets[5], object.solicitudId);
}

ImageModel _imageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImageModel();
  object.id = id;
  object.imagen1 = reader.readStringOrNull(offsets[0]);
  object.imagen2 = reader.readStringOrNull(offsets[1]);
  object.imagen3 = reader.readStringOrNull(offsets[2]);
  object.imagen4 = reader.readStringOrNull(offsets[3]);
  object.imagenFirma = reader.readStringOrNull(offsets[4]);
  object.solicitudId = reader.readLongOrNull(offsets[5]);
  return object;
}

P _imageModelDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _imageModelGetId(ImageModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _imageModelGetLinks(ImageModel object) {
  return [];
}

void _imageModelAttach(IsarCollection<dynamic> col, Id id, ImageModel object) {
  object.id = id;
}

extension ImageModelQueryWhereSort
    on QueryBuilder<ImageModel, ImageModel, QWhere> {
  QueryBuilder<ImageModel, ImageModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ImageModelQueryWhere
    on QueryBuilder<ImageModel, ImageModel, QWhereClause> {
  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idBetween(
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

extension ImageModelQueryFilter
    on QueryBuilder<ImageModel, ImageModel, QFilterCondition> {
  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagen1',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagen1',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagen1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagen1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagen1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagen1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagen1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagen1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagen1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen1',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagen1',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagen2',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagen2',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagen2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagen2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagen2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagen2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagen2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagen2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagen2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen2',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagen2',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagen3',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen3IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagen3',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen3GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagen3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagen3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagen3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagen3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagen3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagen3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagen3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen3',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagen3',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagen4',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen4IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagen4',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen4GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagen4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagen4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagen4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagen4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagen4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagen4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagen4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> imagen4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagen4',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagen4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagen4',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagenFirma',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagenFirma',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagenFirma',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagenFirma',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagenFirma',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagenFirma',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagenFirma',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagenFirma',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagenFirma',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagenFirma',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagenFirma',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imagenFirmaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagenFirma',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      solicitudIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'solicitudId',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      solicitudIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'solicitudId',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      solicitudIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'solicitudId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      solicitudIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'solicitudId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      solicitudIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'solicitudId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      solicitudIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'solicitudId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ImageModelQueryObject
    on QueryBuilder<ImageModel, ImageModel, QFilterCondition> {}

extension ImageModelQueryLinks
    on QueryBuilder<ImageModel, ImageModel, QFilterCondition> {}

extension ImageModelQuerySortBy
    on QueryBuilder<ImageModel, ImageModel, QSortBy> {
  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen1', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen1', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen2', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen2', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen3', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen3', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen4', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagen4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen4', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagenFirma() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagenFirma', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImagenFirmaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagenFirma', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortBySolicitudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortBySolicitudIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.desc);
    });
  }
}

extension ImageModelQuerySortThenBy
    on QueryBuilder<ImageModel, ImageModel, QSortThenBy> {
  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen1', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen1', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen2', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen2', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen3', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen3', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen4', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagen4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagen4', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagenFirma() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagenFirma', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImagenFirmaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagenFirma', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenBySolicitudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenBySolicitudIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solicitudId', Sort.desc);
    });
  }
}

extension ImageModelQueryWhereDistinct
    on QueryBuilder<ImageModel, ImageModel, QDistinct> {
  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByImagen1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagen1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByImagen2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagen2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByImagen3(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagen3', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByImagen4(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagen4', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByImagenFirma(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagenFirma', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctBySolicitudId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'solicitudId');
    });
  }
}

extension ImageModelQueryProperty
    on QueryBuilder<ImageModel, ImageModel, QQueryProperty> {
  QueryBuilder<ImageModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ImageModel, String?, QQueryOperations> imagen1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagen1');
    });
  }

  QueryBuilder<ImageModel, String?, QQueryOperations> imagen2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagen2');
    });
  }

  QueryBuilder<ImageModel, String?, QQueryOperations> imagen3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagen3');
    });
  }

  QueryBuilder<ImageModel, String?, QQueryOperations> imagen4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagen4');
    });
  }

  QueryBuilder<ImageModel, String?, QQueryOperations> imagenFirmaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagenFirma');
    });
  }

  QueryBuilder<ImageModel, int?, QQueryOperations> solicitudIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'solicitudId');
    });
  }
}
