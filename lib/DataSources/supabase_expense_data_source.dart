import 'package:app/models/expense_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseDataSources {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getExpenseListByUserId(
    String userId,
    ExpenseType expenseType,
    String? groupId,
  ) async {
    var query = supabase
        .from('expenses')
        .select()
        .eq('created_by', userId)
        .eq('expense_type', expenseType.name);

    if (groupId != null) {
      query = query.eq('group_id', groupId);
    }

    final response = await query;

    return List<Map<String, dynamic>>.from(response);
  }
}
