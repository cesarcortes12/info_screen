import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/warehouse.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/infrastructure.dart';

class CarOrderServiceRepositoryimpl extends CarManagementRepository {
  final CarManagementDatasource carOrderdatasource;

  CarOrderServiceRepositoryimpl({CarManagementDatasource? carOrderdatasource})
      : carOrderdatasource =
            carOrderdatasource ?? CarOrderServiceDatasourceimpl();

  @override
  Future<dynamic> getCarsOrderService(int idWarehouse) {
    return carOrderdatasource.getCarsOrderService(idWarehouse);
  }

  @override
  Future<User> login(String bussines, String nameUser, String password) {
    return carOrderdatasource.login(bussines, nameUser, password);
  }

  @override
  Future<List<Warehouse>> getWarehouses(bool allWarehouses) {
    return carOrderdatasource.getWarehouses(allWarehouses);
  }
}
