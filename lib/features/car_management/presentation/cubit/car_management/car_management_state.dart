part of 'car_management_cubit.dart';

enum LoadingStatus { initial, checking, success }

class CarManagementState /*extends Equatable*/ {
  final List<Warehouse> allWarehouses;
  final dynamic carsOrderService;
  final Map<String, dynamic> citas;
  final LoadingStatus? loaded;
  final LoadingStatus? loadedInfo;

  final Warehouse? warehouse;

  CarManagementState({
    this.citas = const {'orders': [], 'nextDelivery': []},
    this.allWarehouses = const [],
    this.carsOrderService,
    this.loaded = LoadingStatus.initial,
    this.loadedInfo = LoadingStatus.initial,
    this.warehouse,
  });

  CarManagementState copyWith({
    Map<String, dynamic>? citas,
    List<Warehouse>? allWarehouses,
    dynamic carsOrderService,
    LoadingStatus? loaded,
    LoadingStatus? loadedInfo,
    Warehouse? warehouse,
  }) =>
      CarManagementState(
        citas: citas ?? this.citas,
        allWarehouses: allWarehouses ?? this.allWarehouses,
        carsOrderService: carsOrderService ?? this.carsOrderService,
        loaded: loaded ?? this.loaded,
        loadedInfo: loadedInfo ?? this.loadedInfo,
        warehouse: warehouse ?? this.warehouse,
      );

  //@override
  //List<Object?> get props => [autos, carsOrderService, loaded];
}
