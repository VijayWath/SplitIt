import 'package:app/UI/screens/personal_expense_add_screen.dart';
import 'package:app/models/expense_model.dart';
import 'package:app/providers/auth_notifier.dart';
import 'package:app/providers/expense_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalTab extends ConsumerStatefulWidget {
  const PersonalTab({super.key});

  @override
  ConsumerState<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends ConsumerState<PersonalTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.watch(authNotifierProvider).value;
      ref
          .read(expenseNotifierProvider.notifier)
          .loadExpenses(userId: user!.id, type: ExpenseType.personal);
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Theme.of(context).colorScheme.onPrimary;
    final user = ref.watch(authNotifierProvider).value;
    final expensesAsync = ref.watch(expenseNotifierProvider);
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight + 20, left: 20, right: 20),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => PersonalExpenseAddScreen(),
              );
            },
            child: Text("Add Expense"),
          ),

          expensesAsync.when(
            data: (expenses) => Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return ListTile(
                    title: Text(expense.expense_name),
                    subtitle: Text("\$${expense.amount.toStringAsFixed(2)}"),
                  );
                },
              ),
            ),
            loading: () => CircularProgressIndicator(),
            error: (e, st) => Text("Error loading expenses"),
          ),
        ],
      ),
    );
  }
}
