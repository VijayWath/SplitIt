import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUserDataSource {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> getUser(String id) async {
    return await supabase.from('users').select().eq('id', id).maybeSingle();
  }

  Future<void> createUser(Map<String, dynamic> data) async {
    await supabase.from('users').insert(data);
  }
}
