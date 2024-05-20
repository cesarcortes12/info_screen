import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/warehouse.dart';

abstract class CarManagementRepository {
  Future<List<CarOrderService>> getCarsOrderService(int idWorkShop);
  Future<User> login(String bussines, String nameUser, String password);
  Future<List<Warehouse>> getWarehouses(bool allWarehouses);
}
