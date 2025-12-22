class User {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;
  final String email;

  User({required this.id, required this.name, required this.role, required this.avatarUrl, required this.email });

  User copyWith({String? id, String? name, String? role, String? avatarUrl, String? email}) =>
      User(
          id: id ?? this.id,
          name: name ?? this.name,
          role: role ?? this.role,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          email: email ?? this.email
      );
}