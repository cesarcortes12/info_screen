import 'package:pantalla_informativa/features/car_management/domain/domain.dart';

abstract class CarManagementDatasource {
  Future<dynamic> getCarsOrderService(int idWorkShop);
  Future<User> login(String bussines, String nameUser, String password);
  Future<List<Warehouse>> getWarehouses(bool allWarehouses);
}
