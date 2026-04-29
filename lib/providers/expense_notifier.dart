import 'package:app/Repository/expense_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/models/expense_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final repo = ExpenseRepository();

final expenseNotifierProvider =
    AsyncNotifierProvider<ExpenseNotifier, List<ExpenseModel>>(
      ExpenseNotifier.new,
    );

class ExpenseNotifier extends AsyncNotifier<List<ExpenseModel>> {
  RealtimeChannel? _channel;

  String? _userId;
  ExpenseType? _type;
  String? _groupId;

  @override
  Future<List<ExpenseModel>> build() async {
    return [];
  }

  Future<void> loadExpenses({
    required String userId,
    required ExpenseType type,
    String? groupId,
  }) async {
    _userId = userId;
    _type = type;
    _groupId = groupId;

    state = const AsyncLoading();

    final data = await repo.getExpensesByUserId(userId, type, groupId);

    state = AsyncData(data);

    _listen(repo);
  }

  void _listen(ExpenseRepository repo) {
    final supabase = Supabase.instance.client;

    _channel = supabase
        .channel('expenses-realtime')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'expenses',
          callback: (_) async {
            if (_userId == null || _type == null) return;

            final updated = await repo.getExpensesByUserId(
              _userId!,
              _type!,
              _groupId,
            );

            state = AsyncData(updated);
          },
        )
        .subscribe();

    ref.onDispose(() {
      if (_channel != null) {
        supabase.removeChannel(_channel!);
      }
    });
  }
}
