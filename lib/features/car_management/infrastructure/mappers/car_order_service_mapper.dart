import 'package:pantalla_informativa/features/car_management/domain/domain.dart';

class CarOrderServiceMapper {
  static CarOrderService carOrderServiceToEntity(Map<String, dynamic> json) =>
      CarOrderService(
        id: json['id'] ?? 0,
        licensePlate: json['placa'] ?? 'sin placa',
        name: json['nombre'] ?? 'sin nombre',
        assignedTo: json['asignado_a'] ?? 'sin mecanico',
        deliveryTime: json['hora_entrega'] ?? DateTime.now(),
        status: json['estado'] ?? 'sin estado',
      );
}
