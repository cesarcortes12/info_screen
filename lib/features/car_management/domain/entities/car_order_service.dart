class CarOrderService {
  final int id;
  final String licensePlate;
  final String name;
  final String assignedTo;
  final DateTime deliveryTime;


  CarOrderService({
    required this.id, 
    required this.licensePlate,
    required this.name,
    required this.assignedTo,
    required this.deliveryTime,
  });

}


