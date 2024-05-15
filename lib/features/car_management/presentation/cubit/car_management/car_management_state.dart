part of 'car_management_cubit.dart';

enum LoadingStatus { initial, checking, success }

class CarManagementState {
  final List<Auto> autos;
  final LoadingStatus? loaded;

  CarManagementState({
    this.autos = const [],
    this.loaded = LoadingStatus.initial,
  });

  CarManagementState copyWith({
    List<Auto>? autos,
    LoadingStatus? loaded,
  }) =>
      CarManagementState(
        autos: autos ?? this.autos,
        loaded: loaded ?? this.loaded,
      );
}
