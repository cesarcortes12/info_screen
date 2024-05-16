part of 'car_management_cubit.dart';

enum LoadingStatus { initial, checking, success }

class CarManagementState {
  final List<Auto> autos;
  final List<CarOrderService> carsOrderService;
  final LoadingStatus? loaded;

  CarManagementState({
    this.autos = const [],
    this.carsOrderService = const [],
    this.loaded = LoadingStatus.initial,
  });

  CarManagementState copyWith({
    List<Auto>? autos,
    List<CarOrderService>? carsOrderService,
    LoadingStatus? loaded,
  }) =>
      CarManagementState(
        autos: autos ?? this.autos,
        carsOrderService: carsOrderService ?? this.carsOrderService,
        loaded: loaded ?? this.loaded,
      );
}
