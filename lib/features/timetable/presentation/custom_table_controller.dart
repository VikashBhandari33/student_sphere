import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/timetable/data/custom_table_repository_impl.dart';
import 'package:student_sphere/features/timetable/domain/custom_table_entity.dart';
import 'package:student_sphere/features/timetable/domain/custom_table_repository.dart';

final customTableControllerProvider = StateNotifierProvider<
    CustomTableController, AsyncValue<List<CustomTableEntity>>>((ref) {
  return CustomTableController(ref.watch(customTableRepositoryProvider));
});

class CustomTableController
    extends StateNotifier<AsyncValue<List<CustomTableEntity>>> {
  final CustomTableRepository _repository;

  CustomTableController(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.getTables().listen((tables) {
      state = AsyncValue.data(tables);
    });
  }

  Future<void> createTable(String title) async {
    final result = await _repository.createTable(title);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> deleteTable(String id) async {
    final result = await _repository.deleteTable(id);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> updateTable(CustomTableEntity table) async {
    final result = await _repository.updateTable(table);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> addColumn(String tableId, TableColumn column) async {
    final result = await _repository.addColumn(tableId, column);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> addRow(String tableId, TableRow row) async {
    final result = await _repository.addRow(tableId, row);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }
}
