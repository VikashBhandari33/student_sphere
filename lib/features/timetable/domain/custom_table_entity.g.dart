// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_table_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableColumnImpl _$$TableColumnImplFromJson(Map<String, dynamic> json) =>
    _$TableColumnImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$ColumnTypeEnumMap, json['type']),
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TableColumnImplToJson(_$TableColumnImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ColumnTypeEnumMap[instance.type]!,
      'options': instance.options,
    };

const _$ColumnTypeEnumMap = {
  ColumnType.text: 'text',
  ColumnType.number: 'number',
  ColumnType.date: 'date',
  ColumnType.select: 'select',
};

_$TableRowImpl _$$TableRowImplFromJson(Map<String, dynamic> json) =>
    _$TableRowImpl(
      id: json['id'] as String,
      cells: json['cells'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$TableRowImplToJson(_$TableRowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cells': instance.cells,
    };

_$CustomTableEntityImpl _$$CustomTableEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomTableEntityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      columns: (json['columns'] as List<dynamic>)
          .map((e) => TableColumn.fromJson(e as Map<String, dynamic>))
          .toList(),
      rows: (json['rows'] as List<dynamic>)
          .map((e) => TableRow.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CustomTableEntityImplToJson(
        _$CustomTableEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'columns': instance.columns.map((e) => e.toJson()).toList(),
      'rows': instance.rows.map((e) => e.toJson()).toList(),
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
