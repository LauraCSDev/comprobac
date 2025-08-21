import '../models/user_model.dart';
import '../datasources/user_datasource.dart';

/// Contrato para el repositorio de usuarios.
abstract class UserRepository {
  /// Obtiene la lista de usuarios.
  Future<List<User>> getUsers();

  /// Valida usuario y contraseña.
  Future<bool> validateUser(String username, String password);
}

/// Implementación de [UserRepository] usando un [UserDataSource].
class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  /// Crea un repositorio de usuarios con un [dataSource].
  UserRepositoryImpl({required this.dataSource});

  @override
  Future<List<User>> getUsers() {
    return dataSource.getUsers();
  }

  @override
  Future<bool> validateUser(String username, String password) async {
    final users = await dataSource.getUsers();
    return users.any((u) => u.username == username && u.password == password);
  }
}
