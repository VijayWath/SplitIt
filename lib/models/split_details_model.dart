// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:app/models/expense_model.dart';
import 'package:app/models/userModel.dart';

/// ---------------- ENUM ----------------

enum SplitType { equal, percentage, share }

extension SplitTypeExtension on SplitType {
  String toMap() => name;

  static SplitType fromMap(String? value) {
    return SplitType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SplitType.equal,
    );
  }
}

/// ---------------- MODEL ----------------

class SplitDetail {
  final String? id; // ✅ nullable
  final String expense_id;
  final String user_id;
  final double share;
  final double value;
  final SplitType split_type;

  /// optional relations
  final ExpenseModel? expense;
  final UserModel? user;

  SplitDetail({
    this.id, // ✅ not required
    required this.expense_id,
    required this.user_id,
    required this.share,
    required this.value,
    required this.split_type,
    this.expense,
    this.user,
  });

  /// ---------------- COPY ----------------

  SplitDetail copyWith({
    String? id,
    String? expense_id,
    String? user_id,
    double? share,
    double? value,
    SplitType? split_type,
    ExpenseModel? expense,
    UserModel? user,
  }) {
    return SplitDetail(
      id: id ?? this.id,
      expense_id: expense_id ?? this.expense_id,
      user_id: user_id ?? this.user_id,
      share: share ?? this.share,
      value: value ?? this.value,
      split_type: split_type ?? this.split_type,
      expense: expense ?? this.expense,
      user: user ?? this.user,
    );
  }

  /// ---------------- SERIALIZATION ----------------

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // ✅ critical (same as ExpenseModel)
      'expense_id': expense_id,
      'user_id': user_id,
      'share': share,
      'value': value,
      'split_type': split_type.toMap(),
      'expense': expense?.toMap(),
      'user': user?.toMap(),
    };
  }

  factory SplitDetail.fromMap(Map<String, dynamic> map) {
    return SplitDetail(
      id: map['id'] as String?, // ✅ nullable parse
      expense_id: map['expense_id'] as String,
      user_id: map['user_id'] as String,
      share: (map['share'] as num).toDouble(),
      value: (map['value'] as num).toDouble(),
      split_type: SplitTypeExtension.fromMap(map['split_type'] as String?),
      expense: map['expense'] != null
          ? ExpenseModel.fromMap(map['expense'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SplitDetail.fromJson(String source) =>
      SplitDetail.fromMap(json.decode(source));

  /// ---------------- DEBUG ----------------

  @override
  String toString() {
    return 'SplitDetail(id: $id, user_id: $user_id, value: $value, split_type: $split_type)';
  }

  /// ---------------- EQUALITY ----------------

  @override
  bool operator ==(covariant SplitDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.expense_id == expense_id &&
        other.user_id == user_id &&
        other.share == share &&
        other.value == value &&
        other.split_type == split_type &&
        other.expense == expense &&
        other.user == user;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      expense_id,
      user_id,
      share,
      value,
      split_type,
      expense,
      user,
    );
  }
}
