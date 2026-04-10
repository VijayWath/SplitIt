import 'package:app/DataSources/supabase_user_data_source.dart';
import 'package:app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final SupabaseUserDataSource ds;

  UserRepository(this.ds);

  Future<UserModel> getOrCreateUser(User firebaseUser) async {
    final existingUser = await ds.getUser(firebaseUser.uid);

    if (existingUser != null) {
      return UserModel.fromMap(existingUser);
    }

    final user = UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      profile_picture_url: firebaseUser.photoURL ?? '',
    );

    await ds.createUser(user.toMap());

    return user;
  }
}
