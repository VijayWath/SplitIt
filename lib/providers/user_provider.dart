import 'package:app/DataSources/supabase_user_data_source.dart';
import 'package:app/Repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supabaseDSProvider = Provider((ref) {
  return SupabaseUserDataSource();
});
final userRepositoryProvider = Provider((ref) {
  return UserRepository(ref.read(supabaseDSProvider));
});
