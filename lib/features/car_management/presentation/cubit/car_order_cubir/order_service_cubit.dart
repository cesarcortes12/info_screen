import 'package:bloc/bloc.dart';
import 'package:pantalla_informativa/features/car_management/domain/domain.dart';

part 'order_service_state.dart';

class OrderServiceCubit extends Cubit<OrderServiceState> {
  final CarOrderServiceRepository carOrderServiceRepositoryompl;

  OrderServiceCubit({
    required this.carOrderServiceRepositoryompl,
  }) : super(OrderServiceState());
}


