import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/auto.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/user.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/workshop_list_screen.dart';

part 'car_management_state.dart';

class CarManagementCubit extends Cubit<CarManagementState> {
  CarManagementCubit() : super(CarManagementState()) {}

  Future<void> getAutos() async {
    try {
      emit(state.copyWith(loaded: LoadingStatus.initial));

      List<Auto> autos = [
        Auto(name: 'Taller 1', position: 'Posición 1'),
        Auto(name: 'Taller 2', position: 'Posición 2'),
        Auto(name: 'Taller 3', position: 'Posición 3'),
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
}
  //AuthStatus get authStatus => state.authStatus;


