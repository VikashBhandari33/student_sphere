import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/timetable/domain/class_entity.dart';

abstract class TimetableRepository {
  Stream<List<ClassEntity>> getClasses();
  Future<Either<Failure, void>> addClass(ClassEntity classEntity);
  Future<Either<Failure, void>> updateClass(ClassEntity classEntity);
  Future<Either<Failure, void>> deleteClass(String classId);
}
