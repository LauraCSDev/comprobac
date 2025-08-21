/// Modelo de usuario para autenticación.
class User {
  final String username;
  final String password;

  /// Crea un usuario con [username] y [password].
  const User({required this.username, required this.password});

  /// Crea un usuario a partir de un JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}
