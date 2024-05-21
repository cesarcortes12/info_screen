import 'package:pantalla_informativa/features/car_management/domain/domain.dart';

class CarOrderServiceMapper {
  static CarOrderService carOrderServiceToEntity(Map<String, dynamic> json) =>
      CarOrderService(
        id: json['id'] ?? 0,
        licensePlate: json['placa'] ?? 'sin placa',
        name: json['cliente'] ?? 'sin nombre',
        assignedTo: json['vendedor'] ?? 'sin mecanico',
        deliveryTime: json['fechaEstimada'] ?? '',
        status: json['estado'] ?? 'sin estado',
        modelo: json['modelo'] ?? 'sin modelo',
      );
}
