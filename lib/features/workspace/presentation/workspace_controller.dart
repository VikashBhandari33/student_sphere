import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/workspace/data/workspace_repository_impl.dart';
import 'package:student_sphere/features/workspace/domain/workspace_entity.dart';
import 'package:student_sphere/features/workspace/domain/workspace_repository.dart';

final workspaceControllerProvider = StateNotifierProvider<WorkspaceController,
    AsyncValue<List<WorkspaceEntity>>>((ref) {
  return WorkspaceController(ref.watch(workspaceRepositoryProvider));
});

class WorkspaceController
    extends StateNotifier<AsyncValue<List<WorkspaceEntity>>> {
  final WorkspaceRepository _repository;

  WorkspaceController(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.getWorkspaces().listen((workspaces) {
      state = AsyncValue.data(workspaces);
    });
  }

  Future<void> createWorkspace(String name, String description) async {
    final result = await _repository.createWorkspace(name, description);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> deleteWorkspace(String id) async {
    final result = await _repository.deleteWorkspace(id);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }
}
