part of 'car_management_cubit.dart';

enum LoadingStatus { initial, checking, success }

class CarManagementState /*extends Equatable*/ {
  final List<Warehouse> allWarehouses;
  final List<CarOrderService> carsOrderService;
  final LoadingStatus? loaded;

  CarManagementState( {
    this.allWarehouses = const [],
    this.carsOrderService = const [],
    this.loaded = LoadingStatus.initial,
    
  });

  CarManagementState copyWith({
    List<Warehouse>? allWarehouses,
    List<CarOrderService>? carsOrderService,
    LoadingStatus? loaded,
  }) =>
      CarManagementState(
        allWarehouses: allWarehouses ?? this.allWarehouses,
        carsOrderService: carsOrderService ?? this.carsOrderService,
        loaded: loaded ?? this.loaded,
      );

  //@override
  //List<Object?> get props => [autos, carsOrderService, loaded];
}
