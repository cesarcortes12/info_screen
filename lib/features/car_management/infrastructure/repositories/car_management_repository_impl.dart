import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/infrastructure.dart';

class CarOrderServiceRepositoryimpl extends CarManagementRepository {
  final CarManagementDatasource carOrderdatasource;

  CarOrderServiceRepositoryimpl({CarManagementDatasource? carOrderdatasource})
      : carOrderdatasource =
            carOrderdatasource ?? CarOrderServiceDatasourceimpl();

  @override
  Future<List<CarOrderService>> getCarsOrderService(int idWarehouse) {
    return carOrderdatasource.getCarsOrderService(idWarehouse);
  }
}
