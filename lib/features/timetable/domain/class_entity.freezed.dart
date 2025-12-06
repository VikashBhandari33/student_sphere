// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClassEntity _$ClassEntityFromJson(Map<String, dynamic> json) {
  return _ClassEntity.fromJson(json);
}

/// @nodoc
mixin _$ClassEntity {
  String get id => throw _privateConstructorUsedError;
  String get subjectName => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get facultyName => throw _privateConstructorUsedError;
  int get dayOfWeek =>
      throw _privateConstructorUsedError; // 1 = Monday, 7 = Sunday
  @TimeOfDayConverter()
  TimeOfDay get startTime => throw _privateConstructorUsedError;
  @TimeOfDayConverter()
  TimeOfDay get endTime => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError; // Color value as int
  String get note => throw _privateConstructorUsedError;

  /// Serializes this ClassEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassEntityCopyWith<ClassEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassEntityCopyWith<$Res> {
  factory $ClassEntityCopyWith(
          ClassEntity value, $Res Function(ClassEntity) then) =
      _$ClassEntityCopyWithImpl<$Res, ClassEntity>;
  @useResult
  $Res call(
      {String id,
      String subjectName,
      String roomNumber,
      String facultyName,
      int dayOfWeek,
      @TimeOfDayConverter() TimeOfDay startTime,
      @TimeOfDayConverter() TimeOfDay endTime,
      int color,
      String note});
}

/// @nodoc
class _$ClassEntityCopyWithImpl<$Res, $Val extends ClassEntity>
    implements $ClassEntityCopyWith<$Res> {
  _$ClassEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectName = null,
    Object? roomNumber = null,
    Object? facultyName = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? color = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subjectName: null == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      facultyName: null == facultyName
          ? _value.facultyName
          : facultyName // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassEntityImplCopyWith<$Res>
    implements $ClassEntityCopyWith<$Res> {
  factory _$$ClassEntityImplCopyWith(
          _$ClassEntityImpl value, $Res Function(_$ClassEntityImpl) then) =
      __$$ClassEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String subjectName,
      String roomNumber,
      String facultyName,
      int dayOfWeek,
      @TimeOfDayConverter() TimeOfDay startTime,
      @TimeOfDayConverter() TimeOfDay endTime,
      int color,
      String note});
}

/// @nodoc
class __$$ClassEntityImplCopyWithImpl<$Res>
    extends _$ClassEntityCopyWithImpl<$Res, _$ClassEntityImpl>
    implements _$$ClassEntityImplCopyWith<$Res> {
  __$$ClassEntityImplCopyWithImpl(
      _$ClassEntityImpl _value, $Res Function(_$ClassEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectName = null,
    Object? roomNumber = null,
    Object? facultyName = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? color = null,
    Object? note = null,
  }) {
    return _then(_$ClassEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subjectName: null == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      facultyName: null == facultyName
          ? _value.facultyName
          : facultyName // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassEntityImpl implements _ClassEntity {
  const _$ClassEntityImpl(
      {required this.id,
      required this.subjectName,
      required this.roomNumber,
      required this.facultyName,
      required this.dayOfWeek,
      @TimeOfDayConverter() required this.startTime,
      @TimeOfDayConverter() required this.endTime,
      required this.color,
      this.note = ''});

  factory _$ClassEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String subjectName;
  @override
  final String roomNumber;
  @override
  final String facultyName;
  @override
  final int dayOfWeek;
// 1 = Monday, 7 = Sunday
  @override
  @TimeOfDayConverter()
  final TimeOfDay startTime;
  @override
  @TimeOfDayConverter()
  final TimeOfDay endTime;
  @override
  final int color;
// Color value as int
  @override
  @JsonKey()
  final String note;

  @override
  String toString() {
    return 'ClassEntity(id: $id, subjectName: $subjectName, roomNumber: $roomNumber, facultyName: $facultyName, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, color: $color, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subjectName, subjectName) ||
                other.subjectName == subjectName) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.facultyName, facultyName) ||
                other.facultyName == facultyName) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, subjectName, roomNumber,
      facultyName, dayOfWeek, startTime, endTime, color, note);

  /// Create a copy of ClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassEntityImplCopyWith<_$ClassEntityImpl> get copyWith =>
      __$$ClassEntityImplCopyWithImpl<_$ClassEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassEntityImplToJson(
      this,
    );
  }
}

abstract class _ClassEntity implements ClassEntity {
  const factory _ClassEntity(
      {required final String id,
      required final String subjectName,
      required final String roomNumber,
      required final String facultyName,
      required final int dayOfWeek,
      @TimeOfDayConverter() required final TimeOfDay startTime,
      @TimeOfDayConverter() required final TimeOfDay endTime,
      required final int color,
      final String note}) = _$ClassEntityImpl;

  factory _ClassEntity.fromJson(Map<String, dynamic> json) =
      _$ClassEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get subjectName;
  @override
  String get roomNumber;
  @override
  String get facultyName;
  @override
  int get dayOfWeek; // 1 = Monday, 7 = Sunday
  @override
  @TimeOfDayConverter()
  TimeOfDay get startTime;
  @override
  @TimeOfDayConverter()
  TimeOfDay get endTime;
  @override
  int get color; // Color value as int
  @override
  String get note;

  /// Create a copy of ClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassEntityImplCopyWith<_$ClassEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
