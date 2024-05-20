

import 'package:pantalla_informativa/features/car_management/domain/entities/warehouse.dart';

class WarehouseMapper {

  static Warehouse warehouseJsonToEntity(Map<String, dynamic> json) =>
      Warehouse(     
          id: json['id'] ?? 0,
          name: json['descripcion'] ?? 'sin descripcion',
          address: json['direccion'] ?? 'sin direccion',
          phone: json['telefonos'] ?? 'sin telefono',
          city: json['ciudad'] ?? 'sin ciudad',
          idCity: json['idCiudad'] ?? 0,
          department: json['departamento'] ?? 'sin departamento',
          idDepartment: json['idDepartamento'] ?? 0,

      );
}