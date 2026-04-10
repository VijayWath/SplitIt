import 'dart:async';
import 'package:app/Repository/user_repository.dart' show UserRepository;
import 'package:app/models/userModel.dart';
import 'package:app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthNotifier extends AsyncNotifier<UserModel?> {
  late final UserRepository _repo;
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  FutureOr<UserModel?> build() async {
    _repo = ref.read(userRepositoryProvider);
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;
    return _repo.getOrCreateUser(firebaseUser);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();

    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        state = AsyncData(state.value); // keep existing user
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);
      final firebaseUser = userCred.user;

      if (firebaseUser == null) {
        state = const AsyncData(null);
        return;
      }

      final userModel = await _repo.getOrCreateUser(firebaseUser);

      state = AsyncData(userModel);
    } on FirebaseAuthException catch (e, st) {
      state = AsyncError(e.message ?? e.code, st);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    state = const AsyncData(null);
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(
  AuthNotifier.new,
);
