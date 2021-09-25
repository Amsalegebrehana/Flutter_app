class UserStore {
  final String role;
  final String token;
  final String id;

  UserStore({required this.role, required this.token, required this.id});

  factory UserStore.fromJson(Map<String, dynamic> json) {
    return UserStore(role: json['role'], token: json['token'], id: json['id']);
  }
}
