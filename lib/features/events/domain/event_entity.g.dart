// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventEntityImpl _$$EventEntityImplFromJson(Map<String, dynamic> json) =>
    _$EventEntityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      color: (json['color'] as num).toInt(),
    );

Map<String, dynamic> _$$EventEntityImplToJson(_$EventEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'color': instance.color,
    };
