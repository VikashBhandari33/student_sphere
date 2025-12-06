import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:student_sphere/features/auth/data/auth_repository_impl.dart';
import 'package:student_sphere/features/auth/data/auth_remote_data_source.dart';
import 'package:student_sphere/features/auth/domain/user_entity.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  const tUser = UserEntity(
    id: '1',
    email: 'test@example.com',
    displayName: 'Test User',
    isEmailVerified: true,
    photoUrl: null,
    workspaceIds: [],
  );

  group('getCurrentUser', () {
    test('should return UserEntity when remote data source returns data',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => tUser);

      // Act
      final result = await repository.getCurrentUser();

      // Assert
      verify(() => mockRemoteDataSource.getCurrentUser());
      expect(result, equals(const Right(tUser)));
    });
  });
}
