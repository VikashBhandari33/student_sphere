import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/timetable/data/timetable_repository_impl.dart';
import 'package:student_sphere/features/timetable/domain/class_entity.dart';
import 'package:student_sphere/features/timetable/domain/timetable_repository.dart';

final timetableControllerProvider =
    StateNotifierProvider<TimetableController, AsyncValue<List<ClassEntity>>>(
        (ref) {
  return TimetableController(ref.watch(timetableRepositoryProvider));
});

class TimetableController extends StateNotifier<AsyncValue<List<ClassEntity>>> {
  final TimetableRepository _repository;

  TimetableController(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.getClasses().listen((classes) {
      state = AsyncValue.data(classes);
    });
  }

  Future<void> addClass(ClassEntity classEntity) async {
    final result = await _repository.addClass(classEntity);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {}, // Success is handled by the stream listener
    );
  }

  Future<void> deleteClass(String classId) async {
    final result = await _repository.deleteClass(classId);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }
}
