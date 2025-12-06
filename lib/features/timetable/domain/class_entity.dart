import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'class_entity.freezed.dart';
part 'class_entity.g.dart';

@freezed
class ClassEntity with _$ClassEntity {
  const factory ClassEntity({
    required String id,
    required String subjectName,
    required String roomNumber,
    required String facultyName,
    required int dayOfWeek, // 1 = Monday, 7 = Sunday
    @TimeOfDayConverter() required TimeOfDay startTime,
    @TimeOfDayConverter() required TimeOfDay endTime,
    required int color, // Color value as int
    @Default('') String note,
  }) = _ClassEntity;

  factory ClassEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassEntityFromJson(json);
}

// Custom converter for TimeOfDay
class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour}:${object.minute}';
  }
}
