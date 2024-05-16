import 'package:pantalla_informativa/features/car_management/domain/domain.dart';

abstract class CarManagementDatasource {
  Future<List<CarOrderService>> getCarsOrderService(int idWorkShop);
}
