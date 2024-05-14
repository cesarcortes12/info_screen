class User {
  String name;
  String? position;
  String email;
  String document;
  String phone;
  String? image;
  String? token;

  User({
    required this.name,
    required this.position,
    required this.email,
    required this.document,
    required this.phone,
    required this.image,
    required this.token,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["nombre"],
        position: json["cargo"],
        email: json["email"],
        document: json["documento"],
        phone: json["telefono"],
        image: json["imagen"],
        token: json["token"],
      );
  Map<String, dynamic> toJson() => {
        "nombre": name,
        "cargo": position,
        "email": email,
        "documento": document,
        "telefono": phone,
        "imagen": image,
        "token": token,
      };
}
