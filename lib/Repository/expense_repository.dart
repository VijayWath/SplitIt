import 'package:app/models/expense_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseRepository {
  final supabase = Supabase.instance.client;

  Future<ExpenseModel> addExpense(ExpenseModel expense) async {
    final response = await supabase
        .from('expenses')
        .insert(expense.toMap())
        .select()
        .single();

    return ExpenseModel.fromMap(response);
  }
}
