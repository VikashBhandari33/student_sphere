// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_table_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TableColumn _$TableColumnFromJson(Map<String, dynamic> json) {
  return _TableColumn.fromJson(json);
}

/// @nodoc
mixin _$TableColumn {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ColumnType get type => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;

  /// Serializes this TableColumn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableColumnCopyWith<TableColumn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableColumnCopyWith<$Res> {
  factory $TableColumnCopyWith(
          TableColumn value, $Res Function(TableColumn) then) =
      _$TableColumnCopyWithImpl<$Res, TableColumn>;
  @useResult
  $Res call({String id, String name, ColumnType type, List<String> options});
}

/// @nodoc
class _$TableColumnCopyWithImpl<$Res, $Val extends TableColumn>
    implements $TableColumnCopyWith<$Res> {
  _$TableColumnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? options = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ColumnType,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableColumnImplCopyWith<$Res>
    implements $TableColumnCopyWith<$Res> {
  factory _$$TableColumnImplCopyWith(
          _$TableColumnImpl value, $Res Function(_$TableColumnImpl) then) =
      __$$TableColumnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, ColumnType type, List<String> options});
}

/// @nodoc
class __$$TableColumnImplCopyWithImpl<$Res>
    extends _$TableColumnCopyWithImpl<$Res, _$TableColumnImpl>
    implements _$$TableColumnImplCopyWith<$Res> {
  __$$TableColumnImplCopyWithImpl(
      _$TableColumnImpl _value, $Res Function(_$TableColumnImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? options = null,
  }) {
    return _then(_$TableColumnImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ColumnType,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TableColumnImpl implements _TableColumn {
  const _$TableColumnImpl(
      {required this.id,
      required this.name,
      required this.type,
      final List<String> options = const []})
      : _options = options;

  factory _$TableColumnImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableColumnImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final ColumnType type;
  final List<String> _options;
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'TableColumn(id: $id, name: $name, type: $type, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableColumnImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type,
      const DeepCollectionEquality().hash(_options));

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableColumnImplCopyWith<_$TableColumnImpl> get copyWith =>
      __$$TableColumnImplCopyWithImpl<_$TableColumnImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableColumnImplToJson(
      this,
    );
  }
}

abstract class _TableColumn implements TableColumn {
  const factory _TableColumn(
      {required final String id,
      required final String name,
      required final ColumnType type,
      final List<String> options}) = _$TableColumnImpl;

  factory _TableColumn.fromJson(Map<String, dynamic> json) =
      _$TableColumnImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ColumnType get type;
  @override
  List<String> get options;

  /// Create a copy of TableColumn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableColumnImplCopyWith<_$TableColumnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TableRow _$TableRowFromJson(Map<String, dynamic> json) {
  return _TableRow.fromJson(json);
}

/// @nodoc
mixin _$TableRow {
  String get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get cells => throw _privateConstructorUsedError;

  /// Serializes this TableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableRowCopyWith<TableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableRowCopyWith<$Res> {
  factory $TableRowCopyWith(TableRow value, $Res Function(TableRow) then) =
      _$TableRowCopyWithImpl<$Res, TableRow>;
  @useResult
  $Res call({String id, Map<String, dynamic> cells});
}

/// @nodoc
class _$TableRowCopyWithImpl<$Res, $Val extends TableRow>
    implements $TableRowCopyWith<$Res> {
  _$TableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cells = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cells: null == cells
          ? _value.cells
          : cells // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableRowImplCopyWith<$Res>
    implements $TableRowCopyWith<$Res> {
  factory _$$TableRowImplCopyWith(
          _$TableRowImpl value, $Res Function(_$TableRowImpl) then) =
      __$$TableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Map<String, dynamic> cells});
}

/// @nodoc
class __$$TableRowImplCopyWithImpl<$Res>
    extends _$TableRowCopyWithImpl<$Res, _$TableRowImpl>
    implements _$$TableRowImplCopyWith<$Res> {
  __$$TableRowImplCopyWithImpl(
      _$TableRowImpl _value, $Res Function(_$TableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cells = null,
  }) {
    return _then(_$TableRowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cells: null == cells
          ? _value._cells
          : cells // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TableRowImpl implements _TableRow {
  const _$TableRowImpl(
      {required this.id, required final Map<String, dynamic> cells})
      : _cells = cells;

  factory _$TableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableRowImplFromJson(json);

  @override
  final String id;
  final Map<String, dynamic> _cells;
  @override
  Map<String, dynamic> get cells {
    if (_cells is EqualUnmodifiableMapView) return _cells;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cells);
  }

  @override
  String toString() {
    return 'TableRow(id: $id, cells: $cells)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableRowImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._cells, _cells));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(_cells));

  /// Create a copy of TableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableRowImplCopyWith<_$TableRowImpl> get copyWith =>
      __$$TableRowImplCopyWithImpl<_$TableRowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableRowImplToJson(
      this,
    );
  }
}

abstract class _TableRow implements TableRow {
  const factory _TableRow(
      {required final String id,
      required final Map<String, dynamic> cells}) = _$TableRowImpl;

  factory _TableRow.fromJson(Map<String, dynamic> json) =
      _$TableRowImpl.fromJson;

  @override
  String get id;
  @override
  Map<String, dynamic> get cells;

  /// Create a copy of TableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableRowImplCopyWith<_$TableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomTableEntity _$CustomTableEntityFromJson(Map<String, dynamic> json) {
  return _CustomTableEntity.fromJson(json);
}

/// @nodoc
mixin _$CustomTableEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<TableColumn> get columns => throw _privateConstructorUsedError;
  List<TableRow> get rows => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CustomTableEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomTableEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomTableEntityCopyWith<CustomTableEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomTableEntityCopyWith<$Res> {
  factory $CustomTableEntityCopyWith(
          CustomTableEntity value, $Res Function(CustomTableEntity) then) =
      _$CustomTableEntityCopyWithImpl<$Res, CustomTableEntity>;
  @useResult
  $Res call(
      {String id,
      String title,
      List<TableColumn> columns,
      List<TableRow> rows,
      String userId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$CustomTableEntityCopyWithImpl<$Res, $Val extends CustomTableEntity>
    implements $CustomTableEntityCopyWith<$Res> {
  _$CustomTableEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomTableEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? columns = null,
    Object? rows = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<TableColumn>,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<TableRow>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomTableEntityImplCopyWith<$Res>
    implements $CustomTableEntityCopyWith<$Res> {
  factory _$$CustomTableEntityImplCopyWith(_$CustomTableEntityImpl value,
          $Res Function(_$CustomTableEntityImpl) then) =
      __$$CustomTableEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      List<TableColumn> columns,
      List<TableRow> rows,
      String userId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$CustomTableEntityImplCopyWithImpl<$Res>
    extends _$CustomTableEntityCopyWithImpl<$Res, _$CustomTableEntityImpl>
    implements _$$CustomTableEntityImplCopyWith<$Res> {
  __$$CustomTableEntityImplCopyWithImpl(_$CustomTableEntityImpl _value,
      $Res Function(_$CustomTableEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomTableEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? columns = null,
    Object? rows = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$CustomTableEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<TableColumn>,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<TableRow>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CustomTableEntityImpl implements _CustomTableEntity {
  const _$CustomTableEntityImpl(
      {required this.id,
      required this.title,
      required final List<TableColumn> columns,
      required final List<TableRow> rows,
      required this.userId,
      required this.createdAt,
      required this.updatedAt})
      : _columns = columns,
        _rows = rows;

  factory _$CustomTableEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomTableEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  final List<TableColumn> _columns;
  @override
  List<TableColumn> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  final List<TableRow> _rows;
  @override
  List<TableRow> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  final String userId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CustomTableEntity(id: $id, title: $title, columns: $columns, rows: $rows, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomTableEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_columns),
      const DeepCollectionEquality().hash(_rows),
      userId,
      createdAt,
      updatedAt);

  /// Create a copy of CustomTableEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomTableEntityImplCopyWith<_$CustomTableEntityImpl> get copyWith =>
      __$$CustomTableEntityImplCopyWithImpl<_$CustomTableEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomTableEntityImplToJson(
      this,
    );
  }
}

abstract class _CustomTableEntity implements CustomTableEntity {
  const factory _CustomTableEntity(
      {required final String id,
      required final String title,
      required final List<TableColumn> columns,
      required final List<TableRow> rows,
      required final String userId,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$CustomTableEntityImpl;

  factory _CustomTableEntity.fromJson(Map<String, dynamic> json) =
      _$CustomTableEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  List<TableColumn> get columns;
  @override
  List<TableRow> get rows;
  @override
  String get userId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CustomTableEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomTableEntityImplCopyWith<_$CustomTableEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
