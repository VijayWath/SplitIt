import 'package:app/models/expense_model.dart';

class ExpenseRepository {
  get supabase => null;

  Future<void> addExpense(ExpenseModel expense) async {
    final response = await supabase
        .from('expenses')
        .insert(expense.toMap())
        .execute();
  }
}
