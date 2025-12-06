import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/attendance/domain/subject_entity.dart';

abstract class AttendanceRepository {
  Stream<List<SubjectEntity>> getSubjects();
  Future<Either<Failure, void>> addSubject(String name, int targetPercentage);
  Future<Either<Failure, void>> deleteSubject(String id);
  Future<Either<Failure, void>> markAttendance(String id, bool isPresent);
  Future<Either<Failure, void>> updateSubject(SubjectEntity subject);
}
