// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/models/group_model.dart';
import 'package:app/models/userModel.dart';

class SettlementModel {
  final String id;
  final String group_id;
  final String from_user_id;
  final String to_user_id;
  final double amount;
  final String created_by;
  final DateTime created_at;
  final UserModel? from_user;
  final UserModel? to_user;
  final UserModel? created_by_user;
  final GroupModel? group;
  SettlementModel({
    required this.id,
    required this.group_id,
    required this.from_user_id,
    required this.to_user_id,
    required this.amount,
    required this.created_by,
    required this.created_at,
    this.from_user,
    this.to_user,
    this.created_by_user,
    this.group,
  });

  SettlementModel copyWith({
    String? id,
    String? group_id,
    String? from_user_id,
    String? to_user_id,
    double? amount,
    String? created_by,
    DateTime? created_at,
    UserModel? from_user,
    UserModel? to_user,
    UserModel? created_by_user,
    GroupModel? group,
  }) {
    return SettlementModel(
      id: id ?? this.id,
      group_id: group_id ?? this.group_id,
      from_user_id: from_user_id ?? this.from_user_id,
      to_user_id: to_user_id ?? this.to_user_id,
      amount: amount ?? this.amount,
      created_by: created_by ?? this.created_by,
      created_at: created_at ?? this.created_at,
      from_user: from_user ?? this.from_user,
      to_user: to_user ?? this.to_user,
      created_by_user: created_by_user ?? this.created_by_user,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'group_id': group_id,
      'from_user_id': from_user_id,
      'to_user_id': to_user_id,
      'amount': amount,
      'created_by': created_by,
      'created_at': created_at.millisecondsSinceEpoch,
      'from_user': from_user?.toMap(),
      'to_user': to_user?.toMap(),
      'created_by_user': created_by_user?.toMap(),
      'group': group?.toMap(),
    };
  }

  factory SettlementModel.fromMap(Map<String, dynamic> map) {
    return SettlementModel(
      id: map['id'] as String,
      group_id: map['group_id'] as String,
      from_user_id: map['from_user_id'] as String,
      to_user_id: map['to_user_id'] as String,
      amount: map['amount'] as double,
      created_by: map['created_by'] as String,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      from_user: map['from_user'] != null
          ? UserModel.fromMap(map['from_user'] as Map<String, dynamic>)
          : null,
      to_user: map['to_user'] != null
          ? UserModel.fromMap(map['to_user'] as Map<String, dynamic>)
          : null,
      created_by_user: map['created_by_user'] != null
          ? UserModel.fromMap(map['created_by_user'] as Map<String, dynamic>)
          : null,
      group: map['group'] != null
          ? GroupModel.fromMap(map['group'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettlementModel.fromJson(String source) =>
      SettlementModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SettlementModel(id: $id, group_id: $group_id, from_user_id: $from_user_id, to_user_id: $to_user_id, amount: $amount, created_by: $created_by, created_at: $created_at, from_user: $from_user, to_user: $to_user, created_by_user: $created_by_user, group: $group)';
  }

  @override
  bool operator ==(covariant SettlementModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.group_id == group_id &&
        other.from_user_id == from_user_id &&
        other.to_user_id == to_user_id &&
        other.amount == amount &&
        other.created_by == created_by &&
        other.created_at == created_at &&
        other.from_user == from_user &&
        other.to_user == to_user &&
        other.created_by_user == created_by_user &&
        other.group == group;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        group_id.hashCode ^
        from_user_id.hashCode ^
        to_user_id.hashCode ^
        amount.hashCode ^
        created_by.hashCode ^
        created_at.hashCode ^
        from_user.hashCode ^
        to_user.hashCode ^
        created_by_user.hashCode ^
        group.hashCode;
  }
}
