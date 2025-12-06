// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AssignmentEntity _$AssignmentEntityFromJson(Map<String, dynamic> json) {
  return _AssignmentEntity.fromJson(json);
}

/// @nodoc
mixin _$AssignmentEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get subjectId => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;

  /// Serializes this AssignmentEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssignmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignmentEntityCopyWith<AssignmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentEntityCopyWith<$Res> {
  factory $AssignmentEntityCopyWith(
          AssignmentEntity value, $Res Function(AssignmentEntity) then) =
      _$AssignmentEntityCopyWithImpl<$Res, AssignmentEntity>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String subjectId,
      DateTime deadline,
      bool isCompleted,
      String priority});
}

/// @nodoc
class _$AssignmentEntityCopyWithImpl<$Res, $Val extends AssignmentEntity>
    implements $AssignmentEntityCopyWith<$Res> {
  _$AssignmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssignmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? subjectId = null,
    Object? deadline = null,
    Object? isCompleted = null,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: null == subjectId
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignmentEntityImplCopyWith<$Res>
    implements $AssignmentEntityCopyWith<$Res> {
  factory _$$AssignmentEntityImplCopyWith(_$AssignmentEntityImpl value,
          $Res Function(_$AssignmentEntityImpl) then) =
      __$$AssignmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String subjectId,
      DateTime deadline,
      bool isCompleted,
      String priority});
}

/// @nodoc
class __$$AssignmentEntityImplCopyWithImpl<$Res>
    extends _$AssignmentEntityCopyWithImpl<$Res, _$AssignmentEntityImpl>
    implements _$$AssignmentEntityImplCopyWith<$Res> {
  __$$AssignmentEntityImplCopyWithImpl(_$AssignmentEntityImpl _value,
      $Res Function(_$AssignmentEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssignmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? subjectId = null,
    Object? deadline = null,
    Object? isCompleted = null,
    Object? priority = null,
  }) {
    return _then(_$AssignmentEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: null == subjectId
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentEntityImpl implements _AssignmentEntity {
  const _$AssignmentEntityImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.subjectId,
      required this.deadline,
      this.isCompleted = false,
      this.priority = 'Medium'});

  factory _$AssignmentEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String subjectId;
  @override
  final DateTime deadline;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final String priority;

  @override
  String toString() {
    return 'AssignmentEntity(id: $id, title: $title, description: $description, subjectId: $subjectId, deadline: $deadline, isCompleted: $isCompleted, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      subjectId, deadline, isCompleted, priority);

  /// Create a copy of AssignmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentEntityImplCopyWith<_$AssignmentEntityImpl> get copyWith =>
      __$$AssignmentEntityImplCopyWithImpl<_$AssignmentEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentEntityImplToJson(
      this,
    );
  }
}

abstract class _AssignmentEntity implements AssignmentEntity {
  const factory _AssignmentEntity(
      {required final String id,
      required final String title,
      required final String description,
      required final String subjectId,
      required final DateTime deadline,
      final bool isCompleted,
      final String priority}) = _$AssignmentEntityImpl;

  factory _AssignmentEntity.fromJson(Map<String, dynamic> json) =
      _$AssignmentEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get subjectId;
  @override
  DateTime get deadline;
  @override
  bool get isCompleted;
  @override
  String get priority;

  /// Create a copy of AssignmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignmentEntityImplCopyWith<_$AssignmentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
