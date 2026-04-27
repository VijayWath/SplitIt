import 'package:app/models/expense_model.dart';
import 'package:app/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addExpenseFormKey = GlobalKey<FormState>();
//  food, transportation, entertainment, other

enum PersonalExpenseTypeEntry {
  food('Food', Icons.food_bank),
  transportation('Transportation', Icons.directions_car),
  entertainment('Entertainment', Icons.sentiment_very_satisfied),
  other('Other', Icons.clear_all);

  const PersonalExpenseTypeEntry(this.label, this.icon);

  final String label;
  final IconData icon;
}

extension PersonalExpenseTypeEntryMapper on PersonalExpenseTypeEntry {
  PersonalExpenseType toPersonalExpenseType() {
    switch (this) {
      case PersonalExpenseTypeEntry.food:
        return PersonalExpenseType.Food;
      case PersonalExpenseTypeEntry.transportation:
        return PersonalExpenseType.Transportation;
      case PersonalExpenseTypeEntry.entertainment:
        return PersonalExpenseType.Entertainment;
      case PersonalExpenseTypeEntry.other:
        return PersonalExpenseType.Other;
    }
  }
}

extension PersonalExpenseTypeMapper on PersonalExpenseType {
  PersonalExpenseTypeEntry toEntry() {
    switch (this) {
      case PersonalExpenseType.Food:
        return PersonalExpenseTypeEntry.food;
      case PersonalExpenseType.Transportation:
        return PersonalExpenseTypeEntry.transportation;
      case PersonalExpenseType.Entertainment:
        return PersonalExpenseTypeEntry.entertainment;
      case PersonalExpenseType.Other:
        return PersonalExpenseTypeEntry.other;
    }
  }
}

class PersonalExpenseAddScreen extends ConsumerWidget {
  const PersonalExpenseAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentUser = ref.watch(authNotifierProvider);
    final user = currentUser.value;
    String lable = '';
    String description = '';
    double amount = 0.0;
    PersonalExpenseTypeEntry personalExpenseType =
        PersonalExpenseTypeEntry.food;
    late ExpenseModel? newExpense;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: addExpenseFormKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Lable"),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an Lable";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  lable = newValue ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  description = newValue ?? '';
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                onSaved: (newValue) {
                  amount = double.tryParse(newValue ?? '0') ?? 0.0;
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == 0.0) {
                    return "Please enter a valid amount";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),

              DropdownButtonFormField<PersonalExpenseTypeEntry>(
                decoration: const InputDecoration(
                  labelText: 'Expense Type',
                  border: OutlineInputBorder(),
                ),

                initialValue: PersonalExpenseTypeEntry.food,

                items: PersonalExpenseTypeEntry.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Icon(e.icon),
                        const SizedBox(width: 10),
                        Text(e.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    personalExpenseType = newValue;
                  }
                },
                onSaved: (newVale) {
                  if (newVale != null) {
                    personalExpenseType = newVale;
                  }
                },
              ),
              TextButton.icon(
                label: const Text("Add Expense"),
                icon: Icon(Icons.check),
                onPressed: () {
                  if (addExpenseFormKey.currentState!.validate() &&
                      user != null) {
                    addExpenseFormKey.currentState!.save();

                    newExpense = ExpenseModel(
                      amount: amount,
                      created_at: DateTime.now(),
                      created_by: user.id,
                      description: description,
                      expense_name: lable,
                      expense_type: ExpenseType.personal,
                      paid_by: user.id,
                      personal_expense_type: personalExpenseType
                          .toPersonalExpenseType(),
                      updated_at: DateTime.now(),
                      splits: [],
                    );
                    print("New Expense: ${newExpense.toString()}");
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pop(context, newExpense);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
