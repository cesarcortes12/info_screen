import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pantalla_informativa/config/constants/enviroments.dart';
import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/warehouse.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/car_order_service_mapper.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/response_back_mapper.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/user_mapper.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/warehouse_mapper.dart';
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
      //  final tokenObject =
      //     await keyValueStorageService.getValue<String>('token');
      final tokenObject =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZEVtcHJlc2EiOiJVdUl2Y0Jqai8vVnRtZ25JVFdlWXpOWEZrdFlHYWpiOWNaYmZBMFpSUWhxTDIzcFM0SmJHb0lUZGlHUHhMcWxZT1dtVDRqRnZFQ3ZlYTk2enBOandIc2JxWktIM3JnU2trbjBTVHpjSHpkWXUrSEhLYW95NDVHUHMvMy9YckNFdEc2dHJxbWhMZVgrRFBzcU5OYWhFSG9MUDIrL08wNjlHTTRESU9vMGptODh3ZzVDeFQ3Z2RUNXZmMHVDT2w4NExJMDE0cUVmM3pHaURiK2k0cHJLNTFJMmsxaDRYUk5oNmg5U0ZIZHZVRldJVFBTN1pOYkY3NU1RVHNta2ptdllPKzVobXhQQjZwVFdZS05XU0lkRWVGZDlzNGtGTHlRNGp0M1QzVWVTRjJ6M3lQdUZlNTRtbnB1RFozbVhMU0Y3YTZoTSsraHVPM2tZeUE0YmF3a01acVE9PSIsIklkVXN1YXJpbyI6IlNiMGJLNlRIeCt1MXJXMzN3U1Iyd2hlTzVmVlRLODFzVzFsUUt0SHRKamVpZkdMUlpQVmkyQnpxdTE1RU1tY0hTcjd2aEJ1RWw3b2RRN09TT1NNeVVEZkhITXRZbGhrT2VneXhPS2sxV0NpRjBJMDA5MEt4ejBsMU0xdzNJN2tGRjNLVzIwWFIyeldqSzVYaWdpWTJDLzFUNE1CL01URkp3ZnVldHk1VkxHUXhnQVNrK3BSbDJkUmpkK1djK0VNcTlZY1dyY0t6RkNZaGxrRzVqdEoxSTVhWXB6TEg3Uk5vZndFZHk2VnIrK212bFJpWlpUTzRQZVdQejMwczhxTW01REE3TGZZRUgzOG8zRTAzQ0NRd3hISmZ1MVArdThxblAzQ3dpelNkY2thR1JTUUh4YWxpZk44VlRUR0RmT0ludHhnb3JrUk43RlNXTzBweTI3T2NuUT09IiwiU1MiOiIzNWI3ODVkOC03ZjIwLTQ1ODMtOTM3ZC1lZGJiOTJmNGU4MmIiLCJMTCI6IkU0RTc1NEIyRjY4ODM0QUIiLCJuYmYiOjE3MTYyMTExNDEsImV4cCI6MTcxNjIzOTk0MSwiaWF0IjoxNzE2MjExMTQxfQ.5TOGOxjySJrNgv2__HHjql4Eo-hb0Ov5VpLFhSKsJVk';

      //final Map<String,dynamic> tokenMap = jsonDecode(tokenObject!);

      //String token = tokenMap['token'];

      final response = await client.get(
        Uri.parse(
            '${Environment.apiUrl}/Bodegas?soloPermitidas=${allWarehouses}'),
        headers: {
          'Authorization': 'Bearer ${tokenObject}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = await jsonDecode(response.body);

        final wareHouseMapper =
            await ResponseBackMapper.responseBackJsonToEntity<Warehouse>(
                jsonResponse,
                (json) => WarehouseMapper.warehouseJsonToEntity(json));

        final List<Warehouse> warehouses = wareHouseMapper.data.toList();
        return warehouses;
      } else if (response.statusCode == 401) {
        throw Exception('error 401');
      } else{
        throw Exception('error');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }
}
