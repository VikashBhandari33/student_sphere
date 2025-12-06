import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/attendance/data/attendance_repository_impl.dart';
import 'package:student_sphere/features/attendance/domain/attendance_repository.dart';
import 'package:student_sphere/features/attendance/domain/subject_entity.dart';

final attendanceControllerProvider = StateNotifierProvider<AttendanceController,
    AsyncValue<List<SubjectEntity>>>((ref) {
  return AttendanceController(ref.watch(attendanceRepositoryProvider));
});

class AttendanceController
    extends StateNotifier<AsyncValue<List<SubjectEntity>>> {
  final AttendanceRepository _repository;

  AttendanceController(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.getSubjects().listen((subjects) {
      state = AsyncValue.data(subjects);
    });
  }

  Future<void> addSubject(String name, int targetPercentage) async {
    final result = await _repository.addSubject(name, targetPercentage);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> markAttendance(String id, bool isPresent) async {
    final result = await _repository.markAttendance(id, isPresent);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> deleteSubject(String id) async {
    final result = await _repository.deleteSubject(id);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }
}
