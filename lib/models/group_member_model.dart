// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/models/group_model.dart';
import 'package:app/models/userModel.dart';

class GroupMemberModel {
  final String id;
  final String group_id;
  final String user_id;
  final GroupModel? group;
  final UserModel? user;
  GroupMemberModel({
    required this.id,
    required this.group_id,
    required this.user_id,
    this.group,
    this.user,
  });

  GroupMemberModel copyWith({
    String? id,
    String? group_id,
    String? user_id,
    GroupModel? group,
    UserModel? user,
  }) {
    return GroupMemberModel(
      id: id ?? this.id,
      group_id: group_id ?? this.group_id,
      user_id: user_id ?? this.user_id,
      group: group ?? this.group,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'group_id': group_id,
      'user_id': user_id,
      'group': group?.toMap(),
      'user': user?.toMap(),
    };
  }

  factory GroupMemberModel.fromMap(Map<String, dynamic> map) {
    return GroupMemberModel(
      id: map['id'] as String,
      group_id: map['group_id'] as String,
      user_id: map['user_id'] as String,
      group: map['group'] != null
          ? GroupModel.fromMap(map['group'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupMemberModel.fromJson(String source) =>
      GroupMemberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupMemberModel(id: $id, group_id: $group_id, user_id: $user_id, group: $group, user: $user)';
  }

  @override
  bool operator ==(covariant GroupMemberModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.group_id == group_id &&
        other.user_id == user_id &&
        other.group == group &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        group_id.hashCode ^
        user_id.hashCode ^
        group.hashCode ^
        user.hashCode;
  }
}
