import 'package:app/Repository/expense_repository.dart';
import 'package:app/models/expense_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseRepository = ExpenseRepository();
final ExpenseNotifierProvider = AsyncNotifierProvider<ExpenseNotifier, void>(
  ExpenseNotifier.new,
);

class ExpenseNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> addExpense(ExpenseModel newExpense) async {
    state = const AsyncLoading();

    try {
      await expenseRepository.addExpense(newExpense);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
