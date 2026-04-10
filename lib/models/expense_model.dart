// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:app/models/group_model.dart';
import 'package:app/models/split_details_model.dart';
import 'package:app/models/userModel.dart';

/// ---------------- ENUMS ----------------

enum ExpenseType { personal, group }

extension ExpenseTypeExtension on ExpenseType {
  String toMap() => name;

  static ExpenseType fromMap(String? value) {
    return ExpenseType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ExpenseType.personal,
    );
  }
}

enum PersonalExpenseType { food, transportation, entertainment, other }

extension PersonalExpenseTypeExtension on PersonalExpenseType {
  String toMap() => name;

  static PersonalExpenseType? fromMap(String? value) {
    if (value == null) return null;

    return PersonalExpenseType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PersonalExpenseType.other,
    );
  }
}

/// ---------------- MODEL ----------------

class ExpenseModel {
  final String id;
  final String? group_id;
  final String created_by;
  final String paid_by;
  final String expense_name;
  final ExpenseType expense_type;
  final double amount;
  final String? description;
  final PersonalExpenseType? personal_expense_type;
  final DateTime created_at;
  final DateTime updated_at;
  final List<SplitDetail> splits;

  /// optional populated relations
  final UserModel? created_by_user;
  final UserModel? paid_by_user;
  final GroupModel? group;

  ExpenseModel({
    required this.id,
    this.group_id,
    required this.created_by,
    required this.paid_by,
    required this.expense_name,
    required this.expense_type,
    required this.amount,
    this.description,
    this.personal_expense_type,
    required this.created_at,
    required this.updated_at,
    required this.splits,
    this.created_by_user,
    this.paid_by_user,
    this.group,
  });

  /// ---------------- COPY ----------------

  ExpenseModel copyWith({
    String? id,
    String? group_id,
    String? created_by,
    String? paid_by,
    String? expense_name,
    ExpenseType? expense_type,
    double? amount,
    String? description,
    PersonalExpenseType? personal_expense_type,
    DateTime? created_at,
    DateTime? updated_at,
    List<SplitDetail>? splits,
    UserModel? created_by_user,
    UserModel? paid_by_user,
    GroupModel? group,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      group_id: group_id ?? this.group_id,
      created_by: created_by ?? this.created_by,
      paid_by: paid_by ?? this.paid_by,
      expense_name: expense_name ?? this.expense_name,
      expense_type: expense_type ?? this.expense_type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      personal_expense_type:
          personal_expense_type ?? this.personal_expense_type,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      splits: splits ?? this.splits,
      created_by_user: created_by_user ?? this.created_by_user,
      paid_by_user: paid_by_user ?? this.paid_by_user,
      group: group ?? this.group,
    );
  }

  /// ---------------- SERIALIZATION ----------------

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': group_id,
      'created_by': created_by,
      'paid_by': paid_by,
      'expense_name': expense_name,
      'expense_type': expense_type.toMap(),
      'amount': amount,
      'description': description,
      'personal_expense_type': personal_expense_type?.toMap(),
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
      'splits': splits.map((x) => x.toMap()).toList(),
      'created_by_user': created_by_user?.toMap(),
      'paid_by_user': paid_by_user?.toMap(),
      'group': group?.toMap(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      group_id: map['group_id'] as String?,
      created_by: map['created_by'] as String,
      paid_by: map['paid_by'] as String,
      expense_name: map['expense_name'] as String,
      expense_type: ExpenseTypeExtension.fromMap(
        map['expense_type'] as String?,
      ),
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String?,
      personal_expense_type: map['personal_expense_type'] != null
          ? PersonalExpenseTypeExtension.fromMap(
              map['personal_expense_type'] as String?,
            )
          : null,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      splits: map['splits'] != null
          ? List<SplitDetail>.from(
              (map['splits'] as List).map(
                (x) => SplitDetail.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      created_by_user: map['created_by_user'] != null
          ? UserModel.fromMap(map['created_by_user'] as Map<String, dynamic>)
          : null,
      paid_by_user: map['paid_by_user'] != null
          ? UserModel.fromMap(map['paid_by_user'] as Map<String, dynamic>)
          : null,
      group: map['group'] != null
          ? GroupModel.fromMap(map['group'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  /// ---------------- DEBUG ----------------

  @override
  String toString() {
    return 'ExpenseModel(id: $id, group_id: $group_id, created_by: $created_by, paid_by: $paid_by, expense_name: $expense_name, expense_type: $expense_type, amount: $amount)';
  }

  /// ---------------- EQUALITY ----------------

  @override
  bool operator ==(covariant ExpenseModel other) {
    if (identical(this, other)) return true;

    final listEquals = DeepCollectionEquality().equals;

    return other.id == id &&
        other.group_id == group_id &&
        other.created_by == created_by &&
        other.paid_by == paid_by &&
        other.expense_name == expense_name &&
        other.expense_type == expense_type &&
        other.amount == amount &&
        other.description == description &&
        other.personal_expense_type == personal_expense_type &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        listEquals(other.splits, splits) &&
        other.created_by_user == created_by_user &&
        other.paid_by_user == paid_by_user &&
        other.group == group;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      group_id,
      created_by,
      paid_by,
      expense_name,
      expense_type,
      amount,
      description,
      personal_expense_type,
      created_at,
      updated_at,
      splits,
      created_by_user,
      paid_by_user,
      group,
    );
  }
}
