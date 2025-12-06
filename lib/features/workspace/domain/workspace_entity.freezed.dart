// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workspace_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkspaceEntity _$WorkspaceEntityFromJson(Map<String, dynamic> json) {
  return _WorkspaceEntity.fromJson(json);
}

/// @nodoc
mixin _$WorkspaceEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  List<String> get editorIds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WorkspaceEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkspaceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkspaceEntityCopyWith<WorkspaceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkspaceEntityCopyWith<$Res> {
  factory $WorkspaceEntityCopyWith(
          WorkspaceEntity value, $Res Function(WorkspaceEntity) then) =
      _$WorkspaceEntityCopyWithImpl<$Res, WorkspaceEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String ownerId,
      List<String> memberIds,
      List<String> editorIds,
      DateTime createdAt});
}

/// @nodoc
class _$WorkspaceEntityCopyWithImpl<$Res, $Val extends WorkspaceEntity>
    implements $WorkspaceEntityCopyWith<$Res> {
  _$WorkspaceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkspaceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? editorIds = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _value.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      editorIds: null == editorIds
          ? _value.editorIds
          : editorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkspaceEntityImplCopyWith<$Res>
    implements $WorkspaceEntityCopyWith<$Res> {
  factory _$$WorkspaceEntityImplCopyWith(_$WorkspaceEntityImpl value,
          $Res Function(_$WorkspaceEntityImpl) then) =
      __$$WorkspaceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String ownerId,
      List<String> memberIds,
      List<String> editorIds,
      DateTime createdAt});
}

/// @nodoc
class __$$WorkspaceEntityImplCopyWithImpl<$Res>
    extends _$WorkspaceEntityCopyWithImpl<$Res, _$WorkspaceEntityImpl>
    implements _$$WorkspaceEntityImplCopyWith<$Res> {
  __$$WorkspaceEntityImplCopyWithImpl(
      _$WorkspaceEntityImpl _value, $Res Function(_$WorkspaceEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? editorIds = null,
    Object? createdAt = null,
  }) {
    return _then(_$WorkspaceEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _value._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      editorIds: null == editorIds
          ? _value._editorIds
          : editorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkspaceEntityImpl implements _WorkspaceEntity {
  const _$WorkspaceEntityImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.ownerId,
      required final List<String> memberIds,
      final List<String> editorIds = const [],
      required this.createdAt})
      : _memberIds = memberIds,
        _editorIds = editorIds;

  factory _$WorkspaceEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkspaceEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String ownerId;
  final List<String> _memberIds;
  @override
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<String> _editorIds;
  @override
  @JsonKey()
  List<String> get editorIds {
    if (_editorIds is EqualUnmodifiableListView) return _editorIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editorIds);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'WorkspaceEntity(id: $id, name: $name, description: $description, ownerId: $ownerId, memberIds: $memberIds, editorIds: $editorIds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkspaceEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            const DeepCollectionEquality()
                .equals(other._editorIds, _editorIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      ownerId,
      const DeepCollectionEquality().hash(_memberIds),
      const DeepCollectionEquality().hash(_editorIds),
      createdAt);

  /// Create a copy of WorkspaceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkspaceEntityImplCopyWith<_$WorkspaceEntityImpl> get copyWith =>
      __$$WorkspaceEntityImplCopyWithImpl<_$WorkspaceEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkspaceEntityImplToJson(
      this,
    );
  }
}

abstract class _WorkspaceEntity implements WorkspaceEntity {
  const factory _WorkspaceEntity(
      {required final String id,
      required final String name,
      required final String description,
      required final String ownerId,
      required final List<String> memberIds,
      final List<String> editorIds,
      required final DateTime createdAt}) = _$WorkspaceEntityImpl;

  factory _WorkspaceEntity.fromJson(Map<String, dynamic> json) =
      _$WorkspaceEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get ownerId;
  @override
  List<String> get memberIds;
  @override
  List<String> get editorIds;
  @override
  DateTime get createdAt;

  /// Create a copy of WorkspaceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkspaceEntityImplCopyWith<_$WorkspaceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
