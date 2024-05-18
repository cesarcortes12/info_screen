import 'package:pantalla_informativa/features/car_management/domain/entities/user.dart';

class UserMapper {
  static User? userJsonToEntity(Map<String, dynamic> jsonResponse) {
    Map<String, dynamic> data = jsonResponse['data'];
    return User(
      name: data["nombre"] ?? "",
      position: data["cargo"] ?? "",
      email: data["email"] ?? "",
      document: data["documento"] ?? "",
      phone: data["telefono"] ?? "",
      image: data["imagen"] ?? "",
      token: data["token"] ?? "",
    );
  }
}
