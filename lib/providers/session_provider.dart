import 'package:flutter_riverpod/flutter_riverpod.dart';
// ...existing code...
import '../repositories/user_repository.dart';
import '../datasources/user_datasource.dart';

/// StateNotifier para manejar la sesión de usuario.
class SessionNotifier extends StateNotifier<bool> {
  final UserRepository userRepository;

  /// Crea un SessionNotifier con un [userRepository].
  SessionNotifier({required this.userRepository}) : super(false);

  /// Realiza login y actualiza el estado de sesión.
  Future<bool> login({required String username, required String password}) async {
    final isValid = await userRepository.validateUser(username, password);
    state = isValid;
    return isValid;
  }

  /// Cierra la sesión.
  void logout() {
    state = false;
  }
}

/// Proveedor de estado para la sesión de usuario.
final sessionProvider = StateNotifierProvider<SessionNotifier, bool>(
  (ref) => SessionNotifier(
    userRepository: UserRepositoryImpl(
      dataSource: LocalJsonUserDataSource(assetPath: 'assets/users.json'),
    ),
  ),
);
