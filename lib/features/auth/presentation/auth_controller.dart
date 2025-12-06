import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/auth/data/auth_repository_impl.dart';
import 'package:student_sphere/features/auth/domain/auth_repository.dart';
import 'package:student_sphere/features/auth/domain/user_entity.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserEntity?>>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});

class AuthController extends StateNotifier<AsyncValue<UserEntity?>> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _authRepository.authStateChanges.listen((user) {
      state = AsyncValue.data(user);
    }, onError: (error) {
      state = AsyncValue.error(error, StackTrace.current);
    });
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await _authRepository.login(email, password);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> register(
      String email, String password, String displayName) async {
    state = const AsyncValue.loading();
    final result = await _authRepository.register(email, password, displayName);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _authRepository.logout();
    state = const AsyncValue.data(null);
  }

  Future<void> resetPassword(String email) async {
    // We don't change state here as it's a side effect
    await _authRepository.resetPassword(email);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final result = await _authRepository.signInWithGoogle();
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }
}
