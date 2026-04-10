import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String profile_picture_url;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profile_picture_url,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profile_picture_url,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profile_picture_url: profile_picture_url ?? this.profile_picture_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profile_picture_url': profile_picture_url,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profile_picture_url: map['profile_picture_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, profile_picture_url: $profile_picture_url)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profile_picture_url == profile_picture_url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profile_picture_url.hashCode;
  }
}
