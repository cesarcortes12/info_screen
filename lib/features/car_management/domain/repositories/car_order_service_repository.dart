



import 'package:pantalla_informativa/features/car_management/domain/domain.dart';

abstract class CarOrderServiceRepository {
  Future<List<CarOrderService>> getCarOrderService(int userId, int idWarehouse);
}

