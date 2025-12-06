// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubjectEntityImpl _$$SubjectEntityImplFromJson(Map<String, dynamic> json) =>
    _$SubjectEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      presentCount: (json['presentCount'] as num).toInt(),
      absentCount: (json['absentCount'] as num).toInt(),
      targetPercentage: (json['targetPercentage'] as num?)?.toInt() ?? 75,
    );

Map<String, dynamic> _$$SubjectEntityImplToJson(_$SubjectEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'presentCount': instance.presentCount,
      'absentCount': instance.absentCount,
      'targetPercentage': instance.targetPercentage,
    };
