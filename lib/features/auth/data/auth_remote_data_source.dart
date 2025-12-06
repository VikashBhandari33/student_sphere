import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_sphere/features/auth/domain/user_entity.dart';
import 'package:student_sphere/core/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(
      String email, String password, String displayName);
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
  Future<void> resetPassword(String email);
  Stream<UserEntity?> get authStateChanges;
  Future<UserEntity> signInWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firestore,
    this._googleSignIn,
  );

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return await _getUserFromFirestore(user.uid);
    });
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await _getUserFromFirestore(userCredential.user!.uid);
      if (user == null) {
        // Auto-recover: Create missing user document
        final newUser = UserEntity(
          id: userCredential.user!.uid,
          email: email,
          displayName: userCredential.user!.displayName ?? email.split('@')[0],
          workspaceIds: [],
        );
        await _firestore
            .collection('users')
            .doc(newUser.id)
            .set(newUser.toJson());
        return newUser;
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Login failed');
    }
  }

  @override
  Future<UserEntity> register(
      String email, String password, String displayName) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userEntity = UserEntity(
        id: userCredential.user!.uid,
        email: email,
        displayName: displayName,
        workspaceIds: [],
      );

      await _firestore
          .collection('users')
          .doc(userEntity.id)
          .set(userEntity.toJson());
      return userEntity;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Registration failed');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return await _getUserFromFirestore(user.uid);
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Reset password failed');
    }
  }

  Future<UserEntity?> _getUserFromFirestore(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserEntity.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw ServerException('Google Sign-In aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = await _getUserFromFirestore(userCredential.user!.uid);
      if (user == null) {
        final newUser = UserEntity(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          displayName: userCredential.user!.displayName ??
              userCredential.user!.email!.split('@')[0],
          workspaceIds: [],
        );
        await _firestore
            .collection('users')
            .doc(newUser.id)
            .set(newUser.toJson());
        return newUser;
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Google Sign-In failed');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
