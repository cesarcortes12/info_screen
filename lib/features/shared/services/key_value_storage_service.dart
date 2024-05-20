import 'package:pantalla_informativa/features/car_management/domain/entities/user.dart';

abstract class KeyValueStorageService {
  Future<void> saveToken(String key);
  Future<String?> loadToken();
  Future<bool> removeKey(String key);
  Future<T?> getValue<T>(String key);
  Future<void> saveUser(User? user);
}
