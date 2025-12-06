// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassEntityImpl _$$ClassEntityImplFromJson(Map<String, dynamic> json) =>
    _$ClassEntityImpl(
      id: json['id'] as String,
      subjectName: json['subjectName'] as String,
      roomNumber: json['roomNumber'] as String,
      facultyName: json['facultyName'] as String,
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      startTime:
          const TimeOfDayConverter().fromJson(json['startTime'] as String),
      endTime: const TimeOfDayConverter().fromJson(json['endTime'] as String),
      color: (json['color'] as num).toInt(),
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$$ClassEntityImplToJson(_$ClassEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectName': instance.subjectName,
      'roomNumber': instance.roomNumber,
      'facultyName': instance.facultyName,
      'dayOfWeek': instance.dayOfWeek,
      'startTime': const TimeOfDayConverter().toJson(instance.startTime),
      'endTime': const TimeOfDayConverter().toJson(instance.endTime),
      'color': instance.color,
      'note': instance.note,
    };
