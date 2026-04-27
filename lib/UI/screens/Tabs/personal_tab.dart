import 'package:app/UI/screens/personal_expense_add_screen.dart';
import 'package:flutter/material.dart';

class PersonalTab extends StatelessWidget {
  const PersonalTab({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Theme.of(context).colorScheme.onPrimary;
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
        ],
      ),
    );
  }
}
