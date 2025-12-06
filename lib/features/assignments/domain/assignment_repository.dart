import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/assignments/domain/assignment_entity.dart';

abstract class AssignmentRepository {
  Stream<List<AssignmentEntity>> getAssignments();
  Future<Either<Failure, void>> addAssignment(AssignmentEntity assignment);
  Future<Either<Failure, void>> updateAssignment(AssignmentEntity assignment);
  Future<Either<Failure, void>> deleteAssignment(String id);
  Future<Either<Failure, void>> toggleCompletion(String id, bool isCompleted);
}
