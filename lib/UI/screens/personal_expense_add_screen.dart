import 'package:app/Repository/expense_repository.dart';
import 'package:app/UI/widgets/loading_circle.dart';
import 'package:app/models/expense_model.dart';
import 'package:app/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addExpenseFormKey = GlobalKey<FormState>();

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
        return PersonalExpenseType.food;
      case PersonalExpenseTypeEntry.transportation:
        return PersonalExpenseType.transportation;
      case PersonalExpenseTypeEntry.entertainment:
        return PersonalExpenseType.entertainment;
      case PersonalExpenseTypeEntry.other:
        return PersonalExpenseType.other;
    }
  }
}

/// ---------------- SCREEN ----------------

class PersonalExpenseAddScreen extends ConsumerStatefulWidget {
  const PersonalExpenseAddScreen({super.key});

  @override
  ConsumerState<PersonalExpenseAddScreen> createState() =>
      _PersonalExpenseAddScreenState();
}

class _PersonalExpenseAddScreenState
    extends ConsumerState<PersonalExpenseAddScreen> {
  String _label = '';
  String _description = '';
  double _amount = 0.0;
  PersonalExpenseTypeEntry _type = PersonalExpenseTypeEntry.food;
  bool isLoading = false;

  Future<void> _saveExpense() async {
    final user = ref.read(authNotifierProvider).value;

    if (!addExpenseFormKey.currentState!.validate() || user == null) return;

    addExpenseFormKey.currentState!.save();

    ExpenseModel newExpense = ExpenseModel(
      amount: _amount,
      created_by: user.id,
      paid_by: user.id,
      expense_name: _label,
      description: _description,
      expense_type: ExpenseType.personal,
      personal_expense_type: _type.toPersonalExpenseType(),
    );
    try {
      setState(() {
        isLoading = true;
      });
      newExpense = await ExpenseRepository().addExpense(newExpense);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to add expense: $e")));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (isLoading) Center(child: LoadingCircle()),
          if (!isLoading)
            TextButton.icon(
              onPressed: _saveExpense,
              icon: const Icon(Icons.check),
              label: const Text("Add"),
            ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: addExpenseFormKey,
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: _buildMainFields(theme)),
                          const SizedBox(width: 20),
                          Expanded(flex: 1, child: _buildDescriptionField()),
                        ],
                      )
                    : Column(
                        children: [
                          _buildMainFields(theme),
                          const SizedBox(height: 20),
                          _buildDescriptionField(),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// ---------------- MAIN FIELDS ----------------

  Widget _buildMainFields(ThemeData theme) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0.1,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            labelText: "Label",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
          ),
          validator: (value) =>
              value == null || value.isEmpty ? "Enter label" : null,
          onSaved: (val) => _label = val ?? '',
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0.1,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter amount";
                  }
                  if (double.tryParse(value) == null) {
                    return "Invalid number";
                  }
                  return null;
                },
                onSaved: (val) => _amount = double.tryParse(val ?? '0') ?? 0.0,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: DropdownButtonFormField<PersonalExpenseTypeEntry>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0.1,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  labelText: 'Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                initialValue: _type,
                items: PersonalExpenseTypeEntry.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Icon(e.icon, size: 18),
                        const SizedBox(width: 6),
                        Text(e.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _type = val);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ---------------- DESCRIPTION ----------------

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0.1,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        labelText: "Description",
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      maxLines: 5,
      onSaved: (val) => _description = val ?? '',
    );
  }
}
