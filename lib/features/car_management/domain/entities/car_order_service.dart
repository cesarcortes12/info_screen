class CarOrderService {
  final int id;
  final String licensePlate;
  final String name;
  final String assignedTo;
  final String deliveryTime;
  final String status;
  final String modelo;
  final String line;
  final String brand;

  CarOrderService({
    required this.id,
    required this.licensePlate,
    required this.name,
    required this.assignedTo,
    required this.deliveryTime,
    required this.status,
    required this.modelo,
    required this.line,
    required this.brand,
  });
}
