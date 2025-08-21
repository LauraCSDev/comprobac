import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

/// Contrato para fuente de datos de usuarios.
abstract class UserDataSource {
  /// Obtiene la lista de usuarios.
  Future<List<User>> getUsers();
}

/// Fuente de datos local que lee usuarios desde un archivo JSON de assets.
class LocalJsonUserDataSource implements UserDataSource {
  final String assetPath;

  /// Crea un datasource local con el [assetPath] del JSON.
  LocalJsonUserDataSource({required this.assetPath});

  @override
  Future<List<User>> getUsers() async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => User.fromJson(e)).toList();
  }
}
