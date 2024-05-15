import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/infrastructure.dart';

class CarOrderServiceRepositoryimpl extends CarOrderServiceRepository {
  final CarOrderServiceDatasource carOrderdatasource;

  CarOrderServiceRepositoryimpl({CarOrderServiceDatasource? carOrderdatasource})
      : carOrderdatasource =
            carOrderdatasource ?? CarOrderServiceDatasourceimpl();

  @override
  Future<List<CarOrderService>> getCarOrderService(
      int userId, int idWarehouse) {
    throw UnimplementedError();
  }
}
