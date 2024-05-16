import 'dart:convert';

import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/car_order_service_mapper.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/response_back_mapper.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/info_screen.dart';
import 'package:pantalla_informativa/features/car_management/share/info_order_service.dart';

class CarOrderServiceDatasourceimpl extends CarManagementDatasource {
  @override
  Future<List<CarOrderService>> getCarsOrderService(int idWorkShop) async {
    final wareHousesMapper =
        await ResponseBackMapper.responseBackJsonToEntity<CarOrderService>(
            res, (json) => CarOrderServiceMapper.carOrderServiceToEntity(json));

    final List<CarOrderService> wareHouses = wareHousesMapper.data.toList();

    return wareHouses;
  }
}
