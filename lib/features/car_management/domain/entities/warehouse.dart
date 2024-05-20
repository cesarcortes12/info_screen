class Warehouse {
  int id;
  String name;
  String address;
  String phone;
  String? city;
  int? idCity;
  String? department;
  int? idDepartment;

  Warehouse({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.city,
    required this.idCity,
    required this.department,
    required this.idDepartment,
  });
}
