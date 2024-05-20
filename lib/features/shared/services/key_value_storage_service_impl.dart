import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/user.dart';
import 'package:pantalla_informativa/features/shared/services/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    WidgetsFlutterBinding
        .ensureInitialized(); // Asegura que Flutter esté inicializado
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveToken(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Decodificar el token JWT y obtener el claim 'exp'
    Map<String, dynamic> decodedToken = JwtDecoder.decode(key);
    int expirationTimestamp = decodedToken['exp'];

    Map<String, dynamic> payload = Jwt.parseJwt(key);

    // Guardar el token y la información de expiración en SharedPreferences
    Map<String, dynamic> tokenData = {
      'token': key,
      'idUser': payload['idUsuario'],
      'expirationDate': expirationTimestamp,
    };
    String tokenJson = json.encode(tokenData);
    prefs.setString('token', tokenJson);
    prefs.setString('idUser', tokenJson);
  }

  @override
  Future<String?> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenJson = prefs.getString('token');
    if (tokenJson != null) {
      Map<String, dynamic> tokenData = json.decode(tokenJson);

      if (isValidToken(tokenData)) {
        return tokenData['token'];
      } else {
        // Token no válido, puedes manejar esto según tus necesidades
        removeKey('token');
        removeKey('idUser');
        return null;
      }
    }

    return null; // No hay token almacenado
  }

  bool isValidToken(Map<String, dynamic> tokenData) {
    // Verifica si existe el claim 'expirationDate'
    if (tokenData.containsKey('expirationDate')) {
      int expirationTimestamp = tokenData['expirationDate'];
      DateTime expirationDate =
          DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);

      // Verifica si el token está dentro del periodo de validez
      return expirationDate.isAfter(DateTime.now());
    }

    // Si falta el claim 'expirationDate', considera el token como no válido
    return false;
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> saveUser(User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user != null) {
      String userJson = json.encode(user.toJson());
      prefs.setString('user', userJson);
    }
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case const (int):
        return prefs.getInt(key) as T?;

      case const (String):
        return prefs.getString(key) as T?;
      case const (dynamic):
        return prefs.getString(key) as T?;

      default:
        throw UnimplementedError(
            'GET not implemented for type ${T.runtimeType}');
    }
  }
}
