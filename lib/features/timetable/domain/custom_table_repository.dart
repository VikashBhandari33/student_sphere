import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/timetable/domain/custom_table_entity.dart';

abstract class CustomTableRepository {
  Stream<List<CustomTableEntity>> getTables();
  Future<Either<Failure, void>> createTable(String title);
  Future<Either<Failure, void>> deleteTable(String id);
  Future<Either<Failure, void>> updateTable(CustomTableEntity table);
  Future<Either<Failure, void>> addColumn(String tableId, TableColumn column);
  Future<Either<Failure, void>> addRow(String tableId, TableRow row);
}
