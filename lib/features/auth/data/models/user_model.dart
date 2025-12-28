import 'package:recipe_finder_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.id, required super.name, required super.role, required super.avatarUrl, required super.email});

  UserEntity copyWith({String? id, String? name, String? role, String? avatarUrl, String? email}) =>
      UserModel(
          id: id ?? this.id,
          name: name ?? this.name,
          role: role ?? this.role,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          email: email ?? this.email
      );

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'] as String,
        name: json['username'] as String,
        role: json['role'] as String,
        avatarUrl: json['avatar_url'] ?? '',
        email: json['email'] as String
    );
  }
}