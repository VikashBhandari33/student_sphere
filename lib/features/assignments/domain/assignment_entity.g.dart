// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssignmentEntityImpl _$$AssignmentEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$AssignmentEntityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      subjectId: json['subjectId'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      priority: json['priority'] as String? ?? 'Medium',
    );

Map<String, dynamic> _$$AssignmentEntityImplToJson(
        _$AssignmentEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'subjectId': instance.subjectId,
      'deadline': instance.deadline.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'priority': instance.priority,
    };
