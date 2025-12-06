import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_table_entity.freezed.dart';
part 'custom_table_entity.g.dart';

enum ColumnType { text, number, date, select }

@freezed
class TableColumn with _$TableColumn {
  @JsonSerializable(explicitToJson: true)
  const factory TableColumn({
    required String id,
    required String name,
    required ColumnType type,
    @Default([]) List<String> options, // For select type
  }) = _TableColumn;

  factory TableColumn.fromJson(Map<String, dynamic> json) =>
      _$TableColumnFromJson(json);
}

@freezed
class TableRow with _$TableRow {
  @JsonSerializable(explicitToJson: true)
  const factory TableRow({
    required String id,
    required Map<String, dynamic> cells, // Key: Column ID, Value: Cell Data
  }) = _TableRow;

  factory TableRow.fromJson(Map<String, dynamic> json) =>
      _$TableRowFromJson(json);
}

@freezed
class CustomTableEntity with _$CustomTableEntity {
  @JsonSerializable(explicitToJson: true)
  const factory CustomTableEntity({
    required String id,
    required String title,
    required List<TableColumn> columns,
    required List<TableRow> rows,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CustomTableEntity;

  factory CustomTableEntity.fromJson(Map<String, dynamic> json) =>
      _$CustomTableEntityFromJson(json);
}
