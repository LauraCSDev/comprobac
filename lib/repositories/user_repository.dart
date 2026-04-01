import '../datasources/user_datasource.dart';
import '../models/user_model.dart';

/// Contrato para el repositorio de usuarios.
abstract class UserRepository {
  /// Obtiene la lista de usuarios.
  Future<List<User>> getUsers();

  /// Valida usuario y contraseña.
  Future<bool> validateUser(String username, String password);

  /// Valida usando código BAC de 6 dígitos.
  Future<bool> validateBacCode(String codigoBac);
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

  @override
  Future<bool> validateBacCode(String codigoBac) async {
    final users = await dataSource.getUsers();
    return users.any((u) => u.codigoBac == codigoBac);
  }
}
