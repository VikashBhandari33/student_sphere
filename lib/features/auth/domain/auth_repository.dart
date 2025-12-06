import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/auth/domain/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(
      String email, String password, String displayName);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Stream<UserEntity?> get authStateChanges;
}
