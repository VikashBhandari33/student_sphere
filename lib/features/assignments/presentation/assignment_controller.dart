import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/assignments/data/assignment_repository_impl.dart';
import 'package:student_sphere/features/assignments/domain/assignment_entity.dart';
import 'package:student_sphere/features/assignments/domain/assignment_repository.dart';

final assignmentControllerProvider = StateNotifierProvider<AssignmentController,
    AsyncValue<List<AssignmentEntity>>>((ref) {
  return AssignmentController(ref.watch(assignmentRepositoryProvider));
});

class AssignmentController
    extends StateNotifier<AsyncValue<List<AssignmentEntity>>> {
  final AssignmentRepository _repository;

  AssignmentController(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.getAssignments().listen((assignments) {
      state = AsyncValue.data(assignments);
    });
  }

  Future<void> addAssignment(AssignmentEntity assignment) async {
    final result = await _repository.addAssignment(assignment);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> toggleCompletion(String id, bool isCompleted) async {
    final result = await _repository.toggleCompletion(id, isCompleted);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> deleteAssignment(String id) async {
    final result = await _repository.deleteAssignment(id);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }
}
