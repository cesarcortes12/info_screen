import 'package:bloc/bloc.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/auto.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/car_order_service.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/repositories/car_management_repository_impl.dart';
import 'package:equatable/equatable.dart';

part 'car_management_state.dart';

class CarManagementCubit extends Cubit<CarManagementState> {
  final CarOrderServiceRepositoryimpl carOrderServiceRepositoryimpl;

  CarManagementCubit({
    required this.carOrderServiceRepositoryimpl,
  }) : super(CarManagementState()) {}

  Future<void> getWorkShop() async {
    try {
      emit(state.copyWith(loaded: LoadingStatus.checking));

      List<Auto> autos = [
        Auto(
            name: 'Taller 1',
            city: 'Cali',
            address: 'Cr56 # 56-56',
            phone: '312678809'),
        Auto(
          name: 'Taller 2',
          city: 'Medellín',
          address: 'Cr56 # 56-56',
          phone: '312678809',
        ),
        Auto(
          name: 'Taller 3',
          city: 'Bogota',
          address: 'Cr56 # 56-56',
          phone: '312678809',
        ),
        Auto(
          name: 'Taller 3',
          city: 'Bogota',
          address: 'Cr56 # 56-56',
          phone: '312678809',
        ),
        Auto(
          name: 'Taller 3',
          city: 'Bogota',
          address: 'Cr56 # 56-56',
          phone: '312678809',
        ),
        Auto(
          name: 'Taller 3',
          city: 'Bogota',
          address: 'Cr56 # 56-56',
          phone: '312678809',
        ),
        // Agrega más talleres según sea necesario
      ];
      //print('bodegas ${state.autos}');
      if (state.autos.isEmpty) {
        emit(state.copyWith(autos: autos));
      }
      emit(state.copyWith(loaded: LoadingStatus.success));
    } catch (e) {
      print('Error al obtener department en el evento LabelsEvent: $e');
    }
  }

  Future<void> getOrderCars(int idWorkShop) async {
    try {
      emit(state.copyWith(loaded: LoadingStatus.checking));

      List<CarOrderService> carsOrderService =
          await carOrderServiceRepositoryimpl.getCarsOrderService(idWorkShop);
      //print('bodegas ${state.autos}');
      if (state.carsOrderService.isEmpty) {
        emit(state.copyWith(carsOrderService: carsOrderService));
      }
      emit(state.copyWith(loaded: LoadingStatus.success));
    } catch (e) {
      print('Error al obtener department en el evento LabelsEvent: $e');
    }
  }
}
  //AuthStatus get authStatus => state.authStatus;


