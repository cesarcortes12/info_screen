import 'package:bloc/bloc.dart';
import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/infrastructure.dart';

part 'car_management_state.dart';

class CarManagementCubit extends Cubit<CarManagementState> {
  final CarOrderServiceRepositoryimpl carOrderServiceRepositoryimpl;

  CarManagementCubit({
    required this.carOrderServiceRepositoryimpl,
  }) : super(CarManagementState());

  Future<void> getWarehouses(bool allWarehouses) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      emit(state.copyWith(loaded: LoadingStatus.checking));

      List<Warehouse> warehouses =
          await carOrderServiceRepositoryimpl.getWarehouses(allWarehouses);

      if (state.allWarehouses.isEmpty) {
        emit(state.copyWith(allWarehouses: warehouses));
      }
      emit(state.copyWith(loaded: LoadingStatus.initial));
    } catch (e) {
      print('error al obtener las bodegas error: $e');
    }
  }

  Future<void> getOrderCars(int idWorkShop) async {
    try {
      emit(state.copyWith(loadedInfo: LoadingStatus.checking));

      dynamic carsOrderService =
          await carOrderServiceRepositoryimpl.getCarsOrderService(idWorkShop);

      emit(state.copyWith(citas: carsOrderService));
      emit(state.copyWith(loadedInfo: LoadingStatus.success));
    } catch (e) {
      print('Error al obtener department en el evento LabelsEvent: $e');
    }
  }

  saveWarehouse(Warehouse warehouse) {
    emit(state.copyWith(warehouse: warehouse));
  }

  resetCubit() {
    emit(state.copyWith(
      citas: {'orders': [], 'nextDelivery': []},
      loaded: LoadingStatus.initial,
      warehouse: null,
    ));
  }
}
  //AuthStatus get authStatus => state.authStatus;


