import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pantalla_informativa/config/constants/enviroments.dart';
import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/infrastructure.dart';
import 'package:pantalla_informativa/features/car_management/presentation/presentation.dart';
import 'package:pantalla_informativa/features/shared/services/key_value_storage_service_impl.dart';

class CarOrderServiceDatasourceimpl extends CarManagementDatasource {
  final client = http.Client();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  @override
  Future<dynamic> getCarsOrderService(int idWarehouse) async {
    try {
      final tokenObject =
          await keyValueStorageService.getValue<String>('token');

      final Map<String, dynamic> tokenMap = jsonDecode(tokenObject!);

      String token = tokenMap['token'];

      final response = await client.get(
        Uri.parse('${Environment.apiUrl}/CitasTaller/$idWarehouse'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = await jsonDecode(response.body);

        final wareHousesMapper =
            ResponseBackMapper.responseBackJsonToEntity<CarOrderService>(
                jsonResponse,
                (json) => CarOrderServiceMapper.carOrderServiceToEntity(json));

        final dynamic wareHouses = wareHousesMapper.data;

        return wareHouses;
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  @override
  Future<User> login(String bussines, String nameUser, String password) async {
    try {
      final response = await client.post(
          headers: {
            'Content-Type': 'application/json',
          },
          Uri.parse('${Environment.apiUrl}/Auth'),
          body: jsonEncode({
            'codigoEmpresa': bussines,
            'usuario': nameUser,
            'clave': password
          }));
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

  @override
  Future<List<Warehouse>> getWarehouses(bool allWarehouses) async {
    try {
      final tokenObject =
          await keyValueStorageService.getValue<String>('token');

      final Map<String, dynamic> tokenMap = jsonDecode(tokenObject!);

      String token = tokenMap['token'];

      final response = await client.get(
        Uri.parse(
            '${Environment.apiUrl}/Bodegas?soloPermitidas=$allWarehouses'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = await jsonDecode(response.body);

        final wareHouseMapper =
            ResponseBackMapper.responseBackJsonToEntity<Warehouse>(jsonResponse,
                (json) => WarehouseMapper.warehouseJsonToEntity(json));

        final List<Warehouse> warehouses = wareHouseMapper.data.toList();
        return warehouses;
      } else if (response.statusCode == 401) {
        throw Exception('error 401');
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }
}
