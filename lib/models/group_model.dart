// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:app/models/group_member_model.dart';

class GroupModel {
  final String id;
  final String name;
  final String? description;
  final String created_by;
  final DateTime created_at;
  final DateTime updated_at;
  final String? group_image_url;
  final List<GroupMemberModel>? group_members;
  GroupModel({
    required this.id,
    required this.name,
    this.description,
    required this.created_by,
    required this.created_at,
    required this.updated_at,
    this.group_image_url,
    this.group_members,
  });

  GroupModel copyWith({
    String? id,
    String? name,
    String? description,
    String? created_by,
    DateTime? created_at,
    DateTime? updated_at,
    String? group_image_url,
    List<GroupMemberModel>? group_members,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      created_by: created_by ?? this.created_by,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      group_image_url: group_image_url ?? this.group_image_url,
      group_members: group_members ?? this.group_members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'created_by': created_by,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
      'group_image_url': group_image_url,
      'group_members': group_members?.map((x) => x.toMap()).toList(),
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      created_by: map['created_by'] as String,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      group_image_url: map['group_image_url'] != null
          ? map['group_image_url'] as String
          : null,
      group_members: map['group_members'] != null
          ? List<GroupMemberModel>.from(
              (map['group_members'] as List<int>).map<GroupMemberModel?>(
                (x) => GroupMemberModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupModel(id: $id, name: $name, description: $description, created_by: $created_by, created_at: $created_at, updated_at: $updated_at, group_image_url: $group_image_url, group_members: $group_members)';
  }

  @override
  bool operator ==(covariant GroupModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.created_by == created_by &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.group_image_url == group_image_url &&
        listEquals(other.group_members, group_members);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        created_by.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        group_image_url.hashCode ^
        group_members.hashCode;
  }
}
