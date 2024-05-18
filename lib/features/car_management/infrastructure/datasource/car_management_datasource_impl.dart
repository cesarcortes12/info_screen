import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pantalla_informativa/config/constants/enviroments.dart';
import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/car_order_service_mapper.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/response_back_mapper.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/user_mapper.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/info_screen.dart';
import 'package:pantalla_informativa/features/car_management/share/info_order_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CarOrderServiceDatasourceimpl extends CarManagementDatasource {
  final client = http.Client();

  @override
  Future<List<CarOrderService>> getCarsOrderService(int idWorkShop) async {
    final wareHousesMapper =
        await ResponseBackMapper.responseBackJsonToEntity<CarOrderService>(
            res, (json) => CarOrderServiceMapper.carOrderServiceToEntity(json));

    final List<CarOrderService> wareHouses = wareHousesMapper.data.toList();

    return wareHouses;
  }

  @override
  Future<User> login(String bussines, String nameUser, String password) async {
    try {
      final logindata = {
        'codigoEmpresa': bussines,
        'usuario': nameUser,
        'clave': password
      };
      
      final response = await client.post(headers: {
        'Content-Type': 'application/json',
      }, Uri.parse('${Environment.apiUrl}/Auth'), body: jsonEncode(logindata));
      final responseJson = json.decode(response.body);
      if (responseJson['data'] == null) {
        throw CustomError(responseJson['message']);
      }
      final User? user = UserMapper.userJsonToEntity(responseJson);

      return user!;
    } catch (e) {
      throw Exception(' $e');
    }
  }
}
