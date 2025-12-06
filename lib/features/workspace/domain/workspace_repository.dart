import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/workspace/domain/workspace_entity.dart';

abstract class WorkspaceRepository {
  Stream<List<WorkspaceEntity>> getWorkspaces();
  Future<Either<Failure, void>> createWorkspace(
      String name, String description);
  Future<Either<Failure, void>> deleteWorkspace(String id);
  Future<Either<Failure, void>> addMember(String workspaceId, String email);
  Future<Either<Failure, void>> removeMember(String workspaceId, String userId);
}
