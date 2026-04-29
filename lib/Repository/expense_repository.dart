import 'package:app/DataSources/supabase_expense_data_source.dart';
import 'package:app/models/expense_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ExpenseDataSources ds = ExpenseDataSources();

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

  Future<List<ExpenseModel>> getExpensesByUserId(
    String userId,
    ExpenseType expenseType,
    String? groupId,
  ) async {
    final List<Map<String, dynamic>> response = await ds.getExpenseListByUserId(
      userId,
      expenseType,
      groupId,
    );
    List<ExpenseModel> expenses = response
        .map((e) => ExpenseModel.fromMap(e))
        .toList();
    return expenses;
  }
}
